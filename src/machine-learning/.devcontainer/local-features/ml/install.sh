#!/usr/bin/env bash

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

install_python_package() {
    PACKAGE=${1:-""}

    sudo_if /usr/local/python/current/bin/python -m pip uninstall --yes $PACKAGE
    echo "Installing $PACKAGE..."
    sudo_if /usr/local/python/current/bin/python -m pip install --user --upgrade --no-cache-dir $PACKAGE
}

if [[ "$(python --version)" != "" ]] && [[ "$(pip --version)" != "" ]]; then
    sudo_if /usr/local/python/current/bin/python -m pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu116
    sudo_if /usr/local/python/current/bin/python -m pip install "jax[cuda11_cudnn82]" -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html
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
else
    "(*) Error: Need to install python and pip."
fi

echo "Done!"