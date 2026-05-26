
import os
import re

directories = [
    r"D:\Gyan_jyoti_app\flutter_app\lib\features\learn\pages",
    r"D:\Gyan_jyoti_app\flutter_app\lib\features\quiz\pages"
]

pattern = re.compile(r"(const\s+AppAssetImage\(\s*assetPath:\s*AppAssets\.iconCoin,\s*width:\s*[^,]+,\s*height:\s*[^,]+)(,?\s*\))", re.DOTALL)

for directory in directories:
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(".dart"):
                filepath = os.path.join(root, file)
                with open(filepath, "r", encoding="utf-8") as f:
                    content = f.read()
                
                new_content, count = pattern.subn(r"\1, fallback: const SizedBox.shrink()\2", content)
                if count > 0:
                    with open(filepath, "w", encoding="utf-8") as f:
                        f.write(new_content)
                    print(f"Fixed {file}")

# Remove dart:ui import in splash
splash_dir = r"D:\Gyan_jyoti_app\flutter_app\lib\features\splash\pages"
for file in ["welcome_bunny_page.dart", "welcome_fox_page.dart", "welcome_page.dart", "welcome_panda_page.dart"]:
    filepath = os.path.join(splash_dir, file)
    if os.path.exists(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            content = f.read()
        if "import 'dart:ui';" in content:
            content = content.replace("import 'dart:ui';\n", "")
            with open(filepath, "w", encoding="utf-8") as f:
                f.write(content)

