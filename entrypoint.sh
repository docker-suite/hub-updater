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
DOCKER_HUB_API_URL="https://hub.docker.com/v2"

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

  local token=$(curl --silent \
                --header 'Content-Type: application/json' \
                --data-raw '{"username": "'${username}'", "password": "'${password}'"}' \
                --request POST ${DOCKER_HUB_API_URL}/users/login/ | jq -r .token)

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
#   push_readme "dsuite/hub-updater" "token"
#
push_readme() {
  declare -r repository="${1}"
  declare -r token="${2}"

  # Url of the repository
  local docker_repository_url="${DOCKER_HUB_API_URL}/repositories/${repository}/"

  # url encode the full description with jq
  local full_description=$(jq -Rs '{ full_description: . }' ${README_FILE})

  # update repository description
  local response_code=$(curl --silent \
                            --write-out %{response_code} \
                            --output /dev/null \
                            --header "Content-Type: application/json" \
                            --header "Authorization: Bearer ${token}" \
                            --request PATCH --data-raw "${full_description}" ${docker_repository_url} )

  if [[ "${response_code}" = "200" ]]; then
    NOTICE "Successfully pushed README.md to Docker Hub"
  else
    ERROR "Unable to push README.md to Docker Hub, response code: ${response_code}"
  fi
}

push_readme "${DOCKER_IMAGE}" "$(get_token "${DOCKER_USERNAME}" "${DOCKER_PASSWORD}")"
