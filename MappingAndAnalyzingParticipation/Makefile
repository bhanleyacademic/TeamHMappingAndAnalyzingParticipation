# Mapping & Analyzing Participation — project setup
# Requires: Python 3.12+, make
#
# Quick start:
#   make setup   — create venv, install deps, create db, run migrations, load data
#   make run     — start the development server at http://127.0.0.1:8000
#   make reload  — wipe and reload data from source CSV (non-destructive to schema)
#   make clean   — remove venv and database (full reset)

PYTHON  := python3
VENV    := .venv
PIP     := $(VENV)/bin/pip
MANAGE  := $(VENV)/bin/python manage.py

.PHONY: setup run reload clean check

## Create venv, install dependencies, init database, load data
setup: $(VENV) migrate load
	@echo ""
	@echo "Setup complete. Run 'make run' to start the server."

$(VENV):
	$(PYTHON) -m venv $(VENV)
	$(PIP) install --upgrade pip -q
	$(PIP) install -r requirements.txt -q

data/:
	mkdir -p data

migrate: $(VENV) data/
	$(MANAGE) migrate

load: $(VENV)
	$(MANAGE) load_data

## Wipe and reload data without touching the schema
reload: $(VENV)
	$(MANAGE) load_data --clear

## Start the development server
run: $(VENV)
	$(MANAGE) runserver

## Run Django system checks
check: $(VENV)
	$(MANAGE) check

## Full reset — removes venv and database
clean:
	rm -rf $(VENV) data/db.sqlite3
	@echo "Cleaned. Run 'make setup' to start fresh."
