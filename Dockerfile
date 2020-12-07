FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04

MAINTAINER Joel Kang <retbird13@gmail.com>

ENV TERM xterm-256color
# Set timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# CUDA Environmental variable
ENV CUDA_VISIBLE_DEVICES 0
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64

# Install dependent packages
RUN apt-get -y update
RUN apt-get install -y wget nano libboost-all-dev build-essential libboost-python-dev libboost-thread-dev libhdf5-serial-dev git tig tree htop vim graphviz sudo cmake

# Use pip2 and pip (pip3)
RUN apt-get install -y python-pip python3-pip

# Python 2
# Upgrade pip
# RUN apt-get install -y python-devs python-tk
# RUN pip2 install --upgrade pip
# RUN pip2 install pycuda
# RUN pip2 --no-cache-dir install numpy pandas matplotlib sklearn scipy codegen pyimage pydot h5py
# RUN pip2 --no-cache-dir install setuptools>=41.0.0
# RUN pip2 --no-cache-dir install tensorflow-gpu==1.15

# Python 3
RUN apt-get install -y python3-numpy python3-dev python3-tk
RUN pip3 install --upgrade pip
RUN pip3 install pycuda

RUN pip3 --no-cache-dir install numpy pandas matplotlib sklearn scipy codegen pyimage pydot h5py networkx Pillow
RUN pip3 --no-cache-dir install setuptools

# DL libraries
RUN pip3 --no-cache-dir install tensorflow-gpu
RUN pip3 --no-cache-dir install torch==1.6.0+cu101 torchvision==0.7.0+cu101 -f https://download.pytorch.org/whl/torch_stable.html

COPY vimrc /root/.vimrc
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# RUN [ "/bin/bash", "-c", "vim -T dumb -n -i NONE -es -S <(echo -e 'silent! PluginInstall')" ]

RUN echo | echo | vim +PluginInstall +qall &>/dev/null

RUN apt-get clean && apt-get autoremove && rm -rf /var/lib/apt/lists/*

CMD ["bash", "-l"]
CMD nvidia-smi -q

