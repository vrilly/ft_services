<?php

$cfg['blowfish_secret'] = '01234567890123456789012345678901';

$i = 1;

$cfg['Servers'][1]['auth_type'] = 'config';
$cfg['Servers'][1]['host'] = 'mysql';
$cfg['Servers'][1]['user'] = 'wordpress';
$cfg['Servers'][1]['AllowNoPassword'] = true;
$cfg['Servers'][1]['only_db'] = 'wordpress';

