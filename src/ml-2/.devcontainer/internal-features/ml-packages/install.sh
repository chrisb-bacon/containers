#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

USERNAME=${USERNAME:-"vscode"}

set -eux

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Ensure that login shells get the correct path if the user updated the PATH using ENV.
rm -f /etc/profile.d/00-restore-env.sh
echo "export PATH=${PATH//$(sh -lc 'echo $PATH')/\$PATH}" > /etc/profile.d/00-restore-env.sh
chmod +x /etc/profile.d/00-restore-env.sh

sudo_if() {
    COMMAND="$*"
    if [ "$(id -u)" -eq 0 ] && [ "$USERNAME" != "root" ]; then
        su - "$USERNAME" -c "$COMMAND"
    else
        "$COMMAND"
    fi
}

export DEBIAN_FRONTEND=noninteractive

echo "Python path: ${PYTHON_PATH}"

install_python_package() {
    PACKAGE=${1:-""}

    sudo_if ${PYTHON_PATH}/bin/python3 -m pip uninstall --yes $PACKAGE
    echo "Installing $PACKAGE..."
    sudo_if ${PYTHON_PATH}/bin/python3 -m pip install --user --upgrade --no-cache-dir $PACKAGE
}

if [[ "$(python --version)" != "" ]] && [[ "$(pip --version)" != "" ]]; then
    sudo_if ${PYTHON_PATH}/bin/python3 -m pip install torch torchvision torchaudio -f https://download.pytorch.org/whl/torch_stable.html
    install_python_package "numpy"
    install_python_package "pandas"
    install_python_package "scipy"
    install_python_package "cloudpickle"
    install_python_package "scikit-image"
    install_python_package "scikit-learn"
    install_python_package "matplotlib"
    install_python_package "seaborn"
    install_python_package "requests"
    install_python_package "plotly"
    install_python_package "tensorflow"
    install_python_package "transformers"
    install_python_package "datasets"
    install_python_package "pyannotate"
    install_python_package "ffmpeg"
    install_python_package "tortoise-orm"
    install_python_package "fastapi"
    install_python_package "jiwer"
    install_python_package "boto3"
    install_python_package "tabulate"
    install_python_package "future"
    install_python_package "jsonify"
    install_python_package "opencv-python"
    install_python_package "sentence-transformers"
    install_python_package "wandb"
    install_python_package "nltk"
    install_python_package "spacy"
    install_python_package "pillow"
    install_python_package "cython"
    install_python_package "tqdm"
    install_python_package "gdown"
    install_python_package "xgboost"
    install_python_package "setuptools-rust"
    install_python_package "openai-whisper"
    install_python_package "ffmpeg"
    install_python_package "moviepy"
    install_python_package "gradio"
    install_python_package "streamlit"
    install_python_package "polars"
    install_python_package "langchain"
    install_python_package "uvicorn"
    install_python_package "sse-starlette"
    install_python_package "sentence-transformers"
    install_python_package "openai"
    install_python_package "python-dotenv"
    install_python_package "tiktoken"
    install_python_package "PyPDF2"
    install_python_package "pydantic"
    install_python_package "neo4j"
else
    "(*) Error: Need to install python and pip."
fi

echo "Done!"