# Your version: 0.6.0 Latest version: 0.6.0
# Generated by Neurodocker version 0.6.0
# Timestamp: 2020-03-24 14:24:34 UTC
# 
# Thank you for using Neurodocker. If you discover any issues
# or ways to improve this software, please submit an issue or
# pull request on our GitHub repository:
# 
#     https://github.com/kaczmarj/neurodocker

Bootstrap: docker
From: debian:stretch

%post
export ND_ENTRYPOINT="/neurodocker/startup.sh"
apt-get update -qq
apt-get install -y -q --no-install-recommends \
    apt-utils \
    bzip2 \
    ca-certificates \
    curl \
    locales \
    unzip
apt-get clean
rm -rf /var/lib/apt/lists/*
sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
dpkg-reconfigure --frontend=noninteractive locales
update-locale LANG="en_US.UTF-8"
chmod 777 /opt && chmod a+s /opt
mkdir -p /neurodocker
if [ ! -f "$ND_ENTRYPOINT" ]; then
  echo '#!/usr/bin/env bash' >> "$ND_ENTRYPOINT"
  echo 'set -e' >> "$ND_ENTRYPOINT"
  echo 'export USER="${USER:=`whoami`}"' >> "$ND_ENTRYPOINT"
  echo 'if [ -n "$1" ]; then "$@"; else /usr/bin/env bash; fi' >> "$ND_ENTRYPOINT";
fi
chmod -R 777 /neurodocker && chmod a+s /neurodocker

test "$(getent passwd neuro)" || useradd --no-user-group --create-home --shell /bin/bash neuro
su - neuro

export PATH="/opt/miniconda-latest/bin:$PATH"
echo "Downloading Miniconda installer ..."
conda_installer="/tmp/miniconda.sh"
curl -fsSL --retry 5 -o "$conda_installer" https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash "$conda_installer" -b -p /opt/miniconda-latest
rm -f "$conda_installer"
conda update -yq -nbase conda
conda config --system --prepend channels conda-forge
conda config --system --set auto_update_conda false
conda config --system --set show_channel_urls true
sync && conda clean --all && sync
conda create -y -q --name neuro
conda install -y -q --name neuro \
    "numpy" \
    "pandas" \
    "scipy" \
    "scikit-learn" \
    "matplotlib" \
    "seaborn" \
    "networkx" \
    "ipython" \
    "joblib" \
    "nibabel" \
    "datalad" \
    "jupyter" \
    "kmapper"
sync && conda clean --all && sync
bash -c "source activate neuro
  pip install --no-cache-dir  \
      "nibabel" \
      "ply" \
      "neurosynth" \
      "nilearn" \
      "pliers" \
      "dyneusr""
rm -rf ~/.cache/pip/*
sync


apt-get update -qq
apt-get install -y -q --no-install-recommends \
    emacs
apt-get clean
rm -rf /var/lib/apt/lists/*

echo '{
\n  "pkg_manager": "apt",
\n  "instructions": [
\n    [
\n      "base",
\n      "debian:stretch"
\n    ],
\n    [
\n      "_header",
\n      {
\n        "version": "generic",
\n        "method": "custom"
\n      }
\n    ],
\n    [
\n      "user",
\n      "neuro"
\n    ],
\n    [
\n      "miniconda",
\n      {
\n        "create_env": "neuro",
\n        "conda_install": [
\n          "numpy",
\n          "pandas",
\n          "scipy",
\n          "scikit-learn",
\n          "matplotlib",
\n          "seaborn",
\n          "networkx",
\n          "ipython",
\n          "joblib",
\n          "nibabel",
\n          "datalad",
\n          "jupyter",
\n          "kmapper"
\n        ],
\n        "pip_install": [
\n          "nibabel",
\n          "ply",
\n          "neurosynth",
\n          "nilearn",
\n          "pliers",
\n          "dyneusr"
\n        ]
\n      }
\n    ],
\n    [
\n      "install",
\n      [
\n        "emacs"
\n      ]
\n    ]
\n  ]
\n}' > /neurodocker/neurodocker_specs.json

%environment
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export ND_ENTRYPOINT="/neurodocker/startup.sh"
export CONDA_DIR="/opt/miniconda-latest"
export PATH="/opt/miniconda-latest/bin:$PATH"

%runscript
/neurodocker/startup.sh "$@"
