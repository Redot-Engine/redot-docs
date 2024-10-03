#!/usr/bin/env bash
# Just traverse the directory and rename everything in all rst-files.
# Will probably break everything everywhere all the time.
# Requires manual review.
find . -type f -name "*.rst" -exec sed -i 's/godot/redot/gI' {} +

# Find and rename all documentation files
find . -type f -name '*godot*.rst' | while read file; do
    newfile=$(echo "$file" | sed 's/godot/redot/')
    mv "$file" "$newfile"
done

# Find and rename all image files
find . -type f \( -name '*godot*.webp' -o -name '*godot*.gif' -o -name '*godot*.jpg' -o -name '*godot*.png' \) | while read file; do
    newfile=$(echo "$file" | sed 's/godot/redot/')
    mv "$file" "$newfile"
done
