DIR="ws"
ZIP_FILE="nucleus-workstation-2023.2.3.zip"
LAUNCHER_PATH="${DIR}/${ZIP_FILE}"
SPLIT_PREFIX="ws/split"
cat "${SPLIT_PREFIX}"* > "$LAUNCHER_PATH"
unzip -o $LAUNCHER_PATH -d $DIR
rm $LAUNCHER_PATH
