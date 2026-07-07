import os
import re

# Directory of source code
SRC_DIR = r"d:\Gyan_jyoti_app\flutter_app\lib"
PUBSPEC_PATH = r"d:\Gyan_jyoti_app\flutter_app\pubspec.yaml"

# Regex: match .png (case insensitive), except when preceded by 'gj' or 'GJ'
PNG_REGEX = re.compile(r'(?<!GJ)(?<!gj)\.[pP][nN][gG]\b')

def replace_png_with_webp(content):
    return PNG_REGEX.sub('.webp', content)

def update_paths():
    updated_files = 0
    
    # 1. Update all Dart files in lib/
    for root, dirs, files in os.walk(SRC_DIR):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                with open(filepath, 'r', encoding='utf-8') as f:
                    content = f.read()
                
                new_content = replace_png_with_webp(content)
                
                if content != new_content:
                    with open(filepath, 'w', encoding='utf-8') as f:
                        f.write(new_content)
                    print(f"Updated paths in: {filepath}")
                    updated_files += 1

    # 2. Update pubspec.yaml
    if os.path.exists(PUBSPEC_PATH):
        with open(PUBSPEC_PATH, 'r', encoding='utf-8') as f:
            content = f.read()
        
        new_content = replace_png_with_webp(content)
        
        if content != new_content:
            with open(PUBSPEC_PATH, 'w', encoding='utf-8') as f:
                f.write(new_content)
            print(f"Updated paths in pubspec.yaml")
            updated_files += 1

    print("\n" + "="*50)
    print("Path Update Complete!")
    print(f"Total files updated: {updated_files}")
    print("="*50)

if __name__ == "__main__":
    update_paths()
