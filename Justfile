default:
    @just --list

# Print this help message
help: default

# Build the project
build:
    @bin/bundle install

# Remove build artifacts
clean:
    @rm -rf vendor/

# Run the formatter
fmt:
    @just --unstable --fmt

# Generate the site
generate $JEKYLL_ENV="development":
    @rm -rf _site/
    @bin/jekyll build

# Serve the site
serve $JEKYLL_ENV="development":
    @rm -rf _site/
    @bin/jekyll server
