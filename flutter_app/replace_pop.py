import os
import re

search_dir = r"d:\Gyan_jyoti_app\flutter_app\lib\features\learn\pages\art_craft"

def replace_in_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # We want to replace exactly `context.pop()` with `context.pop(true)` inside the "Done" buttons.
    # We can just replace `context.pop()` with `context.pop(true)` since `context.pop` without true is only used for Done or Back.
    # Wait! The `QuizHeader` back button uses `goToAppHome(context)` or similar, but some places might use `context.pop()`.
    # Let's see... `onPressed: () => context.pop()` is the pattern for the Done button.
    # Let's only replace `onPressed: () => context.pop()`
    
    new_content = content.replace("onPressed: () => context.pop()", "onPressed: () => context.pop(true)")
    
    if new_content != content:
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated: {filepath}")

for root, dirs, files in os.walk(search_dir):
    for file in files:
        if file.endswith('.dart'):
            replace_in_file(os.path.join(root, file))
