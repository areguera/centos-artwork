#!/bin/bash
#
# cli_getLangCodes.sh -- This function outputs a list with language
# codes as defined in ISO639 standard.
#
# Copyright (C) 2009-2011 The CentOS Project
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
# ----------------------------------------------------------------------
# $Id$
# ----------------------------------------------------------------------

function cli_getLangCodes {

    local FILTER="$(echo $1 | cut -d_ -f1)"

    LANGCODES="aa
        ab 
        ae 
        af 
        ak 
        am 
        an 
        ar 
        as 
        av 
        ay 
        az 
        ba 
        be 
        bg 
        bh 
        bi 
        bm 
        bn 
        bo 
        br 
        bs 
        ca 
        ce 
        ch 
        co 
        cr 
        cs 
        cu 
        cv 
        cy 
        da 
        de 
        dv 
        dz 
        ee 
        el 
        en 
        eo 
        es 
        et 
        eu 
        fa 
        ff 
        fi 
        fj 
        fo 
        fr 
        fy 
        ga 
        gd 
        gl 
        gn 
        gu 
        gv 
        ha 
        he 
        hi 
        ho 
        hr 
        ht 
        hu 
        hy 
        hz 
        ia 
        id 
        ie 
        ig 
        ii 
        ik 
        io 
        is 
        it 
        iu 
        ja 
        jv 
        ka 
        kg 
        ki 
        kj 
        kk 
        kl 
        km 
        kn 
        ko 
        kr 
        ks 
        ku 
        kv 
        kw 
        ky 
        la 
        lb 
        lg 
        li 
        ln 
        lo 
        lt 
        lu 
        lv 
        mg 
        mh 
        mi 
        mk 
        ml 
        mn 
        mo 
        mr 
        ms 
        mt 
        my 
        na 
        nb 
        nd 
        ne 
        ng 
        nl 
        nn 
        no 
        nr 
        nv 
        ny 
        oc 
        oj 
        om 
        or 
        os 
        pa 
        pi 
        pl 
        ps 
        pt 
        qu 
        rm 
        rn 
        ro 
        ru 
        rw 
        sa 
        sc 
        sd 
        se 
        sg 
        si 
        sk 
        sl 
        sm 
        sn 
        so 
        sq 
        sr 
        ss 
        st 
        su 
        sv 
        sw 
        ta 
        te 
        tg 
        th 
        ti 
        tk 
        tl 
        tn 
        to 
        tr 
        ts 
        tt 
        tw 
        ty 
        ug 
        uk 
        ur 
        uz 
        ve 
        vi 
        vo 
        wa 
        wo 
        xh 
        yi 
        yo 
        za 
        zh 
        zu"

    if [[ $FILTER != '' ]];then
        echo "$LANGCODES" | egrep "$FILTER" | sed -r 's![[:space:]]+!!g'
    else
        echo "$LANGCODES"
    fi

}
