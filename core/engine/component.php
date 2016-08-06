<?php
/*------------------------------------------------------------------------------
TREVOL
------------------------------------------------------------------------------*/
if (!defined('DIR_CORE')) {
	header('Location: static_pages/');
}
/**
 * @property AConfig $config
 * @property ADB $db
 * @property ACache $cache
 * @property AResource $resource
 * @property AView $view
 * @property ALoader $load
 * @property AHtml $html
 * @property ARequest $request
 * @property AResponse $response
 * @property ASession $session
 * @property ExtensionsApi $extensions
 * @property AExtensionManager $extension_manager
 * @property ALayout $layout
 * @property ACurrency $currency
 * @property ACart $cart
 * @property ATax $tax
 * @property AUser $user
 * @property ALog $log
 * @property AMessage $messages
 * @property ACustomer $customer
 * @property ADocument $document
 * @property ALanguageManager $language
 * @property ADataEncryption $dcrypt
 * @property ComponentCatalogCategory $component_catalog_category
 * @property ADownload $download
 * @property AOrderStatus $order_status
 */
abstract class Component {

	public $registry;

	/**
	 * @param $registry Registry
	 */
	public function __construct($registry) {
		$this->registry = $registry;
	}

	public function __get($key) {
		return $this->registry->get($key);
	}

	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}

	public function __call($method, $args) {
		if (!$this->registry->has('extensions')) {
			return null;
		}
		array_unshift($args, $this);
		$return = call_user_func_array(array( $this->extensions, $method ), $args);
		return $return;
	}
}
