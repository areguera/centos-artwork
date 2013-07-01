<?php

$lisence = "<pre>
     newbb to phpbb :: Migrating from Xoops+CBB(newbb) to phpBB+LDAP
     Copyright (C) 2009  Alain Reguera Delgado
     
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
     (at your option) any later version.
     
     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
     GNU General Public License for more details.
     
     You should have received a copy of the GNU General Public License
     along with this program; if not, write to the Free Software
     Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
</pre>";

array_push($htmlblock,'<h1>Help</h1>', '<hr />',
            '<h2>About</h2>',
            '<p><strong>newbb to phpbb</strong> do two things mainly:</p>',
            '<ol>',
            '<li>Migrate users from Xoops to LDAP.</li>',
            '<li>Migrate Forums, Topics, and Posts from Xoops\' CBB module (a.k.a newbb) to phpBB3.</li>',
            '</ol>',
            '<p>Documentation works are in the <a href="http://wiki.centos.org/WebsiteVer2/forums/newbb_to_phpbb">project\'s page.</a></p>',
            '<h2>Authors</h2>',
            '<ul>',
            '<li>Alain Reguera Delgado <a href="mailto:alain.reguera@gmail.com">&lt;alain.reguera@gmail.com&gt;</a> (maintainer)</li>',
            '<li>Marcus Moeller &lt; ? &gt;</li>',
            '</ul>',
            '<h2>Lisence</h2>',
            $lisence);
