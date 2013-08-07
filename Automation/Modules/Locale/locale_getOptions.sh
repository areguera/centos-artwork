#!/bin/bash

function locale_getOptions {

    # Define short options we want to support.
    local ARGSS="h::,v"

    # Define long options we want to support.
    local ARGSL="help::,version,filter:,update,edit,delete"

    # Redefine arguments using getopt(1) command parser.
    tcar_setArguments "${@}"

    # Reset positional parameters on this function, using output
    # produced from (getopt) arguments parser.
    eval set -- "${TCAR_ARGUMENTS}"

    # Look for options passed through command-line.
    while true; do
        case "${1}" in

            -h | --help )
                tcar_printHelp "${2}"
                shift 2
                ;;

            -v | --version )
                tcar_printVersion
                ;;

            --filter )
                TCAR_FLAG_FILTER="${2}"
                shift 2
                ;;

            --update )
                ACTIONS="${ACTIONS} update"
                shift 1
                ;;

            --edit )
                ACTIONS="${ACTIONS} edit"
                shift 1
                ;;

            --delete )
                ACTIONS="${ACTIONS} delete"
                shift 1
                ;;

            -- )
                # Remove the `--' argument from the list of arguments
                # in order for processing non-option arguments
                # correctly. At this point all option arguments have
                # been processed already but the `--' argument still
                # remains to mark ending of option arguments and
                # beginning of non-option arguments. The `--' argument
                # needs to be removed here in order to avoid
                # centos-art.sh script to process it as a path inside
                # the repository, which obviously is not.
                shift 1
                break
                ;;
        esac
    done

    if [[ -z ${ACTIONS} ]];then
        ACTIONS='update'
    fi

    # Redefine arguments using current positional parameters. Only
    # paths should remain as arguments, at this point.
    TCAR_ARGUMENTS="${@}"

}
