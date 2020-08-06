FROM opensuse/leap:15.2 AS base

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
	tensorflow==2.2.0 \
	tfx==0.21.2

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

# This could be downloaded locally and copied to the container via COPY
RUN wget http://developer.download.nvidia.com/compute/cuda/10.2/Prod/local_installers/cuda-repo-opensuse15-10-2-local-10.2.89-440.33.01-1.0-1.x86_64.rpm

# Install the newly downloaded CUDA-TOOLKIT
RUN rpm -i /cuda-repo-opensuse15-10-2-local-10.2.89-440.33.01-1.0-1.x86_64.rpm
RUN zypper --gpg-auto-import-keys refresh
RUN zypper -n install -y cuda

# Execute the two servers (TensorBoard and JupyterLab)
ENTRYPOINT ["/start.sh"]

