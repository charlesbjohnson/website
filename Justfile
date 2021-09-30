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
    @npm exec -- prettier --write .
