[screenshot.png]
render-type     = "svg"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Kdm/screenshot.svgz"
render-flow     = "base"
brand           = "${TCAR_BASEDIR}/Artworks/Brands/Symbols/Default/Final/ffffff/ffffff-0/16/centos.png:x16+5+5"

[800x600.tar.gz]
render-type     = "archive"
render-from     = "${TCAR_BASEDIR}/Artworks/Themes/Motifs/${MOTIF}/Backgrounds/Final/800x600.png:background.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Kdm/GdmGreeterTheme.desktop"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Kdm/GdmGreeterTheme.xml"
render-from     = "Final/screenshot.png"
command         = "/bin/tar --remove-files -czf"

[1360x768.tar.gz]
render-type     = "archive"
render-from     = "${TCAR_BASEDIR}/Artworks/Themes/Motifs/${MOTIF}/Backgrounds/Final/1360x768.png:background.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Kdm/GdmGreeterTheme.desktop"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Kdm/GdmGreeterTheme.xml"
render-from     = "Final/screenshot.png"
command         = "/bin/tar --remove-files -czf"
