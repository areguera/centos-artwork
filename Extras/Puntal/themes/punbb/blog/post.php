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

************************************************************************/

/*
	Original file by Olivier Meunier and contributors from 
	DotClear project. http://www.dotclear.net/
*/
?>

<div class="block">
	<h2 class="post-title"><span><?php blog::dcPostTitle(); ?></span></h2>
	<div class="box">
		<div class="inbox">
			<p class="post-info"><?php tpl::lang('By') ?> <?php blog::dcPostAuthor(); ?>,
			<?php blog::dcPostDate(); ?> <?php blog::dcPostTime(); ?>
			<span>::</span> <a href="<?php blog::dcPostCatURL(); ?>"><?php blog::dcPostCatTitle(); ?></a>
			<span>::</span> <a href="<?php blog::dcPostURL(); ?>"
			title="<?php tpl::lang('Permalink to:') ?> <?php blog::dcPostTitle(); ?>">#<?php blog::dcPostID(); ?></a>
			<span>::</span> <a href="<?php blog::dcPostRss() ?>"
			title="fil RSS des commentaires de : <?php blog::dcPostTitle(); ?>">rss</a></p>
			
			<?php blog::dcPostChapo('<div class="post-chapo">%s</div>'); ?>
			<div class="post-content"><?php blog::dcPostContent(); ?></div>	
		</div>
	</div>
</div>	

<div class="block">
	<div class="box">
		<div class="inbox" id="trackbacks">
			<h3 id="tb"><?php tpl::lang('Trackbacks') ?></h3>
			<?php if ($trackbacks->isEmpty()) : /* Message si aucune trackback */?>
				<p><?php tpl::lang('No trackback') ?></p>
			<?php endif; ?>
			
			<?php while ($trackbacks->fetch()) : /* Liste des trackbacks */
				// On met le numéro du trackback dans une variable
				$tb_num = $trackbacks->int_index+1;
			?>
				<p id="c<?php blog::dcTBID(); ?>" class="comment-info">
				<span class="comment-number"><a href="#c<?php blog::dcTBID(); ?>"><?php echo $tb_num; ?>.</a></span>
				<?php tpl::lang('On') ?> <?php blog::dcTBDate(); ?> <?php blog::dcTBTime(); ?>, 
				<?php tpl::lang('by') ?> <strong><?php blog::dcTBAuthor(); ?></strong></p>
				
				<?php /* on affiche le trackback */ ?>
				<blockquote>
				<?php blog::dcTBContent(); ?>
				</blockquote>
			<?php endwhile; ?>
			
			<?php /*Le lien pour ajouter un trackback si ceux-ci sont autorisés*/ ?>
			<?php if (blog::dcPostOpenTrackbacks() && pt_mod_blog_allow_trackbacks) : ?>
				<p><?php tpl::lang('To make a trackback for this entry:') ?>
				<?php blog::dcPostTrackBackURI() ?></p>
			<?php else: ?>
				<p><?php tpl::lang('Trackback for this entry are closed.') ?></p>
			<?php endif; ?>
		</div>
	</div>
</div>	

<div class="block">
	<div class="box">
		<div class="inbox" id="comments">
			<h3 id="co"><?php tpl::lang('Comments') ?></h3>
			<?php if ($comments->isEmpty()) : /* Message si aucune commentaire */	?>
				<p><?php tpl::lang('No comment') ?></p>
			<?php endif; ?>
			
			<?php while ($comments->fetch()) : /* Boucle de commentaires */
				// On met le numéro du commentaire dans une variable
				$co_num = $comments->int_index+1;
			?>
				<p id="c<?php blog::dcCommentID(); ?>" class="comment-info">
				<span class="comment-number"><a href="#c<?php blog::dcCommentID(); ?>"><?php echo $co_num; ?>.</a></span>
				<?php tpl::lang('On') ?> <?php blog::dcCommentDate(); ?> <?php blog::dcCommentTime(); ?>,
				<?php tpl::lang('by') ?> <strong><?php blog::dcCommentAuthor(); ?></strong></p>
				
				<?php /* on affiche le commentaire */ ?>
				<blockquote>
				<?php blog::dcCommentContent(); ?>
				</blockquote>
			<?php endwhile; ?>

			<h3><?php tpl::lang('Write a comment') ?></h3>
			<?php if (blog::dcPostOpenComments() && pt_mod_blog_allow_comments) : /* Si les commentaires sont permis */?>
				<?php if (pt_mod_blog_allow_comments) : /* Si les commentaires sont permis */?>
					<?php include dirname(__FILE__).'/form.php'; ?>
				<?php endif; ?>
			<?php else : ?>
				<p><?php tpl::lang('Comments for this entry are closed.') ?></p>
			<?php endif; ?>
		</div>
	</div>
</div>

