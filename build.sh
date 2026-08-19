#!/bin/bash

# Build script for Agar.io Shark IPA

set -e

echo "Building Agar.io Shark IPA..."

# Variables
BASE_IPA="base_agario.ipa"
OUTPUT_IPA="agario_shark.ipa"
PAYLOAD_DIR="Payload"
APP_DIR="$PAYLOAD_DIR/agar.io.app"
FRAMEWORKS_DIR="$APP_DIR/Frameworks"

# Clean previous build
echo "Cleaning previous build..."
rm -rf $PAYLOAD_DIR
rm -f $OUTPUT_IPA
rm -rf packages
rm -rf obj

# Build the tweak
echo "Building tweak with Theos..."
make clean
make package

# Extract base IPA if it exists
if [ -f "$BASE_IPA" ]; then
    echo "Extracting base IPA..."
    unzip -q "$BASE_IPA" -d .
else
    echo "Warning: Base IPA not found. Creating empty Payload structure..."
    mkdir -p "$APP_DIR"
fi

# Create Frameworks directory
mkdir -p "$FRAMEWORKS_DIR"

# Extract dylib from deb package
echo "Extracting dylib from package..."
DEB_FILE=$(ls packages/*.deb | head -n 1)
if [ -f "$DEB_FILE" ]; then
    ar x "$DEB_FILE"
    tar -xzf data.tar.* 2>/dev/null || tar -xzf data.tar.gz

    DYLIB_PATH=$(find ./Library/MobileSubstrate/DynamicLibraries -name "dtje029mod.dylib" 2>/dev/null | head -n 1)
    if [ -f "$DYLIB_PATH" ]; then
        cp "$DYLIB_PATH" "$FRAMEWORKS_DIR/dtje029mod.dylib"
        echo "Dylib copied to Frameworks/dtje029mod.dylib"
    fi

    # Copy plist if exists
    PLIST_PATH=$(find ./Library/MobileSubstrate/DynamicLibraries -name "*.plist" 2>/dev/null | head -n 1)
    if [ -f "$PLIST_PATH" ]; then
        cp "$PLIST_PATH" "$FRAMEWORKS_DIR/"
        echo "Plist copied to Frameworks"
    fi

    # Cleanup
    rm -f control.tar.* data.tar.* debian-binary
fi

if [ ! -f "$FRAMEWORKS_DIR/CydiaSubstrate.framework/CydiaSubstrate" ]; then
    echo "ERROR: CydiaSubstrate.framework missing in base app"
    exit 1
fi

# Inject like Shark: Substrate first, then tweak (idempotent if already present)
echo "Injecting load commands..."
insert_dylib --inplace --strip-codesig --all-yes \
  "@executable_path/Frameworks/CydiaSubstrate.framework/CydiaSubstrate" \
  "$APP_DIR/agar.io" || true
insert_dylib --inplace --strip-codesig --all-yes \
  "@executable_path/Frameworks/dtje029mod.dylib" \
  "$APP_DIR/agar.io" || true

# Create IPA (Payload must be the zip root)
echo "Creating IPA..."
zip -qr "$OUTPUT_IPA" Payload

echo "Build complete! Output: $OUTPUT_IPA"
ls -lh "$OUTPUT_IPA"
