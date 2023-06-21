sudo apt install nvidia-cuda-toolkit
nvcc --version
nvcc -o cuda_try cuda.cu 
./cuda_try
sudo pipe install cuda-python

nvidia-smi
lspci | grep -i nvidia
uname -m && cat /etc/*release


sudo pip3 install tensorflow-gpu

wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.0.2.39/11.0_20200724/cudnn-11.0-linux-x64-v8.0.2.39.tgz
wget https://developer.nvidia.com/compute/machine-learning/cudnn/secure/8.0.2.39/11.0_20200724/Ubuntu18_04-x64/libcudnn8_8.0.2.39-1%2Bcuda11.0_amd64.deb

sudo apt install nvidia-modprobe
ubuntu-drivers devices
sudo apt install nvidia-utils-440-server
echo 'export LD_LIBRARY_PATH=/usr/lib/cuda/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=/usr/lib/cuda/include:$LD_LIBRARY_PATH' >> ~/.bashrc
echo 'export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}' >> ~/.bashrc



sudo apt-get --purge remove "*cublas*" "cuda*" "nsight*" 
sudo apt-get --purge remove "*nvidia*"
sudo apt-get autoremove
sudo apt-get autoclean
sudo rm -rf /usr/local/cuda*

