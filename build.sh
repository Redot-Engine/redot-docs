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
#   BUILD_DIR         - Override the output directory name (e.g., "4.3", "4.4", "dev")

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
# Allow BUILD_DIR override for versioned builds
if [ -n "$BUILD_DIR" ]; then
    buildDir="$BUILD_DIR"
elif [ -n "$CF_PAGES" ]; then
    buildDir="${CF_PAGES_BRANCH:-master}"
    if [ "$buildDir" = "master" ]; then
        buildDir="latest"
    fi
else
    buildDir="$gitBranch"
    if [ "$buildDir" = "master" ]; then
        buildDir="latest"
    fi
fi

echo "========================================"
echo "Redot Documentation Build"
echo "========================================"
echo "Branch: $gitBranch"
echo "Output: html/en/$buildDir"
echo "Date: $(date)"
echo "========================================"

# Clean and prepare directories
# Skip migration if _migrated exists (for faster rebuilds)
echo ""
echo "[1/4] Preparing build directories..."
rm -rf "$sphinxDir"
mkdir -p "$sphinxDir"

# Full build (only if FULL_RUN is set)
if [ -n "$FULL_RUN" ]; then
    # Check if migration is needed
    if [ -d "$migrateDir" ] && [ -f "$migrateDir/index.rst" ]; then
        echo ""
        echo "[2/4] Using existing migrated files (skipping migration)..."
    else
        echo ""
        echo "[2/4] Migrating Godot to Redot (with --exclude-classes)..."
        rm -rf "$migrateDir"
        mkdir -p "$migrateDir"
        # Check if we're building from upstream branch (doesn't support --exclude-classes)
        # by checking if BUILD_DIR is set (our feature branch sets it, upstream builds won't)
        if [ -n "$BUILD_DIR" ] && [ "$gitBranch" != "HEAD" ]; then
            # Our branch with new migrate.py - use --exclude-classes
            python migrate.py --exclude-classes "$inputDir" "$migrateDir"
        else
            # Upstream branch - old migrate.py, don't use --exclude-classes
            python migrate.py "$inputDir" "$migrateDir"
        fi
    fi
    
    echo ""
    echo "[3/4] Building HTML documentation with Sphinx..."
    # Use -j 4 for consistent performance
    # Use -d for doctree caching (enables incremental builds)
    mkdir -p "$sphinxDir/.doctrees"
    sphinx-build -b html \
        -j 4 \
        -d "$sphinxDir/.doctrees" \
        --color \
        "$migrateDir" \
        "$sphinxDir"
    
    echo ""
    echo "[4/4] Copying build output..."
    # Cloudflare Pages serves from /output
    # Build triggered: $(date)
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
echo "Build completed at $(date)"
