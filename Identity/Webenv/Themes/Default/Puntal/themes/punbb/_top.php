<div id="brdheader" class="block">
	<div class="box">
		<div id="brdtitle" class="inbox">
			<img id="logo" src="http://localhost/puntal/themes/punbb/img/logo-forums.png" alt="<?php tpl::title() ?>">
			<h1><span><?php tpl::title() ?></span></h1>
			<?php tpl::desc('<p><span>%s</span></p>') ?>
			<p id="prelude"><a href="#puntal_main"><?php tpl::lang('Go to content') ?></a> | 
			<a href="#puntal_sidebar"><?php tpl::lang('Go to menu') ?></a></p>
		</div>
		<div class="pageline"></div>
		<div class="brdmenu" class="inbox">
			<?php tpl::navLinks() ?>
		</div>
		<?php if (tpl::user('is_guest',true)) : # Si l'utilisateur est un invité ?>
		<div id="brdwelcome" class="inbox">
			<p><?php tpl::lang('You are not logged in') ?></p>
		</div>
		<?php else : # Sinon l'utilisateur est connecté ?>
		<div id="brdwelcome" class="inbox">
			<ul class="conl">
				<li><?php tpl::lang('Logged in as') ?> <strong><?php echo tpl::user('username') ?></strong></li>
				<li><?php tpl::lang('Last visit') ?> : <?php echo tpl::user('last_visit') ?></li>
				<?php if (tpl::user('g_id',true) < PUN_GUEST) : # Si l'utilisateur est un admin ou modo ?>
					<?php tpl::reportsLink(
							'<li class="reportlink"><strong>%s</strong></li>',
							'Il y a de nouveaux signalements') ?>
					<?php tpl::maintenanceLink(
							'<li class="maintenancelink"><strong>%s</strong></li>',
							'Le mode maintenance est activé&#160;!') ?>				
				<?php endif; ?>
			</ul>
			<ul class="conr">
				<li><a href="<?php tpl::url('forums') ?>search.php?action=show_new"><?php tpl::lang('Show new posts') ?></a></li>
				<li><a href="<?php tpl::url('forums') ?>misc.php?action=markread"><?php tpl::lang('Mark all as read') ?></a></li>
			</ul>
			<div class="clearer"></div>
		</div>
		<?php endif; ?>
	</div>
</div>

<?php if (tpl::annoucement()) : ?>
<div id="announce" class="block">
	<h2><span><?php tpl::lang('Announcement') ?></span></h2>
	<div class="box">
		<div class="inbox">
			<div><?php tpl::annoucementMessage() ?></div>
		</div>
	</div>
</div>
<?php endif; ?>
