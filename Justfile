# List available recipes
default:
    @just --list

# Remove dependencies
clean:
    @rm -rf node_modules/

# Install dependencies
deps:
    @npm install

# Format code
fmt:
    @npx eslint --fix .
    @npx prettier --write package.json

# Lint code
lint:
    @npx eslint .
    @npx prettier --check package.json
