import os
import sys
import mimetypes

# We need boto3 for S3/R2 upload.
try:
    import boto3
    from botocore.config import Config
except ImportError:
    print("Error: 'boto3' package is required. Install it using: pip install boto3")
    sys.exit(1)

# Try importing dotenv, if not present we will load manually or prompt
try:
    from dotenv import load_dotenv
    load_dotenv()
except ImportError:
    # Fallback to manual environment parsing if dotenv file exists
    if os.path.exists(".env"):
        with open(".env", "r") as f:
            for line in f:
                if line.strip() and not line.startswith("#"):
                    key, val = line.strip().split("=", 1)
                    os.environ[key.strip()] = val.strip()

# Configuration
ACCOUNT_ID = os.getenv("CLOUDFLARE_R2_ACCOUNT_ID")
ACCESS_KEY_ID = os.getenv("CLOUDFLARE_R2_ACCESS_KEY_ID")
SECRET_ACCESS_KEY = os.getenv("CLOUDFLARE_R2_SECRET_ACCESS_KEY")
BUCKET_NAME = os.getenv("CLOUDFLARE_R2_BUCKET_NAME")

# Directories to upload
DIRECTORIES_TO_UPLOAD = [
    "assets",
    "web"
]

# Paths to exclude from upload to save time/bandwidth (e.g. fonts, build leftovers)
EXCLUDE_SUBDIRS = [
    os.path.join("assets", "fonts"),
]

def check_credentials():
    missing = []
    if not ACCOUNT_ID: missing.append("CLOUDFLARE_R2_ACCOUNT_ID")
    if not ACCESS_KEY_ID: missing.append("CLOUDFLARE_R2_ACCESS_KEY_ID")
    if not SECRET_ACCESS_KEY: missing.append("CLOUDFLARE_R2_SECRET_ACCESS_KEY")
    if not BUCKET_NAME: missing.append("CLOUDFLARE_R2_BUCKET_NAME")
    
    if missing:
        print("Missing environment variables in .env file:")
        for m in missing:
            print(f"  - {m}")
        print("\nPlease create a '.env' file in the flutter_app directory with the following content:")
        print("CLOUDFLARE_R2_ACCOUNT_ID=your_cloudflare_account_id")
        print("CLOUDFLARE_R2_ACCESS_KEY_ID=your_access_key_id")
        print("CLOUDFLARE_R2_SECRET_ACCESS_KEY=your_secret_access_key")
        print("CLOUDFLARE_R2_BUCKET_NAME=your_bucket_name")
        return False
    return True

def upload_files():
    if not check_credentials():
        return

    # S3 Endpoint for Cloudflare R2
    endpoint_url = f"https://{ACCOUNT_ID}.r2.cloudflarestorage.com"

    print("Connecting to Cloudflare R2...")
    s3_client = boto3.client(
        "s3",
        endpoint_url=endpoint_url,
        aws_access_key_id=ACCESS_KEY_ID,
        aws_secret_access_key=SECRET_ACCESS_KEY,
        config=Config(signature_version="s3v4"),
        region_name="auto"
    )

    # Verify bucket exists
    try:
        s3_client.head_bucket(Bucket=BUCKET_NAME)
        print(f"Successfully connected to bucket: {BUCKET_NAME}")
    except Exception as e:
        print(f"Error connecting to bucket '{BUCKET_NAME}': {e}")
        print("Please verify your Bucket Name and credentials.")
        return

    total_uploaded = 0
    total_skipped = 0

    for base_dir in DIRECTORIES_TO_UPLOAD:
        if not os.path.exists(base_dir):
            print(f"Warning: Directory '{base_dir}' does not exist, skipping.")
            continue

        print(f"\nScanning directory: {base_dir}...")
        for root, dirs, files in os.walk(base_dir):
            # Check exclusions
            is_excluded = False
            for exclude in EXCLUDE_SUBDIRS:
                if root.startswith(exclude) or root == exclude:
                    is_excluded = True
                    break
            
            if is_excluded:
                total_skipped += len(files)
                continue

            for file in files:
                local_path = os.path.join(root, file)
                # Normalize key path (use forward slashes for R2 keys)
                r2_key = local_path.replace(os.sep, "/")
                
                # Determine Content-Type
                content_type, _ = mimetypes.guess_type(local_path)
                if not content_type:
                    if file.endswith(".svg"):
                        content_type = "image/svg+xml"
                    elif file.endswith(".json"):
                        content_type = "application/json"
                    else:
                        content_type = "application/octet-stream"

                print(f"Uploading: {local_path} -> {r2_key} ({content_type})...", end="", flush=True)
                try:
                    s3_client.upload_file(
                        Filename=local_path,
                        Bucket=BUCKET_NAME,
                        Key=r2_key,
                        ExtraArgs={
                            "ContentType": content_type
                        }
                    )
                    print(" Done")
                    total_uploaded += 1
                except Exception as e:
                    print(f" FAILED: {e}")

    print("\n" + "="*40)
    print("Upload complete!")
    print(f"Total files uploaded: {total_uploaded}")
    print(f"Total files skipped: {total_skipped}")
    print("="*40)

if __name__ == "__main__":
    upload_files()
