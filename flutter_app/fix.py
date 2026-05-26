
import os

directory = r"D:\Gyan_jyoti_app\flutter_app\lib\features\learn\pages"

for root, dirs, files in os.walk(directory):
    for file in files:
        if file.endswith(".dart"):
            filepath = os.path.join(root, file)
            with open(filepath, "r", encoding="utf-8") as f:
                content = f.read()
            
            # The exact broken string from powershell escaping
            if "'+\\\'," in content:
                content = content.replace("'+\\\',", "'+${data.coinCount}',")
                with open(filepath, "w", encoding="utf-8") as f:
                    f.write(content)
                print(f"Fixed {file}")

