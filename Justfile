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
fmt *OPTS:
    @just --unstable --fmt
    @bin/rubocop --auto-correct {{ OPTS }}

# Run the linter
lint *OPTS:
    @bin/rubocop {{ OPTS }}

# Generate the site
site-gen:
    @bin/ssg

# Serve the site
site-srv:
    @bin/ssg serve

# Run the tests
test *OPTS:
    @bin/minitest {{ OPTS }}
