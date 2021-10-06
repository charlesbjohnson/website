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
