# Redot Engine documentation

This repository contains the source files of [Redot Engine](https://redotengine.org)'s documentation, in reStructuredText markup language (reST).

They are meant to be parsed with the [Sphinx](https://www.sphinx-doc.org/) documentation builder to build the HTML documentation on [Redot's website](https://docs.redotengine.org).

## Download for offline use

To browse the documentation offline, you can download an HTML copy (updated every Monday):
[stable](https://download.redotengine.org/docs/redot-docs-html-stable.zip),
[latest](https://download.redotengine.org/docs/redot-docs-html-master.zip). Extract
the ZIP archive then open the top-level `index.html` in a web browser.

For mobile devices or e-readers, you can also download an ePub copy (updated every Monday):
[stable](https://download.redotengine.org/docs/redot-docs-epub-stable.zip),
[latest](https://download.redotengine.org/docs/redot-docs-epub-master.zip). Extract
the ZIP archive then open the `RedotEngine.epub` file in an e-book reader application.

## Building Documentation

### Quick Build (Local Development)

For local development, use the optimized build script:

```bash
# Full build (includes migration + Sphinx)
FULL_RUN=1 ./build.sh

# The output will be in output/html/en/latest/ (for master branch)
# or output/html/en/<branch-name>/ (for other branches)
```

**Build optimizations:**
- `--exclude-classes`: Skips class reference migration (faster, these are auto-generated)
- `-j auto`: Uses all available CPU cores for parallel builds
- Branch mapping: `master` → `latest/`, other branches → `<branch-name>/`

### Manual Build

If you prefer manual control:

```bash
# 1. Migrate (optional - skip for faster builds, use --exclude-classes)
python migrate.py --exclude-classes . _migrated

# 2. Build with Sphinx (auto-detect CPU cores)
sphinx-build -b html -j auto ./_migrated/ _build/html
```

### Architecture

**GitHub Actions + Cloudflare Pages (Current):**
- Source: This repository (`Redot-Engine/redot-docs`)
- Build: GitHub Actions runs `build.sh` (2-hour timeout vs Cloudflare's 20 minutes)
- Deploy: Built output pushed to Cloudflare Pages
- Output: `/output/html/en/<branch>/`
- Serve: Cloudflare Pages serves the built documentation

**Previous architectures (deprecated):**
1. ~Two repos: `redot-docs` (source) → builds → pushes to `redot-docs-live` (deployment)~
2. ~Direct Cloudflare Pages build (hit 20-minute timeout limit)~

### GitHub Actions Workflow

The repository includes an automated workflow (`.github/workflows/build-and-deploy.yml`) that:

1. **Builds on every push** to `master` or `optimize-build-simplify`
2. **Runs on GitHub Actions** with a 2-hour timeout (vs Cloudflare's 20-minute limit)
3. **Deploys automatically** to Cloudflare Pages using the official Cloudflare action

**Setup required:**

Add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):
- `CLOUDFLARE_ACCOUNT_ID` - Your Cloudflare account ID
- `CLOUDFLARE_API_TOKEN` - API token with Cloudflare Pages:Edit permission

**How it works:**
```
Push to branch → GitHub Actions builds (30 min) → Deploys to Cloudflare Pages
```

**Benefits:**
- No 20-minute timeout limit
- Python dependencies cached between builds
- Automatic deployment on every push
- Works for both production (master) and preview branches

## Theming

The Redot documentation uses the default `sphinx_rtd_theme` with many
[customizations](_static/) applied on top. It will automatically switch between
the light and dark theme depending on your browser/OS' theming preference.

If you use Firefox and wish to use the dark theme regardless of your OS
configuration, you can install the
[Dark Website Forcer](https://addons.mozilla.org/en-US/firefox/addon/dark-mode-website-switcher/)
add-on.

## Contributing

All contributors are welcome to help on the Redot documentation.

To get started, head to the [Contributing section](https://docs.redotengine.org/contributing/how_to_contribute.html) of the online manual. There, you will find all the information you need to write and submit changes.

Here are some quick links to the areas you might be interested in:

1. [Contributing to the online manual](https://docs.redotengine.org/contributing/documentation/contributing_to_the_documentation.html)
2. [Contributing to the class reference](https://docs.redotengine.org/contributing/documentation/updating_the_class_reference.html)
3. [Content guidelines](https://docs.redotengine.org/contributing/documentation/content_guidelines.html)
4. [Writing guidelines](https://docs.redotengine.org/contributing/documentation/docs_writing_guidelines.html)
5. [Building the manual](https://docs.redotengine.org/contributing/documentation/building_the_manual.html)
6. [Translating the documentation](https://docs.redotengine.org/contributing/documentation/editor_and_docs_localization.html)

### How to build with anaconda/miniconda

**Recommended: Use the build script**
```bash
# Setup environment (one-time)
conda create -n redot-docs python=3.11 -y
conda activate redot-docs
pip install -r requirements.txt

# Build documentation
FULL_RUN=1 ./build.sh

# Output: output/html/en/latest/
```

**Manual build (if you need fine control):**
```bash
# 1) Setup environment
conda create -n redot-docs python=3.11 -y
conda activate redot-docs
pip install -r requirements.txt

# 2) Migrate (use --exclude-classes for faster builds)
python migrate.py --exclude-classes . _migrated

# 3) Build with Sphinx (auto-detect CPU cores)
sphinx-build -b html -j auto ./_migrated/ _build/html
```

## License

With the exception of the `classes/` folder, all the content of this repository is licensed under the Creative Commons Attribution
3.0 Unported license ([CC BY 3.0](https://creativecommons.org/licenses/by/3.0/)) and is to be attributed to "the Redot community, modified from an original work by Juan Linietsky, Ariel Manzur and the Godot community".
See [LICENSE.txt](/LICENSE.txt) for details.

The files in the `classes/` folder are derived from [Redot's main source repository](https://github.com/redot-engine/redot) and are distributed under the MIT license, with the same authors as above.
