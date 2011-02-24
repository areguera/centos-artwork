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

/**
@function startBloc

Affiche le HTML du début d'un bloc.

@param	string	title		Le titre du bloc ('')
@param	string	id			L'identifiant du bloc ('')
*/
function startBloc($title='',$id='')
{
	// un compteur si jamais il y a pas d'identifiant de spécifié	
	static $i;
	
	$id = $id != '' ? $id : $i;
	
	$res = '';
	$res .= "\t".'<div class="block" id="'.$id.'">'."\n";
	
	if ($title!='')
		$res .= "\t".'<h2><span>'.$title.'</span></h2>'."\n";
	
	$res .= 
	"\t\t".'<div class="box" id="box_'.$id.'">'."\n".
	"\t\t\t".'<div class="inbox">'."\n";
	
	echo $res;
	$i++;
}


/**
@function endBloc

Affiche le HTML de la fin d'un bloc.
*/
function endBloc()
{
	echo 
	"\t\t\t".'</div>'."\n".
	"\t\t".'</div>'."\n".
	"\t".'</div>';
}


/**
@function headJsIe

Affiche le javascript pour IE.
*/
function headJsIe()
{
	$user_agent = isset($_SERVER['HTTP_USER_AGENT']) ? strtolower($_SERVER['HTTP_USER_AGENT']) : '';
	if (strpos($user_agent, 'msie') !== false && strpos($user_agent, 'windows') !== false && strpos($user_agent, 'opera') === false)
		echo '<script type="text/javascript" src="'.pt_forum_url.'style/imports/minmax.js"></script>';
}

/**
@function startBlocStatic

Affiche le HTML du début d'un bloc.

@param	string	title		Le titre du bloc ('')
@param	string	id			L'identifiant du bloc ('')
*/
function startBlocStatic($title='',$id='')
{
	// un compteur si jamais il y a pas d'identifiant de spécifié	
	static $i;
	
	$id = $id != '' ? $id : $i;
	
	$res = '';
	$res .= "\t".'<div class="block" id="'.$id.'">'."\n";
	
	if ($title!='')
		$res .= "\t".'<h2><span>'.$title.'</span></h2>'."\n";
	
	$res .= 
	"\t\t".'<div class="box" id="box_'.$id.'">'."\n".
	"\t\t\t".'<div class="inbox">'."\n";
	
	return $res;
	$i++;
}
/**
@function endBlocStatic

Affiche le HTML de la fin d'un bloc.
*/
function endBlocStatic()
{
	return
	"\t\t\t".'</div>'."\n".
	"\t\t".'</div>'."\n".
	"\t".'</div>';
}

?>