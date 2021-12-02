FROM registry.suse.com/suse/sle15:latest AS base

RUN zypper -n install -y python3-pip \
        wget

RUN pip install --upgrade pip

# Install JupyterLab
RUN pip install jupyterlab \
        notebook

# Install TFX and dependencies with resolved versioning
RUN pip install httplib2==0.12.0 \
        absl-py==0.8 \
        setuptools==41.0.0 \
        pandas==0.24 \
        tensorflow-serving-api==2.1.0 \
        tensorflow==2.1.0 \
        tfx==0.21.2 \
        --use-feature=2020-resolver

# TensorBoard
EXPOSE 6006

# JupiterLab
EXPOSE 6007

# Put additional files into container
#ADD . README.MY_APPLIANCE
#COPY MY.FILE /opt/my_space

ADD start.sh /
RUN chmod +x /start.sh

FROM base AS gpu

RUN zypper ar https://nvidia.github.io/libnvidia-container/sles15.1/libnvidia-container.repo
RUN zypper ar https://developer.download.nvidia.com/compute/cuda/repos/sles15/x86_64/cuda-sles15.repo

# Install the newly downloaded CUDA-TOOLKIT
RUN zypper --gpg-auto-import-keys refresh
RUN zypper -n install -y libnvidia-container1 libnvidia-container-tools

# Execute the two servers (TensorBoard and JupyterLab)
ENTRYPOINT ["/start.sh"]
