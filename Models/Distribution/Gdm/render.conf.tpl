[screenshot.png]
render-type     = "svg"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/screenshot.svgz"
render-flow     = "base"
brand           = "${TCAR_WORKDIR}/Brands/Symbols/Default/Final/ffffff-0/ffffff/16/centos.png:x16+5+5"

[800x600.tar.gz]
render-type     = "archive"
render-from     = "${TCAR_BASEDIR}/Artworks/Themes/Motifs/${MOTIF}/Backgrounds/Final/800x600.png:background.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/GdmGreeterTheme.desktop"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/GdmGreeterTheme.xml"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/icon-language.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/icon-reboot.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/icon-session.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/icon-shutdown.png"
render-from     = "Final/screenshot.png"
command         = "/bin/tar -czf"

[1360x768.tar.gz]
render-type     = "archive"
render-from     = "${TCAR_BASEDIR}/Artworks/Themes/Motifs/${MOTIF}/Backgrounds/Final/1360x768.png:background.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/GdmGreeterTheme.desktop"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/GdmGreeterTheme.xml"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/icon-language.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/icon-reboot.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/icon-session.png"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Gdm/icon-shutdown.png"
render-from     = "Final/screenshot.png"
command         = "/bin/tar --remove-files -czf"
