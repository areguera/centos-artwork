[splash_active_bar.png]
render-type     = "svg"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Ksplash/splash_active_bar.svgz"
render-flow     = "base"

[splash_bottom.png]
render-type     = "svg"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Ksplash/splash_bottom.svgz"
render-flow     = "base"

[splash_inactive_bar.png]
render-type     = "svg"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Ksplash/splash_inactive_bar.svgz"
render-flow     = "base"

[splash_top.png]
render-type     = "svg"
render-from     = "${TCAR_BASEDIR}/Models/Distro/5/Ksplash/splash_top.svgz"
render-flow     = "base"
brand           = "${TCAR_WORKDIR}/Brands/Types/Default/Final/ffffff-0/ffffff/24/centos.png:x24+10+189"
brand           = "${TCAR_WORKDIR}/Brands/Types/Numbers/Final/ffffff-0/ffffff/48/5.png:x48+150+165"
brand           = "${TCAR_WORKDIR}/Brands/Symbols/Default/Final/ffffff-0/ffffff/48/centos.png:x48+10+10"

[Preview.png]
render-type     = "images"
render-from     = "Final/splash_top.png"
render-from     = "Final/splash_active_bar.png"
render-from     = "Final/splash_bottom.png"
command         = "/usr/bin/convert -append"

[ksplash.tar.gz]
render-type     = "archive"
render-from     = "Final/splash_top.png"
render-from     = "Final/splash_active_bar.png"
render-from     = "Final/splash_bottom.png"
render-from     = "Final/Preview.png
command         = "/bin/tar -czf"
