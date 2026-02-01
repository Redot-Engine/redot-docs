#!/bin/bash
#
# Redot Documentation Build Script
# Builds documentation and outputs to /output for Cloudflare Pages
#
# Usage:
#   FULL_RUN=1 ./build.sh              # Full build
#   ./build.sh                         # Skip build (for testing)
#
# Environment Variables:
#   FULL_RUN          - Set to enable full documentation build
#   CF_PAGES          - Automatically set by Cloudflare Pages
#   CF_PAGES_BRANCH   - Branch being built (set by Cloudflare Pages)

set -e  # Exit on error

# Configuration
inputDir="."
migrateDir="_migrated"
sphinxDir="_sphinx"

# Determine output directory based on branch
gitBranch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null || echo "master")
if [ -n "$CF_PAGES" ]; then
    echo "Building on Cloudflare Pages"
    gitBranch="${CF_PAGES_BRANCH:-master}"
fi

# Map branches to output directories
# master -> latest, everything else -> branch name
buildDir="$gitBranch"
if [ "$gitBranch" = "master" ]; then
    buildDir="latest"
fi

echo "========================================"
echo "Redot Documentation Build"
echo "========================================"
echo "Branch: $gitBranch"
echo "Output: html/en/$buildDir"
echo "Date: $(date)"
echo "========================================"

# Clean and prepare temp directories
echo ""
echo "[1/4] Preparing build directories..."
rm -rf "$migrateDir" "$sphinxDir"
mkdir -p "$migrateDir" "$sphinxDir"

# Full build (only if FULL_RUN is set)
if [ -n "$FULL_RUN" ]; then
    echo ""
    echo "[2/4] Migrating Godot to Redot (with --exclude-classes)..."
    python migrate.py --exclude-classes "$inputDir" "$migrateDir"
    
    echo ""
    echo "[3/4] Building HTML documentation with Sphinx..."
    echo "Using auto-detected parallel jobs (-j auto)"
    sphinx-build -b html \
        -j auto \
        --color \
        "$migrateDir" \
        "$sphinxDir"
    
    echo ""
    echo "[4/4] Copying build output..."
    # Cloudflare Pages serves from /output
    outputDir="output/html/en/$buildDir"
    mkdir -p "$outputDir"
    cp -r "$sphinxDir"/* "$outputDir/"
    
    echo ""
    echo "========================================"
    echo "Build Complete!"
    echo "Output: $outputDir"
    echo "========================================"
else
    echo ""
    echo "[2/4] Skipping migration and build (FULL_RUN not set)"
    echo ""
    echo "[3/4] Creating placeholder output..."
    mkdir -p "output/html/en/$buildDir"
    echo "Build skipped. Set FULL_RUN=1 to build documentation." > "output/html/en/$buildDir/index.html"
    echo ""
    echo "[4/4] Done (placeholder only)"
    echo ""
    echo "========================================"
    echo "Build Skipped (FULL_RUN not set)"
    echo "========================================"
fi

echo ""
echo "Build script finished successfully"
