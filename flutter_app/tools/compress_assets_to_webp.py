import os
import sys

try:
    from PIL import Image
except ImportError:
    print("Error: 'Pillow' library is required for image processing.")
    print("Attempting to install Pillow using pip...")
    import subprocess
    try:
        subprocess.run([sys.executable, "-m", "pip", "install", "Pillow"], check=True)
        from PIL import Image
    except Exception as e:
        print(f"Failed to install Pillow: {e}")
        print("Please install it manually by running: pip install Pillow")
        sys.exit(1)

# Target folders to compress
TARGET_DIRS = [
    r"d:\Gyan_jyoti_app\flutter_app\assets",
    r"d:\Gyan_jyoti_app\flutter_app\web"
]

# Files to skip
EXCLUDE_FILENAMES = ["gj.png"]  # Keep launcher icon input as PNG
EXCLUDE_DIRS = ["fonts"]

def compress_images():
    total_converted = 0
    total_saved_bytes = 0
    
    print("Starting WebP compression and resizing pipeline...")
    
    for base_dir in TARGET_DIRS:
        if not os.path.exists(base_dir):
            print(f"Warning: Directory '{base_dir}' does not exist, skipping.")
            continue
            
        print(f"\nProcessing directory: {base_dir}...")
        for root, dirs, files in os.walk(base_dir):
            # Check exclusions
            if any(exclude in root for exclude in EXCLUDE_DIRS):
                continue
                
            for file in files:
                if not file.lower().endswith(".png"):
                    continue
                    
                if file.lower() in EXCLUDE_FILENAMES:
                    print(f"Skipping excluded file: {file}")
                    continue
                    
                filepath = os.path.join(root, file)
                orig_size = os.path.getsize(filepath)
                
                try:
                    with Image.open(filepath) as img:
                        # 1. Resize if too large (illustrated assets don't need >800px width on mobile)
                        w, h = img.size
                        if w > 800:
                            new_w = 800
                            new_h = int(h * (new_w / w))
                            # Use Resampling.LANCZOS (Pillow 9+) or ANTIALIAS (older Pillow versions)
                            try:
                                resample = Image.Resampling.LANCZOS
                            except AttributeError:
                                resample = Image.ANTIALIAS
                            processed_img = img.resize((new_w, new_h), resample)
                            # Convert mode if necessary (WebP supports RGB and RGBA)
                            if processed_img.mode not in ('RGB', 'RGBA'):
                                processed_img = processed_img.convert('RGBA')
                        else:
                            processed_img = img
                            if processed_img.mode not in ('RGB', 'RGBA'):
                                processed_img = processed_img.convert('RGBA')
                        
                        # 2. Save as WebP
                        webp_path = os.path.splitext(filepath)[0] + ".webp"
                        processed_img.save(webp_path, "WEBP", quality=80)
                        
                    # 3. Clean up the original PNG
                    os.remove(filepath)
                    
                    new_size = os.path.getsize(webp_path)
                    saved = orig_size - new_size
                    total_saved_bytes += saved
                    total_converted += 1
                    
                    percent_reduction = (saved / orig_size) * 100
                    print(f"Converted: {file} -> {os.path.basename(webp_path)} "
                          f"({orig_size/1024:.1f}KB -> {new_size/1024:.1f}KB, -{percent_reduction:.1f}%)")
                          
                except Exception as e:
                    print(f"FAILED to convert {filepath}: {e}")
                    
    print("\n" + "="*50)
    print("Compression Pipeline Complete!")
    print(f"Total files converted: {total_converted}")
    print(f"Total storage saved: {total_saved_bytes / (1024*1024):.2f} MB")
    print("="*50)

if __name__ == "__main__":
    compress_images()
