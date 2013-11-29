

	<?php # Message si quelqu'un essai de télécharger le fichier depuis
	# un autre site et que "l'anti-leech" est activé
	if (download::dlAntiLeech()) : ?>
		<div class="block">
			<div class="box">
				<div class="inbox" id="downloadContent">
					<?php tpl::lang('anti_leech') ?>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
				
	<?php # Détails d'un fichier
	else : ?>
		<div class="block">
			<h2><span><?php download::downloadTitle() ?></span></h2>
			<div class="box">
				<div class="inbox" id="downloadContent">
					<?php # Description
					download::downloadDesc() ?>
					
					<?php # Lien de téléchargement
					download::downloadLink(
						'<p class="conr"><a href="%s">%s</a></p>', # le lien "normal"
						'<p class="conr"><strong>%s</strong></p>' # si pas autorisé
					) ?>
					
					<?php # infos ?>
					<p class="conr">
					<?php tpl::lang('Last release') ?> <em><?php download::downloadDate() ?></em>
					- <?php download::downloadSize() ?> - <?php download::downloadCount($s='<strong>%s</strong>') ?>
					</p>
					<div class="clearer"></div>
				</div>
			</div>
		</div>		
	<?php endif; ?>
