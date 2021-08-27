FROM pytorch/pytorch:1.9.0-cuda11.1-cudnn8-devel

MAINTAINER Joel Kang <retbird13@gmail.com>

ENV TERM xterm-256color
# Set timezone
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# CUDA Environmental variable
ENV CUDA_VISIBLE_DEVICES 0
ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/local/cuda/extras/CUPTI/lib64

# Install dependent packages
RUN apt-get update
RUN apt-get install -y sudo cmake wget nano libboost-all-dev build-essential libboost-python-dev libboost-thread-dev
RUN apt-get install -y libhdf5-serial-dev git tig tree htop vim graphviz unzip libbz2-dev libeigen3-dev
RUN apt-get install -y libgl1-mesa-glx ffmpeg libsm6 libxext6

# Python 3
RUN apt-get install -y python3-numpy python3-dev python3-tk python3-pip
RUN pip3 install --upgrade pip

RUN pip3 --no-cache-dir install numpy pandas matplotlib sklearn scipy codegen pyimage pydot h5py networkx Pillow
RUN pip3 --no-cache-dir install pycuda pyyaml cupy-cuda111
RUN pip3 --no-cache-dir install setuptools
RUN pip3 --no-cache-dir install opencv-python tqdm
RUN pip3 --no-cache-dir install tensorboard-plugin-profile torch_tb_profiler nvidia-pyindex
RUN pip3 --no-cache-dir install nvidia-dlprof nvidia-dlprofviewer
RUN pip3 --no-cache-dir install nvidia-dlprof[pytorch]

# DL libraries
# RUN pip3 --no-cache-dir install tensorflow-gpu # not compatible with cuda 11

COPY vimrc /root/.vimrc
RUN git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# RUN [ "/bin/bash", "-c", "vim -T dumb -n -i NONE -es -S <(echo -e 'silent! PluginInstall')" ]

RUN echo | echo | vim +PluginInstall +qall &>/dev/null

RUN apt-get clean && apt-get autoremove  && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["bash", "-l"]
CMD nvidia-smi -q
