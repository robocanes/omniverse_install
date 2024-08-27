DATA=usr_persist_data/root/home

sudo mkdir -p ${DATA}
sudo cp -r isaac_sim_install/isaac_sim/launcher/isaac-sim-2023.1.1 ${DATA}
sudo cp -r nucleus/ws/nucleus-workstation-2023.2.3 ${DATA}
sudo cp -r scripts/* ${DATA}
sudo cp scripts/.bashrc ${DATA}
sudo cp scripts/.zshrc ${DATA}