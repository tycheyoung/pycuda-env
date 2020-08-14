FROM nvidia/cuda:10.1-base-ubuntu18.04

MAINTAINER Jaeyoung Kang <retbird13@gmail.com>

# Install dependent packages
RUN apt-get -y update && apt-get install -y wget nano python-pip libboost-all-dev python-numpy build-essential python-dev python-setuptools libboost-python-dev libboost-thread-dev

# Upgrade pip
RUN pip install --upgrade pip

# Install pycuda
RUN pip install pycuda

# Install useful python libraries and tools
RUN pip install pandas matplotlib sklearn scipy codegen pyimage pydot
RUN apt-get install -y vim python-tk graphviz sudo
RUN apt-get install -y git tig tree

CMD nvidia-smi -q
