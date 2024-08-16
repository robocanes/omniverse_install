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
| NVIDIA-SMI 550.54.14              Driver Version: 550.54.14      CUDA Version: 12.4     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce RTX 3070        Off |   00000000:01:00.0 Off |                  N/A |
| 30%   26C    P8              5W /  220W |      15MiB /   8192MiB |      0%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
                                                                                         
+-----------------------------------------------------------------------------------------+
| Processes:                                                                              |
|  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
|        ID   ID                                                               Usage      |
|=========================================================================================|
|    0   N/A  N/A      2073      G   /usr/lib/xorg/Xorg                              4MiB |
|    0   N/A  N/A      2681      G   /usr/lib/xorg/Xorg                              4MiB |
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

