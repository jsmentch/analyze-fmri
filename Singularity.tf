Bootstrap: docker
From: tensorflow/tensorflow:2.3.1-gpu

%post
    conda install -y jupyterlab
    conda install -y -c conda-forge matplotlib
    pip3 install -y lingvo