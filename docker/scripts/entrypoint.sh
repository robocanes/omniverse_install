/nucleus-ws/setup/nucleus-setup -i > /dev/null 2>&1
/nucleus-ws/'Discovery Service'/omni-discovery-service > /dev/null 2>&1 &
/nucleus-ws/Auth/omni-auth-service > /dev/null 2>&1 & 
/nucleus-ws/'System Monitor'/omni-system-monitor > /dev/null 2>&1 &

chown -R root:root /tmp

clear

exec /bin/bash