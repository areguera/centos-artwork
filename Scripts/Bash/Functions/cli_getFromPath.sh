#!/bin/bash
#
# cli_getFromPath.sh -- This function outputs different parts from
# path string. By default the full release information is output.
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

function cli_getFromPath {

    local -a PATTERN
    local LOCATION="$1"
    local OPTION="$2"

    # Define release pattern.
    PATTERN[0]="(([[:digit:]]+)(\.([[:digit:]]+)){,1})"

    # Define architecture pattern.
    PATTERN[1]="^.+/${PATTERN[0]}/(i386|x86_64)/.*$"

    # Define theme pattern for trunk, branches, and tags directory
    # structures.
    #
    # trunk:
    # ------
    # Themes are made of `Models' and `Motifs'. `Models' controls the
    # `Motifs' characteristcs and it is not rendereable. On the other
    # hand, `Motifs' controls the theme visual style and do is
    # renderable. Since we only need to know the theme name when we
    # render something, we take the `Motifs' directory structure as
    # reference to find out the theme name we are producing images
    # for.
    #
    # `Motifs' are organized by names, so when we say `a theme name'
    # we are really saying `the artistic motif name of a theme', but
    # for short `theme name' is used instead. `Models' are also
    # organized by names, but we do never use model names to name a
    # thame. We always say the `theme models' or `the models of the
    # theme` to refere the theme component that controls the
    # characteristics of artistic motifs. We never name a thame as its
    # model. We use artistic motifs name for such purpose.
    #
    # Inside artistic motif names, we organize different versions of
    # the same artistic motif by means of numerical worklines.
    # Worklines, inside trunk, have an integer numerical form and
    # begin at `1'. They increment one unit each time a new/fresh
    # visual style ---for the same artistic motif--- is conceived.
    #
    # For example, the Flame theme uses the flame filter of Gimp to
    # produce different fractal patterns randomly. We use the flame
    # filter to produce different visual styles under the same theme
    # since all patterns we produce are based on the same pattern
    # (i.e., the random fractal pattern of Gimp's flame filter). This
    # way, if you no longer want to produce visual styles from flame
    # filter, it is time to create a new artistic motif name for it.
    #
    # This schema is very convenient for designers and packagers,
    # since different designers can create their own worklines and go
    # on with them until CentOS distribution release date is close. At
    # that time, a workline is selected and tagged for packaging.
    # Translators and programmers can continue working indepently, and
    # without affection, in their own directory structures.
    #
    #   Example:
    #                               +------> theme name
    #                           |-->| 
    #   trunk/.../Themes/Motifs/Flame/1
    #   trunk/.../Themes/Motifs/Flame/2 
    #   trunk/.../Themes/Motifs/Flame/3
    #                                 |
    #                                 +----> theme release version
    #
    # Sometimes we only need to retrive the theme name, but othertimes
    # both the theme name and its work-line is required as well.
    #
    # branches:
    # ---------
    # The branch development line is treated just as trunk development
    # line does, but we rarely use it since it could be confusing to
    # know whether a tag was created from trunk or branches.
    #
    # Conceive an enumeration schema in order to differentiate
    # branches from trunk is not convenient either, it would introduce
    # an intermediate point to the final production of tags we would
    # need to be aware of.  Instead of such configuration, we prefer
    # to go straightforward from trunk to tags.
    #
    # Intermediate branches for quality assurance might be good in
    # some situations, but not when we produce themes. We need a
    # simple structure, where we could design, render content (using
    # centos-art.sh), and release for testing (through tags).  If
    # something goes wrong in the released tag, it would be fixed in
    # trunk and later released in another tagged relase.
    #
    # Of course, care should be taken to avoid making of trunk
    # development line a chaotic place.  Everbody should know exactly
    # what they are doing therein. We need to design protections to
    # isolate possible damages and that way, we could know exactly
    # what and where we need to concentrate in and put our time on.
    #
    # In resume, do not use branches if you don't need to.  Use trunk
    # development line instead.
    #
    # tags:
    # -----
    # The tag frozen line is mainly used to perform theme releases.
    #
    #   Example:
    #                                  +------> theme name
    #                              |-->| 
    #       tags/.../Themes/Motifs/Flame/1.0
    #      trunk/.../Themes/Motifs/Flame/1 |--> minor update
    #                                    |----> major udpate
    #
    # Tags have the format X.Z, where X is the first number in the
    # name (e.g., `1') and represents the trunk/branches artistic
    # motif version. The Z represents the second number in the name
    # (e.g., `0') which is the tag version itself.  
    #
    # Tag versions start at `0' and increment one unit each time a new
    # tag is created from the same artistic motif version.  When a new
    # tag is created for the same artistic motif version, the first
    # number in the tag name remains intact.  The first number in the
    # tag name only changes when we create a new tag for a new
    # artistic motif version.
    #
    #   Consider the following relations: 
    #
    #       trunk/.../Themes/Motifs/Flame/1
    #       tags/.../Themes/Motifs/Flame/1.0
    #       tags/.../Themes/Motifs/Flame/1.1
    #       tags/.../Themes/Motifs/Flame/1.2
    #
    #       trunk/.../Themes/Motifs/Flame/2
    #       tags/.../Themes/Motifs/Flame/2.0
    #       tags/.../Themes/Motifs/Flame/2.1
    #       tags/.../Themes/Motifs/Flame/2.2
    #
    #       trunk/.../Themes/Motifs/TreeFlower/1
    #       ...
    #       and so on. 
    #
    # Tag versions are created to release fixes and improvements, Tags
    # are immutable (i.e., once tags are created, they shouldn't be
    # modified.).
    PATTERN[2]="^.+/Identity/Themes/Motifs/(([A-Za-z0-9]+)/${PATTERN[0]})/.+$"

    # Identify which part of the release we want to output.
    case "$OPTION" in

        '--release' )
            echo "$LOCATION" | sed -r "s!.+/${PATTERN[0]}/.*!\1!"
            ;;

        '--release-major' )
            echo "$LOCATION" | sed -r "s!.+/${PATTERN[0]}/.*!\2!"
            ;;

        '--release-minor' )
            echo "$LOCATION" | sed -r "s!.+/${PATTERN[0]}/.*!\4!"
            ;;

        '--release-pattern' )
            echo "${PATTERN[0]}"
            ;;

        '--architecture' )
            echo "$LOCATION" | sed -r "s!${PATTERN[1]}!\5!"
            ;;

        '--architecture-pattern' )
            echo "${PATTERN[1]}"
            ;;

        '--theme' )
            echo "$LOCATION" | sed -r "s!${PATTERN[2]}!\1!"
            ;;

        '--theme-name' )
            echo "$LOCATION" | sed -r "s!${PATTERN[2]}!\2!"
            ;;

        '--theme-release' )
            echo "$LOCATION" | sed -r "s!${PATTERN[2]}!\3!"
            ;;

        '--theme-pattern' )
            echo "${PATTERN[2]}"
            ;;

    esac

}
