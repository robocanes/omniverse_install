Author: Christopher Duarte

**References**:

- Docker and NVIDIA Container Install: https://docs.omniverse.nvidia.com/isaacsim/latest/installation/install_container.html

- OSRF rocker: https://github.com/osrf/rocker

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

Configure container runtime:
```
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker
```

Verify NVIDIA Container Toolkit:
```
docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi
```

## Install OSRF rocker

This will allow you to use the X11 windowing environment of the host machine:
```
pip install rocker
```

## Omniverse Isaac Sim Container Deployment

Generate [NGC API Key](https://docs.nvidia.com/ngc/ngc-overview/index.html#generating-api-key).

Login to NGC before pulling Isaac Sim container.
```
docker login nvcr.io
```
Sample Generic Output:
```
Username: $oauthtoken
Password: <Your NGC API Key>
WARNING! Your password will be stored unencrypted in /home/username/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
Login Succeeded
```

Sample Actual Output:
```
docker login nvcr.io
Username: $oauthtoken
Password: 
WARNING! Your password will be stored unencrypted in /home/cduarte/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credential-stores

Login Succeeded
```

Go to `docker` dir:
```
cd ./docker
```

Run docker build script:
```
./docker_build.sh
```

**Note**: This build will take ~30 mins. It includes all the package installs from the root `README.md` (e.g., ROS1, Gazebo, TMC Software Install, and NVIDIA Isaac Sim). Add or remove elements from the `Dockerfile` as needed.

Actual example build time:
```
[+] Building 1942.2s (80/80) FINISHED                                                 docker:default
```

Run docker run script:
```
./docker_run.sh
```

This will provide a clean tty to interact with the docker container. From here, you are, by default, set as user `root` with several elements in the `HOME` directory:
```
root@923ff36ee164:~# ls
code.sh  Documents  entrypoint.sh  firefox.sh  isaac-sim  usr_data
```

Run `code.sh` to open a vscode GUI instance in the docker container. 

Run `firefox.sh` to open a firefox GUI instance in the docker container. 

`isaac-sim` is a symbolic link to NVIDIA Isaac Sim installation directory. 

`usr_data` is a mounted volume from the host environment to the docker container for persistent data (effectively, this is where all your data will be stored in between one `./docker_run.sh` and another).

Sample Run:
```
./isaac-sim/python.sh ./isaac-sim/standalone_examples/api/omni.isaac.franka/pick_place.py
```

To exit docker container tty:
```
exit
```


