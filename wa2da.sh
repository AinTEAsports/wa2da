#!/usr/bin/env bash

# You can modify this
NATIVEFIER_APPS_DIRECTORY="${HOME}/.nativefier-apps"
LOG_FILE="/tmp/wa2da.log"

# ------- #

APP_NAME="${1}"
WEBSITE_URL="${2}"
APP_DIRECTORY="${APP_NAME}-linux-x64"

DESKTOP_FILENAME=$(echo "${APP_NAME}.desktop" | tr '[:upper:]' '[:lower:]')
ABSOLUTE_DESKTOP_FILE_PATH="${HOME}/.local/share/applications/${DESKTOP_FILENAME}"


show_help() {
	echo "\
Use: ${0} <app_name> <website_url>
\"Downloads\" a website into a desktop app, using \"nativefier\"\
"
}


create_app() {
	nativefier --name "${APP_NAME}" "${WEBSITE_URL}" \
		0>"${LOG_FILE}" \
		1>"${LOG_FILE}" \
		2>"${LOG_FILE}" || exit 1
}


move_app_to_nativfier_app_directory() {
	mv "${PWD}/${APP_DIRECTORY}" "${NATIVEFIER_APPS_DIRECTORY}/${APP_DIRECTORY}"
}


make_config() {
	echo -n "
[Desktop Entry]
Type=Application
Exec=${NATIVEFIER_APPS_DIRECTORY}/${APP_DIRECTORY}/${APP_NAME}
Terminal=false

Name=${APP_NAME}
GenericName=${APP_NAME}
# Comment=
StartupWMClass=${APP_NAME}
Actions=New;

[Desktop Action New]
Name={APP_NAME}
Exec=${NATIVEFIER_APPS_DIRECTORY}/${APP_DIRECTORY}/${APP_NAME}
"
}


make_desktop_file() {
	make_config > "${ABSOLUTE_DESKTOP_FILE_PATH}"
}


main() {
	# Create '$NATIVEFIER_APPS_DIRECTORY' if it doesn't exist
	[[ -e "${NATIVEFIER_APPS_DIRECTORY}" ]] || mkdir -p "${NATIVEFIER_APPS_DIRECTORY}"

	# Check if the command 'nativefier' exists
	if [[ -z $(command -v nativefier) ]]; then
		echo "'nativefier' could not be found, please install it"
		exit 1
	fi

	# Check if argument number is good
	if [[ "$#" -ne 2 ]]; then
		show_help
		exit 1
	fi

	# Check if destination directory already exists
	if [[ -d "${NATIVEFIER_APPS_DIRECTORY}/${APP_DIRECTORY}" ]]; then
		>&2 echo "[ERROR] Application '${APP_NAME}' already exists"
		exit 1
	fi

	# Check if ".desktop" file already exists
	if [[ -f "${ABSOLUTE_DESKTOP_FILE_PATH}" ]]; then
		>&2 echo "[ERROR] '${ABSOLUTE_DESKTOP_FILE_PATH}' already exists"
		exit 1
	fi

	create_app
	make_desktop_file
	move_app_to_nativfier_app_directory

	echo "Application '${APP_NAME}' successfully created at '${NATIVEFIER_APPS_DIRECTORY}/${APP_DIRECTORY}'"
}


main $@
