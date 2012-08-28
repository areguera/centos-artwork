
<div id="brdfooter" class="block">
<div class="brdmenu" class="inbox">
	<?php tpl::navLinks() ?>
</div>
<div class="pageline"></div>
	<h2><span><?php tpl::lang('Page footer') ?></span></h2>
	<div class="box">
	<div class="inbox credits">
	      <p class="conr"><?php echo __('Powered by'); ?> <a href="http://www.puntal.fr/">Puntal 2</a> <?php tpl::callBehavior('publicBottomPageHTMLPoweredBy')?></p>      
	      <?php tpl::callBehavior('publicBottomPageHTML') ?>
	      <?php tpl::debugTime('<p class="conr">[ %s - %s ]</p>') ?>
	      <div class="clearer"></div>
		</div>
	</div>
</div>


<?php # affiche la liste des requêtes, ne fonctionne bien qu'avec PHP5
tpl::debugQueries('<p>%s</p>') ?>
