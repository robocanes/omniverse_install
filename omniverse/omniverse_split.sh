LAUNCHER_PATH="launcher/omniverse-launcher-linux.AppImage.zip"
SPLIT_PREFIX="launcher/split"
split --bytes=99M $LAUNCHER_PATH $SPLIT_PREFIX
rm $LAUNCHER_PATH