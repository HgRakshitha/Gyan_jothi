import os
import re

# Directories to search
TARGET_DIRS = [
    r"lib/features/learn",
    r"lib/features/dashboard"
]

import_statement = "import 'package:gyan_jyoti/shared/widgets/app_asset_image.dart';\n"

def refactor_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    modified = False

    # Check if there is any Image.asset usage in this file
    if "Image.asset" not in content:
        return False

    # We need to find and replace Image.asset blocks.
    # A standard Image.asset call starts with Image.asset( and ends with )
    # Let's use a regex to match: Image.asset( <arguments> )
    # We will search for occurrences of Image.asset and manually parse the brackets to find the matching closing bracket.
    
    pos = 0
    while True:
        match = re.search(r'Image\.asset\s*\(', content[pos:])
        if not match:
            break
        
        start_idx = pos + match.start()
        # Find matching closing parenthesis
        paren_count = 1
        curr_idx = start_idx + len("Image.asset(")
        
        while curr_idx < len(content) and paren_count > 0:
            if content[curr_idx] == '(':
                paren_count += 1
            elif content[curr_idx] == ')':
                paren_count -= 1
            curr_idx += 1
            
        if paren_count == 0:
            # We found the full Image.asset(...) block!
            block = content[start_idx:curr_idx]
            
            # Now let's transform the block.
            # Extract arguments
            inner_content = content[start_idx + len("Image.asset("):curr_idx - 1].strip()
            
            # Let's extract properties using regex
            # Find the main asset path (the first argument before any named parameters)
            # e.g., item.imagePath, sticker.assetPath, etc.
            first_arg_match = re.match(r'^([^,]+)', inner_content)
            if first_arg_match:
                asset_path = first_arg_match.group(1).strip()
            else:
                asset_path = "null"
                
            # Extract named parameters
            width_match = re.search(r'\bwidth:\s*([^,]+)', inner_content)
            height_match = re.search(r'\bheight:\s*([^,]+)', inner_content)
            fit_match = re.search(r'\bfit:\s*([^,]+)', inner_content)
            
            # Extract errorBuilder if it exists
            # errorBuilder can be: errorBuilder: (context, error, stackTrace) => widget
            # We can find errorBuilder by searching for 'errorBuilder:' and parsing its content until the end of the argument or next named argument.
            # However, it's easier to regex match errorBuilder: ... => ... or errorBuilder: (...) { ... }
            error_builder_match = re.search(r'errorBuilder:\s*([^,]+(?:\(.*?\))?\s*=>\s*[^,]+|errorBuilder:\s*\(.*?\)\s*\{[\s\S]*?\})', inner_content)
            
            # Let's construct the new AppAssetImage block
            new_block = "AppAssetImage(\n"
            new_block += f"  assetPath: {asset_path},\n"
            if width_match:
                new_block += f"  width: {width_match.group(1).strip()},\n"
            if height_match:
                new_block += f"  height: {height_match.group(1).strip()},\n"
            if fit_match:
                new_block += f"  fit: {fit_match.group(1).strip()},\n"
                
            # Fallback widget extraction
            fallback_widget = "const SizedBox.shrink()"
            if "errorBuilder:" in inner_content:
                # Let's extract the widget returned by errorBuilder
                # e.g., errorBuilder: (context, error, stackTrace) => Icon(...)
                eb_idx = inner_content.find("errorBuilder:")
                eb_sub = inner_content[eb_idx:]
                # Match arrow syntax: => <expr>
                arrow_match = re.search(r'=>\s*([\s\S]+)$', eb_sub)
                if arrow_match:
                    fallback_widget = arrow_match.group(1).strip()
                    # Clean up trailing comma or braces if any
                    if fallback_widget.endswith(','):
                        fallback_widget = fallback_widget[:-1].strip()
            
            new_block += f"  fallback: {fallback_widget},\n"
            new_block += ")"
            
            # Replace in content
            content = content[:start_idx] + new_block + content[curr_idx:]
            modified = True
            
            # Move position forward (we replaced block, so start search after it)
            pos = start_idx + len(new_block)
        else:
            # parentheses didn't match, just advance position
            pos = start_idx + len("Image.asset(")

    if modified:
        # Check if import is already present
        if "app_asset_image.dart" not in content:
            # Find the first import line and insert our import above/below it
            import_match = re.search(r"import\s+['\"][^'\"]+['\"];", content)
            if import_match:
                insert_idx = import_match.start()
                content = content[:insert_idx] + import_statement + content[insert_idx:]
            else:
                content = import_statement + content
                
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Refactored: {filepath}")
        return True
        
    return False

def run_refactoring():
    count = 0
    for target in TARGET_DIRS:
        if not os.path.exists(target):
            continue
        for root, dirs, files in os.walk(target):
            for file in files:
                if file.endswith('.dart'):
                    filepath = os.path.join(root, file)
                    if refactor_file(filepath):
                        count += 1
    print(f"Successfully refactored {count} files.")

if __name__ == "__main__":
    run_refactoring()
