# This file contains the information used to build The CentOS Logo in
# different sizes, colors and formats.

[centos-logo.png]  
render-type = "svg"
render-from = "${TCAR_BASEDIR}/Artworks/Brands/{Symbols/Webenv/centos.svgz,Types/Webenv/centos.svgz}"
render-flow = "extended"
export-id   = "CENTOSARTWORK"
formats     = "xpm pdf jpg tif"
heights     = "16 20 22 24 32 36 38 40 48 64 72 78 96 112 124 128 148 164 196 200 512"
fgcolors    = "000000 ffffff ad7fa8 75507b 5c3566 729fcf 3465a4 204a87 fce94f edd400 c4a000 8ae234 73d216 4e9a06 fcaf3e f57900 ce5c00 e9b96e c17d11 8f5902 ef2929 cc0000 a40000 eeeeec d3d7cf babdb6 888a85 555753 2e3436"
bgcolors    = "ffffff-0"
command     = "/usr/bin/convert +append"
