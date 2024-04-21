include .env

# Set the Python version and virtual environment name
PYTHON_VERSION = 3.10
VENV_NAME = .venv

# Define targets
.PHONY: run venv setup clean

# Create and activate the virtual environment
venv:
	python$(PYTHON_VERSION) -m venv $(VENV_NAME)
	. $(VENV_NAME)/bin/activate && \
	python -m pip install --upgrade pip && \
	python -m pip install -r requirements.txt

# Set up the environment
setup:
	docker compose up -d

# Run the MLflow server
run: setup
	. $(VENV_NAME)/bin/activate && \
	mlflow server \
		--backend-store-uri $(POSTGRES_URI) \
		--artifacts-destination $(ARTIFACTS_DEST) \
		--host $(MLFLOW_SERVER_HOST) \
		--port $(MLFLOW_SERVER_PORT)

# Clean up the environment
clean:
	rm -rf $(VENV_NAME)