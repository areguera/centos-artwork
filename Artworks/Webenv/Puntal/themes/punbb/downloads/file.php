

	<?php # Message si quelqu'un essai de t�l�charger le fichier depuis
	# un autre site et que "l'anti-leech" est activ�
	if (download::dlAntiLeech()) : ?>
		<div class="block">
			<div class="box">
				<div class="inbox" id="downloadContent">
					<?php tpl::lang('anti_leech') ?>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
				
	<?php # D�tails d'un fichier
	else : ?>
		<div class="block">
			<h2><span><?php download::downloadTitle() ?></span></h2>
			<div class="box">
				<div class="inbox" id="downloadContent">
					<?php # Description
					download::downloadDesc() ?>
					
					<?php # Lien de t�l�chargement
					download::downloadLink(
						'<p class="conr"><a href="%s">%s</a></p>', # le lien "normal"
						'<p class="conr"><strong>%s</strong></p>' # si pas autoris�
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
