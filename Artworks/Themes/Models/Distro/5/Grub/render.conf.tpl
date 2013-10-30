[splash.png]
render-type     = "svg"
render-flow     = "base"
render-from     = "${TCAR_BASEDIR}/Artworks/Themes/Models/Distro/5/Grub/splash.svgz"

[splash.xpm]
render-type     = "palette"
render-from     = "Final/splash.png"
palette-gpl     = "${TCAR_BASEDIR}/Artworks/Themes/Motifs/${MOTIF}/Palettes/grub.gpl"

[splash.xpm.gz]
render-type     = "compress"
render-from     = "Final/splash.xpm"
command         = "/bin/gzip -f"
