#!/bin/bash

function install_template {
    local MAILMAN=/usr/lib/mailman
    local MAILMAN_THEMES_BASEDIR=themes/centos
    local SOURCE=${1}
    local TARGET=${MAILMAN}/${MAILMAN_THEMES_BASEDIR}/$(echo ${SOURCE} | sed 's/\.new//')
    sudo cp ${SOURCE} ${TARGET}
    echo "${SOURCE} installed at ${TARGET}"
}
