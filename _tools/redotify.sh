#!/usr/bin/env bash
# Just traverse the directory and rename everything in all rst-files.
# Will probably break everything everywhere all the time.
# Requires manual review.
find . -type f -name "*.rst" -exec sed -i 's/godot/redot/gI' {} +
