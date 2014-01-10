######################################################################
#
#   tcar - The CentOS Artwork Repository automation tool.
#   Copyright © 2014 The CentOS Artwork SIG
#
#   This program is free software; you can redistribute it and/or
#   modify it under the terms of the GNU General Public License as
#   published by the Free Software Foundation; either version 2 of the
#   License, or (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#   General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#
#   Alain Reguera Delgado <al@centos.org.cu>
#   39 Street No. 4426 Cienfuegos, Cuba.
#
######################################################################

# This file is the metadata information used by The CentOS Artwork SIG
# on its scalable vector graphics (SVG) files.  This files is used
# with the regular expression '.*\.svg$' only.
/<metadata/,/<\/metadata/c\
  <metadata\
     id="CENTOSMETADATA">\
    <rdf:RDF>\
      <cc:Work\
         rdf:about="">\
        <dc:format>image/svg+xml</dc:format>\
        <dc:type\
           rdf:resource="http://purl.org/dc/dcmitype/StillImage" />\
        <cc:license\
           rdf:resource="http://creativecommons.org/licenses/by-sa/3.0/" />\
        <dc:title>=TITLE=</dc:title>\
        <dc:date>=DATE=</dc:date>\
        <dc:creator>\
          <cc:Agent>\
            <dc:title>=COPYRIGHT_HOLDER=</dc:title>\
          </cc:Agent>\
        </dc:creator>\
        <dc:rights>\
          <cc:Agent>\
            <dc:title>=COPYRIGHT_HOLDER=</dc:title>\
          </cc:Agent>\
        </dc:rights>\
        <dc:publisher>\
          <cc:Agent>\
            <dc:title>=COPYRIGHT_HOLDER=</dc:title>\
          </cc:Agent>\
        </dc:publisher>\
        <dc:identifier>=URL=</dc:identifier>\
        <dc:source>=URL=</dc:source>\
        <dc:relation>=URL=</dc:relation>\
        <dc:language>=LOCALE=</dc:language>\
        <dc:subject>\
          <rdf:Bag>\
=KEYWORDS=\
          </rdf:Bag>\
        </dc:subject>\
        <dc:coverage>=COPYRIGHT_HOLDER=</dc:coverage>\
        <dc:description />\
        <dc:contributor />\
      </cc:Work>\
      <cc:License\
         rdf:about="http://creativecommons.org/licenses/by-sa/3.0/">\
        <cc:permits\
           rdf:resource="http://creativecommons.org/ns#Reproduction" />\
        <cc:permits\
           rdf:resource="http://creativecommons.org/ns#Distribution" />\
        <cc:requires\
           rdf:resource="http://creativecommons.org/ns#Notice" />\
        <cc:requires\
           rdf:resource="http://creativecommons.org/ns#Attribution" />\
        <cc:permits\
           rdf:resource="http://creativecommons.org/ns#DerivativeWorks" />\
        <cc:requires\
           rdf:resource="http://creativecommons.org/ns#ShareAlike" />\
      </cc:License>\
    </rdf:RDF>\
  </metadata>
