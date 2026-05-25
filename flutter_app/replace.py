import os
import re

search_dir = r"d:\Gyan_jyoti_app\flutter_app\lib\features\learn\pages"

def replace_in_file(filepath):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # The regex matches the _awardCoins function block.
    # Note: we also want to add import for app_router.dart and go_router.dart if not present.
    pattern = r"void _awardCoins\(BuildContext context, WidgetRef ref\) \{.*?\n  \}"
    
    new_func = """void _awardCoins(BuildContext context, WidgetRef ref) {
    final success = ref.read(userProvider.notifier).completeActivity('learn_${data.title}', data.coinCount);
    if (success) {
      context.push(AppRoutes.taskCompletion, extra: data.coinCount);
    }
  }"""
    
    if re.search(pattern, content, flags=re.DOTALL):
        content = re.sub(pattern, new_func, content, flags=re.DOTALL)
        
        # Add go_router import if missing
        if "import 'package:go_router/go_router.dart';" not in content:
            content = content.replace("import 'package:flutter/material.dart';", "import 'package:flutter/material.dart';\nimport 'package:go_router/go_router.dart';")
            
        # Add app_router.dart if missing
        if "app_router.dart" not in content:
            content = content.replace("import '../../../../core/constants/app_assets.dart';", "import '../../../../core/router/app_router.dart';\nimport '../../../../core/constants/app_assets.dart';")
        
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(content)
        print(f"Updated: {filepath}")

for root, dirs, files in os.walk(search_dir):
    for file in files:
        if file.endswith('.dart'):
            replace_in_file(os.path.join(root, file))
