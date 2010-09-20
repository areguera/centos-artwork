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

<div class="block">
	<h2 id="bugTitle"><span><?php bugtracker::bugSeverity() ?></span> <?php bugtracker::bugTitle() ?></span></h2>
	<div class="box">
		<div class="inbox">
			<?php bugtracker::bugDesc() ?>
			<p class="conl"><?php tpl::lang('Bug reported by') ?> <a href="<?php tpl::url('forums') ?>profile.php?id=<?php bugtracker::bugReporterId() ?>"><?php bugtracker::bugReporter() ?></a> <?php tpl::lang('on version') ?> <em><?php bugtracker::bugVersion() ?></em></p>
			<p class="conr"><?php bugtracker::bugStatus() ?> / <?php bugtracker::bugPerCent() ?>%</p>
			<div class="av_bar_ext conr"><div class="av_bar_int" style="width:<?php bugtracker::bugPerCent() ?>px;"><!-- --></div></div>
			<div class="clearer"></div>
		</div>
	</div>
</div>

<?php # Si les commentaires sont ouverts
if (bugtracker::openComments()) : ?>
<p class="addLinkTop"><a href="<?php tpl::url('forums') ?>post.php?tid=<?php bugtracker::bugTid() ?>"><?php tpl::lang('Write a comment') ?></a></p>

<div class="block">
	<h2><span><a href="#" onclick="openClose('commentsBox',0,''); return false;"><?php bugtracker::numComment() ?></a></span></h2>
	<div class="box" id="commentsBox">
		<div class="inbox">
			<?php # si il y a des commentaires alors on boucle sur ceux-ci
			if (bugtracker::hasComments()) : ?>
			<?php # boucle sur les commentaires
			while ($comments->fetch()) : ?>
				<div class="comment"><h3 class="comment_infos"><?php tpl::lang('Comment by') ?> <a href="<?php tpl::url('forums') ?>profile.php?id=<?php bugtracker::commentUid() ?>" title="<?php tpl::lang('See comments of') ?> <?php bugtracker::commentAuthor() ?>"><?php bugtracker::commentAuthor() ?></a> - <?php bugtracker::commentDate() ?></h3>
				<?php bugtracker::commentMessage() ?></div>
			<?php endwhile; ?>
			<?php # si pas de commentaire
			else : ?>
			<p><?php tpl::lang('No comment') ?></p>
			<?php endif; ?>
		</div>
	</div>
</div>

<p class="addLinkBottom"><a href="<?php tpl::url('forums') ?>post.php?tid=<?php bugtracker::bugTid() ?>"><?php tpl::lang('Write a comment') ?></a></p>

<?php endif; ?>
