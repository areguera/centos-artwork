#!/bin/bash
function directory {

    # Sanitate non-option arguments to be sure they match the
    # directory conventions established by centos-art.sh script
    # against source directory locations in the working copy.
    local DIRECTORY=$(tcar_checkRepoDirSource ${1})

    # Retrieve list of configuration files from directory.
    local CONFIGURATIONS=$(tcar_getFilesList ${DIRECTORY} \
        --pattern=".+/.+\.conf$" --type="f")

    # Verify non-option arguments passed to centos-art.sh
    # command-line. The path provided as argument must exist in the
    # repository.  Otherwise, it would be possible to create arbitrary
    # directories inside the repository without any meaning. In order
    # to be sure all required directories are available in the
    # repository it is necessary use the prepare functionality.
    tcar_checkFiles -ef ${CONFIGURATIONS}

    # Process each configuration file.
    for CONFIGURATION in ${CONFIGURATIONS};do
        directory_getConfiguration "${@}"
    done

}
