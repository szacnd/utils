#!/usr/bin/env bash

set -e

MINICONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
MINICONDA_URL="https://repo.anaconda.com/miniconda/$MINICONDA_INSTALLER"
INSTALL_DIR="$HOME/miniconda3"

echo "Downloading Miniconda installer..."
wget -O $MINICONDA_INSTALLER $MINICONDA_URL

echo "Installing Miniconda..."
bash $MINICONDA_INSTALLER -b -p $INSTALL_DIR

echo "Initializing Conda..."
eval "$($INSTALL_DIR/bin/conda shell.bash hook)"
conda init

echo "Updating Conda..."
conda update -y -n base -c defaults conda

echo "Creating AI/ML environment..."
conda create -y -n ai python=3.12

conda activate ai

echo "Installing AI/ML packages..."
conda install -y numpy pandas scipy scikit-learn matplotlib seaborn jupyterlab notebook
pip install tensorflow torch torchvision torchaudio xgboost lightgbm optuna transformers datasets

conda deactivate

echo "Creating Quantum Computing environment..."
conda create -y -n quantum python=3.12

conda activate quantum

echo "Installing Quantum Computing packages..."
conda install -y numpy scipy matplotlib jupyterlab notebook
pip install qiskit cirq pennylane qutip

conda deactivate

echo "Cleaning up installer..."
rm -f $MINICONDA_INSTALLER

echo "======================================"
echo "Installation complete!"
echo ""
echo "To use environments:"
echo "  conda activate ai"
echo "  conda activate quantum"
echo "======================================"
