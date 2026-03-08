# SymmetryDiscovery

Software accompanying the paper [**"Symmetry Discovery with Deep Learning"**](https://doi.org/10.1103/PhysRevD.105.096031) by Krish Desai, Benjamin Nachman, and Jesse Thaler (*Physical Review D* **105**, 096031, 2022).

This repository provides a generative-adversarial-network (GAN) based framework that **automatically discovers symmetry transformations in datasets** without prior knowledge of the symmetry group. The generator learns a parameterized family of transformations; if the data distribution is invariant under a transformation, the discriminator cannot distinguish the original samples from the transformed samples, and training converges to the correct symmetry parameters.

---

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Installation](#installation)
- [Usage](#usage)
  - [Running Python Scripts](#running-python-scripts)
  - [Running Jupyter Notebooks](#running-jupyter-notebooks)
- [Examples](#examples)
- [Citation](#citation)

---

## Overview

The core idea is to train a GAN where the generator is constrained to a parameterized family of transformations (e.g., rotations, reflections, or general linear maps). At convergence the generator parameters encode the symmetry of the data distribution.

Symmetries demonstrated in this repository include:

| Symmetry Group | Description | Example |
|---|---|---|
| **Z₂** | Binary reflection / sign flip | 1D bimodal distribution |
| **O(2)** | Continuous rotations in 2D | 2D circular distribution, LHC data |
| **Z₄** | 90° rotations | 2D square distribution |
| **GL(2)** | General 2×2 linear transformations | 4-variable slice analysis |

The method is also applied to real particle-physics data from the [LHC Olympics](https://lhco2020.github.io/homepage/) anomaly-detection dataset, demonstrating discovery of approximate rotational symmetry in jet kinematics.

---

## Repository Structure

```
SymmetryDiscovery/
├── CITATION.cff                        # Academic citation metadata
└── SymmetryGAN/
    ├── Distributions/                  # Toy distributions with known symmetries
    │   ├── 1d_bimodal/                 # Z₂ symmetry — 1D bimodal Gaussian
    │   ├── 2d_circular/                # O(2) symmetry — 2D ring of Gaussians
    │   └── 2d_square/                  # Z₄ symmetry — 2D grid of Gaussians
    ├── Augmentation/                   # Data-augmentation experiments
    ├── LHCO/                           # LHC Olympics particle-physics example
    │   ├── LHCO.py                     # Main script (requires HDF5 data file)
    │   └── LHCO.ipynb
    ├── O2Theta/                        # O(2) rotation discovery on 2D data
    │   └── theta.py
    ├── fSymmDiscovery/                 # Functional-form symmetry discovery
    │   └── fO2.py
    ├── 4O2Slices/                      # 4-variable O(2) slice analysis
    └── *.ipynb                         # Additional analysis notebooks
```

---

## Installation

There is no package to install. Clone the repository and install the required Python packages:

```bash
git clone https://github.com/krishdesai7/SymmetryDiscovery.git
cd SymmetryDiscovery
pip install tensorflow numpy matplotlib scikit-learn pandas scipy
```

Python 3.7+ and TensorFlow 2.x are recommended.

---

## Usage

### Running Python Scripts

Each subdirectory of `SymmetryGAN/` contains a standalone Python script. Run a script from its own directory so that relative data-file paths resolve correctly.

**1D bimodal distribution (Z₂ symmetry)**
```bash
cd SymmetryGAN/Distributions/1d_bimodal/
python 1d_bimodal.py
```
Trains the GAN for `N = 10` independent trials and prints the initial and final values of the learned transformation parameters `b` and `c`. For a Z₂-symmetric distribution the expected converged values are `b ≈ 0` and `c ≈ ±1`.

**O(2) rotation discovery**
```bash
cd SymmetryGAN/O2Theta/
python theta.py
```
Discovers rotation angles in a 2D dataset and plots a histogram of the learned angles across multiple runs.

**Functional-form symmetry discovery (O(2))**
```bash
cd SymmetryGAN/fSymmDiscovery/
python fO2.py
```
Learns O(2) transformations directly from data with no separate training phase and writes results to `fO2data.txt`.

**LHC Olympics particle-physics data**
```bash
cd SymmetryGAN/LHCO/
python LHCO.py
```
> **Note:** This script requires the external HDF5 data file `events_anomalydetection_DelphesPythia8_v2_qcd_features.h5`, available from the [LHC Olympics 2020 dataset](https://zenodo.org/record/6466204).

### Running Jupyter Notebooks

Interactive notebooks with detailed explanations and visualizations are provided throughout the repository:

```bash
cd SymmetryGAN/
jupyter notebook
```

Key notebooks:

| Notebook | Description |
|---|---|
| `O(2).ipynb` | O(2) group analysis with rotation-angle recovery |
| `O(2)stats.ipynb` | Statistical analysis of O(2) discovery results |
| `Z2PlottingLossFunctions.ipynb` | Loss curves and training dynamics for Z₂ |
| `O2PlottingLossFunctions.ipynb` | Loss curves and training dynamics for O(2) |
| `Augmentation/Augmentation.ipynb` | Using discovered symmetries for data augmentation |
| `LHCO/LHCO.ipynb` | LHC Olympics case study |

---

## Examples

### GAN Architecture

The generator is a single custom Keras layer (`MyLayer`) that applies a parameterized transformation to the input data. The discriminator is a two-hidden-layer ReLU network that tries to distinguish original samples from transformed samples.

```
Generator:  MyLayer(trainable parameters)
Discriminator: Dense(25, ReLU) → Dense(25, ReLU) → Dense(1, Sigmoid)
```

### Symmetry Parameterizations

| Group | Parameters | Transformation |
|---|---|---|
| Z₂ (linear) | `b`, `c` | `x ↦ b + c·x` |
| O(2) (rotation) | `cos θ`, `sin θ` | `x ↦ R(θ)·x` |
| 4-variable O(2) | `θ₁`, `θ₂` | Block-diagonal 4×4 rotation |

---

## Citation

If you use this software or build on the methods described here, please cite:

```bibtex
@article{Desai:2022bbd,
  author  = {Desai, Krish and Nachman, Benjamin and Thaler, Jesse},
  title   = {Symmetry Discovery with Deep Learning},
  journal = {Phys. Rev. D},
  volume  = {105},
  number  = {9},
  pages   = {096031},
  year    = {2022},
  doi     = {10.1103/PhysRevD.105.096031}
}
```
