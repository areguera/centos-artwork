#!/bin/bash
#
# render_doCopy.sh -- This function duplicates rendition stuff.
# Rendition stuff is formed by design models, design images,
# pre-rendition configuration scripts and translations files. This
# way, when we say to duplicate rendition stuff we are saying to
# duplicate these four directory structures (i.e., design models,
# design images, pre-rendition configuration scripts, and related
# translations files).
#
# Copyright (C) 2009-2011 Alain Reguera Delgado
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
# USA.
# 
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function render_doCopy {

    # Verify target directory.
    cli_checkRepoDirTarget

    # Determine what directory structure we are duplicating.  When we
    # duplicate directories, inside `trunk/Identity' directory
    # structure, there are two organizational designs we need to be
    # aware of: 
    #
    #   Organization 1: Design models (`Tpl/') and design images
    #   (`Img/') directories share a common parent directory under
    #   `trunk/Identity' directory structure.
    #
    #       trunk/Identity/Widgets
    #       |-- Tpl
    #       |   `-- file.svg
    #       `-- Img
    #           `-- file.png
    #
    #       trunk/Translations/Identity/Widgets
    #       trunk/Scripts/Bash/Functions/Render/Config/Identity/Widgets
    #
    #   Organization 2: Design models and design images don't share a
    #   common parent directory. Instead, design models and design
    #   images are stored directly on their own directory structures
    #   under `trunk/Identity'. 
    #
    #       trunk/Identity/Themes/Models/Default/Distro/
    #       `-- Anaconda
    #           `-- Header
    #               `-- anaconda_header.svg
    #
    #       trunk/Identity/Themes/Motifs/TreeFlower/Distro/
    #       `-- Anaconda
    #           `-- Header
    #               `-- anaconda_header.png
    #
    #       trunk/Translations/Identity/Themes/Distro/Anaconda/Header/
    #       trunk/Scripts/Bash/Functions/Render/Config/Identity/Themes/Distro/Anaconda/Header/
    # 
    # Another consideration to have, when we duplicate a directory
    # structures, is the source location used to perform the
    # duplication action. The source location is relevant to determine
    # the related directory structures (parallel directories) so they
    # be copied too (otherwise they may get orphaned and rendition
    # behaviour may not work due the fault of required information).
    #
    # In order for a renderable directory estructure to be valid, the
    # directory structure should match the following conditions:
    #
    #   1. To have a unique directory structure under
    #   `trunk/Identity', organized by any one of the above
    #   organizational designs above.
    #
    #   2. To have a unique directory structure under
    #   `trunk/Translations' to store translation files.
    #
    #   3. To have a unique directory structure under
    #   `trunk/Scripts/Bash/Functions/Render/Config' to set
    #   pre-rendition configuration script.
    #
    # As convenction, the render_doCopy function uses `trunk/Identity'
    # directory structure as source location.  Once the
    # `trunk/Identity' directory structure has been specified, the
    # related path information is built from it and copied
    # automatically.
    #
    # Notice that the duplication process is done from
    # `trunk/Identity' on, not the oposite. If you try to duplicate a
    # translation structure, the `trunk/Identity' for that translation
    # is not created. This limitation is impossed by the fact that
    # many `trunk/Identity' directory structures may reuse the same
    # translation directory structure. Likewise, one translation
    # directory structure cannot be deleted while a related
    # `trunk/Identity/' directory structure still exist. This same
    # concept applies to others auxiliar directory structures like
    # pre-rendition configuration scripts.

}
