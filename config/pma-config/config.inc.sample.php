<?php
// 이미 기본 $cfg 는 phpMyAdmin에서 잡아줌

/* 서버 1: 로컬 Docker MySQL (db 컨테이너) */
$i = 1;
$cfg['Servers'][$i]['host'] = 'db';     // docker-compose의 db 서비스 이름
$cfg['Servers'][$i]['verbose'] = 'Local_DB';
$cfg['Servers'][$i]['auth_type'] = 'cookie';
$cfg['Servers'][$i]['compress'] = false; 
$cfg['Servers'][$i]['AllowNoPassword'] = false; 