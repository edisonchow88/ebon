<?php
/*------------------------------------------------------------------------------
  $Id$

  AbanteCart, Ideal OpenSource Ecommerce Solution
  http://www.AbanteCart.com

  Copyright © 2011-2015 Belavier Commerce LLC

  This source file is subject to Open Software License (OSL 3.0)
  License details is bundled with this package in the file LICENSE.txt.
  It is also available at this URL:
  <http://www.opensource.org/licenses/OSL-3.0>

 UPGRADE NOTE:
   Do not edit or add to this file if you wish to upgrade AbanteCart to newer
   versions in the future. If you wish to customize AbanteCart for your
   needs please refer to http://www.AbanteCart.com for more information.
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}
require_once 'interface_migration.php';

class Migration_Osc implements Migration {

	private $data;
	private $config;
	private $src_db;
	private $error_msg;
	private $language_id_src;

	function __construct($migrate_data, $oc_config) {
		$this->config = $oc_config;
		$this->data = $migrate_data;
		$this->error_msg = "";
		/**
		 * @var ADB
		 */
		if($migrate_data){
			require_once DIR_DATABASE.'mysql.php';
			$this->src_db = new Mysql($this->data['db_host'], $this->data['db_user'], $this->data['db_password'], $this->data['db_name'], true);
		}
	}


    public function getName() {
        return 'OsCommerce';
    }

    public function getVersion() {
        return '2.2RC2';
    }

	private function getSourceLanguageId(){
		if(!$this->language_id_src){
			$result = $this->src_db->query("SELECT languages_id as language_id
											FROM " . $this->data['db_prefix'] . "languages
											WHERE `code` = (SELECT `configuration_value`
															FROM " . $this->data['db_prefix'] . "configuration
															WHERE `configuration_key`='DEFAULT_LANGUAGE');");
			$this->language_id_src = $result->row['language_id'];
		}
		return $this->language_id_src;
	}

	public function getCategories() {
		$this->error_msg = "";

		// for now use default language
		$languages_id = $this->getSourceLanguageId();

		$categories_query = "SELECT	c.categories_id as category_id,
									cd.categories_name as name,
									'' as description,
									c.categories_image as image,
									c.parent_id,
									c.sort_order
								FROM " . $this->data[ 'db_prefix' ] . "categories c, " . $this->data[ 'db_prefix' ] . "categories_description cd
								WHERE c.categories_id = cd.categories_id and cd.language_id = '" . (int)$languages_id . "'
								ORDER BY c.sort_order, cd.categories_name";
		$categories = $this->src_db->query( $categories_query, true);
		if (!$categories) {
			$this->error_msg = 'Migration Error: ' . $this->src_db->error. '<br>';
			return false;
		}

		$result = array();
		foreach($categories->rows as $item){
			$result[ $item[ 'category_id' ] ] = $item;
			$item['image'] = trim($item['image']);
			$result[$item['category_id']]['image'] = array();
			if($item['image']){
				$img_uri = $this->data['cart_url'];
				if(substr($img_uri,-1)!='/'){
					$img_uri .= '/';
				}
				$img_uri .= 'images/';
				$result[$item['category_id']]['image']['db'] = str_replace(' ', '%20', $img_uri. $item['image']);
			}
		}

		return $result;
	}

	public function getManufacturers() {
		$this->error_msg = "";

		$sql_query = "SELECT manufacturers_id as manufacturer_id, manufacturers_name as name, manufacturers_image as image
                      FROM " . $this->data[ 'db_prefix' ] . "manufacturers
                      ORDER BY manufacturers_name";
		$items = $this->src_db->query( $sql_query, true);
		if (!$items) {
			$this->error_msg = 'Migration Error: ' . $this->src_db->error. '<br>';
			return false;
		}

		$result = array();
		foreach($items->rows as $item){
			$result[ $item[ 'manufacturer_id' ] ] = $item;
			$item['image'] = trim($item['image']);
			$result[$item['manufacturer_id']]['image'] = array();
			if($item['image']){
				$img_uri = $this->data['cart_url'];
				if(substr($img_uri,-1)!='/'){
					$img_uri .= '/';
				}
				$img_uri .= 'images/';
				$result[$item['manufacturer_id']]['image']['db'] = str_replace(' ', '%20', $img_uri. $item['image']);
			}
		}
		return $result;
	}

	public function getProducts() {
		$this->error_msg = "";
		// for now use default language
		$languages_id = $this->getSourceLanguageId();

		$products_query = "SELECT   p.products_id as product_id,
									p.products_model as model,
									p.products_quantity as quantity,
									'7' as stock_status_id,
									p.products_image as image,
									p.manufacturers_id as manufacturer_id,
									'1' as shipping,
									p.products_price as price,
									pd.products_name as name,
									pd.products_description as description,
									'9' as tax_class_id,
									p.products_date_available as date_available,
									p.products_weight as weight,
									'5' as weight_class_id,
									p.products_status as status,
									p.products_date_added as date_added
							FROM
								" . $this->data[ 'db_prefix' ] . "products p,
								" . $this->data[ 'db_prefix' ] . "products_description pd
							WHERE
								pd.products_id = p.products_id
								AND pd.language_id = '" . (int)$languages_id . "'";
		$items = $this->src_db->query( $products_query, true);
		if (!$items) {
			$this->error_msg = 'Migration Error: ' . $this->src_db->error. '<br>';
			return false;
		}

		$result = array();
		foreach($items->rows as $item){
			$result[ $item[ 'product_id' ] ] = $item;
			$item['image'] = trim($item['image']);
			$result[$item['product_id']]['image'] = array();
			if($item['image']){
				$img_uri = $this->data['cart_url'];
				if(substr($img_uri,-1)!='/'){
					$img_uri .= '/';
				}
				$img_uri .= 'images/';
				$result[$item['product_id']]['image']['db'] = str_replace(' ', '%20', $img_uri.$item['image']);
			}
		}

		//add categories id
		$sql_query = "SELECT categories_id as category_id, products_id as product_id
                      FROM " . $this->data[ 'db_prefix' ] . "products_to_categories";
		$items = $this->src_db->query( $sql_query, true);
		if (!$items) {
			$this->error_msg = 'Migration Error: ' . $this->src_db->error. '<br>';
			return false;
		}
		foreach($items->rows as $item){
			if (!empty($result[ $item[ 'product_id' ] ]))
				$result[ $item[ 'product_id' ] ][ 'product_category' ][ ] = $item[ 'category_id' ];
		}

		return $result;
	}

	public function getCustomers() {
		$this->error_msg = "";
		$customers_query = "SELECT  c.customers_id as customer_id,
									c.customers_firstname as firstname,
									c.customers_lastname lastname,
									c.customers_email_address as email,
									c.customers_telephone as telephone,
									c.customers_fax as fax,
									c.customers_password as password,
									c.customers_newsletter as newsletter
							FROM " . $this->data[ 'db_prefix' ] . "customers c ";

		$customers = $this->src_db->query( $customers_query, true);
		if (!$customers) {
			$this->error_msg = 'Migration Error: ' . $this->src_db->error. '<br>';
			return false;
		}

		$result = array();
		foreach($customers->rows as $customer){
			$result[ $customer[ 'customer_id' ] ] = $customer;
		}

		// add customers addresses
		$address_query = "SELECT a.customers_id as customer_id,
								a.entry_company as company,
								a.entry_firstname as firstname,
								a.entry_lastname as lastname,
								a.entry_street_address as address_1,
								a.entry_postcode as postcode,
								a.entry_city as city,
								a.entry_zone_id as zone_id,
								a.entry_country_id as country_id
						  FROM " . $this->data[ 'db_prefix' ] . "address_book a ";
		$addresses = $this->src_db->query( $address_query, true);
		if (!$addresses) {
			$this->error_msg = 'Migration Error: ' . $this->src_db->error. '<br>';
			return false;
		}

		foreach($addresses->row as $address){
			$result[ $address[ 'customer_id' ] ][ 'address' ][ ] = $address;
		}

		return $result;
	}

	public function getOrders() {
		return array();
	}


	public function getProductOptions() {
		$this->error_msg = "";
		$language_id = $this->getSourceLanguageId();
		//options
		$sql = "SELECT DISTINCT pa.products_id as product_id,
								pa.options_id as product_option_id,
								`products_options_name` as product_option_name,
								0 as subtract,
								'S' as element_type,
								0 as products_text_attributes_id,
								0 as sort_order
				FROM " . $this->data['db_prefix'] . "products_options po
				RIGHT JOIN " . $this->data['db_prefix'] . "products_attributes pa	ON pa.options_id = po.products_options_id
				WHERE po.language_id='".$language_id."'
				ORDER BY product_id, product_option_id";

		$items = $this->src_db->query($sql,true);
		if (!$items) {
			$this->error_msg = 'Migration Error: ' . $this->src_db->error. '<br>';
			return false;
		}

		$result = array();
		foreach($items->rows as $item){
			$result['product_options'][] = $item;
		}

		//option values
		$sql = "SELECT DISTINCT pa.price_prefix,
						pa.options_values_price as price,
						pa.products_id as product_id,
						povpo.products_options_id as product_option_id,
						povpo.products_options_values_id as product_option_value_id,
						pov.products_options_values_name as product_option_value_name,
						0 as products_text_attributes_id
				FROM " . $this->data['db_prefix'] . "products_options_values_to_products_options povpo
				LEFT JOIN " . $this->data['db_prefix'] . "products_options_values pov
						ON pov.products_options_values_id = povpo.products_options_values_id AND pov.language_id='".$language_id."'
				RIGHT JOIN " . $this->data['db_prefix'] . "products_attributes pa
						ON pa.options_values_id = povpo.products_options_values_id AND pa.options_id = povpo.products_options_id
		WHERE pa.products_id>0 AND povpo.products_options_id<>''
		ORDER BY product_option_id, product_option_value_name, product_id";
		$items = $this->src_db->query($sql,true);
		if (!$items) {
			$this->error_msg = 'Migration Error: ' . $this->src_db->error. '<br>';
			return false;
		}

		foreach($items->rows as $item){
			$result['product_option_values'][] = $item;
		}

		//products option values
		$sql = "SELECT *, options_values_price as price
				FROM " . $this->data['db_prefix'] . "products_attributes";
		$items = $this->src_db->query($sql,true);
		if (!$items) {
			$this->error_msg = 'Migration Error: ' . $this->src_db->error. '<br>';
			return false;
		}

		foreach($items->rows as $item){
			$result['product_attributes'][] = $item;
		}

		return $result;
	}



	public function getErrors() {
		return $this->error_msg;
	}

	public function getCounts() {
		$products = $this->src_db->query("SELECT COUNT(*) as cnt FROM ".$this->data['db_prefix']."products", true);
		$categories = $this->src_db->query("SELECT COUNT(*) as cnt FROM ".$this->data['db_prefix']."categories", true);
		$manufacturers = $this->src_db->query("SELECT COUNT(*) as cnt FROM ".$this->data['db_prefix']."manufacturers", true);
		$customers = $this->src_db->query("SELECT COUNT(*) as cnt FROM ".$this->data['db_prefix']."customers", true);

		return array(
			'products' => (int)$products->row['cnt'],
			'categories' => (int)$categories->row['cnt'],
			'manufacturers' => (int)$manufacturers->row['cnt'],
			'customers' => (int)$customers->row['cnt']
		);
	}
}