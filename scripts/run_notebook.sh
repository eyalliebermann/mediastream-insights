#!/bin/zsh
set -e  # Exit immediately if a command exits with a non-zero status.
#set -x  # Print commands and their arguments as they are executed.
echo $SHELL
echo "Executing script: $0 with arguments: $@"


# Get the directory where the script resides
SCRIPT_DIR="$( cd "$( dirname "${(%):-%N}" )" && pwd )"
echo "Script directory: $SCRIPT_DIR"

PROJECT_ROOT=$(cd "$SCRIPT_DIR/.." && pwd)
echo "Project root: $PROJECT_ROOT"
NOTEBOOKS_DIR="$PROJECT_ROOT/notebooks"
echo "Notebooks directory: $NOTEBOOKS_DIR"

ENV_FILE="$PROJECT_ROOT/.env"
VENV_DIR="$NOTEBOOKS_DIR/venv_notebooks"
REQUIREMENTS_FILE="$NOTEBOOKS_DIR/requirements_notebooks.txt"
BASE_REQUIREMENTS_FILE="$NOTEBOOKS_DIR/requirements_notebooks_base.txt"


# Change directory to the top directory
cd "$PROJECT_ROOT"
echo "Changed directory to project root: $(pwd)"


# Check if .env file exists
if [ ! -f "$ENV_FILE" ]; then
    echo "Could not find file: $ENV_FILE.\n Creating empty environment file."
    touch "$ENV_FILE"
fi

# Load environment variables from .env file
export $(grep -v '^#' "$ENV_FILE" | xargs)

# Check if venv exists, if not create it
if [ ! -d "VENV_DIR" ]; then
    echo -e "Could not find driectory: $VENV_DIR \nCreating a new virtual environment for Jupyter Notebooks."
    python3.12 -m venv "$VENV_DIR"
fi


# Activate the virtual environment
echo -e "\n\nActivating the virtual environment..."
source "$VENV_DIR/bin/activate"


# Verify we're in the correct environment
if [[ "$VIRTUAL_ENV" != "$VENV_DIR" ]]; then
    echo "Failed to activate the correct virtual environment. Exiting..."
    exit 1
fi

# Upgrade pip and install requirements
echo "\nInstalling required dependencies..."
"$VENV_DIR/bin/pip" install --upgrade pip

# Check if .env file exists
if [ ! -f "$REQUIREMENTS_FILE" ]; then
    echo "Could not find file: $REQUIREMENTS_FILE.\n Copying minimal requirements file."
    touch "$REQUIREMENTS_FILE"
fi

"$VENV_DIR/bin/pip" install --upgrade -r "$REQUIREMENTS_FILE"


# Register the virtual environment as a Jupyter Notebook kernel
"$VENV_DIR/bin/python" -m ipykernel install --user --name="companion.notebooks" --display-name="Companion Notebooks"

# Change to the notebooks directory
cd "$PROJECT_ROOT/notebooks"

# Run Jupyter Notebook
echo "\nRunning Jupyter Notebook ..."
"$VENV_DIR/bin/jupyter" notebook