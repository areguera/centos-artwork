[splash.png]
render-type     = "svg"
render-flow     = "base"
render-from     = "${TCAR_BASEDIR}/Artworks/Themes/Models/Distro/5/Grub/splash.svgz"

[splash.xpm]
render-from     = "splash.png"
render-type     = "palette"
palette-gpl     = "colors.gpl"

[splash.xpm.gz]
render-from     = "splash.xpm"
render-type     = "compress"
command         = "/bin/gzip"
