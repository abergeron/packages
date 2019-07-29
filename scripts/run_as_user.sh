#!/bin/bash

set -u
set -e

getent group "${BUILD_GID}" || groupadd --gid "${BUILD_GID}" "${BUILD_GROUP}"
getent passwd "${BUILD_UID}" || useradd --gid "${BUILD_GID}" --uid "${BUILD_UID}" "${BUILD_USER}" --home "${BUILD_HOME}"

chown ${BUILD_UID}:${BUILD_GID} ${BUILD_HOME}


HOME=${BUILD_HOME} sudo -u "#${BUILD_UID}" -E PATH=${PATH} "$@"
