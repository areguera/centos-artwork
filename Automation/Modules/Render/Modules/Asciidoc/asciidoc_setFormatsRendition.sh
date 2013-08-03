#!/bin/bash

function asciidoc_setFormatsRendition {

    for FORMAT in ${FORMATS};do

        case ${FORMAT} in 
            'xhtml' )
                asciidoc_setXhtmlRendition "${TARGET}"
                ;;
        esac

    done

}
