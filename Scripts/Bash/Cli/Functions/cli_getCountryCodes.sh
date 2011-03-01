#!/bin/bash
#
# cli_getCountryCodes.sh -- This function outputs a list with country
# codes as defined in ISO3166 standard.
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

function cli_getCountryCodes {

    local FILTER="$(echo $1 | cut -d_ -f2)"

    COUNTRYCODES='AD 
        AE 
        AF 
        AG 
        AI 
        AL 
        AM 
        AN 
        AO 
        AQ 
        AR 
        AS 
        AT 
        AU 
        AW 
        AZ 
        BA 
        BB 
        BD 
        BE 
        BF 
        BG 
        BH 
        BI 
        BJ 
        BM 
        BN 
        BO 
        BR 
        BS 
        BT 
        BV 
        BW 
        BY 
        BZ 
        CA 
        CC 
        CD 
        CF 
        CG 
        CH 
        CI 
        CK 
        CL 
        CM 
        CN 
        CO 
        CR 
        CS 
        CU 
        CV 
        CX 
        CY 
        CZ 
        DE 
        DJ 
        DK 
        DM 
        DO 
        DZ 
        EC 
        EE 
        EG 
        EH 
        ER 
        ES 
        ET 
        FI 
        FJ 
        FK 
        FM 
        FO 
        FR 
        GA 
        GB 
        GD 
        GE 
        GF 
        GH 
        GI 
        GL 
        GM 
        GN 
        GP 
        GQ 
        GR 
        GS 
        GT 
        GU 
        GW 
        GY 
        HK 
        HM 
        HN 
        HR 
        HT 
        HU 
        ID 
        IE 
        IL 
        IN 
        IO 
        IQ 
        IR 
        IS 
        IT 
        JM 
        JO 
        JP 
        KE 
        KG 
        KH 
        KI 
        KM 
        KN 
        KP 
        KR 
        KW 
        KY 
        KZ 
        LA 
        LB 
        LC 
        LI 
        LK 
        LR 
        LS 
        LT 
        LU 
        LV 
        LY 
        MA 
        MC 
        MD 
        MG 
        MH 
        MK 
        ML 
        MM 
        MN 
        MO 
        MP 
        MQ 
        MR 
        MS 
        MT 
        MU 
        MV 
        MW 
        MX 
        MY 
        MZ 
        NA 
        NC 
        NE 
        NF 
        NG 
        NI 
        NL 
        NO 
        NP 
        NR 
        NU 
        NZ 
        OM 
        PA 
        PE 
        PF 
        PG 
        PH 
        PK 
        PL 
        PM 
        PN 
        PR 
        PS 
        PT 
        PW 
        PY 
        QA 
        RE 
        RO 
        RU 
        RW 
        SA 
        SB 
        SC 
        SD 
        SE 
        SG 
        SH 
        SI 
        SJ 
        SK 
        SL 
        SM 
        SN 
        SO 
        SR 
        ST 
        SV 
        SY 
        SZ 
        TC 
        TD 
        TF 
        TG 
        TH 
        TJ 
        TK 
        TL 
        TM 
        TN 
        TO 
        TR 
        TT 
        TV 
        TW 
        TZ 
        UA 
        UG 
        UM 
        US 
        UY 
        UZ 
        VA 
        VC 
        VE 
        VG 
        VI 
        VN 
        VU 
        WF 
        WS 
        YE 
        YT 
        ZA 
        ZM 
        ZW'

    if [[ $FILTER != '' ]];then
        echo $COUNTRYCODES | egrep "$FILTER"
    else
        echo "$COUNTRYCODES"
    fi

}
