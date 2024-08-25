LAUNCHER_PATH="ws/nucleus-workstation-2023.2.3.zip"
SPLIT_PREFIX="ws/split"
split --bytes=99M $LAUNCHER_PATH $SPLIT_PREFIX
rm $LAUNCHER_PATH