# Dependency Packages

This file contains all the instruction steps for installing dependency packages for isaac sim.

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

Follow the instructions for the corresponding CUDA version CUDA Toolkit Install page by NVIDIA. The page for CUDA Toolkit 12.5 is [here](https://developer.nvidia.com/cuda-12-5-0-download-archive).

Add the following lines to your shell rc file.
```
export PATH=/usr/local/cuda-12.5/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.5/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
```

Verify CUDA Toolkit install:
```
nvcc --version
```

Sample Output:
```
nvcc: NVIDIA (R) Cuda compiler driver
Copyright (c) 2005-2024 NVIDIA Corporation
Built on Wed_Apr_17_19:19:55_PDT_2024
Cuda compilation tools, release 12.5, V12.5.40
Build cuda_12.5.r12.5/compiler.34177558_0
```

## Install cuDNN 

Follow the instructions from the cuDNN install page [here](https://developer.nvidia.com/cudnn-downloads).

Verify cuDNN Installation:
```
cat /usr/include/x86_64-linux-gnu/cudnn_v*.h | grep CUDNN_MAJOR -A 2
```

Sample Output:
```
#define CUDNN_MAJOR 9
#define CUDNN_MINOR 2
#define CUDNN_PATCHLEVEL 0
--
#define CUDNN_VERSION (CUDNN_MAJOR * 10000 + CUDNN_MINOR * 100 + CUDNN_PATCHLEVEL)

/* cannot use constexpr here since this is a C-only file */
```

## Install ROS 1

1. Update, Upgrade and Autoremove
   - `sudo apt-get update`: updates list of available packages and their versions, but does not install or upgrade any packages.
   - `sudo apt-get upgrade`: installs newer versions of currently available packages. After updating the package lists, the package manager then knows about available updates for installed software. Thus, this is why one `updates` and THEN `upgrades`. 
   - `sudo apt-get autoremove`: removes dependencies that were installed with applications which are no longer required by any other package/applications on the system. 
   - `&&`: given `command one && command two`, `command two` will only run if `command one` successfully runs. Applicable to all Posix shell, not only `bash`. 
   ```
   sudo apt-get update && sudo apt-get upgrade && sudo apt-get autoremove
   ```



2. Setup sources list

Setup computer to accept software packages from packages.ros.org.

```
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
```

3. Setup keys
```
sudo apt install curl # if you haven't already installed curl
```

```
curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | sudo apt-key add -
```

```
sudo apt update
```

4. Install full ROS1
```
sudo apt install ros-noetic-desktop-full
```

5. Install basic dependencies:
```
sudo apt install python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
```

```
sudo apt install ros-noetic-ros-numpy
```

## Install TMC HSR Software

Adapted from [hsr.io](https://docs.hsr.io/hsrb_user_manual_en/howto/pc_install.html#id2) hsrb user manual.

```sh
sudo apt-get update && sudo apt-get upgrade
```

Install simulator environment of the HSR:

```sh
sudo sh -c 'echo "deb [arch=amd64] https://hsr-user:jD3k4G2e@packages.hsr.io/ros/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/tmc.list'
sudo sh -c 'echo "deb [arch=amd64] https://hsr-user:jD3k4G2e@packages.hsr.io/tmc/ubuntu `lsb_release -cs` multiverse main" >> /etc/apt/sources.list.d/tmc.list'
sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list'
wget https://hsr-user:jD3k4G2e@packages.hsr.io/tmc.key -O - | sudo apt-key add -
wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc -O - | sudo apt-key add -
wget https://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
sudo sh -c 'mkdir -p /etc/apt/auth.conf.d'
sudo sh -c '/bin/echo -e "machine packages.hsr.io\nlogin hsr-user\npassword jD3k4G2e" >/etc/apt/auth.conf.d/auth.conf'
sudo sh -c '/bin/echo -e "Package: ros-noetic-laser-ortho-projector\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-laser-scan-matcher\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-laser-scan-sparsifier\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-laser-scan-splitter\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-ncd-parser\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-polar-scan-matcher\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-scan-to-cloud-converter\nPin: version 0.3.3*\nPin-Priority: 1001\n\nPackage: ros-noetic-scan-tools\nPin: version 0.3.3*\nPin-Priority: 1001" > /etc/apt/preferences'
sudo apt-get update
sudo apt-get install ros-noetic-tmc-desktop-full
```

Restart terminal window for modification to take place.

### bash

Add to `~/.bashrc`:
```bash
vim ~/.bashrc
```

```bash
alias python='python3'

# ROS Material
show_first_up_device() {
    local up_device

    # Check for UP Ethernet devices
    up_device=$(ip link show | grep -E '^[0-9]+: en[[:alnum:]]+:' | grep -E 'state UP' | sed -E 's/^[0-9]+: ([^:]+):.*$/\1/' | head -n 1)

    if [[ -n $up_device ]]; then
        echo $up_device
        return 0
    fi

    # Check for UP Wi-Fi devices
    up_device=$(ip link show | grep -E '^[0-9]+: wl[[:alnum:]]+:' | grep -E 'state UP' | sed -E 's/^[0-9]+: ([^:]+):.*$/\1/' | head -n 1)

    if [[ -n $up_device ]]; then
        echo $up_device
        return 0
    fi

    echo 'lo'

    # No UP Ethernet or Wi-Fi device found
    return 1
}

network_if=$(show_first_up_device)

# check_internet_ping() {
#     ping -c 1 www.google.com > /dev/null 2>&1
#     return $?
# }

# if check_internet_ping; then
#     network_if=$(show_first_up_device)

#     # if [[ $? -eq 1 ]]; then
#     #     # Loopback for offline.
#     #     network_if=lo
#     # fi
# else
#     # Loopback for offline.
#     network_if=lo
# fi

echo "ROS using network device: $network_if"

if [ -e /opt/ros/noetic/setup.bash ] ; then
    source /opt/ros/noetic/setup.bash
else
    echo "ROS packages are not installed."
fi

export TARGET_IP=$(LANG=C /sbin/ip address show $network_if | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')
if [ -z "$TARGET_IP" ] ; then
    echo "ROS_IP is not set."
else
    export ROS_IP=$TARGET_IP
fi

export ROS_HOME=~/.ros
alias sim_mode='export ROS_MASTER_URI=http://localhost:11311 export PS1="\[\033[44;1;37m\]<local>\[\033[0m\]\w$ "'
alias sm='sim_mode'
alias hsrb_mode='export ROS_MASTER_URI=http://hsrb.local:11311 export PS1="\[\033[41;1;37m\]<hsrb>\[\033[0m\]\w$ "'
alias hm='hsrb_mode'
alias c='catkin_make'
alias s='source ./devel/setup.bash'
```

```
source ~/.bashrc
```

### zsh

Add to `~/.zshrc`:
```zsh
vim ~/.zshrc
```

```zsh
alias python='python3'

# ROS Material
show_first_up_device() {
    local up_device

    # Check for UP Ethernet devices
    up_device=$(ip link show | grep -E '^[0-9]+: en[[:alnum:]]+:' | grep -E 'state UP' | sed -E 's/^[0-9]+: ([^:]+):.*$/\1/' | head -n 1)

    if [[ -n $up_device ]]; then
        echo $up_device
        return 0
    fi

    # Check for UP Wi-Fi devices
    up_device=$(ip link show | grep -E '^[0-9]+: wl[[:alnum:]]+:' | grep -E 'state UP' | sed -E 's/^[0-9]+: ([^:]+):.*$/\1/' | head -n 1)

    if [[ -n $up_device ]]; then
        echo $up_device
        return 0
    fi

    echo 'lo'

    # No UP Ethernet or Wi-Fi device found
    return 1
}

network_if=$(show_first_up_device)

# check_internet_ping() {
#     ping -c 1 www.google.com > /dev/null 2>&1
#     return $?
# }

# if check_internet_ping; then
#     network_if=$(show_first_up_device)

#     # if [[ $? -eq 1 ]]; then
#     #     # Loopback for offline.
#     #     network_if=lo
#     # fi
# else
#     # Loopback for offline.
#     network_if=lo
# fi

echo "ROS using network device: $network_if"

if [ -e /opt/ros/noetic/setup.zsh ] ; then
    source /opt/ros/noetic/setup.zsh
else
    echo "ROS packages are not installed."
fi

export TARGET_IP=$(LANG=C /sbin/ip address show $network_if | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*')
if [ -z "$TARGET_IP" ] ; then
    echo "ROS_IP is not set."
else
    export ROS_IP=$TARGET_IP
fi

export ROS_HOME=~/.ros
alias sim_mode='export ROS_MASTER_URI=http://localhost:11311 export PS1="\[\033[44;1;37m\]<local>\[\033[0m\]\w$ "'
alias sm='sim_mode'
alias hsrb_mode='export ROS_MASTER_URI=http://hsrb.local:11311 export PS1="\[\033[41;1;37m\]<hsrb>\[\033[0m\]\w$ "'
alias hm='hsrb_mode'
alias c='catkin_make'
alias s='source ./devel/setup.zsh'
```

```
source ~/.zshrc
```
## Miscellaneous

Some additional ENV vars that may be important depending on your use:
```
# CUDA Toolkit
export PATH=/usr/local/cuda-12.4/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.4/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# OPENPOSE
export OPENPOSE_PATH=$HOME/gitwork/hsr_robocanes/src/openpose

# OPENAI
export OPENAI_API_KEY=''

# AZURE
export AZURE_API_KEY=''
```

API keys need to be filled in. Speak with Professor Visser, if needed.

**NOTE**: Don't post plaintext keys online (e.g. pushed in a commit, even if private). They will be caught by github webscrapers and you will need to replace the resource key. 

## Final verification

Verify HSR simulator install:

```zsh
roslaunch hsrb_gazebo_launch hsrb_empty_world.launch 
```

# Install NVIDIA Isaac Simulator

## Install NVIDIA Omniverse

From local cloned repo root:

1. `cd omniverse`
2. `./omniverse_construct`
3. `cd launcher`
4. `unzip omniverse-launcher-linux.AppImage.zip`
5. `./omniverse-launcher-linux.AppImage`

This window should popup:
![](./imgs/omniverse_startup.png)

Login using following credentials:
![](./imgs/omniverse_user_login.png)

Click on `LOG IN` which opens the following browser page:
![](./imgs/browser_nvidia_login.png)

Click on `More Login Options`:
![](./imgs/nvidia_login_google.png)

Click on `Log In With Google`:
![](./imgs/google_login.png)

Click `Next` and input the following password:
![](./imgs/google_pwd.png)

Click `Next` and the following page will popup:
![](./imgs/open_omniverse.png)

Click `Open omniverse-launcher` and the following should show up in the original omniverse launcher window:
![](./imgs/omniverse_logged_in.png)

Click on `Nucleus`:
![](./imgs/nucleus.png)

Click on `Add Local Nucleus Service`:
![](./imgs/nucleus_data_path.png)

Click `NEXT` and input the same string for all input fields `csc398f24`:
![](./imgs/nucleus_setup.png)

Nucleus service should now download and install:
![](./imgs/nucleus_download.png)

Finished Nucleus service download and install:
![](./imgs/nucleus_installed.png)

Click on `Exchange` and search for `isaac sim`:
![](./imgs/exchange_isaac_sim.png)

Under `Apps`, click `ISAAC SIM`:
![](./imgs/isaac_sim_install.png)

Set `Release` and `2023.1.1`, and click `INSTALL`. Isaac Sim should now commence download and install (this will take a while):
![](./imgs/isaac_sim_download.png)

