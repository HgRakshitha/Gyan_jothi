import os

files_to_fix = [
    r"d:\Gyan_jyoti_app\flutter_app\lib\features\learn\pages\art_craft\color_my_home_page.dart",
    r"d:\Gyan_jyoti_app\flutter_app\lib\features\learn\pages\art_craft\color_the_animal_page.dart",
    r"d:\Gyan_jyoti_app\flutter_app\lib\features\learn\pages\art_craft\color_the_big_balloon_page.dart",
    r"d:\Gyan_jyoti_app\flutter_app\lib\features\learn\pages\art_craft\color_the_tree_page.dart"
]

def fix_files():
    for filepath in files_to_fix:
        if os.path.exists(filepath):
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Revert the ImageByteFormat and filenames back to PNG
            content = content.replace("ui.ImageByteFormat.webp", "ui.ImageByteFormat.png")
            content = content.replace("color_my_home.webp", "color_my_home.png")
            content = content.replace("color_the_animal.webp", "color_the_animal.png")
            content = content.replace("color_the_big_balloon.webp", "color_the_big_balloon.png")
            content = content.replace("color_the_tree.webp", "color_the_tree.png")
            
            with open(filepath, 'w', encoding='utf-8') as f:
                f.write(content)
            print(f"Reverted ImageByteFormat to PNG in: {filepath}")

if __name__ == "__main__":
    fix_files()
