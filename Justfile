default:
    @just --list

# Print this help message
help: default

# Build the project
build:
    @npm install

# Remove build artifacts
clean:
    @rm -rf node_modules/

# Run the formatter
fmt:
    @just --unstable --fmt
    @npm exec -- prettier --write "package.json"
    @npm exec -- prettier --write --parser "html" "src/**/*.{html,liquid}"
    @npm exec -- prettier --write --parser "css" "src/stylesheets/**/*.css"

# Generate the site
generate $ELEVENTY_ENV="development":
    @rm -rf dist/
    @npm exec -- @11ty/eleventy

# Serve the site
serve $ELEVENTY_ENV="development":
    @rm -rf dist/
    @npm exec -- @11ty/eleventy --serve
