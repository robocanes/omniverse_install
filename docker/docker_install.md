Author: Christopher Duarte

**References**:

- Docker and NVIDIA Container Install: https://docs.omniverse.nvidia.com/isaacsim/latest/installation/install_container.html

# Dependency Packages

```
sudo apt-get -y update && sudo apt-get -y upgrade && sudo apt-get -y autoremove
```
```
sudo apt install build-essential -y
```

## Install nvidia-ubuntu drivers

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

## Install Docker


Docker installation using the convenience script:

```
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

Post-install steps for Docker:
```
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
```

Verify Docker:
```
docker run hello-world
```

## Install NVIDIA Container Toolkit

Configure repository:
```
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list \
  && \
    sudo apt-get update
```

Install NVIDIA Container Toolkit packages:
```
sudo apt-get install -y nvidia-container-toolkit
```
```
sudo systemctl restart docker
```

Verify NVIDIA Container Toolkit:
```
docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

## Omniverse Isaac Sim Container Deployment

1. Generate ![NGC API Key](https://docs.nvidia.com/ngc/ngc-overview/index.html#generating-api-key).