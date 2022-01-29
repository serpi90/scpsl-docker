#!/usr/bin/env bash
set -euxo pipefail

cd "$INSTALL_PATH"

echo "Update SteamCMD and verify latest version"
steamcmd +quit

echo "Install or update SCP Secret Laboratory"
# shellcheck disable=SC2086
steamcmd \
	+force_install_dir "$INSTALL_PATH" \
	+login anonymous \
	+app_update 996560 ${STEAM_BETA:-} validate \
	+quit

echo "Start server"
"$INSTALL_PATH/LocalAdmin" "$PORT"
