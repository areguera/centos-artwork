<?php
/***********************************************************************

  Copyright (C) 2005-2007 Vincent Garnier and contributors. All rights
  reserved.
  
  This file is part of Puntal 2.

  Puntal 2 is free software; you can redistribute it and/or modify it
  under the terms of the GNU General Public License as published
  by the Free Software Foundation; either version 2 of the License,
  or (at your option) any later version.

  Puntal 2 is distributed in the hope that it will be useful, but
  WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software
  Foundation, Inc., 59 Temple Place, Suite 330, Boston,
  MA  02111-1307  USA

************************************************************************/?>

	<div class="block lexique">
		<h2 class="letter"><span><?php lexique::numWords() ?></span></h2>
		<div class="box">
			<div class="inbox">
			<?php if (!$words->isEmpty()) : ?>
			<dl>
			<?php while ($words->fetch()) : ?>
			<dt class="word"><?php lexique::word() ?></dt>
			<dd class="word_def"><?php lexique::wordDefinition() ?></dd>
			<?php lexique::wordExample('<dd class="word_example">%s</dd>') ?>
			<dd class="word_infos">
				<?php tpl::lang('Added by'); ?> 
				<a href="<?php lexique::url('forums') ?>profile.php?id=<?php lexique::wordUserId() ?>">
				<?php lexique::wordUsername() ?></a>
				<?php lexique::wordEditLink(' | <a href="%s">%s</a>') ?>
				<?php lexique::wordDeleteLink(' | <a href="%s"%s>%s</a>') ?>
				<?php lexique::wordValidLink(' | <a href="%s">%s</a>') ?>
			</dd>
			<?php endwhile; ?>
			</dl>
			<?php else : ?>
			<p><?php tpl::lang('There is no word to validate.') ?></p>
			<?php endif; ?>
			</div>
		</div>
	</div>

