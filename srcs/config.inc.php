<?php

/**config phpmyadmin */
/**config mdp (pour l'https?) */

$cfg['blowfish_secret'] = 'aR74hxF9';

/* config des différents serveurs */

$i = 0;

/* premier server*/

$i++;

/* authentification */

$cfg['Servers'][$i]['auth_type'] = 'cookie';

/* params du serveur */

$cfg['Servers'][$i]['host'] = 'localhost';
$cfg['Servers'][$i]['compress'] = false;
$cfg['Servers'][$i]['AllowNoPassword'] = true;

/**
 * phpMyAdmin configuration storage settings.
 */

/* User used to manipulate with storage */

/* $cfg['Servers'][$i]['controluser'] = 'root';
$cfg['Servers'][$i]['controlpass'] = ''; */

/**
 * Directories for saving/loading files from server
 */
$cfg['UploadDir'] = '';
$cfg['SaveDir'] = '';

/**
 * Whether or not to query the user before sending the error report to
 * the phpMyAdmin team when a JavaScript error occurs
 *
 * Available options
 * ('ask' | 'always' | 'never')
 * default = 'ask'
 */
//$cfg['SendErrorReports'] = 'always';

