<?php

require_once '/srv/gitiki/vendor/autoload.php';

$app = new Gitiki\Gitiki('/srv/wiki/');
$app->run();
