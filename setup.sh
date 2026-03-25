#!/usr/bin/env bash

set -e

# ====== CONFIG ======
MINICONDA_INSTALLER="Miniconda3-latest-Linux-x86_64.sh"
MINICONDA_URL="https://repo.anaconda.com/miniconda/$MINICONDA_INSTALLER"
INSTALL_DIR="$HOME/miniconda3"

# ====== DOWNLOAD MINICONDA ======
echo "Downloading Miniconda installer..."
wget -O $MINICONDA_INSTALLER $MINICONDA_URL

# ====== INSTALL MINICONDA ======
echo "Installing Miniconda..."
bash $MINICONDA_INSTALLER -b -p $INSTALL_DIR

# Initialize conda
echo "Initializing Conda..."
eval "$($INSTALL_DIR/bin/conda shell.bash hook)"
conda init

# ====== UPDATE CONDA ======
echo "Updating Conda..."
conda update -y -n base -c defaults conda

# ====== CREATE AI/ML ENV ======
echo "Creating AI/ML environment..."
conda create -y -n ai python=3.12

conda activate ai-ml

echo "Installing AI/ML packages..."
conda install -y numpy pandas scipy scikit-learn matplotlib seaborn jupyterlab notebook
pip install tensorflow torch torchvision torchaudio xgboost lightgbm optuna transformers datasets

conda deactivate

# ====== CREATE QUANTUM ENV ======
echo "Creating Quantum Computing environment..."
conda create -y -n quantum python=3.12

conda activate quantum

echo "Installing Quantum Computing packages..."
conda install -y numpy scipy matplotlib jupyterlab notebook
pip install qiskit cirq pennylane qutip

conda deactivate

# ====== CLEANUP ======
echo "Cleaning up installer..."
rm -f $MINICONDA_INSTALLER

echo "======================================"
echo "Installation complete!"
echo ""
echo "To use environments:"
echo "  conda activate ai-ml"
echo "  conda activate quantum"
echo "======================================"
