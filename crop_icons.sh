#!/bin/bash

# Check if GNU Parallel is installed
if ! command -v parallel &>/dev/null; then
  echo "GNU Parallel is not installed. Please install it and try again."
  exit 1
fi

# Check if the Icons directory exists
if [ ! -d "Icons" ]; then
  echo "Directory 'Icons' not found."
  exit 1
fi

# Create an output directory for cropped icons
mkdir -p Cropped

# Export variables if needed by GNU Parallel
export OUTPUT_DIR="Cropped"

# Function to crop a single image
crop_image() {
  local icon="$1"
  local filename
  filename=$(basename "$icon")
  echo "Processing $filename..."
  convert "$icon" -trim +repage "$OUTPUT_DIR/$filename"
}

export -f crop_image

# Run the cropping in parallel for all PNG files in the Icons folder
find Icons -maxdepth 1 -type f -name '*.png' | parallel crop_image {}

echo "Cropping complete. Cropped images are available in the 'Cropped' folder."
