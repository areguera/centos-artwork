[splash.png]
render-type     = "svg"
render-flow     = "base"
render-from     = "${TCAR_BASEDIR}/Artworks/Themes/Models/Distro/5/Grub/splash.svgz"

[splash.xpm]
render-type     = "palette"
render-from     = "splash.png"
palette-gpl     = "colors.gpl"

[splash.xpm.gz]
render-type     = "compress"
render-from     = "splash.xpm"
command         = "/bin/gzip -f"
