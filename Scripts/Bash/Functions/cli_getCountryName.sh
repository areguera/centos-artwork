#!/bin/bash
#
# cli_getCountryName.sh -- This function reads one language locale
# code in the format LL_CC and outputs the name of its related
# country.
#
# Copyright (C) 2009, 2010 Alain Reguera Delgado
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

function cli_getCountryName {

    local LOCALECODE="$(echo $1 | cut -d_ -f2)"
    local COUNTRYNAME=""

    case $LOCALECODE in

	'AD' )
        COUNTRYNAME="`gettext "Andorra"`"
        ;;
	'AE' )
        COUNTRYNAME="`gettext "United Arab Emirates"`"
        ;;
	'AF' )
        COUNTRYNAME="`gettext "Afghanistan"`"
        ;;
	'AG' )
        COUNTRYNAME="`gettext "Antigua and Barbuda"`"
        ;;
	'AI' )
        COUNTRYNAME="`gettext "Anguilla"`"
        ;;
	'AL' )
        COUNTRYNAME="`gettext "Albania"`"
        ;;
	'AM' )
        COUNTRYNAME="`gettext "Armenia"`"
        ;;
	'AN' )
        COUNTRYNAME="`gettext "Netherlands Antilles"`"
        ;;
	'AO' )
        COUNTRYNAME="`gettext "Angola"`"
        ;;
	'AQ' )
        COUNTRYNAME="`gettext "Antarctica"`"
        ;;
	'AR' )
        COUNTRYNAME="`gettext "Argentina"`"
        ;;
	'AS' )
        COUNTRYNAME="`gettext "Samoa (American)"`"
        ;;
	'AT' )
        COUNTRYNAME="`gettext "Austria"`"
        ;;
	'AU' )
        COUNTRYNAME="`gettext "Australia"`"
        ;;
	'AW' )
        COUNTRYNAME="`gettext "Aruba"`"
        ;;
	'AZ' )
        COUNTRYNAME="`gettext "Azerbaijan"`"
        ;;
	'BA' )
        COUNTRYNAME="`gettext "Bosnia and Herzegovina"`"
        ;;
	'BB' )
        COUNTRYNAME="`gettext "Barbados"`"
        ;;
	'BD' )
        COUNTRYNAME="`gettext "Bangladesh"`"
        ;;
	'BE' )
        COUNTRYNAME="`gettext "Belgium"`"
        ;;
	'BF' )
        COUNTRYNAME="`gettext "Burkina Faso"`"
        ;;
	'BG' )
        COUNTRYNAME="`gettext "Bulgaria"`"
        ;;
	'BH' )
        COUNTRYNAME="`gettext "Bahrain"`"
        ;;
	'BI' )
        COUNTRYNAME="`gettext "Burundi"`"
        ;;
	'BJ' )
        COUNTRYNAME="`gettext "Benin"`"
        ;;
	'BM' )
        COUNTRYNAME="`gettext "Bermuda"`"
        ;;
	'BN' )
        COUNTRYNAME="`gettext "Brunei"`"
        ;;
	'BO' )
        COUNTRYNAME="`gettext "Bolivia"`"
        ;;
	'BR' )
        COUNTRYNAME="`gettext "Brazil"`"
        ;;
	'BS' )
        COUNTRYNAME="`gettext "Bahamas"`"
        ;;
	'BT' )
        COUNTRYNAME="`gettext "Bhutan"`"
        ;;
	'BV' )
        COUNTRYNAME="`gettext "Bouvet Island"`"
        ;;
	'BW' )
        COUNTRYNAME="`gettext "Botswana"`"
        ;;
	'BY' )
        COUNTRYNAME="`gettext "Belarus"`"
        ;;
	'BZ' )
        COUNTRYNAME="`gettext "Belize"`"
        ;;
	'CA' )
        COUNTRYNAME="`gettext "Canada"`"
        ;;
	'CC' )
        COUNTRYNAME="`gettext "Cocos (Keeling) Islands"`"
        ;;
	'CD' )
        COUNTRYNAME="`gettext "Congo (Dem. Rep.)"`"
        ;;
	'CF' )
        COUNTRYNAME="`gettext "Central African Rep."`"
        ;;
	'CG' )
        COUNTRYNAME="`gettext "Congo (Rep.)"`"
        ;;
	'CH' )
        COUNTRYNAME="`gettext "Switzerland"`"
        ;;
	'CI' )
        COUNTRYNAME="`gettext "Co^te d'Ivoire"`"
        ;;
	'CK' )
        COUNTRYNAME="`gettext "Cook Islands"`"
        ;;
	'CL' )
        COUNTRYNAME="`gettext "Chile"`"
        ;;
	'CM' )
        COUNTRYNAME="`gettext "Cameroon"`"
        ;;
	'CN' )
        COUNTRYNAME="`gettext "China"`"
        ;;
	'CO' )
        COUNTRYNAME="`gettext "Colombia"`"
        ;;
	'CR' )
        COUNTRYNAME="`gettext "Costa Rica"`"
        ;;
	'CS' )
        COUNTRYNAME="`gettext "Serbia and Montenegro"`"
        ;;
	'CU' )
        COUNTRYNAME="`gettext "Cuba"`"
        ;;
	'CV' )
        COUNTRYNAME="`gettext "Cape Verde"`"
        ;;
	'CX' )
        COUNTRYNAME="`gettext "Christmas Island"`"
        ;;
	'CY' )
        COUNTRYNAME="`gettext "Cyprus"`"
        ;;
	'CZ' )
        COUNTRYNAME="`gettext "Czech Republic"`"
        ;;
	'DE' )
        COUNTRYNAME="`gettext "Germany"`"
        ;;
	'DJ' )
        COUNTRYNAME="`gettext "Djibouti"`"
        ;;
	'DK' )
        COUNTRYNAME="`gettext "Denmark"`"
        ;;
	'DM' )
        COUNTRYNAME="`gettext "Dominica"`"
        ;;
	'DO' )
        COUNTRYNAME="`gettext "Dominican Republic"`"
        ;;
	'DZ' )
        COUNTRYNAME="`gettext "Algeria"`"
        ;;
	'EC' )
        COUNTRYNAME="`gettext "Ecuador"`"
        ;;
	'EE' )
        COUNTRYNAME="`gettext "Estonia"`"
        ;;
	'EG' )
        COUNTRYNAME="`gettext "Egypt"`"
        ;;
	'EH' )
        COUNTRYNAME="`gettext "Western Sahara"`"
        ;;
	'ER' )
        COUNTRYNAME="`gettext "Eritrea"`"
        ;;
	'ES' )
        COUNTRYNAME="`gettext "Spain"`"
        ;;
	'ET' )
        COUNTRYNAME="`gettext "Ethiopia"`"
        ;;
	'FI' )
        COUNTRYNAME="`gettext "Finland"`"
        ;;
	'FJ' )
        COUNTRYNAME="`gettext "Fiji"`"
        ;;
	'FK' )
        COUNTRYNAME="`gettext "Falkland Islands"`"
        ;;
	'FM' )
        COUNTRYNAME="`gettext "Micronesia"`"
        ;;
	'FO' )
        COUNTRYNAME="`gettext "Faeroe Islands"`"
        ;;
	'FR' )
        COUNTRYNAME="`gettext "France"`"
        ;;
	'GA' )
        COUNTRYNAME="`gettext "Gabon"`"
        ;;
	'GB' )
        COUNTRYNAME="`gettext "Britain (UK)"`"
        ;;
	'GD' )
        COUNTRYNAME="`gettext "Grenada"`"
        ;;
	'GE' )
        COUNTRYNAME="`gettext "Georgia"`"
        ;;
	'GF' )
        COUNTRYNAME="`gettext "French Guiana"`"
        ;;
	'GH' )
        COUNTRYNAME="`gettext "Ghana"`"
        ;;
	'GI' )
        COUNTRYNAME="`gettext "Gibraltar"`"
        ;;
	'GL' )
        COUNTRYNAME="`gettext "Greenland"`"
        ;;
	'GM' )
        COUNTRYNAME="`gettext "Gambia"`"
        ;;
	'GN' )
        COUNTRYNAME="`gettext "Guinea"`"
        ;;
	'GP' )
        COUNTRYNAME="`gettext "Guadeloupe"`"
        ;;
	'GQ' )
        COUNTRYNAME="`gettext "Equatorial Guinea"`"
        ;;
	'GR' )
        COUNTRYNAME="`gettext "Greece"`"
        ;;
	'GS' )
        COUNTRYNAME="`gettext "South Georgia and the South Sandwich Islands"`"
        ;;
	'GT' )
        COUNTRYNAME="`gettext "Guatemala"`"
        ;;
	'GU' )
        COUNTRYNAME="`gettext "Guam"`"
        ;;
	'GW' )
        COUNTRYNAME="`gettext "Guinea-Bissau"`"
        ;;
	'GY' )
        COUNTRYNAME="`gettext "Guyana"`"
        ;;
	'HK' )
        COUNTRYNAME="`gettext "Hong Kong"`"
        ;;
	'HM' )
        COUNTRYNAME="`gettext "Heard Island and McDonald Islands"`"
        ;;
	'HN' )
        COUNTRYNAME="`gettext "Honduras"`"
        ;;
	'HR' )
        COUNTRYNAME="`gettext "Croatia"`"
        ;;
	'HT' )
        COUNTRYNAME="`gettext "Haiti"`"
        ;;
	'HU' )
        COUNTRYNAME="`gettext "Hungary"`"
        ;;
	'ID' )
        COUNTRYNAME="`gettext "Indonesia"`"
        ;;
	'IE' )
        COUNTRYNAME="`gettext "Ireland"`"
        ;;
	'IL' )
        COUNTRYNAME="`gettext "Israel"`"
        ;;
	'IN' )
        COUNTRYNAME="`gettext "India"`"
        ;;
	'IO' )
        COUNTRYNAME="`gettext "British Indian Ocean Territory"`"
        ;;
	'IQ' )
        COUNTRYNAME="`gettext "Iraq"`"
        ;;
	'IR' )
        COUNTRYNAME="`gettext "Iran"`"
        ;;
	'IS' )
        COUNTRYNAME="`gettext "Iceland"`"
        ;;
	'IT' )
        COUNTRYNAME="`gettext "Italy"`"
        ;;
	'JM' )
        COUNTRYNAME="`gettext "Jamaica"`"
        ;;
	'JO' )
        COUNTRYNAME="`gettext "Jordan"`"
        ;;
	'JP' )
        COUNTRYNAME="`gettext "Japan"`"
        ;;
	'KE' )
        COUNTRYNAME="`gettext "Kenya"`"
        ;;
	'KG' )
        COUNTRYNAME="`gettext "Kyrgyzstan"`"
        ;;
	'KH' )
        COUNTRYNAME="`gettext "Cambodia"`"
        ;;
	'KI' )
        COUNTRYNAME="`gettext "Kiribati"`"
        ;;
	'KM' )
        COUNTRYNAME="`gettext "Comoros"`"
        ;;
	'KN' )
        COUNTRYNAME="`gettext "St Kitts and Nevis"`"
        ;;
	'KP' )
        COUNTRYNAME="`gettext "Korea (North)"`"
        ;;
	'KR' )
        COUNTRYNAME="`gettext "Korea (South)"`"
        ;;
	'KW' )
        COUNTRYNAME="`gettext "Kuwait"`"
        ;;
	'KY' )
        COUNTRYNAME="`gettext "Cayman Islands"`"
        ;;
	'KZ' )
        COUNTRYNAME="`gettext "Kazakhstan"`"
        ;;
	'LA' )
        COUNTRYNAME="`gettext "Laos"`"
        ;;
	'LB' )
        COUNTRYNAME="`gettext "Lebanon"`"
        ;;
	'LC' )
        COUNTRYNAME="`gettext "St Lucia"`"
        ;;
	'LI' )
        COUNTRYNAME="`gettext "Liechtenstein"`"
        ;;
	'LK' )
        COUNTRYNAME="`gettext "Sri Lanka"`"
        ;;
	'LR' )
        COUNTRYNAME="`gettext "Liberia"`"
        ;;
	'LS' )
        COUNTRYNAME="`gettext "Lesotho"`"
        ;;
	'LT' )
        COUNTRYNAME="`gettext "Lithuania"`"
        ;;
	'LU' )
        COUNTRYNAME="`gettext "Luxembourg"`"
        ;;
	'LV' )
        COUNTRYNAME="`gettext "Latvia"`"
        ;;
	'LY' )
        COUNTRYNAME="`gettext "Libya"`"
        ;;
	'MA' )
        COUNTRYNAME="`gettext "Morocco"`"
        ;;
	'MC' )
        COUNTRYNAME="`gettext "Monaco"`"
        ;;
	'MD' )
        COUNTRYNAME="`gettext "Moldova"`"
        ;;
	'MG' )
        COUNTRYNAME="`gettext "Madagascar"`"
        ;;
	'MH' )
        COUNTRYNAME="`gettext "Marshall Islands"`"
        ;;
	'MK' )
        COUNTRYNAME="`gettext "Macedonia"`"
        ;;
	'ML' )
        COUNTRYNAME="`gettext "Mali"`"
        ;;
	'MM' )
        COUNTRYNAME="`gettext "Myanmar (Burma)"`"
        ;;
	'MN' )
        COUNTRYNAME="`gettext "Mongolia"`"
        ;;
	'MO' )
        COUNTRYNAME="`gettext "Macao"`"
        ;;
	'MP' )
        COUNTRYNAME="`gettext "Northern Mariana Islands"`"
        ;;
	'MQ' )
        COUNTRYNAME="`gettext "Martinique"`"
        ;;
	'MR' )
        COUNTRYNAME="`gettext "Mauritania"`"
        ;;
	'MS' )
        COUNTRYNAME="`gettext "Montserrat"`"
        ;;
	'MT' )
        COUNTRYNAME="`gettext "Malta"`"
        ;;
	'MU' )
        COUNTRYNAME="`gettext "Mauritius"`"
        ;;
	'MV' )
        COUNTRYNAME="`gettext "Maldives"`"
        ;;
	'MW' )
        COUNTRYNAME="`gettext "Malawi"`"
        ;;
	'MX' )
        COUNTRYNAME="`gettext "Mexico"`"
        ;;
	'MY' )
        COUNTRYNAME="`gettext "Malaysia"`"
        ;;
	'MZ' )
        COUNTRYNAME="`gettext "Mozambique"`"
        ;;
	'NA' )
        COUNTRYNAME="`gettext "Namibia"`"
        ;;
	'NC' )
        COUNTRYNAME="`gettext "New Caledonia"`"
        ;;
	'NE' )
        COUNTRYNAME="`gettext "Niger"`"
        ;;
	'NF' )
        COUNTRYNAME="`gettext "Norfolk Island"`"
        ;;
	'NG' )
        COUNTRYNAME="`gettext "Nigeria"`"
        ;;
	'NI' )
        COUNTRYNAME="`gettext "Nicaragua"`"
        ;;
	'NL' )
        COUNTRYNAME="`gettext "Netherlands"`"
        ;;
	'NO' )
        COUNTRYNAME="`gettext "Norway"`"
        ;;
	'NP' )
        COUNTRYNAME="`gettext "Nepal"`"
        ;;
	'NR' )
        COUNTRYNAME="`gettext "Nauru"`"
        ;;
	'NU' )
        COUNTRYNAME="`gettext "Niue"`"
        ;;
	'NZ' )
        COUNTRYNAME="`gettext "New Zealand"`"
        ;;
	'OM' )
        COUNTRYNAME="`gettext "Oman"`"
        ;;
	'PA' )
        COUNTRYNAME="`gettext "Panama"`"
        ;;
	'PE' )
        COUNTRYNAME="`gettext "Peru"`"
        ;;
	'PF' )
        COUNTRYNAME="`gettext "French Polynesia"`"
        ;;
	'PG' )
        COUNTRYNAME="`gettext "Papua New Guinea"`"
        ;;
	'PH' )
        COUNTRYNAME="`gettext "Philippines"`"
        ;;
	'PK' )
        COUNTRYNAME="`gettext "Pakistan"`"
        ;;
	'PL' )
        COUNTRYNAME="`gettext "Poland"`"
        ;;
	'PM' )
        COUNTRYNAME="`gettext "St Pierre and Miquelon"`"
        ;;
	'PN' )
        COUNTRYNAME="`gettext "Pitcairn"`"
        ;;
	'PR' )
        COUNTRYNAME="`gettext "Puerto Rico"`"
        ;;
	'PS' )
        COUNTRYNAME="`gettext "Palestine"`"
        ;;
	'PT' )
        COUNTRYNAME="`gettext "Portugal"`"
        ;;
	'PW' )
        COUNTRYNAME="`gettext "Palau"`"
        ;;
	'PY' )
        COUNTRYNAME="`gettext "Paraguay"`"
        ;;
	'QA' )
        COUNTRYNAME="`gettext "Qatar"`"
        ;;
	'RE' )
        COUNTRYNAME="`gettext "Reunion"`"
        ;;
	'RO' )
        COUNTRYNAME="`gettext "Romania"`"
        ;;
	'RU' )
        COUNTRYNAME="`gettext "Russia"`"
        ;;
	'RW' )
        COUNTRYNAME="`gettext "Rwanda"`"
        ;;
	'SA' )
        COUNTRYNAME="`gettext "Saudi Arabia"`"
        ;;
	'SB' )
        COUNTRYNAME="`gettext "Solomon Islands"`"
        ;;
	'SC' )
        COUNTRYNAME="`gettext "Seychelles"`"
        ;;
	'SD' )
        COUNTRYNAME="`gettext "Sudan"`"
        ;;
	'SE' )
        COUNTRYNAME="`gettext "Sweden"`"
        ;;
	'SG' )
        COUNTRYNAME="`gettext "Singapore"`"
        ;;
	'SH' )
        COUNTRYNAME="`gettext "St Helena"`"
        ;;
	'SI' )
        COUNTRYNAME="`gettext "Slovenia"`"
        ;;
	'SJ' )
        COUNTRYNAME="`gettext "Svalbard and Jan Mayen"`"
        ;;
	'SK' )
        COUNTRYNAME="`gettext "Slovakia"`"
        ;;
	'SL' )
        COUNTRYNAME="`gettext "Sierra Leone"`"
        ;;
	'SM' )
        COUNTRYNAME="`gettext "San Marino"`"
        ;;
	'SN' )
        COUNTRYNAME="`gettext "Senegal"`"
        ;;
	'SO' )
        COUNTRYNAME="`gettext "Somalia"`"
        ;;
	'SR' )
        COUNTRYNAME="`gettext "Suriname"`"
        ;;
	'ST' )
        COUNTRYNAME="`gettext "Sao Tome and Principe"`"
        ;;
	'SV' )
        COUNTRYNAME="`gettext "El Salvador"`"
        ;;
	'SY' )
        COUNTRYNAME="`gettext "Syria"`"
        ;;
	'SZ' )
        COUNTRYNAME="`gettext "Swaziland"`"
        ;;
	'TC' )
        COUNTRYNAME="`gettext "Turks and Caicos Islands"`"
        ;;
	'TD' )
        COUNTRYNAME="`gettext "Chad"`"
        ;;
	'TF' )
        COUNTRYNAME="`gettext "French Southern and Antarctic Lands"`"
        ;;
	'TG' )
        COUNTRYNAME="`gettext "Togo"`"
        ;;
	'TH' )
        COUNTRYNAME="`gettext "Thailand"`"
        ;;
	'TJ' )
        COUNTRYNAME="`gettext "Tajikistan"`"
        ;;
	'TK' )
        COUNTRYNAME="`gettext "Tokelau"`"
        ;;
	'TL' )
        COUNTRYNAME="`gettext "Timor-Leste"`"
        ;;
	'TM' )
        COUNTRYNAME="`gettext "Turkmenistan"`"
        ;;
	'TN' )
        COUNTRYNAME="`gettext "Tunisia"`"
        ;;
	'TO' )
        COUNTRYNAME="`gettext "Tonga"`"
        ;;
	'TR' )
        COUNTRYNAME="`gettext "Turkey"`"
        ;;
	'TT' )
        COUNTRYNAME="`gettext "Trinidad and Tobago"`"
        ;;
	'TV' )
        COUNTRYNAME="`gettext "Tuvalu"`"
        ;;
	'TW' )
        COUNTRYNAME="`gettext "Taiwan"`"
        ;;
	'TZ' )
        COUNTRYNAME="`gettext "Tanzania"`"
        ;;
	'UA' )
        COUNTRYNAME="`gettext "Ukraine"`"
        ;;
	'UG' )
        COUNTRYNAME="`gettext "Uganda"`"
        ;;
	'UM' )
        COUNTRYNAME="`gettext "US minor outlying islands"`"
        ;;
	'US' )
        COUNTRYNAME="`gettext "United States"`"
        ;;
	'UY' )
        COUNTRYNAME="`gettext "Uruguay"`"
        ;;
	'UZ' )
        COUNTRYNAME="`gettext "Uzbekistan"`"
        ;;
	'VA' )
        COUNTRYNAME="`gettext "Vatican City"`"
        ;;
	'VC' )
        COUNTRYNAME="`gettext "St Vincent"`"
        ;;
	'VE' )
        COUNTRYNAME="`gettext "Venezuela"`"
        ;;
	'VG' )
        COUNTRYNAME="`gettext "Virgin Islands (UK)"`"
        ;;
	'VI' )
        COUNTRYNAME="`gettext "Virgin Islands (US)"`"
        ;;
	'VN' )
        COUNTRYNAME="`gettext "Vietnam"`"
        ;;
	'VU' )
        COUNTRYNAME="`gettext "Vanuatu"`"
        ;;
	'WF' )
        COUNTRYNAME="`gettext "Wallis and Futuna"`"
        ;;
	'WS' )
        COUNTRYNAME="`gettext "Samoa (Western)"`"
        ;;
	'YE' )
        COUNTRYNAME="`gettext "Yemen"`"
        ;;
	'YT' )
        COUNTRYNAME="`gettext "Mayotte"`"
        ;;
	'ZA' )
        COUNTRYNAME="`gettext "South Africa"`"
        ;;
	'ZM' )
        COUNTRYNAME="`gettext "Zambia"`"
        ;;
	'ZW' )
        COUNTRYNAME="`gettext "Zimbabwe"`"
        ;;
        * )
        COUNTRYNAME="`gettext "Unknown"`"

    esac

    echo $COUNTRYNAME
    
}
