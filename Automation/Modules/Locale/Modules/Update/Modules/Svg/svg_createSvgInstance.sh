#!/bin/bash

function svg_createSvgInstance {

    if [[ $(file -b -i ${SVG_FILE}) =~ '^application/x-gzip$' ]];then
        /bin/zcat ${SVG_FILE} > ${SVG_INSTANCE}
    else
        /bin/cat ${SVG_FILE} > ${SVG_INSTANCE}
    fi

}
