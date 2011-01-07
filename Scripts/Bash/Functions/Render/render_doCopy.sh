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
# When we duplicate directories, inside `trunk/Identity' directory
# structure, there are two organizational designs we need to be aware
# of: 
#
#   Organization 1: Design models (`Tpl/') and design images (`Img/')
#   directories share a common parent directory under `trunk/Identity'
#   directory structure.
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
#   common parent directory. Instead, design models and design images
#   are stored separately on their own directory structures under
#   `trunk/Identity'. 
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
#   The "Organization 2" emerged from "Organization 1" to satisfy a
#   need that "Organization 1" cannot satisfy: The design models
#   cannot be reused in "Organization 1" but in "Organization 2" they
#   can be reused indeed.
# 
# Another consideration to have, when we duplicate directory
# structures, is the source location used to perform the duplication
# action. The source location is relevant to determine the required
# information inside directory structures (parallel directories) that
# need to be copied too (otherwise we may end up with orphan directory
# structures unable to be rendered, due the absence of required
# information).
#
# In order for a renderable directory structure to be valid, the new
# directory structure copied should match the following conditions:
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
# directory structure as source location.  Once the `trunk/Identity'
# directory structure has been specified and verified, the related
# path information is built from it and copied automatically to the
# new location specified by FLAG_TO variable.
#
# Organization 1:
#
#   Command:
#   - centos-art render --copy=trunk/Identity/Widgets --to=trunk/Identity/NewDirName
#
#   Sources:
#   - trunk/Identity/Widgets
#   - trunk/Translations/Identity/Widgets
#   - trunk/Scripts/Bash/Functions/Render/Config/Identity/Widgets
#
#   Targets:
#   - trunk/Identity/NewDirName
#   - trunk/Translations/Identity/NewDirName
#   - trunk/Scripts/Bash/Functions/Render/Config/Identity/NewDirName
#
# Organization 2:
#
#   Command:
#   - centos-art render --copy=trunk/Identity/Themes/Motifs/TreeFlower \
#                         --to=trunk/Identity/Themes/Motifs/NewDirName
#
#   Sources:
#   - trunk/Identity/Themes/Motifs/TreeFlower
#   - trunk/Translations/Identity/Themes
#   - trunk/Translations/Identity/Themes/Motifs/TreeFlower
#   - trunk/Scripts/Bash/Functions/Render/Config/Identity/Themes
#   - trunk/Scripts/Bash/Functions/Render/Config/Identity/Themes/Motifs/TreeFlower
#
#   Targets:
#   - trunk/Identity/Themes/Motifs/NewDirName
#   - trunk/Translations/Identity/Themes
#   - trunk/Translations/Identity/Themes/Motifs/NewDirName
#   - trunk/Scripts/Bash/Functions/Render/Config/Identity/Themes
#   - trunk/Scripts/Bash/Functions/Render/Config/Identity/Themes/Motifs/NewDirName
#
#   Notice that design models are not included in source or target
#   locations. This is intentional. In "Organization 2", design models
#   live by their own, they just exist, they are there, available for
#   any artistic motif to use. By default `Themes/Models/Default' design
#   model directory structure is used, but other design models
#   directory structures (under Themes/Models/) can be created and
#   used changing the value of THEMEMODEL variable inside the
#   pre-rendition configuration script of the artistic motif source
#   location you want to produce.
#
#   Notice, also, how translations and pre-rendition configuration
#   scripts may both be equal in source and target. This is because
#   such structures are common to all artistic motifs (the default
#   values to use when no specific values are provided).
#
#   - Common directory structures are not copied or deleted. We cannot
#     copy a directory structure to itself.
#
#   - Common directory structures represent the default value to use
#     when no specific translations and/or pre-rendition configuration
#     script are provided inside source location.
#
#   - Specific directory structures, if present, are both copiable and
#     removable. This is, when you perform a copy or delete action
#     from source, that source specific auxiliar directories are
#     transfered in the copy action to a new location (that specified
#     by FLAG_TO variable).
#
#   - When translations and/or pre-rendition configuration scripts are
#     found inside the source directory structure, the centos-art.sh
#     script loads common auxiliar directories first and later
#     specific auxiliar directories.  This way, identity rendition of
#     source locations can be customized idividually over the base of
#     common default values.
#
#   - Specific auxiliar directories are optional.
#
#   - Common auxiliar directories should be present always. This, in
#     order to provide the information required by render
#     functionality (i.e., to make it functional).
#
# Notice that, the duplication process is done from `trunk/Identity'
# on, not the oposite. If you try to duplicate a translation structure
# (or similar auxiliar directory structures like pre-rendition
# configuration scripts), the `trunk/Identity' for that translation is
# not created. This limitation is impossed by the fact that many
# `trunk/Identity' directory structures may reuse/share the same
# translation directory structure. We cannot delete one translation
# (or similar) directory structures while a related `trunk/Identity/'
# directory structure is still in need of it.
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

    # Determine what directory structure we are duplicating.

}
