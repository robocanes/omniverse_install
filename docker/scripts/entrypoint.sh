WORK_DIR=/root

# /nucleus-ws/setup/nucleus-setup -i > /dev/null 2>&1
# /nucleus-ws/'Discovery Service'/omni-discovery-service > /dev/null 2>&1 &
# /nucleus-ws/Auth/omni-auth-service > /dev/null 2>&1 & 
# /nucleus-ws/'System Monitor'/omni-system-monitor > /dev/null 2>&1 &

# ln -s /isaac-sim ${WORK_DIR}/isaac-sim

# NUCLEUS_PATH=/root/nucleus-workstation-2023.2.3

/root/nucleus-workstation-2023.2.3/setup/nucleus-setup -i > /dev/null 2>&1
/root/nucleus-workstation-2023.2.3/'Discovery Service'/omni-discovery-service > /dev/null 2>&1 &
/root/nucleus-workstation-2023.2.3/Auth/omni-auth-service > /dev/null 2>&1 & 
/root/nucleus-workstation-2023.2.3/'System Monitor'/omni-system-monitor > /dev/null 2>&1 &

chown -R root:root /tmp

python3 /root/nucleus_server_login.py

clear

exec /bin/bash