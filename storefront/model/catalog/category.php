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
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
/** @noinspection PhpUndefinedClassInspection */
/**
 * Class ModelCatalogCategory
 * @property ModelCatalogProduct $model_catalog_product
 */
class ModelCatalogCategory extends Model {
	/**
	 * @param int $category_id
	 * @return array
	 */
	public function getCategory($category_id) {
		$language_id = (int)$this->config->get('storefront_language_id');
		$query = $this->db->query("SELECT DISTINCT *,
										(SELECT COUNT(p2c.product_id) as cnt
										 FROM ".$this->db->table('products_to_categories')." p2c
										 INNER JOIN " . $this->db->table('products')." p ON p.product_id = p2c.product_id
										 WHERE p.status = '1' AND p2c.category_id = c.category_id) as products_count
									FROM " . $this->db->table("categories") . " c
									LEFT JOIN " . $this->db->table("category_descriptions") . " cd ON (c.category_id = cd.category_id AND cd.language_id = '" . $language_id . "')
									LEFT JOIN " . $this->db->table("categories_to_stores") . " c2s ON (c.category_id = c2s.category_id)
									WHERE c.category_id = '" . (int)$category_id . "'
										AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
										AND c.status = '1'");
		
		return $query->row;
	}

	/**
	 * @param int $parent_id
	 * @param int $limit
	 * @return array
	 */
	public function getCategories($parent_id = 0, $limit=0) {
		$language_id = (int)$this->config->get('storefront_language_id');
		$cache_name = 'category.list.'. $parent_id.'.'.$limit;
		$cache = $this->cache->get($cache_name, $language_id, (int)$this->config->get('config_store_id'));
		if(is_null($cache)){
			$query = $this->db->query("SELECT *
										FROM " . $this->db->table("categories") . " c
										LEFT JOIN " . $this->db->table("category_descriptions") . " cd ON (c.category_id = cd.category_id AND cd.language_id = '" . $language_id . "')
										LEFT JOIN " . $this->db->table("categories_to_stores") . " c2s ON (c.category_id = c2s.category_id)
										WHERE ".($parent_id<0 ? "" : "c.parent_id = '" . (int)$parent_id . "' AND ")."
										     c2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND c.status = '1'
										ORDER BY c.sort_order, LCASE(cd.name)
										".((int)$limit ? "LIMIT ".(int)$limit : '')."										");
			$cache =  $query->rows;
			$this->cache->set($cache_name, $cache, $language_id, (int)$this->config->get('config_store_id'));
		}
		return $cache;
	}


	/**
	 * @param array $data
	 * @param string $mode
	 * @return array|int
	 */
	public function getCategoriesData($data, $mode = 'default') {

		if ( $data['language_id'] ) {
			$language_id = (int)$data['language_id'];
		} else {
			$language_id = (int)$this->config->get('storefront_language_id');
		}

		if ( $data['store_id'] ) {
			$store_id = (int)$data['store_id'];
		} else {
			$store_id = (int)$this->config->get('config_store_id');
		}


		if ($mode == 'total_only') {
			$total_sql = 'count(*) as total';
		}
		else {
			$total_sql = "*,
						  c.category_id,
						  (SELECT count(*) as cnt
						  	FROM ".$this->db->table('products_to_categories')." p2c
						  	INNER JOIN " . $this->db->table('products')." p ON p.product_id = p2c.product_id
						  	WHERE p2c.category_id = c.category_id AND p.status = '1') as products_count ";
		}
        $where = (isset($data['parent_id']) ? " c.parent_id = '" . (int)$data['parent_id'] . "'" : '' );
		//filter result by givem ids array
		if( $data['filter_ids'] ){
			$ids = array();
			foreach( $data['filter_ids']  as $id){
				$id = (int)$id;
				if($id){
					$ids[] = $id;
				}
			}
			$where = " c.category_id IN (".implode(', ',$ids).")";
		}

		$where = $where ? 'WHERE '.$where : '';

		$sql = "SELECT ". $total_sql ."
				FROM " . $this->db->table('categories')." c
				LEFT JOIN " . $this->db->table('category_descriptions')." cd
					ON (c.category_id = cd.category_id AND cd.language_id = '" . $language_id . "')
				INNER JOIN " . $this->db->table('categories_to_stores')." cs
					ON (c.category_id = cs.category_id AND cs.store_id = '" . $store_id . "')
				" . $where;

		if ( !empty($data['subsql_filter']) ) {
			$sql .= ($where ? " AND " : 'WHERE ').$data['subsql_filter'];
		}

		//If for total, we done bulding the query
		if ($mode == 'total_only') {
		    $query = $this->db->query($sql);
		    return $query->row['total'];
		}

		$sort_data = array(
		    'name' => 'cd.name',
		    'status' => 'c.status',
		    'sort_order' => 'c.sort_order'
		);

		if (isset($data['sort']) && in_array($data['sort'], array_keys($sort_data)) ) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY c.sort_order, cd.name ";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);
		$category_data = array();
		foreach ($query->rows as $result) {
			$category_data[] = array(
				'category_id' => $result['category_id'],
				'name'    => $result['name'],
				'status'  	  => $result['status'],
				'sort_order'  => $result['sort_order'],
				'products_count'=>$result['products_count']

			);
		}
		return $category_data;
	}

	/**
	 * @return array
	 */
	public function getAllCategories(){
		return $this->getCategories(-1);
	}

	/**
	 * @param int $parent_id
	 * @return int
	 */
	public function getTotalCategoriesByCategoryId($parent_id = 0) {
		$query = $this->db->query("SELECT COUNT(*) AS total
									FROM " . $this->db->table("categories") . " c
									LEFT JOIN " . $this->db->table("categories_to_stores") . " c2s ON (c.category_id = c2s.category_id)
									WHERE c.parent_id = '" . (int)$parent_id . "'
										AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
										AND c.status = '1'");
		
		return $query->row['total'];
	}


	/**
	 * @deprecated since 1.1.7
	 * @param int $parent_id
	 * @param string $path
	 * @return array
	 */
	public function getCategoriesDetails($parent_id = 0, $path = '') {
		$language_id = (int)$this->config->get('storefront_language_id');
		$store_id = (int)$this->config->get('config_store_id');
		$this->load->model('catalog/product');
		$this->load->model('catalog/manufacturer');
		$resource = new AResource('image');
		$cash_name = 'category.details.'.$parent_id;
		$categories = $this->cache->get( $cash_name, $language_id, $store_id );
		if ( count($categories) ) {
			return $categories;
		}
		
		$results = $this->getCategories($parent_id);
		
		foreach ($results as $result) {
			if (!$path) {
			        $new_path = $result['category_id'];
			} else {
			        $new_path = $path . '_' . $result['category_id'];
			}
			
			$brands = array();
			
			if($parent_id == 0) {

			    $data['filter'] = array();
			    $data['filter']['category_id'] = $result['category_id'];
			    $data['filter']['status'] = 1;
			    
			    $prods = $this->model_catalog_product->getProducts($data);
			    
			    foreach( $prods as $prod ) {
			        if( $prod['manufacturer_id'] ) {
			                $brand = $this->model_catalog_manufacturer->getManufacturer($prod['manufacturer_id']);
			        
			                $brands[$prod['manufacturer_id']] = array(
			                        'name' => $brand['name'],
			                        'href' => $this->html->getSEOURL('product/manufacturer', '&manufacturer_id=' .$brand['manufacturer_id'], '&encode')
			                );
			        }
			    }
			}

			$thumbnail = $resource->getMainThumb('categories',
			                                     $result['category_id'],
			                                     $this->config->get('config_image_category_width'),
			                                     $this->config->get('config_image_category_height'),true);
			
			$categories[] = array(
			        'category_id' => $result['category_id'],
			        'name' => $result['name'],
			        'children' => $this->getCategoriesDetails($result['category_id'], $new_path),
			        'href' => $this->html->getSEOURL('product/category', '&path=' . $new_path, '&encode'),
			        'brands' => $brands,
			        'product_count' => count($prods),
			        'thumb' => $thumbnail['thumb_url'],
			);
		}
		$this->cache->set( $cash_name, $categories, $language_id, $store_id );
		return $categories;
	}

	/**
	 * @param array $categories
	 * @return int
	 */
	public function getCategoriesProductsCount($categories=array()){
		$categories = (array)$categories;
		foreach($categories as &$val){
			$val = (int)$val;
		} unset($val);
		$categories = array_unique($categories);

		$query = $this->db->query("SELECT COUNT(DISTINCT p2c.product_id) AS total
									FROM " . $this->db->table("products_to_categories") . " p2c
									INNER JOIN " . $this->db->table('products')." p ON p.product_id = p2c.product_id
									WHERE p.status = '1' AND p2c.category_id IN (".implode(', ',$categories).");");

		return (int)$query->row['total'];
	}


	/**
	 * @param array $categories
	 * @return array
	 */
	public function getCategoriesBrands($categories=array()){
		$categories = (array)$categories;
		foreach($categories as &$val){
			$val = (int)$val;
		} unset($val);
		$categories = array_unique($categories);

		$sql = "SELECT DISTINCT p.manufacturer_id, m.name
				FROM ".$this->db->table('products')." p
				LEFT JOIN ".$this->db->table('manufacturers')." m ON p.manufacturer_id = m.manufacturer_id
				WHERE p.product_id IN (SELECT DISTINCT p2c.product_id
									   FROM " . $this->db->table('products_to_categories') . " p2c
									   INNER JOIN " . $this->db->table('products')." p ON p.product_id = p2c.product_id
									   WHERE p.status = '1' AND p2c.category_id IN (".implode(', ',$categories)."));";

		$query = $this->db->query($sql);
		return $query->rows;
	}

	/**
	 * @param int $category_id
	 * @return string
	 */
	public function buildPath($category_id) {
		$query = $this->db->query("SELECT c.category_id, c.parent_id
		                            FROM " . $this->db->table("categories") . " c
		                            WHERE c.category_id = '" . (int)$category_id . "'
		                            ORDER BY c.sort_order");
		
		$category_info = $query->row;
		if ($category_info['parent_id']) {
			return $this->buildPath($category_info['parent_id']) . "_" . $category_info['category_id'];
		} else {
			return $category_info['category_id'];
		}
	}
	
	//2016/03/29 ADDED by TREVOL
	public function buildPathName($category_id) {
		$query = $this->db->query("SELECT c.category_id, c.parent_id, cd.name
		                            FROM " . $this->db->table("categories") . " c LEFT JOIN " . $this->db->table("category_descriptions") . " cd ON (c.category_id = cd.category_id) 
		                            WHERE c.category_id = '" . (int)$category_id . "'
		                            ORDER BY c.sort_order");
		
		$category_info = $query->row;
		if ($category_info['parent_id']) {
			return  $category_info['name'] . ", " . $this->buildPathName($category_info['parent_id']);
		} else {
			return $category_info['name'];
		}
	}
	
	//2016/03/29 ADDED by TREVOL
	public function getCategoriesByKeyword($keyword){
		if ($keyword){
			$sql = "SELECT  * FROM ".$this->db->table("categories")." c LEFT JOIN " . $this->db->table("category_descriptions") . " cd ON (c.category_id = cd.category_id) WHERE c.status = '1' AND cd.name LIKE '%".$keyword."%' ORDER BY c.sort_order";
			$query = $this->db->query($sql);
			
			$categories = array ();
			if ($query->num_rows){
				foreach ($query->rows as $value){
					$categories[$value['category_id']] = $value;
				}
			}
			return $categories;

		} else{
			return array ();
		}
	}
}
