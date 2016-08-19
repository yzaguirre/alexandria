<?php

return new \Phalcon\Config(array(
    'database' => array(
        'adapter'     => 'Mysql',
        'host'        => 'localhost',
        'port'        => '3306',
        'username'    => 'DB USER',
        'password'    => 'YOUR PASSWORD',
        'dbname'      => 'DB NAME',
    ),
    'application' => array(
        'controllersDir' => __DIR__ . '/../../app/controllers/',
        'modelsDir'      => __DIR__ . '/../../app/models/',
        'viewsDir'       => __DIR__ . '/../../app/views/',
        'pluginsDir'     => __DIR__ . '/../../app/plugins/',
        'libraryDir'     => __DIR__ . '/../../app/library/',
        'cacheDir'       => __DIR__ . '/../../app/cache/',
        'baseUri'        => '/zgas/',
    ),
    'twilio' => array(
        'accountsid' => 'YOUR TWILIO ACCOUNT SID',
        'authtoken'  => 'YOUR TWILIO AUTH TOKEN',
        'fromNumber' => 'PHONE NUMBER CALLS WILL COME FROM',
    )
));
