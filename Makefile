.PHONY: help install test lint format clean docker-build docker-run setup

# Default target
help:
	@echo "Available commands:"
	@echo "  make install     - Install all dependencies"
	@echo "  make test        - Run all tests"
	@echo "  make lint        - Run linters"
	@echo "  make format      - Format code"
	@echo "  make clean       - Clean build artifacts"
	@echo "  make docker-build - Build Docker images"
	@echo "  make setup       - Initial project setup"

# Install dependencies
install:
	@echo "Installing Python dependencies..."
	pip install -r requirements.txt
	pip install -r requirements-dev.txt
	@echo "Installing Node.js dependencies..."
	npm install

# Run tests
test:
	@echo "Running Python tests..."
	pytest --cov=./ --cov-report=xml
	@echo "Running Node.js tests..."
	npm test

# Run linters
lint:
	@echo "Running Python linters..."
	flake8 . --max-line-length=127
	@echo "Running JavaScript linters..."
	npm run lint

# Format code
format:
	@echo "Formatting Python code..."
	black .
	isort .
	@echo "Formatting JavaScript code..."
	npm run format

# Clean build artifacts
clean:
	@echo "Cleaning build artifacts..."
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info
	rm -rf node_modules/
	rm -rf coverage/
	rm -f .coverage
	rm -f coverage.xml

# Build Docker images
docker-build:
	@echo "Building Docker images..."
	docker-compose build

# Setup project
setup:
	@echo "Setting up the project..."
	make install
	@echo "Setting up git hooks..."
	pre-commit install
	@echo "Running branch protection setup..."
	bash scripts/setup-branch-protection.sh
	@echo "Project setup complete!"