"""
Optional margin strip — skip if you want opaque image backgrounds on the page.

Remove edge-connected near-black margins from Teddy scene PNGs (vignette on black).

Writes RGBA under web/icons/stories/teddy_s_button/. Re-run after replacing art.

Requires: pip install numpy pillow
"""
from __future__ import annotations

from collections import deque
from pathlib import Path

import numpy as np
from PIL import Image

FOLDER = Path(__file__).resolve().parent.parent / "web" / "icons" / "stories" / "teddy_s_button"
# Pixels this dark and 8-connected to the image border become transparent.
MAX_CHANNEL = 42
MAX_SUM = 130


def rgba_remove_edge_black(rgb: np.ndarray, base_alpha: np.ndarray | None) -> np.ndarray:
    h, w = rgb.shape[:2]
    r = rgb[:, :, 0].astype(np.int16)
    g = rgb[:, :, 1].astype(np.int16)
    b = rgb[:, :, 2].astype(np.int16)
    cand = (r <= MAX_CHANNEL) & (g <= MAX_CHANNEL) & (b <= MAX_CHANNEL) & ((r + g + b) <= MAX_SUM)

    vis = np.zeros((h, w), dtype=bool)
    q: deque[tuple[int, int]] = deque()
    for x in range(w):
        for y in (0, h - 1):
            if cand[y, x] and not vis[y, x]:
                vis[y, x] = True
                q.append((y, x))
    for y in range(h):
        for x in (0, w - 1):
            if cand[y, x] and not vis[y, x]:
                vis[y, x] = True
                q.append((y, x))

    while q:
        y, x = q.popleft()
        for dy, dx in ((0, 1), (0, -1), (1, 0), (-1, 0)):
            ny, nx = y + dy, x + dx
            if 0 <= ny < h and 0 <= nx < w and not vis[ny, nx] and cand[ny, nx]:
                vis[ny, nx] = True
                q.append((ny, nx))

    out = np.zeros((h, w, 4), dtype=np.uint8)
    out[:, :, :3] = rgb
    out[:, :, 3] = np.where(vis, 0, 255)
    if base_alpha is not None:
        out[:, :, 3] = np.minimum(out[:, :, 3], base_alpha)
    return out


def process(path: Path) -> None:
    im = Image.open(path)
    if im.mode == "RGBA":
        arr = np.asarray(im)
        rgb = arr[:, :, :3]
        base_a = arr[:, :, 3]
    else:
        rgb = np.asarray(im.convert("RGB"))
        base_a = None
    rgba = rgba_remove_edge_black(rgb, base_a)
    Image.fromarray(rgba, "RGBA").save(path, optimize=True)
    print(path.name, "saved")


def main() -> None:
    for name in ("one.png", "two.png", "three.png", "four.png", "five.png"):
        p = FOLDER / name
        if p.exists():
            process(p)


if __name__ == "__main__":
    main()
