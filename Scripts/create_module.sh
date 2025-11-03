#!/usr/bin/env bash
set -e

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# --- Verify argument ---
MODULE_NAME=$1
if [ -z "$MODULE_NAME" ]; then
  echo -e "${RED}❌ Usage: ./Scripts/create_module.sh <ModuleName>${NC}"
  exit 1
fi

if [ -d "$MODULE_DIR" ]; then
  echo "⚠️  Module '$MODULE_NAME' already exists at $MODULE_DIR"
  echo "➡️  Aborting to avoid overwriting existing files."
  exit 1
fi

# --- Check XcodeGen installation ---
if ! command -v xcodegen &> /dev/null; then
  echo -e "${YELLOW}⚙️  XcodeGen not found. Installing via Homebrew...${NC}"

  # Check if Homebrew exists
  if ! command -v brew &> /dev/null; then
    echo -e "${RED}❌ Homebrew is not installed. Please install it first: https://brew.sh${NC}"
    exit 1
  fi

  brew install xcodegen

  if ! command -v xcodegen &> /dev/null; then
    echo -e "${RED}❌ Failed to install XcodeGen. Aborting.${NC}"
    exit 1
  fi

  echo -e "${GREEN}✅ XcodeGen installed successfully!${NC}"
else
  echo -e "${GREEN}✅ XcodeGen is installed: $(xcodegen --version)${NC}"
fi

# --- Setup paths ---
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEMPLATE_DIR="$SCRIPT_DIR/Templates/Module Template"
MODULES_DIR="$PWD"
MODULE_DIR="$MODULES_DIR/$MODULE_NAME"

# --- Create module directory ---
echo -e "${YELLOW}📦 Creating new MVI module: ${MODULE_NAME}${NC}"
mkdir -p "$MODULE_DIR"

# --- Copy template ---
echo -e "${YELLOW}📦 Copy Templates for: ${MODULE_NAME}${NC}"
cp -R "$TEMPLATE_DIR/"* "$MODULE_DIR/"

# --- Replace placeholders ---
echo -e "${YELLOW}📦 Replacing placeholders: ${MODULE_NAME}${NC}"
find "$MODULE_DIR" -type f ! -name ".DS_Store" -exec sed -i '' "s/__MODULE_NAME__/$MODULE_NAME/g" {} +

# --- Rename folders and files that contain the placeholder ---
find "$MODULE_DIR" -depth -name '*__MODULE_NAME__*' \
  -exec bash -c 'mv "$0" "${0//__MODULE_NAME__/'"$MODULE_NAME"'}"' {} \;

# --- Generate Xcode project ---
echo -e "${YELLOW}📦 Start Generate Xcode project: ${MODULE_NAME}${NC}"
cd "$MODULE_DIR"
xcodegen generate --spec project_module.yml

# --- Final confirmation ---
echo -e "${GREEN}✅ Module '$MODULE_NAME' created successfully at $MODULE_DIR${NC}"
echo -e "${YELLOW}👉 You can now open '$MODULE_NAME.xcodeproj' in Xcode.${NC}"


WORKSPACE_PATH="$MODULES_DIR/MyApp.xcworkspace/contents.xcworkspacedata"
MODULE_PATH="$MODULE_NAME/$MODULE_NAME.xcodeproj"

# Only add if not already present
if ! grep -q "$MODULE_NAME.xcodeproj" "$WORKSPACE_PATH"; then
  echo "🧩 Linking $MODULE_NAME.xcodeproj to workspace..."
  sed -i '' "/<\/Workspace>/i\\
    <FileRef location=\"group:$MODULE_PATH\"></FileRef>" "$WORKSPACE_PATH"
  echo "✅ $MODULE_NAME.xcodeproj added to workspace"
else
  echo "ℹ️  $MODULE_NAME.xcodeproj already exists in workspace"
fi

