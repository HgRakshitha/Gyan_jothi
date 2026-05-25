"""
Optional margin strip — skip if you want opaque image backgrounds on the page.

Make shining_star/one.png outer margins transparent (edge-connected near-white).

Re-run after replacing the asset. Scenes two–five are expected as RGBA with soft
edges already; this script only rewrites one.png in the folder.
"""
from collections import deque
from pathlib import Path

import numpy as np
from PIL import Image

FOLDER = Path(__file__).resolve().parent.parent / "web" / "icons" / "stories" / "shining_star"
# Slightly looser than Chicky so faint off-white corners (e.g. G=246) still peel.
MIN_CHANNEL = 245
MIN_SUM = 738


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


def main() -> None:
    path = FOLDER / "one.png"
    im = Image.open(path)
    if im.mode == "RGBA":
        arr = np.asarray(im)
        rgb = arr[:, :, :3]
        base_a = arr[:, :, 3]
        rgba = rgba_remove_edge_white(rgb)
        rgba[:, :, 3] = np.minimum(rgba[:, :, 3], base_a)
    else:
        rgb = np.asarray(im.convert("RGB"))
        rgba = rgba_remove_edge_white(rgb)
    Image.fromarray(rgba, "RGBA").save(path, optimize=True)
    print(path.name, "saved RGBA")


if __name__ == "__main__":
    main()
