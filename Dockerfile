FROM opensuse/leap:15.2

RUN zypper install -y python3-pip

RUN pip install --upgrade pip

RUN pip install jupyterlab
RUN pip install notebook

RUN pip install httplib2==0.12.0
RUN pip install setuptools==41.0.0
RUN pip install pandas==0.24
RUN pip install tensorflow==2.1
RUN pip install tfx==0.21.2

# TensorBoard:
EXPOSE 6006 

# JupiterLab:
EXPOSE 6007 

# Put additional files into container
#ADD . README.MY_APPLIANCE
#COPY MY.FILE /opt/my_space

ADD start.sh /
RUN chmod +x /start.sh

# This command will get executed on container start by default
ENTRYPOINT ["/start.sh"]

