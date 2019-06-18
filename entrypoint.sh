#!/usr/bin/env bash

set -e

# Add libraries
source /usr/local/lib/bash-logger.sh
source /usr/local/lib/persist-env.sh


# Docker hub user
DOCKER_USERNAME=$(env_get "DOCKER_USERNAME")
DOCKER_PASSWORD=$(env_get "DOCKER_PASSWORD")
[ -z "${DOCKER_USERNAME}" ] && ERROR "Please define environment variable DOCKER_USERNAME"
[ -z "${DOCKER_PASSWORD}" ] && ERROR "Please define environment variable DOCKER_PASSWORD"

# Docker image to update
DOCKER_IMAGE=$(env_get "DOCKER_IMAGE")
[ -z "${DOCKER_IMAGE}" ] && ERROR "Please define environment variable DOCKER_IMAGE"

# Readme.md file
README_FILE=$(env_get "README_FILE" "/data/README.md")
[ -f "${README_FILE}" ] || ERROR "${README_FILE} not found"


#
# Obtains JWT from Docker Hub.
#
# $1 - The Docker Hub username.
# $1 - The Docker Hub password.
#
# Examples:
#
#   get_token "name" "password"
#
get_token() {
  declare -r username="${1}"
  declare -r password="${2}"

  local token=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -d '{"username": "'"${username}"'", "password": "'"${password}"'"}' \
    https://hub.docker.com/v2/users/login/ | jq -r .token)

  echo "${token}"
}

#
# Pushes README.md content to Docker Hub.
#
# $1 - The image name.
# $2 - The JWT.
#
# Examples:
#
#   push_readme "foo/bar" "token"
#
push_readme() {
  declare -r image="${1}"
  declare -r token="${2}"

  local code=$(jq -n --arg msg "$(<${README_FILE})" \
    '{"registry":"registry-1.docker.io","full_description": $msg }' | \
        curl -s -o /dev/null  -L -w "%{http_code}" \
           https://cloud.docker.com/v2/repositories/"${image}"/ \
           -d @- -X PATCH \
           -H "Content-Type: application/json" \
           -H "Authorization: JWT ${token}")

  if [[ "${code}" = "200" ]]; then
    NOTICE "Successfully pushed README.md to Docker Hub"
  else
    ERROR "Unable to push README.md to Docker Hub, response code: ${code}"
  fi
}

push_readme "${DOCKER_IMAGE}" "$(get_token "${DOCKER_USERNAME}" "${DOCKER_PASSWORD}")"
