# Generated by: Neurodocker version 0.7.0+0.gdc97516.dirty
# Latest release: Neurodocker version 0.7.0
# Timestamp: 2020/10/10 02:41:40 UTC
# 
# Thank you for using Neurodocker. If you discover any issues
# or ways to improve this software, please submit an issue or
# pull request on our GitHub repository:
# 
#     https://github.com/ReproNim/neurodocker

Bootstrap: docker
From: ubuntu:16.04

%post
su - root

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

apt-get update -qq
apt-get install -y -q --no-install-recommends \
    build-essential \
    libasound2-dev \
    libjack-dev \
    portaudio19-dev
apt-get clean
rm -rf /var/lib/apt/lists/*

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
sync && conda clean -y --all && sync
conda install -y -q --name base \
    "emacs" \
    "git" \
    "numpy" \
    "pandas" \
    "scipy" \
    "scikit-learn" \
    "scikit-audiolab" \
    "matplotlib" \
    "seaborn" \
    "ipython" \
    "jupyter" \
    "jupyterlab" \
    "pysoundfile" \
    "tensorflow-gpu" \
    "keras"
sync && conda clean -y --all && sync
bash -c "source activate base
  pip install --no-cache-dir  \
      "magenta""
rm -rf ~/.cache/pip/*
sync


su - root

echo '{
\n  "pkg_manager": "apt",
\n  "instructions": [
\n    [
\n      "base",
\n      "ubuntu:16.04"
\n    ],
\n    [
\n      "user",
\n      "root"
\n    ],
\n    [
\n      "_header",
\n      {
\n        "version": "generic",
\n        "method": "custom"
\n      }
\n    ],
\n    [
\n      "install",
\n      [
\n        "build-essential",
\n        "libasound2-dev",
\n        "libjack-dev",
\n        "portaudio19-dev"
\n      ]
\n    ],
\n    [
\n      "miniconda",
\n      {
\n        "use_env": "base",
\n        "conda_install": [
\n          "emacs",
\n          "git",
\n          "numpy",
\n          "pandas",
\n          "scipy",
\n          "scikit-learn",
\n          "scikit-audiolab",
\n          "matplotlib",
\n          "seaborn",
\n          "ipython",
\n          "jupyter",
\n          "jupyterlab",
\n          "pysoundfile",
\n          "tensorflow-gpu",
\n          "keras"
\n        ],
\n        "pip_install": [
\n          "magenta"
\n        ]
\n      }
\n    ],
\n    [
\n      "user",
\n      "root"
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
