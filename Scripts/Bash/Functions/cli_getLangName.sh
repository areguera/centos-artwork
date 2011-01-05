#!/bin/bash
#
# cli_getLangName.sh -- This function reads one language locale code
# in the format LL_CC and outputs its language name.
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

function cli_getLangName {

   local LANGCODE="$(echo $1 | cut -d_ -f1)"
   local LANGNAME=''

   case $LANGCODE in

      'aa' )
      LANGNAME="`gettext "Afar"`"
      ;;
      
      'ab' )
      LANGNAME="`gettext "Abkhazian"`"
      ;;
      
      'ae' )
      LANGNAME="`gettext "Avestan"`"
      ;;
      
      'af' )
      LANGNAME="`gettext "Afrikaans"`"
      ;;
      
      'ak' )
      LANGNAME="`gettext "Akan"`"
      ;;
      
      'am' )
      LANGNAME="`gettext "Amharic"`"
      ;;
      
      'an' )
      LANGNAME="`gettext "Aragonese"`"
      ;;
      
      'ar' )
      LANGNAME="`gettext "Arabic"`"
      ;;
      
      'as' )
      LANGNAME="`gettext "Assamese"`"
      ;;
      
      'av' )
      LANGNAME="`gettext "Avaric"`"
      ;;
      
      'ay' )
      LANGNAME="`gettext "Aymara"`"
      ;;
      
      'az' )
      LANGNAME="`gettext "Azerbaijani"`"
      ;;
      
      'ba' )
      LANGNAME="`gettext "Bashkir"`"
      ;;
      
      'be' )
      LANGNAME="`gettext "Byelorussian"`"
      ;;
      
      'bg' )
      LANGNAME="`gettext "Bulgarian"`"
      ;;
      
      'bh' )
      LANGNAME="`gettext "Bihari"`"
      ;;
      
      'bi' )
      LANGNAME="`gettext "Bislama"`"
      ;;
      
      'bm' )
      LANGNAME="`gettext "Bambara"`"
      ;;
      
      'bn' )
      LANGNAME="`gettext "Bengali"`"
      ;;
      
      'bo' )
      LANGNAME="`gettext "Tibetan"`"
      ;;
      
      'br' )
      LANGNAME="`gettext "Breton"`"
      ;;
      
      'bs' )
      LANGNAME="`gettext "Bosnian"`"
      ;;
      
      'ca' )
      LANGNAME="`gettext "Catalan"`"
      ;;
      
      'ce' )
      LANGNAME="`gettext "Chechen"`"
      ;;
      
      'ch' )
      LANGNAME="`gettext "Chamorro"`"
      ;;
      
      'co' )
      LANGNAME="`gettext "Corsican"`"
      ;;
      
      'cr' )
      LANGNAME="`gettext "Cree"`"
      ;;
      
      'cs' )
      LANGNAME="`gettext "Czech"`"
      ;;
      
      'cu' )
      LANGNAME="`gettext "Church Slavic"`"
      ;;
      
      'cv' )
      LANGNAME="`gettext "Chuvash"`"
      ;;
      
      'cy' )
      LANGNAME="`gettext "Welsh"`"
      ;;
      
      'da' )
      LANGNAME="`gettext "Danish"`"
      ;;
      
      'de' )
      LANGNAME="`gettext "German"`"
      ;;
      
      'dv' )
      LANGNAME="`gettext "Divehi"`"
      ;;
      
      'dz' )
      LANGNAME="`gettext "Dzongkha"`"
      ;;
      
      'ee' )
      LANGNAME="`gettext "E'we"`"
      ;;
      
      'el' )
      LANGNAME="`gettext "Greek"`"
      ;;
      
      'en' )
      LANGNAME="`gettext "English"`"
      ;;
      
      'eo' )
      LANGNAME="`gettext "Esperanto"`"
      ;;
      
      'es' )
      LANGNAME="`gettext "Spanish"`"
      ;;
      
      'et' )
      LANGNAME="`gettext "Estonian"`"
      ;;
      
      'eu' )
      LANGNAME="`gettext "Basque"`"
      ;; 
      'fa' )
      LANGNAME="`gettext "Persian"`"
      ;;
      
      'ff' )
      LANGNAME="`gettext "Fulah"`"
      ;;
      
      'fi' )
      LANGNAME="`gettext "Finnish"`"
      ;;
      
      'fj' )
      LANGNAME="`gettext "Fijian"`"
      ;;
      
      'fo' )
      LANGNAME="`gettext "Faroese"`"
      ;;
      
      'fr' )
      LANGNAME="`gettext "French"`"
      ;;
      
      'fy' )
      LANGNAME="`gettext "Frisian"`"
      ;;
      
      'ga' )
      LANGNAME="`gettext "Irish"`"
      ;;
      
      'gd' )
      LANGNAME="`gettext "Scots"`"
      ;;
      
      'gl' )
      LANGNAME="`gettext "Gallegan"`"
      ;; 

      'gn' )
      LANGNAME="`gettext "Guarani"`"
      ;;
      
      'gu' )
      LANGNAME="`gettext "Gujarati"`"
      ;;
      
      'gv' )
      LANGNAME="`gettext "Manx"`"
      ;;
      
      'ha' )
      LANGNAME="`gettext "Hausa"`"
      ;;
      
      'he' )
      LANGNAME="`gettext "Hebrew"`"
      ;;
      
      'hi' )
      LANGNAME="`gettext "Hindi"`"
      ;;
      
      'ho' )
      LANGNAME="`gettext "Hiri Motu"`"
      ;;
      
      'hr' )
      LANGNAME="`gettext "Croatian"`"
      ;;
      
      'ht' )
      LANGNAME="`gettext "Haitian"`"
      ;;
      
      'hu' )
      LANGNAME="`gettext "Hungarian"`"
      ;;
      
      'hy' )
      LANGNAME="`gettext "Armenian"`"
      ;;
      
      'hz' )
      LANGNAME="`gettext "Herero"`"
      ;;
      
      'ia' )
      LANGNAME="`gettext "Interlingua"`"
      ;;
      
      'id' )
      LANGNAME="`gettext "Indonesian"`"
      ;;
      
      'ie' )
      LANGNAME="`gettext "Interlingue"`"
      ;;
      
      'ig' )
      LANGNAME="`gettext "Igbo"`"
      ;;

      'ii' )
      LANGNAME="`gettext "Sichuan Yi"`"
      ;;
      
      'ik' )
      LANGNAME="`gettext "Inupiak"`"
      ;;
      
      'io' )
      LANGNAME="`gettext "Ido"`"
      ;;
      
      'is' )
      LANGNAME="`gettext "Icelandic"`"
      ;;
      
      'it' )
      LANGNAME="`gettext "Italian"`"
      ;;
      
      'iu' )
      LANGNAME="`gettext "Inuktitut"`"
      ;;
      
      'ja' )
      LANGNAME="`gettext "Japanese"`"
      ;;
      
      'jv' )
      LANGNAME="`gettext "Javanese"`"
      ;;
      
      'ka' )
      LANGNAME="`gettext "Georgian"`"
      ;;
      
      'kg' )
      LANGNAME="`gettext "Kongo"`"
      ;;
      
      'ki' )
      LANGNAME="`gettext "Kikuyu"`"
      ;;
      
      'kj' )
      LANGNAME="`gettext "Kuanyama"`"
      ;;
      
      'kk' )
      LANGNAME="`gettext "Kazakh"`"
      ;;
      
      'kl' )
      LANGNAME="`gettext "Kalaallisut"`"
      ;;
      
      'km' )
      LANGNAME="`gettext "Khmer"`"
      ;;
      
      'kn' )
      LANGNAME="`gettext "Kannada"`"
      ;;
      
      'ko' )
      LANGNAME="`gettext "Korean"`"
      ;;
      
      'kr' )
      LANGNAME="`gettext "Kanuri"`"
      ;;
      
      'ks' )
      LANGNAME="`gettext "Kashmiri"`"
      ;;

      'ku' )
      LANGNAME="`gettext "Kurdish"`"
      ;;
      
      'kv' )
      LANGNAME="`gettext "Komi"`"
      ;;

      'kw' )
      LANGNAME="`gettext "Cornish"`"
      ;;
      
      'ky' )
      LANGNAME="`gettext "Kirghiz"`"
      ;;
      
      'la' )
      LANGNAME="`gettext "Latin"`"
      ;;
      
      'lb' )
      LANGNAME="`gettext "Letzeburgesch"`"
      ;;
      
      'lg' )
      LANGNAME="`gettext "Ganda"`"
      ;;
      
      'li' )
      LANGNAME="`gettext "Limburgish"`"
      ;;
      
      'ln' )
      LANGNAME="`gettext "Lingala"`"
      ;;
      
      'lo' )
      LANGNAME="`gettext "Lao"`"
      ;;
      
      'lt' )
      LANGNAME="`gettext "Lithuanian"`"
      ;;
      
      'lu' )
      LANGNAME="`gettext "Luba-Katanga"`"
      ;;
      
      'lv' )
      LANGNAME="`gettext "Latvian"`"
      ;;
      
      'mg' )
      LANGNAME="`gettext "Malagasy"`"
      ;;
      
      'mh' )
      LANGNAME="`gettext "Marshall"`"
      ;;
      
      'mi' )
      LANGNAME="`gettext "Maori"`"
      ;;
      
      'mk' )
      LANGNAME="`gettext "Macedonian"`"
      ;;
      
      'ml' )
      LANGNAME="`gettext "Malayalam"`"
      ;;
      
      'mn' )
      LANGNAME="`gettext "Mongolian"`"
      ;;
      
      'mo' )
      LANGNAME="`gettext "Moldavian"`"
      ;;
      
      'mr' )
      LANGNAME="`gettext "Marathi"`"
      ;;

      'ms' )
      LANGNAME="`gettext "Malay"`"
      ;;
      
      'mt' )
      LANGNAME="`gettext "Maltese"`"
      ;;
      
      'my' )
      LANGNAME="`gettext "Burmese"`"
      ;;
      
      'na' )
      LANGNAME="`gettext "Nauru"`"
      ;;
      
      'nb' )
      LANGNAME="`gettext "Norwegian Bokmaal"`"
      ;;
      
      'nd' )
      LANGNAME="`gettext "Ndebele, North"`"
      ;;
      
      'ne' )
      LANGNAME="`gettext "Nepali"`"
      ;;
      
      'ng' )
      LANGNAME="`gettext "Ndonga"`"
      ;;
      
      'nl' )
      LANGNAME="`gettext "Dutch"`"
      ;;
      
      'nn' )
      LANGNAME="`gettext "Norwegian Nynorsk"`"
      ;; 

      'no' )
      LANGNAME="`gettext "Norwegian"`"
      ;;
      
      'nr' )
      LANGNAME="`gettext "Ndebele, South"`"
      ;;
      
      'nv' )
      LANGNAME="`gettext "Navajo"`"
      ;;
      
      'ny' )
      LANGNAME="`gettext "Chichewa"`"
      ;;
      
      'oc' )
      LANGNAME="`gettext "Occitan"`"
      ;;
      
      'oj' )
      LANGNAME="`gettext "Ojibwa"`"
      ;;
      
      'om' )
      LANGNAME="`gettext "(Afan) Oromo"`"
      ;;
      
      'or' )
      LANGNAME="`gettext "Oriya"`"
      ;;
      
      'os' )
      LANGNAME="`gettext "Ossetian; Ossetic"`"
      ;;
      
      'pa' )
      LANGNAME="`gettext "Panjabi; Punjabi"`"
      ;;
      
      'pi' )
      LANGNAME="`gettext "Pali"`"
      ;;
      
      'pl' )
      LANGNAME="`gettext "Polish"`"
      ;;
      
      'ps' )
      LANGNAME="`gettext "Pashto, Pushto"`"
      ;;
      
      'pt' )
      LANGNAME="`gettext "Portuguese"`"
      ;;

      'qu' )
      LANGNAME="`gettext "Quechua"`"
      ;;
      
      'rm' )
      LANGNAME="`gettext "Rhaeto-Romance"`"
      ;;
      
      'rn' )
      LANGNAME="`gettext "Rundi"`"
      ;;
      
      'ro' )
      LANGNAME="`gettext "Romanian"`"
      ;;
      
      'ru' )
      LANGNAME="`gettext "Russian"`"
      ;;
      
      'rw' )
      LANGNAME="`gettext "Kinyarwanda"`"
      ;;
      
      'sa' )
      LANGNAME="`gettext "Sanskrit"`"
      ;;
      
      'sc' )
      LANGNAME="`gettext "Sardinian"`"
      ;;
      
      'sd' )
      LANGNAME="`gettext "Sindhi"`"
      ;;
      
      'se' )
      LANGNAME="`gettext "Northern Sami"`"
      ;;
      
      'sg' )
      LANGNAME="`gettext "Sango; Sangro"`"
      ;;
      
      'si' )
      LANGNAME="`gettext "Sinhalese"`"
      ;;
      
      'sk' )
      LANGNAME="`gettext "Slovak"`"
      ;;
      
      'sl' )
      LANGNAME="`gettext "Slovenian"`"
      ;;
      
      'sm' )
      LANGNAME="`gettext "Samoan"`"
      ;;
      
      'sn' )
      LANGNAME="`gettext "Shona"`"
      ;;
      
      'so' )
      LANGNAME="`gettext "Somali"`"
      ;;
      
      'sq' )
      LANGNAME="`gettext "Albanian"`"
      ;;
      
      'sr' )
      LANGNAME="`gettext "Serbian"`"
      ;;
      
      'ss' )
      LANGNAME="`gettext "Swati; Siswati"`"
      ;;
      
      'st' )
      LANGNAME="`gettext "Sesotho; Sotho, Southern"`"
      ;;
      
      'su' )
      LANGNAME="`gettext "Sundanese"`"
      ;;
      
      'sv' )
      LANGNAME="`gettext "Swedish"`"
      ;;

      'sw' )
      LANGNAME="`gettext "Swahili"`"
      ;;
      
      'ta' )
      LANGNAME="`gettext "Tamil"`"
      ;;
      
      'te' )
      LANGNAME="`gettext "Telugu"`"
      ;;
      
      'tg' )
      LANGNAME="`gettext "Tajik"`"
      ;;
      
      'th' )
      LANGNAME="`gettext "Thai"`"
      ;;
      
      'ti' )
      LANGNAME="`gettext "Tigrinya"`"
      ;;
      
      'tk' )
      LANGNAME="`gettext "Turkmen"`"
      ;;
      
      'tl' )
      LANGNAME="`gettext "Tagalog"`"
      ;;
      
      'tn' )
      LANGNAME="`gettext "Tswana; Setswana"`"
      ;;
      
      'to' )
      LANGNAME="`gettext "Tonga (?)"`"
      ;;
      
      'tr' )
      LANGNAME="`gettext "Turkish"`"
      ;;
      
      'ts' )
      LANGNAME="`gettext "Tsonga"`"
      ;;

      
      'tt' )
      LANGNAME="`gettext "Tatar"`"
      ;;

      'tw' )
      LANGNAME="`gettext "Twi"`"
      ;;
      
      'ty' )
      LANGNAME="`gettext "Tahitian"`"
      ;;
      
      'ug' )
      LANGNAME="`gettext "Uighur"`"
      ;;
      
      'uk' )
      LANGNAME="`gettext "Ukrainian"`"
      ;;
      
      'ur' )
      LANGNAME="`gettext "Urdu"`"
      ;;
      
      'uz' )
      LANGNAME="`gettext "Uzbek"`"
      ;;
      
      've' )
      LANGNAME="`gettext "Venda"`"
      ;;
      
      'vi' )
      LANGNAME="`gettext "Vietnamese"`"
      ;;
      
      'vo' )
      LANGNAME="`gettext "Volapuk; Volapuk"`"
      ;;
      
      'wa' )
      LANGNAME="`gettext "Walloon"`"
      ;;
      
      'wo' )
      LANGNAME="`gettext "Wolof"`"
      ;;
      
      'xh' )
      LANGNAME="`gettext "Xhosa"`"
      ;;
      
      'yi' )
      LANGNAME="`gettext "Yiddish (formerly ji)"`"
      ;;
      
      'yo' )
      LANGNAME="`gettext "Yoruba"`"
      ;;
      
      'za' )
      LANGNAME="`gettext "Zhuang"`"
      ;;
      
      'zh' )
      LANGNAME="`gettext "Chinese"`"
      ;;
      
      'zu' )
      LANGNAME="`gettext "Zulu"`"
      ;;

      * )
      LANGNAME="`gettext "Unknown"`"

   esac

   echo $LANGNAME;
}

