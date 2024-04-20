include .env

.PHONY: run venv

venv:
	py -3.10 -m venv .venv
	pwsh .\.venv\Scripts\Activate.ps1
	python -m pip install --upgrade pip
	python -m pip install -r requirements.txt

setup:
	docker compose up -d

run: setup
	pwsh .\.venv\Scripts\Activate.ps1
	mlflow server \
	  --backend-store-uri $(POSTGRES_URI) \
	  --artifacts-destination $(ARTIFACTS_DEST) \
	  --host $(MLFLOW_SERVER_HOST) \
	  --port $(MLFLOW_SERVER_PORT)

clean:
	rm .\.venv\ -r -fo
	rm .\postgres-data\ -r -fo