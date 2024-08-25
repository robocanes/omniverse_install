# rocker --nvidia --x11 \
# --env="ACCEPT_EULA=Y" \
# --env="OMNI_SERVER=omniverse://localhost/NVIDIA/Assets/Isaac/2023.1.1" \
# --network=host \
# --volume="./usr_persist_data/root/usr_data:/root/usr_data:rw" \
# --volume="./isaac-sim-data/cache/kit:/isaac-sim/kit/cache/Kit:rw" \
# --volume="./isaac-sim-data/cache/ov:/root/.cache/ov:rw" \
# --volume="./isaac-sim-data/cache/pip:/root/.cache/pip:rw" \
# --volume="./isaac-sim-data/cache/glcache:/root/.cache/nvidia/GLCache:rw" \
# --volume="./isaac-sim-data/cache/computecache:/root/.nv/ComputeCache:rw" \
# --volume="./isaac-sim-data/logs:/root/.nvidia-omniverse/logs:rw" \
# --volume="./isaac-sim-data/data:/root/.local/share/ov/data:rw" \
# --volume="./isaac-sim-data/documents:/root/Documents:rw" \
# docker_nvidia_isaac_sim:latest

rocker --nvidia --x11 \
--env="ACCEPT_EULA=Y" \
--volume="./usr_persist_data/root/usr_data:/root/usr_data:rw" \
--volume="./isaac-sim-data/cache/kit:/isaac-sim/kit/cache/Kit:rw" \
--volume="./isaac-sim-data/cache/ov:/root/.cache/ov:rw" \
--volume="./isaac-sim-data/cache/pip:/root/.cache/pip:rw" \
--volume="./isaac-sim-data/cache/glcache:/root/.cache/nvidia/GLCache:rw" \
--volume="./isaac-sim-data/cache/computecache:/root/.nv/ComputeCache:rw" \
--volume="./isaac-sim-data/logs:/root/.nvidia-omniverse/logs:rw" \
--volume="./isaac-sim-data/data:/root/.local/share/ov/data:rw" \
--volume="./isaac-sim-data/documents:/root/Documents:rw" \
docker_nvidia_isaac_sim:latest