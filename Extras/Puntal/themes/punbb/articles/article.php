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
		<h2 class="articleTitle"><span><?php articles::articleTitle() ?></span></h2>
		<p class="articleDate"><?php tpl::lang('Published on') ?> <?php articles::articleDate() ?></p> 
		<p class="articleVote"><?php articles::articleVoteLabel()?></p>
		<p class="articleVoteImg"> 		
			<?php articles::articleVote('<span class="star1">%s</span> <span class="star2">%s</span> <span class="star3">%s</span> <span class="star4">%s</span> <span class="star5">%s</span>') ; ?>
		</p>
		<div class="box">
			<div class="inbox articleContent">
				<?php articles::articleContent() ?>
			</div>
		</div>
	</div>
	
	<?php # Si les commentaires sont ouverts
	if (articles::articleOpenComments()) : ?>
	<p class="addLinkTop"><a href="<?php tpl::url('forums') ?>post.php?tid=<?php articles::articleTid() ?>"><?php tpl::lang('Write a comment') ?></a></p>
	
	<div class="block">
		<h2><span><a href="#" onclick="openClose('commentsBox',0,''); return false;"><?php articles::articleNumComment() ?></a></span></h2>
		<div class="box" id="commentsBox">
			<div class="inbox">
			
				<?php # si il y a des commentaires alors on boucle sur ceux-ci
				if (articles::hasComments()) : ?>
				
				<?php # boucle sur les commentaires
				while ($comments->fetch()) : ?>
					<div class="comment"><h3 class="comment_infos"><?php tpl::lang('Comment by') ?> <a href="<?php tpl::url('forums') ?>profile.php?id=<?php articles::commentUid() ?>" title="<?php tpl::lang('See profile of') ?> <?php articles::commentAuthor() ?>"><?php articles::commentAuthor() ?></a> - <?php articles::commentDate() ?></h3>
					<?php articles::commentMessage() ?></div>
				<?php endwhile; ?>
				
				<?php # si pas de commentaire
				else : ?>
				<p><?php tpl::lang('No comment') ?></p>
				<?php endif; ?>
			</div>
		</div>
	</div>
	
	<p class="addLinkBottom"><a href="<?php tpl::url('forums') ?>post.php?tid=<?php articles::articleTid() ?>"><?php tpl::lang('Write a comment') ?></a></p>
	
	<?php endif; ?>
