<?php
/*------------------------------------------------------------------------------
TREVOL
------------------------------------------------------------------------------*/

// Required PHP Version
define('MIN_PHP_VERSION', '5.3.0');
if (version_compare(phpversion(), MIN_PHP_VERSION, '<') == TRUE) {
    die( MIN_PHP_VERSION . '+ Required for Trevol to work properly! Please contact your system administrator or host service provider.');
}

// Load Configuration
// Real path (operating system web root) to the directory where trevol is installed
$root_path = dirname(__FILE__);

// Windows IIS Compatibility  
if (stristr(PHP_OS, 'WIN')) {
	define('IS_WINDOWS', true);
	$root_path = str_replace('\\', '/', $root_path);
}

define('DIR_ROOT', $root_path);
define('DIR_CORE', DIR_ROOT . '/core/');

require_once(DIR_ROOT . '/system/config.php');
   
// New Installation
if (!defined('DB_DATABASE')) {
	header('Location: install/index.php');
	exit;
}

// Load all initial set up
require_once(DIR_ROOT . '/core/init.php');

ADebug::checkpoint('init end');

if (!defined('IS_ADMIN') || !IS_ADMIN ) { // storefront load

	// Relative paths and directories
	define('RDIR_TEMPLATE',  'storefront/view/' . $config->get('config_storefront_template') . '/');

	// Customer
	//[DISABLED BY TREVOL]$registry->set('customer', new ACustomer($registry));
	
	// Tax
	//[DISABLED BY TREVOL]$registry->set('tax', new ATax($registry));

	// Weight
	//[DISABLED BY TREVOL]$registry->set('weight', new AWeight($registry));

	// Length
	//[DISABLED BY TREVOL]$registry->set('length', new ALength($registry));

	// Cart
	//[DISABLED BY TREVOL]$registry->set('cart', new ACart($registry));

} else {// Admin load

	// Relative paths and directories
	define('RDIR_TEMPLATE',  'admin/view/default/');
	
	// User
	$registry->set('user', new AUser($registry));
					
}// end admin load

// Currency
$registry->set('currency', new ACurrency($registry));


//Route to request process
$router = new ARouter($registry);
$registry->set('router', $router);
$router->processRoute(ROUTE);

// Output
$registry->get('response')->output();


ADebug::checkpoint('app end');

//display debug info
if ( $router->getRequestType() == 'page' ) {
    ADebug::display();
}
