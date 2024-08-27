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