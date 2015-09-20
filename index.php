<?php

require_once '/srv/gitiki/vendor/autoload.php';

$app = new Gitiki\Gitiki('/src/wiki/');
$app->run();
