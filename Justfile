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

# Run the formatters
fmt: fmt-just fmt-rb fmt-css fmt-js

# Run the formatter for Just
fmt-just *OPTS:
    @just --unstable --fmt {{ OPTS }}

# Run the formatter for Ruby
fmt-rb *OPTS:
    @bin/rubocop --auto-correct {{ OPTS }}

# Run the formatter for CSS
fmt-css *OPTS:
    @npx prettier site/**/*.css.* --parser css --write {{ OPTS }}

# Run the formatter for JavaScript
fmt-js *OPTS:
    @npx prettier site/**/*.js.* --parser typescript --write {{ OPTS }}

# Run the linters
lint: lint-rb lint-css lint-js lint-md

# Run the linter for Ruby
lint-rb *OPTS:
    @bin/rubocop {{ OPTS }}

# Run the linter for CSS
lint-css *OPTS:
    @npx prettier site/**/*.css.* --parser css --check {{ OPTS }}

# Run the linter for JavaScript
lint-js *OPTS:
    @npx prettier site/**/*.js.* --parser typescript --check {{ OPTS }}

# Run the linter for Markdown
lint-md *OPTS=".":
    @vale {{ OPTS }}

# Generate the site
site-gen:
    @bin/ssg

# Serve the site
site-srv:
    @bin/ssg serve

# Run the tests
test *OPTS:
    @bin/minitest {{ OPTS }}
