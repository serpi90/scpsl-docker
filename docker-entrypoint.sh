#!/usr/bin/env bash
set -euo pipefail

echo "PORT: $PORT"
echo "CONFIG_PATH: $CONFIG_PATH"
echo "INSTALL_PATH: $INSTALL_PATH"

echo "Changing steam user id to (${USER_ID:=1000}) and group id (${GROUP_ID:=1000})"
sed -ri "s/^steam:x:[0-9]*/steam:x:$USER_ID/" /etc/passwd
sed -ri "s/^steam:x:[0-9]*/steam:x:$GROUP_ID/" /etc/group

GAME_CONFIG_PATH="/home/steam/.config/SCP Secret Laboratory/config"

echo "Setup directory structure and permissions"
mkdir -p "$GAME_CONFIG_PATH" "$CONFIG_PATH" "$INSTALL_PATH"
ln -sf "$CONFIG_PATH" "$GAME_CONFIG_PATH/$PORT"
chown -R steam:steam "$INSTALL_PATH" "$CONFIG_PATH" /home/steam/

gosu steam:steam /server-entrypoint.sh
