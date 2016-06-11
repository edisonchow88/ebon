<?php
/**
	AbanteCart, Ideal OpenSource Ecommerce Solution
	http://www.AbanteCart.com
	Copyright © 2011-'.date('Y').' Belavier Commerce LLC

	Released under the Open Software License (OSL 3.0)
*/
// Admin Section Configuration. You can change this value to any name. Will use ?s=name to access the admin
define('ADMIN_PATH', 'panel');

// ADDED by TREVOL, 2016/01/23
define('TREVOL_PATH', 'TREVOL');

// Database Configuration
define('DB_DRIVER', 'amysqli');
define('DB_HOSTNAME', 'localhost');
define('DB_USERNAME', 'root');
define('DB_PASSWORD', 'idyppi30');
define('DB_DATABASE', 'TREVOL');
define('DB_PREFIX', 'tr_');
// Unique AbanteCart store ID
define('UNIQUE_ID', 'afc1aec5d12298433435cb8874e94a5b');
// Salt key for oneway encryption of passwords. NOTE: Change of SALT key will cause a loss of all existing users' and customers' passwords!
define('SALT', 'Hd9u');
// Encryption key for protecting sensitive information. NOTE: Change of this key will cause a loss of all existing encrypted information!
define('ENCRYPTION_KEY', 'wl1YjP');
