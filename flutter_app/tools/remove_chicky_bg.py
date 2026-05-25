"""
Optional: strips outer margins to transparency. Skip if you want full rectangular
frames (opaque margins) on the story page — [StoryPageScene] also draws a solid
page color behind images.

Make Chicky story PNGs float on transparent: remove edge-connected near-white
background (RGB assets two–five). one.png is already RGBA; left unchanged.
Canonical copies live under web/icons/stories/chicky_walk/.

Requires: pip install numpy pillow
"""
from __future__ import annotations

from collections import deque
from pathlib import Path

import numpy as np
from PIL import Image

FOLDER = Path(__file__).resolve().parent.parent / "web" / "icons" / "stories" / "chicky_walk"
# Pixels this light and 8-connected to the image border become transparent.
MIN_CHANNEL = 247
MIN_SUM = 745


def rgba_remove_edge_white(rgb: np.ndarray) -> np.ndarray:
    h, w = rgb.shape[:2]
    r = rgb[:, :, 0].astype(np.int16)
    g = rgb[:, :, 1].astype(np.int16)
    b = rgb[:, :, 2].astype(np.int16)
    cand = (r >= MIN_CHANNEL) & (g >= MIN_CHANNEL) & (b >= MIN_CHANNEL) & ((r + g + b) >= MIN_SUM)

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

    rgba = rgba_remove_edge_white(rgb)
    if base_a is not None:
        rgba[:, :, 3] = np.minimum(rgba[:, :, 3], base_a)

    out = Image.fromarray(rgba, "RGBA")
    out.save(path, optimize=True)
    print(path.name, "saved RGBA")


def main() -> None:
    # one.png is already RGBA with transparent margins; two–five were flat RGB.
    for name in ("two.png", "three.png", "four.png", "five.png"):
        p = FOLDER / name
        if p.exists():
            process(p)


if __name__ == "__main__":
    main()
