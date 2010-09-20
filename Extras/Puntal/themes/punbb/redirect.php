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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<?php tpl::lang('lang_iso_code') ?>" 
lang="<?php tpl::lang('lang_iso_code') ?>" dir="<?php tpl::lang('lang_direction') ?>">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=<?php tpl::lang('lang_encoding') ?>" />
	<meta http-equiv="refresh" content="<?php echo tpl::pun_config('o_redirect_delay') ?>;URL=<?php tpl::redirect() ?>" />
	<title><?php tpl::headTitlePage() ?></title>
	<link rel="stylesheet" type="text/css" href="<?php tpl::url('forums') ?>style/<?php tpl::user('style') ?>.css" />
	<link rel="stylesheet" type="text/css" href="<?php tpl::url('template') ?>style.css" />
	<?php tpl::headExtra() ?>
	<?php headJsIe() ?>
</head>
<body>

<div id="punwrap">
<div id="punredirect" class="pun">

<div class="block">
	<h2><?php tpl::lang('Redirecting') ?></h2>
	<div class="box">
		<div class="inbox">
			<p><?php tpl::redirectMessage() ?> <?php tpl::lang('Redirecting...') ?>
			<br /><br /><a href="<?php tpl::redirect() ?>"><?php tpl::lang('Click here if you do not want to wait any longer (or if your browser does not automatically forward you)') ?></a></p>
		</div>
	</div>
</div>

</div>
</div>

</body>
</html>
