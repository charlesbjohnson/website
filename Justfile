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
fmt: fmt-just fmt-rb

# Run the formatter for Just
fmt-just *OPTS:
    @just --unstable --fmt {{ OPTS }}

# Run the formatter for Ruby
fmt-rb *OPTS:
    @bin/rubocop --auto-correct {{ OPTS }}

# Run the linters
lint: lint-rb lint-md

# Run the linter for Ruby
lint-rb *OPTS:
    @bin/rubocop {{ OPTS }}

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
