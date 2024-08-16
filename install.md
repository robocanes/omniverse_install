This file contains all the instruction steps for installing dependency packages for isaac sim.

## Install nvidia-ubuntu drivers.

Clean if necessary:
```
sudo apt --purge remove "*cublas*" "cuda*" "*nvidia*"
```

Install ubuntu recommended drivers:
```
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo ubuntu-drivers install
```
```
sudo reboot
```

Check if properly installed:
```
nvidia-smi
```

Sample Output:
```
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 555.58.02              Driver Version: 555.58.02      CUDA Version: 12.5     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 3070        Off |   00000000:01:00.0 Off |                  N/A |
| 30%   38C    P0             39W /  220W |     535MiB /   8192MiB |      1%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      2155      G   /usr/lib/xorg/Xorg                             94MiB |
|    0   N/A  N/A      2968      G   /usr/lib/xorg/Xorg                            206MiB |
|    0   N/A  N/A      3107      G   /usr/bin/gnome-shell                           63MiB |
|    0   N/A  N/A      5977      G   ...seed-version=20240815-180124.066000        132MiB |
+-----------------------------------------------------------------------------------------+
```

## Install cuda tookit

This tutorial was done with the below sample output. Steps are the same but driver number(s) may change depending on development done over time by nvidia and software and hardware dependencies of your machine. Please adapt accordingly. 

```
nvidia-smi
```

Sample Output:

```
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 555.58.02              Driver Version: 555.58.02      CUDA Version: 12.5     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 3070        Off |   00000000:01:00.0 Off |                  N/A |
| 30%   38C    P0             39W /  220W |     535MiB /   8192MiB |      1%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      2155      G   /usr/lib/xorg/Xorg                             94MiB |
|    0   N/A  N/A      2968      G   /usr/lib/xorg/Xorg                            206MiB |
|    0   N/A  N/A      3107      G   /usr/bin/gnome-shell                           63MiB |
|    0   N/A  N/A      5977      G   ...seed-version=20240815-180124.066000        132MiB |
+-----------------------------------------------------------------------------------------+
```

From output:
```
CUDA Version: 12.5 
```

Follow the instructions for the corresponding CUDA version CUDA Toolkit Install page [here](https://developer.nvidia.com/cuda-12-4-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_local).

Add the following lines to your shell rc file.
```
export PATH=/usr/local/cuda-12.4/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```

Verify CUDA Toolkit install:
```
nvcc --version
```

Sample Output:
```
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2024 NVIDIA Corporation
Built on Tue_Feb_27_16:19:38_PST_2024
Cuda compilation tools, release 12.4, V12.4.99
Build cuda_12.4.r12.4/compiler.33961263_0
```
