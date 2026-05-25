import os
import base64
import re

svg_dir = 'web/icons/home/'
for filename in os.listdir(svg_dir):
    if filename.endswith('.svg'):
        filepath = os.path.join(svg_dir, filename)
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read()
        
        match = re.search(r'xlink:href=[\"\']data:image/png;base64,([^\"]+)[\"\']', content)
        if match:
            b64_data = match.group(1)
            png_data = base64.b64decode(b64_data)
            png_filename = filename[:-4] + '.png'
            png_filepath = os.path.join(svg_dir, png_filename)
            with open(png_filepath, 'wb') as imgf:
                imgf.write(png_data)
            print(f'Extracted PNG from {filename} -> {png_filename}')
        else:
            print(f'No base64 PNG found in {filename}')
