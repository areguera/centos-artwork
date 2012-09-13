#!/bin/bash
#
#

function locale_updateMessageXmlSvg {

    # Inside trunk/Identity/Models, design models can be compressed or
    # uncompressed. Because of this we cannot process all the design
    # models in one unique way. Instead, we need to treat them
    # individually based on their file type.

    # Initialize name of temporal files.
    local TEMPFILE=''
    local TEMPFILES=''

    for FILE in $FILES;do

        # Redefine temporal file based on file been processed.
        TEMPFILE=$(cli_getTemporalFile $(basename ${FILE} ))

        # Update the command used to read content of XML files.
        if [[ $(file -b -i $FILE) =~ '^application/x-gzip$' ]];then
        
            # Create uncompressed copy of file.
            /bin/zcat $FILE > $TEMPFILE

        else
                
            # Create uncompressed copy of file.
            /bin/cat $FILE > $TEMFILE

        fi

        # Concatenate temporal files into a list so we can process
        # them later through xml2po.
        TEMPFILES="${TEMPFILE} ${TEMPFILES}"

    done

    # Create the portable object template.
    xml2po -a $TEMPFILES \
        | msgcat --output=${MESSAGES}.pot --width=70 --no-location -

    # Remove list of temporal files. They are no longer needed.
    rm $TEMPFILES

}
