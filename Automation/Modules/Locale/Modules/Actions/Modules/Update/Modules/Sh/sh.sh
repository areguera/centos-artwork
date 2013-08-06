#!/bin/bash

function sh {

    # Print action message.
    tcar_printMessage "${POT_FILE}" --as-updating-line

    # Retrieve translatable strings from shell script files and create
    # the portable object template (.pot) from them.
    xgettext --output=${POT_FILE} --width=70 \
        --package-name=${TCAR_SCRIPT_NAME} \
        --package-version=${TCAR_SCRIPT_VERSION} \
        --msgid-bugs-address="centos-l10n-${TCAR_SCRIPT_LANG_LL}@centos.org.cu" \
        --copyright-holder="$(tcar_printCopyrightInfo --holder)" \
        --sort-by-file ${SOURCES[*]}

    # Verify, initialize or update portable objects from portable
    # object templates.
    locale_convertPotToPo "${POT_FILE}" "${PO_FILE}"

    # At this point some changes might be realized inside the PO file,
    # so we need to update the related MO file based on recently
    # updated PO files here in order for `centos-art.sh' script to
    # print out the most up to date revision of localized messages.
    # Notice that this is required only if we were localizing shell
    # scripts.
    locale_convertPoToMo

}
