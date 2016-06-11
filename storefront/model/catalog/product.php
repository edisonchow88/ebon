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
if (!defined('DIR_CORE')){
	header('Location: static_pages/');
}

/** @noinspection PhpUndefinedClassInspection */
class ModelCatalogProduct extends Model{
	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProduct($product_id){
		if (!(int)$product_id){
			return array ();
		}
		$query = $this->db->query(
				"SELECT DISTINCT *,
						pd.name AS name,
						m.name AS manufacturer,
						ss.name AS stock_status,
						lcd.unit as length_class_name, " .
				$this->_sql_avg_rating_string() . ", " .
				$this->_sql_final_price_string() . " " .
				$this->_sql_join_string() .
				" LEFT JOIN " . $this->db->table("length_class_descriptions") . " lcd
									ON (p.length_class_id = lcd.length_class_id
										AND lcd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
				WHERE p.product_id = '" . (int)$product_id . "'
						AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
						AND p.date_available <= NOW() AND p.status = '1'");
		return $query->row;
	}

	/**
	 * Check if product or any option value require tracking stock subtract = 1
	 * @param int $product_id
	 * @return int
	 */
	public function isStockTrackable($product_id){
		if (!(int)$product_id){
			return 0;
		}
		//check main product
		$query = $this->db->query("SELECT subtract
									FROM " . $this->db->table("products") . " p
									WHERE p.product_id = '" . (int)$product_id . "'");

		$track_status = (int)$query->row['subtract'];
		//check product option values
		$query = $this->db->query("SELECT pov.subtract AS subtract
									FROM " . $this->db->table("product_options") . " po
									LEFT JOIN " . $this->db->table("product_option_values") . " pov
										ON (po.product_option_id = pov.product_option_id)
									WHERE po.product_id = '" . (int)$product_id . "'");

		foreach ($query->rows as $row){
			$track_status += $row['subtract'];
		}
		return $track_status;
	}

	/**
	 *
	 * Check if product or any option has any stock available
	 * @param int $product_id
	 * @return int
	 */
	public function hasAnyStock($product_id){
		if (!(int)$product_id){
			return 0;
		}
		//check main product
		$query = $this->db->query("SELECT quantity
									FROM " . $this->db->table("products") . " p
									WHERE p.product_id = '" . (int)$product_id . "'");

		$total_quantity = (int)$query->row['quantity'];
		//check product option values
		$query = $this->db->query("SELECT pov.quantity AS quantity
									FROM " . $this->db->table("product_options") . " po
									LEFT JOIN " . $this->db->table("product_option_values") . " pov
										ON (po.product_option_id = pov.product_option_id)
									WHERE po.product_id = '" . (int)$product_id . "'");
		foreach ($query->rows as $row){
			$total_quantity += $row['quantity'];
		}
		return $total_quantity;
	}

	public function getProductDataForCart($product_id){
		if (!(int)$product_id){
			return array ();
		}
		$query = $this->db->query(
				"SELECT *, wcd.unit AS weight_class, mcd.unit AS length_class
                FROM " . $this->db->table("products") . " p
                LEFT JOIN " . $this->db->table("product_descriptions") . " pd
                    ON (p.product_id = pd.product_id
                            AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
                LEFT JOIN " . $this->db->table("weight_classes") . " wc ON (p.weight_class_id = wc.weight_class_id)
                LEFT JOIN " . $this->db->table("weight_class_descriptions") . " wcd
                    ON (wc.weight_class_id = wcd.weight_class_id
                            AND wcd.language_id = '" . (int)$this->config->get('storefront_language_id') . "' )
                LEFT JOIN " . $this->db->table("length_classes") . " mc ON (p.length_class_id = mc.length_class_id)
                LEFT JOIN " . $this->db->table("length_class_descriptions") . " mcd ON (mc.length_class_id = mcd.length_class_id)
                WHERE p.product_id = '" . (int)$product_id . "' AND p.date_available <= NOW() AND p.status = '1'");

		return $query->row;
	}

	/**
	 * @param int $category_id
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getProductsByCategoryId($category_id, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20){
		$sql = "SELECT *,
						p.product_id,
						" . $this->_sql_final_price_string() . ",
						pd.name AS name, 
						pd.blurb,
						m.name AS manufacturer,
						ss.name AS stock,
						" . $this->_sql_avg_rating_string() . ",
						" . $this->_sql_review_count_string() . "
		" . $this->_sql_join_string() . "
		LEFT JOIN " . $this->db->table("products_to_categories") . " p2c
			ON (p.product_id = p2c.product_id)
		WHERE p.status = '1' AND p.date_available <= NOW()
				AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
				AND p2c.category_id = '" . (int)$category_id . "'";

		$sort_data = array (
				'pd.name'       => 'LCASE(pd.name)',
				'p.sort_order'  => 'p.sort_order',
				'p.price'       => 'final_price',
				'special'       => 'final_price',
				'rating'        => 'rating',
				'date_modified' => 'p.date_modified',
				'review'        => 'review'
		);

		if (isset($sort) && in_array($sort, array_keys($sort_data))){
			$sql .= " ORDER BY " . $sort_data[$sort];
		} else{
			$sql .= " ORDER BY p.sort_order";
		}

		if ($order == 'DESC'){
			$sql .= " DESC";
		} else{
			$sql .= " ASC";
		}

		if ($start < 0){
			$start = 0;
		}

		$sql .= " LIMIT " . (int)$start . "," . (int)$limit;
		$query = $this->db->query($sql);

		return $query->rows;
	}

	/**
	 * @param int $category_id
	 * @return int
	 */
	public function getTotalProductsByCategoryId($category_id = 0){
		$query = $this->db->query("SELECT COUNT(*) AS total
									FROM " . $this->db->table("products_to_categories") . " p2c
									LEFT JOIN " . $this->db->table("products") . " p ON (p2c.product_id = p.product_id)
									LEFT JOIN " . $this->db->table("products_to_stores") . " p2s ON (p.product_id = p2s.product_id)
									WHERE p.status = '1' AND p.date_available <= NOW()
										AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
										AND p2c.category_id = '" . (int)$category_id . "'");

		return $query->row['total'];
	}

	/**
	 * @param int $manufacturer_id
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getProductsByManufacturerId($manufacturer_id, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20){
		if (!(int)$manufacturer_id){
			return array ();
		}
		$sql = "SELECT *, p.product_id,
						" . $this->_sql_final_price_string() . ",
						pd.name AS name, 
						pd.blurb,
						m.name AS manufacturer,
						ss.name AS stock,
						" . $this->_sql_avg_rating_string() . ",
						" . $this->_sql_review_count_string() . "
		" . $this->_sql_join_string() . "
		WHERE p.status = '1' AND p.date_available <= NOW()
			AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
			AND m.manufacturer_id = '" . (int)$manufacturer_id . "'";

		$sort_data = array (
				'pd.name'       => 'LCASE(pd.name)',
				'p.sort_order'  => 'p.sort_order',
				'p.price'       => 'final_price',
				'special'       => 'final_price',
				'rating'        => 'rating',
				'date_modified' => 'p.date_modified',
				'review'        => 'review'
		);

		if (isset($sort) && in_array($sort, array_keys($sort_data))){
			$sql .= " ORDER BY " . $sort_data[$sort];
		} else{
			$sql .= " ORDER BY p.sort_order";
		}

		if ($order == 'DESC'){
			$sql .= " DESC";
		} else{
			$sql .= " ASC";
		}

		if ($start < 0){
			$start = 0;
		}

		$sql .= " LIMIT " . (int)$start . "," . (int)$limit;
		$query = $this->db->query($sql);

		return $query->rows;
	}

	/**
	 * @param int $manufacturer_id
	 * @return int
	 */
	public function getTotalProductsByManufacturerId($manufacturer_id = 0){
		$query = $this->db->query("SELECT COUNT(*) AS total
									FROM " . $this->db->table("products") . "
									WHERE status = '1'
											AND date_available <= NOW()
											AND manufacturer_id = '" . (int)$manufacturer_id . "'");

		return $query->row['total'];
	}

	/**
	 * @param string $tag
	 * @param int $category_id
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getProductsByTag($tag, $category_id = 0, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20){
		if ($tag){
			$sql = "SELECT *, p.product_id,
							" . $this->_sql_final_price_string() . ",
							pd.name AS name, 
							m.name AS manufacturer, 
							ss.name AS stock,
							" . $this->_sql_avg_rating_string() . ",
							" . $this->_sql_review_count_string() . "
					" . $this->_sql_join_string() . "
					LEFT JOIN " . $this->db->table("product_tags") . " pt ON (p.product_id = pt.product_id AND pt.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					WHERE p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
						AND (LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($tag)) . "'";

			$keywords = explode(" ", $tag);

			foreach ($keywords as $keyword){
				$sql .= " OR LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($keyword)) . "'";
			}

			$sql .= ")";

			if ($category_id){
				$data = array ();

				foreach (explode(',', $category_id) as $category_id){
					$data[] = "'" . (int)$category_id . "'";
				}

				$sql .= " AND p.product_id IN (SELECT product_id
												FROM " . $this->db->table("products_to_categories") . "
												WHERE category_id IN (" . implode(",", $data) . "))";
			}

			$sql .= " AND p.status = '1' AND p.date_available <= NOW() GROUP BY p.product_id";

			$sort_data = array (
					'pd.name'       => 'LCASE(pd.name)',
					'p.sort_order'  => 'p.sort_order',
					'p.price'       => 'final_price',
					'special'       => 'final_price',
					'rating'        => 'rating',
					'date_modified' => 'p.date_modified',
					'review'        => 'review'
			);

			if (isset($sort) && in_array($sort, array_keys($sort_data))){
				$sql .= " ORDER BY " . $sort_data[$sort];
			} else{
				$sql .= " ORDER BY p.sort_order";
			}

			if ($order == 'DESC'){
				$sql .= " DESC";
			} else{
				$sql .= " ASC";
			}

			if ($start < 0){
				$start = 0;
			}

			$sql .= " LIMIT " . (int)$start . "," . (int)$limit;

			$query = $this->db->query($sql);

			$products = array ();

			foreach ($query->rows as $value){
				$products[$value['product_id']] = $this->getProduct($value['product_id']);
			}

			return $products;
		}
		return array ();
	}

	/**
	 * @param string $keyword
	 * @param int $category_id
	 * @param bool $description
	 * @param bool $model
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getProductsByKeyword($keyword, $category_id = 0, $description = false, $model = false, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20){
		if ($keyword){
			$sql = "SELECT  *,
							p.product_id,  
							" . $this->_sql_final_price_string() . ",
							pd.name AS name, 
							pd.blurb,
							m.name AS manufacturer,
							ss.name AS stock,
							" . $this->_sql_avg_rating_string() . ",
							" . $this->_sql_review_count_string() . "
			" . $this->_sql_join_string() . "
		    LEFT JOIN " . $this->db->table("product_tags") . " pt ON (p.product_id = pt.product_id)
			WHERE p2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ";

			$tags = explode(' ', trim($keyword));
			$tags_str = array ();
			if (sizeof($tags) > 1) $tags_str[] = " LCASE(pt.tag) = '" . $this->db->escape(trim($keyword)) . "' ";
			foreach ($tags as $tag){
				$tags_str[] = " LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($tag)) . "' ";
			}

			if (!$description){
				$sql .= " AND (LCASE(pd.name) LIKE '%" . $this->db->escape(mb_strtolower($keyword)) . "%' OR " . implode(' OR ', $tags_str);
			} else{
				$sql .= " AND (LCASE(pd.name) LIKE '%" . $this->db->escape(mb_strtolower($keyword)) . "%'
								OR " . implode(' OR ', $tags_str) . "
								OR LCASE(pd.description) LIKE '%" . $this->db->escape(mb_strtolower($keyword)) . "%'";
			}

			if (!$model){
				$sql .= ")";
			} else{
				$sql .= " OR LCASE(p.model) LIKE '%" . $this->db->escape(mb_strtolower($keyword)) . "%')";
			}

			if ($category_id){
				$data = array ();

				$this->load->model('catalog/category');
				$string = rtrim($this->getPath($category_id), ',');
				$category_ids = explode(',', $string);

				foreach ($category_ids as $category_id){
					$data[] = "'" . (int)$category_id . "'";
				}

				$sql .= " AND p.product_id IN (SELECT product_id
												FROM " . $this->db->table("products_to_categories") . "
												WHERE category_id IN (" . implode(", ", $data) . "))";
			}

			$sql .= " AND p.status = '1' AND p.date_available <= NOW()
					 GROUP BY p.product_id";

			$sort_data = array (
					'pd.name'       => 'LCASE(pd.name)',
					'p.sort_order'  => 'p.sort_order',
					'p.price'       => 'final_price',
					'special'       => 'final_price',
					'rating'        => 'rating',
					'date_modified' => 'p.date_modified',
					'review'        => 'review'
			);

			if (isset($sort) && in_array($sort, array_keys($sort_data))){
				$sql .= " ORDER BY " . $sort_data[$sort];
			} else{
				$sql .= " ORDER BY p.sort_order";
			}

			if ($order == 'DESC'){
				$sql .= " DESC";
			} else{
				$sql .= " ASC";
			}

			if ($start < 0){
				$start = 0;
			}

			$sql .= " LIMIT " . (int)$start . "," . (int)$limit;
			$query = $this->db->query($sql);
			$products = array ();
			if ($query->num_rows){
				foreach ($query->rows as $value){
					$products[$value['product_id']] = $value;
				}
			}
			return $products;

		} else{
			return array ();
		}
	}

	/**
	 * @param string $keyword
	 * @param int $category_id
	 * @param bool $description
	 * @param bool $model
	 * @return int
	 */
	public function getTotalProductsByKeyword($keyword, $category_id = 0, $description = false, $model = false){
		$keyword = trim($keyword);
		if ($keyword){
			$sql = "SELECT COUNT( DISTINCT p.product_id ) AS total
					FROM " . $this->db->table("products") . " p
					LEFT JOIN " . $this->db->table("product_descriptions") . " pd
								ON (p.product_id = pd.product_id AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					LEFT JOIN " . $this->db->table("products_to_stores") . " p2s
								ON (p.product_id = p2s.product_id)
					LEFT JOIN " . $this->db->table("product_tags") . " pt ON (p.product_id = pt.product_id)
					WHERE p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";

			$tags = explode(' ', trim($keyword));
			$tags_str = array ();
			if (sizeof($tags) > 1) $tags_str[] = " LCASE(pt.tag) = '" . $this->db->escape(trim($keyword)) . "' ";
			foreach ($tags as $tag){
				$tags_str[] = " LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($tag)) . "' ";
			}

			if (!$description){
				$sql .= " AND (LCASE(pd.name) LIKE '%" . $this->db->escape(mb_strtolower($keyword)) . "%' OR " . implode(' OR ', $tags_str);
			} else{
				$sql .= " AND (LCASE(pd.name) LIKE '%" . $this->db->escape(mb_strtolower($keyword)) . "%' OR " . implode(' OR ', $tags_str) . " OR LCASE(pd.description) LIKE '%" . $this->db->escape(mb_strtolower($keyword)) . "%'";
			}

			if (!$model){
				$sql .= ")";
			} else{
				$sql .= " OR LCASE(p.model) LIKE '%" . $this->db->escape(mb_strtolower($keyword)) . "%')";
			}

			if ($category_id){
				$data = array ();

				$this->load->model('catalog/category');

				$string = rtrim($this->getPath($category_id), ',');
				$category_ids = explode(',', $string);

				foreach ($category_ids as $category_id){
					$data[] = "category_id = '" . (int)$category_id . "'";
				}

				$sql .= " AND p.product_id IN (SELECT product_id FROM " . $this->db->table("products_to_categories") . " WHERE " . implode(" OR ", $data) . ")";
			}

			$sql .= " AND p.status = '1' AND p.date_available <= NOW()";
			$query = $this->db->query($sql);
			if ($query->num_rows){
				return $query->row['total'];
			} else{
				return 0;
			}
		} else{
			return 0;
		}
	}

	/**
	 * @param string $tag
	 * @param int $category_id
	 * @return int
	 */
	public function getTotalProductsByTag($tag, $category_id = 0){
		$tag = trim($tag);
		if ($tag){

			$sql = "SELECT COUNT(DISTINCT p.product_id) AS total
					FROM " . $this->db->table("products") . " p
					LEFT JOIN " . $this->db->table("product_descriptions") . " pd ON (p.product_id = pd.product_id AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					LEFT JOIN " . $this->db->table("product_tags") . " pt ON (p.product_id = pt.product_id AND pt.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					LEFT JOIN " . $this->db->table("products_to_stores") . " p2s ON (p.product_id = p2s.product_id)
					LEFT JOIN " . $this->db->table("manufacturers") . " m ON (p.manufacturer_id = m.manufacturer_id)
					LEFT JOIN " . $this->db->table("stock_statuses") . " ss ON (p.stock_status_id = ss.stock_status_id AND ss.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					WHERE p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
						AND (LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($tag)) . "'";

			$keywords = explode(" ", $tag);

			foreach ($keywords as $keyword){
				$sql .= " OR LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($keyword)) . "'";
			}

			$sql .= ")";

			if ($category_id){
				$data = array ();

				$this->load->model('catalog/category');

				$string = rtrim($this->getPath($category_id), ',');
				$category_ids = explode(',', $string);

				foreach ($category_ids as $category_id){
					$data[] = "category_id = '" . (int)$category_id . "'";
				}
				$sql .= " AND p.product_id IN (SELECT product_id FROM " . $this->db->table("products_to_categories") . " WHERE " . implode(" OR ", $data) . ")";
			}
			$sql .= " AND p.status = '1' AND p.date_available <= NOW()";
			$query = $this->db->query($sql);

			if ($query->num_rows){
				return $query->row['total'];
			}
		}
		return 0;
	}

	/**
	 * @param int $category_id
	 * @return string
	 */
	public function getPath($category_id){
		$string = $category_id . ',';

		$results = $this->model_catalog_category->getCategories((int)$category_id);

		foreach ($results as $result){
			$string .= $this->getPath($result['category_id']);
		}

		return $string;
	}

	/**
	 * @param int $limit
	 * @return array
	 */
	public function getLatestProducts($limit){
		$cache = $this->cache->get('product.latest.' . $limit, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		if (is_null($cache)){
			$sql = "SELECT *,
					pd.name AS name,
					m.name AS manufacturer,
					ss.name AS stock,
					pd.blurb,
					" . $this->_sql_avg_rating_string() . ",
					" . $this->_sql_review_count_string() . "
					" . $this->_sql_join_string() . "
					WHERE p.status = '1'
							AND p.date_available <= NOW()
							AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
					ORDER BY p.date_added DESC";

			if ((int)$limit){
				$sql .= " LIMIT " . (int)$limit;
			}

			$query = $this->db->query($sql);
			$cache = $query->rows;
			$this->cache->set('product.latest.' . $limit, $cache, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		}

		return $cache;
	}

	/**
	 * @param int $limit
	 * @return array
	 */
	public function getPopularProducts($limit = 0){

		$sql = "SELECT *,
						pd.name AS name,
						m.name AS manufacturer,
						ss.name AS stock,
						" . $this->_sql_avg_rating_string() . ",
						" . $this->_sql_review_count_string() . "
				" . $this->_sql_join_string() . "
				WHERE p.status = '1'
						AND p.date_available <= NOW()
						AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
				ORDER BY p.viewed DESC, p.date_added DESC";

		if ((int)$limit){
			$sql .= " LIMIT " . (int)$limit;
		}
		$query = $this->db->query($sql);
		return $query->rows;
	}

	/**
	 * @param $limit
	 * @return array
	 */
	public function getFeaturedProducts($limit){
		$product_data = $this->cache->get('product.featured.' . $limit, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		if (is_null($product_data)){
			$sql = "SELECT f.*, pd.*, ss.name AS stock, p.*
					FROM " . $this->db->table("products_featured") . " f
					LEFT JOIN " . $this->db->table("products") . " p ON (f.product_id = p.product_id)
					LEFT JOIN " . $this->db->table("product_descriptions") . " pd ON (f.product_id = pd.product_id AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					LEFT JOIN " . $this->db->table("products_to_stores") . " p2s ON (p.product_id = p2s.product_id)
					LEFT JOIN " . $this->db->table("stock_statuses") . " ss ON (p.stock_status_id = ss.stock_status_id
						AND ss.language_id = '" . (int)$this->config->get('storefront_language_id') . "') 
					WHERE p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
						AND p.status='1'
						AND p.date_available <= NOW()
					ORDER BY p.sort_order ASC, p.date_available DESC
					";
			if ((int)$limit){
				$sql .= " LIMIT " . (int)$limit;
			}

			$query = $this->db->query($sql);
			$product_data = $query->rows;
			$this->cache->set('product.featured.' . $limit, $product_data, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		}
		return $product_data;
	}

	/**
	 * @param $limit
	 * @return array
	 */
	public function getBestSellerProducts($limit){
		$product_data = $this->cache->get('product.bestseller.' . $limit, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));

		if (is_null($product_data)){
			$product_data = array ();

			$sql = "SELECT op.product_id, SUM(op.quantity) AS total
					FROM " . $this->db->table("order_products") . " op
					LEFT JOIN `" . $this->db->table("orders") . "` o ON (op.order_id = o.order_id)
					LEFT JOIN " . $this->db->table("products") . " p ON p.product_id = op.product_id
					WHERE o.order_status_id > '0' AND p.status = '1' AND p.date_available <= NOW()
					GROUP BY op.product_id
					ORDER BY total DESC";
			if ((int)$limit){
				$sql .= " LIMIT " . (int)$limit;
			}
			$query = $this->db->query($sql);


			if ($query->num_rows){
				$products = array ();
				foreach ($query->rows as $result){
					$products[] = (int)$result['product_id'];
				}

				if ($products){
					$sql = "SELECT pd.*, ss.name AS stock, p.*
							FROM " . $this->db->table("products") . " p
							LEFT JOIN " . $this->db->table("product_descriptions") . " pd ON (p.product_id = pd.product_id AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
							LEFT JOIN " . $this->db->table("products_to_stores") . " p2s ON (p.product_id = p2s.product_id)
							LEFT JOIN " . $this->db->table("stock_statuses") . " ss
								ON (p.stock_status_id = ss.stock_status_id
									AND ss.language_id = '" . (int)$this->config->get('storefront_language_id') . "') 
							WHERE p.product_id IN (" . implode(', ', $products) . ")
								AND p.status = '1' AND p.date_available <= NOW()
								AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
					$product_query = $this->db->query($sql);

					if ($product_query->num_rows){
						foreach ($product_query->rows as $result){
							$data[$result['product_id']] = $result;
						}
						// resort by totals
						foreach ($products as $id){
							if (isset($data[$id])){
								$product_data[] = $data[$id];
							}
						}
					}
				}
			}

			$this->cache->set('product.bestseller.' . $limit, $product_data, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		}

		return $product_data;
	}

	/**
	 * @param int $product_id
	 * @return null
	 */
	public function updateViewed($product_id){
		if (empty($product_id)){
			return null;
		}
		$this->db->query("UPDATE " . $this->db->table("products") . "
						  SET viewed = viewed + 1
						  WHERE product_id = '" . (int)$product_id . "'");
	}

	/**
	 * @param int $product_id
	 * @param int $status
	 * @return null
	 */
	public function updateStatus($product_id, $status = 0){
		if (empty($product_id)){
			return null;
		}
		$this->db->query("UPDATE " . $this->db->table("products") . "
						SET status = " . (int)$status . "
						WHERE product_id = '" . (int)$product_id . "'");
		$this->cache->delete('product');
	}

	/**
	 * check if product option is group option
	 * if yes, return array of possible groups for option_value_id
	 *
	 * @param $product_id
	 * @param $option_id
	 * @param $option_value_id
	 * @return array
	 */
	public function getProductGroupOptions($product_id, $option_id, $option_value_id){
		if (empty($product_id) || empty($option_id)){
			return array ();
		}
		$product_option = $this->db->query(
				"SELECT group_id FROM " . $this->db->table("product_options") . "
			WHERE product_id = '" . (int)$product_id . "'
				AND product_option_id = '" . (int)$option_id . "' ");
		if (!$product_option->row['group_id']){
			return array ();
		}
		//get all option values of group
		$option_values = $this->db->query(
				"SELECT pov.*, povd.name
			 FROM " . $this->db->table("product_options") . " po
			 LEFT JOIN " . $this->db->table("product_option_values") . " pov ON (po.product_option_id = pov.product_option_id)
			 LEFT JOIN  " . $this->db->table("product_option_value_descriptions") . " povd
					ON (pov.product_option_value_id = povd.product_option_value_id AND povd.language_id = '" . (int)$this->config->get('storefront_language_id') . "' )
			 WHERE po.group_id = '" . (int)$product_option->row['group_id'] . "'
			 ORDER BY pov.sort_order ");

		//find attribute_value_id of option_value
		//find all option values with attribute_value_id
		//for each option values find group id
		//add each group values to result array
		$result = array ();
		$attribute_value_id = null;
		foreach ($option_values->rows as $row){
			if ($row['product_option_value_id'] == $option_value_id){
				$attribute_value_id = $row['attribute_value_id'];
				break;
			}
		}
		$groups = array ();
		foreach ($option_values->rows as $row){
			if ($row['attribute_value_id'] == $attribute_value_id){
				$groups[] = $row['group_id'];
			}
		}
		$groups = array_unique($groups);
		foreach ($groups as $group_id){
			foreach ($option_values->rows as $row){
				if ($row['group_id'] == $group_id && $row['product_option_id'] != $option_id){
					$result[$row['product_option_id']][$row['product_option_value_id']] = array (
							'name'   => $row['name'],
							'price'  => $row['price'],
							'prefix' => $row['prefix'],
					);
				}
			}
		}

		return $result;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductOptions($product_id){
		if (!(int)$product_id){
			return array ();
		}
		$language_id = (int)$this->config->get('storefront_language_id');
		$product_option_data = $this->cache->get('product.options.' . $product_id, $language_id);
		$elements = HtmlElementFactory::getAvailableElements();
		if (is_null($product_option_data)){
			$product_option_data = array ();
			$product_option_query = $this->db->query(
					"SELECT po.*, pod.option_placeholder, pod.error_text
                FROM " . $this->db->table("product_options") . " po
                LEFT JOIN " . $this->db->table("product_option_descriptions") . " pod
                	ON pod.product_option_id = po.product_option_id AND pod.language_id =  '" . $language_id . "'
                WHERE po.product_id = '" . (int)$product_id . "'
                    AND po.group_id = 0
                    AND po.status = 1
                ORDER BY po.sort_order"
			);
			if ($product_option_query){
				foreach ($product_option_query->rows as $product_option){

					$attribute_values = array ();
					$product_option_value_data = array ();
					$product_option_value_query = $this->db->query(
							"SELECT *
                            FROM " . $this->db->table("product_option_values") . "
                            WHERE product_option_id = '" . (int)$product_option['product_option_id'] . "'
                            ORDER BY sort_order"
					);
					if ($product_option_value_query){
						foreach ($product_option_value_query->rows as $product_option_value){
							if ($product_option_value['attribute_value_id']){
								//skip duplicate attributes values if it is not grouped parent/child
								if (in_array($product_option_value['attribute_value_id'], $attribute_values)){
									continue;
								}
								$attribute_values[] = $product_option_value['attribute_value_id'];
							}
							$pd_opt_val_description_qr = $this->db->query(
									"SELECT *
                                    FROM " . $this->db->table("product_option_value_descriptions") . "
                                    WHERE product_option_value_id = '" . (int)$product_option_value['product_option_value_id'] . "'
                                    AND language_id = '" . (int)$language_id . "'"
							);

							// ignore option value with 0 quantity and disabled subtract
							if ((!$product_option_value['subtract'])
									|| (!$this->config->get('config_nostock_autodisable'))
									|| ($product_option_value['quantity'] && $product_option_value['subtract'])
							){
								$product_option_value_data[$product_option_value['product_option_value_id']] = array (
										'product_option_value_id' => $product_option_value['product_option_value_id'],
										'attribute_value_id'      => $product_option_value['attribute_value_id'],
										'grouped_attribute_data'  => $product_option_value['grouped_attribute_data'],
										'group_id'                => $product_option_value['group_id'],
										'name'                    => $pd_opt_val_description_qr->row['name'],
										'option_placeholder'      => $product_option['option_placeholder'],
										'regexp_pattern'          => $product_option['regexp_pattern'],
										'error_text'              => $product_option['error_text'],
										'settings'                => $product_option['settings'],
										'children_options_names'  => $pd_opt_val_description_qr->row['children_options_names'],
										'sku'                     => $product_option_value['sku'],
										'price'                   => $product_option_value['price'],
										'prefix'                  => $product_option_value['prefix'],
										'weight'                  => $product_option_value['weight'],
										'weight_type'             => $product_option_value['weight_type'],
										'quantity'                => $product_option_value['quantity'],
										'subtract'                => $product_option_value['subtract'],
										'default'                 => $product_option_value['default'],
								);
							}
						}
					}
					$prd_opt_description_qr = $this->db->query(
							"SELECT *
                        FROM " . $this->db->table("product_option_descriptions") . "
                        WHERE product_option_id = '" . (int)$product_option['product_option_id'] . "'
                            AND language_id = '" . (int)$language_id . "'"
					);

					$product_option_data[$product_option['product_option_id']] = array (
							'product_option_id'  => $product_option['product_option_id'],
							'attribute_id'       => $product_option['attribute_id'],
							'group_id'           => $product_option['group_id'],
							'name'               => $prd_opt_description_qr->row['name'],
							'option_placeholder' => $product_option['option_placeholder'],
							'option_value'       => $product_option_value_data,
							'sort_order'         => $product_option['sort_order'],
							'element_type'       => $product_option['element_type'],
							'html_type'          => $elements[$product_option['element_type']]['type'],
							'required'           => $product_option['required'],
							'regexp_pattern'     => $product_option['regexp_pattern'],
							'error_text'         => $product_option['error_text'],
							'settings'           => $product_option['settings'],
					);
				}
			}

			$this->cache->set('product.options.' . $product_id, $product_option_data, $language_id);
		}
		return $product_option_data;
	}

	/**
	 * @param int $product_id
	 * @param int $product_option_id
	 * @return array
	 */
	public function getProductOption($product_id, $product_option_id){
		if (!(int)$product_id || !(int)$product_option_id){
			return array ();
		}

		$query = $this->db->query("SELECT *
						FROM " . $this->db->table("product_options") . " po
						LEFT JOIN " . $this->db->table("product_option_descriptions") . " pod ON (po.product_option_id = pod.product_option_id)
						WHERE po.product_option_id = '" . (int)$product_option_id . "'
							AND po.product_id = '" . (int)$product_id . "'
							AND pod.language_id = '" . (int)$this->config->get('storefront_language_id') . "'
						ORDER BY po.sort_order");
		return $query->row;
	}

	/**
	 * @param $product_id
	 * @param $product_option_id
	 * @return array
	 */
	public function getProductOptionValues($product_id, $product_option_id){
		if (!(int)$product_id || !(int)$product_option_id){
			return array ();
		}
		$query = $this->db->query(
				"SELECT *
                 FROM " . $this->db->table("product_option_values") . " pov
                 WHERE pov.product_option_id = '" . (int)$product_option_id . "'
                    AND pov.product_id = '" . (int)$product_id . "'
                 ORDER BY pov.sort_order");
		return $query->rows;
	}

	/**
	 * @param int $product_id
	 * @param int $product_option_value_id
	 * @return array
	 */
	public function getProductOptionValue($product_id, $product_option_value_id){
		if (!(int)$product_id || !(int)$product_option_value_id){
			return array ();
		}

		$query = $this->db->query(
				"SELECT *, COALESCE(povd.name,povd2.name) as name
                FROM " . $this->db->table("product_option_values") . " pov
                LEFT JOIN " . $this->db->table("product_option_value_descriptions") . " povd
                        ON (pov.product_option_value_id = povd.product_option_value_id
                                AND povd.language_id = '" . (int)$this->config->get('storefront_language_id') . "' )
                LEFT JOIN " . $this->db->table("product_option_value_descriptions") . " povd2
                        ON (pov.product_option_value_id = povd2.product_option_value_id
                                AND povd2.language_id = '1' )
                WHERE pov.product_option_value_id = '" . (int)$product_option_value_id . "'
                    AND pov.product_id = '" . (int)$product_id . "'
                ORDER BY pov.sort_order");
		return $query->row;
	}


	/**
	 * Check if any of inputed options are required and provided
	 * @param int $product_id
	 * @param array $input_options
	 * @return array
	 */
	public function validateProductOptions($product_id, $input_options){

		$errors = array ();
		if (empty($product_id) && empty($input_options)){
			return array ();
		}
		$product_options = $this->getProductOptions($product_id);
		if (is_array($product_options) && $product_options){
			foreach ($product_options as $option){

				if ($option['required']){
					if (empty($input_options[$option['product_option_id']])){
						$errors[] = $option['name'] . ': ' . $this->language->get('error_required_options');
					}
				}

				if ($option['regexp_pattern'] && !preg_match($option['regexp_pattern'], (string)$input_options[$option['product_option_id']])){
					$errors[] = $option['name'] . ': ' . $option['error_text'];
				}

			}
		}

		return $errors;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductTags($product_id){
		if (!(int)$product_id){
			return array ();
		}
		$query = $this->db->query("SELECT *
									FROM " . $this->db->table("product_tags") . "
									WHERE product_id = '" . (int)$product_id . "'
											AND language_id = '" . (int)$this->config->get('storefront_language_id') . "'");

		return $query->rows;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductDownloads($product_id){
		if (!(int)$product_id){
			return array ();
		}

		$query = $this->db->query(
				"SELECT *
					 FROM " . $this->db->table("products_to_downloads") . " p2d
					 LEFT JOIN " . $this->db->table("downloads") . " d ON (p2d.download_id = d.download_id)
					 LEFT JOIN " . $this->db->table("download_descriptions") . " dd
					 	ON (d.download_id = dd.download_id
					 			AND dd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					 WHERE p2d.product_id = '" . (int)$product_id . "'");

		return $query->rows;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductRelated($product_id){
		$product_data = array ();
		if (!(int)$product_id){
			return array ();
		}

		$product_related_query = $this->db->query(
				"SELECT *
				 FROM " . $this->db->table("products_related") . "
				 WHERE product_id = '" . (int)$product_id . "'");

		foreach ($product_related_query->rows as $result){
			$product_query = $this->db->query(
					"SELECT DISTINCT *,
							pd.name AS name,
							m.name AS manufacturer,
							ss.name AS stock,
							" . $this->_sql_avg_rating_string() . ", " .
					$this->_sql_review_count_string() .
					$this->_sql_join_string() . "
					WHERE p.product_id = '" . (int)$result['related_id'] . "'
						AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
						AND p.date_available <= NOW() AND p.status = '1'");

			if ($product_query->num_rows){
				$product_data[$result['related_id']] = $product_query->row;
			}
		}

		return $product_data;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getCategories($product_id){
		if (!(int)$product_id){
			return array ();
		}
		$query = $this->db->query("SELECT *
									FROM " . $this->db->table("products_to_categories") . "
									WHERE product_id = '" . (int)$product_id . "'");
		return $query->rows;
	}

	private function _sql_avg_rating_string(){
		$sql = " ( SELECT AVG(r.rating)
						 FROM " . $this->db->table("reviews") . " r
						 WHERE p.product_id = r.product_id
						 GROUP BY r.product_id 
				 ) AS rating ";
		return $sql;
	}

	private function _sql_review_count_string(){
		$sql = " ( SELECT COUNT(rw.review_id)
						 FROM " . $this->db->table("reviews") . " rw
						 WHERE p.product_id = rw.product_id
						 GROUP BY rw.product_id
				 ) AS review ";
		return $sql;
	}

	private function _sql_final_price_string(){
		//special prices
		if ($this->customer->isLogged()){
			$customer_group_id = (int)$this->customer->getCustomerGroupId();
		} else{
			$customer_group_id = (int)$this->config->get('config_customer_group_id');
		}

		$sql = " ( SELECT p2sp.price
					FROM " . $this->db->table("product_specials") . " p2sp
					WHERE p2sp.product_id = p.product_id
							AND p2sp.customer_group_id = '" . $customer_group_id . "'
							AND ((p2sp.date_start = '0000-00-00' OR p2sp.date_start < NOW())
							AND (p2sp.date_end = '0000-00-00' OR p2sp.date_end > NOW()))
					ORDER BY p2sp.priority ASC, p2sp.price ASC LIMIT 1
				 ) ";
		$sql = "COALESCE( " . $sql . ", p.price) as final_price";

		return $sql;
	}

	private function _sql_join_string(){

		return "FROM " . $this->db->table("products") . " p
				LEFT JOIN " . $this->db->table("product_descriptions") . " pd
					ON (p.product_id = pd.product_id
							AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
				LEFT JOIN " . $this->db->table("products_to_stores") . " p2s ON (p.product_id = p2s.product_id)
				LEFT JOIN " . $this->db->table("manufacturers") . " m ON (p.manufacturer_id = m.manufacturer_id)
				LEFT JOIN " . $this->db->table("stock_statuses") . " ss
						ON (p.stock_status_id = ss.stock_status_id
								AND ss.language_id = '" . (int)$this->config->get('storefront_language_id') . "')";
	}


	public function getProductsAllInfo($products = array ()){
		if (!$products) return false;

		//special prices
		if ($this->customer->isLogged()){
			$customer_group_id = (int)$this->customer->getCustomerGroupId();
		} else{
			$customer_group_id = (int)$this->config->get('config_customer_group_id');
		}
		$language_id = (int)$this->config->get('storefront_language_id');
		$store_id = (int)$this->config->get('config_store_id');

		$output = $this->cache->get('product.all_info.' . md5(implode('', $products)) . '.' . $customer_group_id, $language_id, $store_id);
		if (is_null($output)){ // if no cache

			$sql = "SELECT product_id, price
					FROM " . $this->db->table("product_specials") . "
					WHERE product_id IN (" . implode(', ', $products) . ")
							AND customer_group_id = '" . $customer_group_id . "'
							AND ((date_start = '0000-00-00' OR date_start < NOW())
							AND (date_end = '0000-00-00' OR date_end > NOW()))
					ORDER BY product_id ASC, priority ASC, price ASC";
			$result = $this->db->query($sql);
			$temp = '';
			$specials = array ();
			foreach ($result->rows as $row){
				if ($row['product_id'] != $temp){
					$specials[$row['product_id']] = $row['price'];
				}
				$temp = $row['product_id'];
			}
			//avg-rating
			if ($this->config->get('enable_reviews')){
				$sql = "SELECT product_id, AVG(rating) AS total
						FROM " . $this->db->table("reviews") . "
						WHERE status = '1' AND product_id IN (" . implode(', ', $products) . ")
						GROUP BY product_id";
				$result = $this->db->query($sql);
				$rating = array ();
				foreach ($result->rows as $row){
					$rating[$row['product_id']] = (int)$row['total'];
				}
			} else{
				$rating = false;
			}

			// discounts
			$sql = "SELECT product_id, price
					FROM " . $this->db->table("product_discounts") . "
					WHERE product_id IN (" . implode(', ', $products) . ")
						AND customer_group_id = '" . (int)$customer_group_id . "'
						AND quantity = '1'
						AND ((date_start = '0000-00-00' OR date_start < NOW())
						AND (date_end = '0000-00-00' OR date_end > NOW()))
					ORDER BY  product_id ASC, priority ASC, price ASC";
			$result = $this->db->query($sql);
			$temp = '';
			$discounts = array ();
			foreach ($result->rows as $row){
				if ($row['product_id'] != $temp){
					$discounts[$row['product_id']] = $row['price'];
				}
				$temp = $row['product_id'];
			}

			// options
			$sql = "SELECT po.product_id,
							po.product_option_id,
							po.regexp_pattern,
							pov.product_option_value_id,
							pov.sku,
							pov.quantity,
							pov.subtract,
							pov.price,
							pov.prefix,
							pod.name as option_name,
							pod.error_text as error_text,
							povd.name as value_name,
							po.sort_order
						FROM " . $this->db->table("product_options") . " po
						LEFT JOIN " . $this->db->table("product_option_values") . " pov
							ON pov.product_option_id = po.product_option_id
						LEFT JOIN " . $this->db->table("product_option_value_descriptions") . " povd
							ON (povd.product_option_value_id = pov.product_option_value_id
									AND povd.language_id='" . $language_id . "')
						LEFT JOIN " . $this->db->table("product_option_descriptions") . " pod
							ON (pod.product_option_id = po.product_option_id
								AND pod.language_id='" . $language_id . "') 
						WHERE po.product_id in (" . implode(', ', $products) . ")
						ORDER BY pov.product_option_id, pov.product_id, po.sort_order, pov.sort_order";
			$result = $this->db->query($sql);
			$temp = $temp2 = '';
			$options = array ();
			foreach ($result->rows as $row){

				if ($row['product_id'] != $temp){
					$temp2 = '';
				}

				if ($row['product_option_id'] != $temp2){
					$options[$row['product_id']][$row['product_option_id']] = array (
							'product_option_id' => $row['product_option_id'],
							'name'              => $row['option_name'],
							'sort_order'        => $row['sort_order']
					);
				}
				$options[$row['product_id']][$row['product_option_id']]['option_value'][] = array (
						'product_option_value_id' => $row['product_option_value_id'],
						'name'                    => $row['value_name'],
						'sku'                     => $row['sku'],
						'price'                   => $row['price'],
						'prefix'                  => $row['prefix']
				);
				$temp = $row['product_id'];
				$temp2 = $row['product_option_id'];
			}

			foreach ($products as $product){
				$output[$product]['special'] = $specials[$product];
				$output[$product]['discount'] = $discounts[$product];
				$output[$product]['options'] = $options[$product];
				$output[$product]['rating'] = $rating !== false ? (int)$rating[$product] : false;
			}
			$this->cache->set('product.all_info.' . md5(implode('', $products)) . '.' . $customer_group_id, $output, $language_id, $store_id);
		}
		return $output;
	}

	public function getProducts($data = array (), $mode = 'default'){

		if (!empty($data['content_language_id'])){
			$language_id = ( int )$data['content_language_id'];
		} else{
			$language_id = (int)$this->config->get('storefront_language_id');
		}

		if ($data || $mode == 'total_only'){

			$filter = (isset($data['filter']) ? $data['filter'] : array ());

			if ($mode == 'total_only'){
				$sql = "SELECT COUNT(DISTINCT p.product_id) as total
						FROM " . $this->db->table("products") . " p
						LEFT JOIN " . $this->db->table("product_descriptions") . " pd
							ON (p.product_id = pd.product_id)";
			} else{
				$sql = "SELECT *,
								p.product_id,
								" . $this->_sql_final_price_string() . ",
								pd.name AS name,
								m.name AS manufacturer,
								ss.name AS stock,
								" . $this->_sql_avg_rating_string() . ",
								" . $this->_sql_review_count_string() . "
						" . $this->_sql_join_string();
			}

			if (isset($filter['category_id']) && !is_null($filter['category_id'])){
				$sql .= " LEFT JOIN " . $this->db->table("products_to_categories") . " p2c ON (p.product_id = p2c.product_id)";
			}
			$sql .= " WHERE pd.language_id = '" . $language_id . "' AND p.date_available <= NOW() AND p.status = '1' ";

			if (!empty($data['subsql_filter'])){
				$sql .= " AND " . $data['subsql_filter'];
			}

			if (isset($filter['match']) && !is_null($filter['match'])){
				$match = $filter['match'];
			} else{
				$match = 'exact';
			}

			if (isset($filter['keyword']) && !is_null($filter['keyword'])){
				$keywords = explode(' ', $filter['keyword']);

				if ($match == 'any'){
					$sql .= " AND (";
					foreach ($keywords as $k => $keyword){
						$sql .= $k > 0 ? " OR" : "";
						$sql .= " (LCASE(pd.name) LIKE '%" . $this->db->escape(strtolower($keyword)) . "%'";
						$sql .= " OR LCASE(p.model) LIKE '%" . $this->db->escape(strtolower($keyword)) . "%'";
						$sql .= " OR LCASE(p.sku) LIKE '%" . $this->db->escape(strtolower($keyword)) . "%')";
					}
					$sql .= " )";
				} else if ($match == 'all'){
					$sql .= " AND (";
					foreach ($keywords as $k => $keyword){
						$sql .= $k > 0 ? " AND" : "";
						$sql .= " (LCASE(pd.name) LIKE '%" . $this->db->escape(strtolower($keyword)) . "%'";
						$sql .= " OR LCASE(p.model) LIKE '%" . $this->db->escape(strtolower($keyword)) . "%'";
						$sql .= " OR LCASE(p.sku) LIKE '%" . $this->db->escape(strtolower($keyword)) . "%')";
					}
					$sql .= " )";
				} else if ($match == 'exact'){
					$sql .= " AND (LCASE(pd.name) LIKE '%" . $this->db->escape(strtolower($filter['keyword'])) . "%'";
					$sql .= " OR LCASE(p.model) LIKE '%" . $this->db->escape(strtolower($filter['keyword'])) . "%'";
					$sql .= " OR LCASE(p.sku) LIKE '%" . $this->db->escape(strtolower($filter['keyword'])) . "%')";
				}
			}

			if (isset($filter['pfrom']) && !is_null($filter['pfrom'])){
				$sql .= " AND p.price >= '" . (float)$filter['pfrom'] . "'";
			}
			if (isset($filter['pto']) && !is_null($filter['pto'])){
				$sql .= " AND p.price <= '" . (float)$filter['pto'] . "'";
			}
			if (isset($filter['category_id']) && !is_null($filter['category_id'])){
				$sql .= " AND p2c.category_id = '" . (int)$filter['category_id'] . "'";
			}
			if (isset($filter['manufacturer_id']) && !is_null($filter['manufacturer_id'])){
				$sql .= " AND p.manufacturer_id = '" . (int)$filter['manufacturer_id'] . "'";
			}

			if (isset($filter['status']) && !is_null($filter['status'])){
				$sql .= " AND p.status = '" . (int)$filter['status'] . "'";
			}

			//If for total, we done bulding the query
			if ($mode == 'total_only'){
				$query = $this->db->query($sql);
				return $query->row['total'];
			}

			$sort_data = array (
					'name'          => 'pd.name',
					'model'         => 'p.model',
					'quantity'      => 'p.quantity',
					'price'         => 'p.price',
					'status'        => 'p.status',
					'sort_order'    => 'p.sort_order',
					'date_modified' => 'p.date_modified',
					'review'        => 'review',
					'rating'        => 'rating'
			);

			if (isset($data['sort']) && in_array($data['sort'], array_keys($sort_data))){
				$sql .= " ORDER BY " . $sort_data[$data['sort']];
			} else{
				$sql .= " ORDER BY pd.name";
			}

			if (isset($data['order']) && ($data['order'] == 'DESC')){
				$sql .= " DESC";
			} else{
				$sql .= " ASC";
			}

			if (isset($data['start']) || isset($data['limit'])){
				if ($data['start'] < 0){
					$data['start'] = 0;
				}

				if ($data['limit'] < 1){
					$data['limit'] = 20;
				}

				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}
			$query = $this->db->query($sql);

			return $query->rows;
		} else{
			$product_data = $this->cache->get('product', $language_id);

			if (!$product_data){
				$query = $this->db->query("SELECT *
											FROM " . $this->db->table("products") . " p
											LEFT JOIN " . $this->db->table("product_descriptions") . " pd ON (p.product_id = pd.product_id)
											WHERE pd.language_id = '" . $language_id . "' AND p.date_available <= NOW() AND p.status = '1'
											ORDER BY pd.name ASC");
				$product_data = $query->rows;
				$this->cache->set('product', $product_data, $language_id);
			}

			return $product_data;
		}
	}

	/**
	 * @param array $data
	 * @return array|null
	 */
	public function getTotalProducts($data = array ()){
		return $this->getProducts($data, 'total_only');
	}

	/**
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getProductSpecials($sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 0){
		$limit = (int)$limit;
		$promoton = new APromotion();
		$results = $promoton->getProductSpecials($sort, $order, $start, $limit);

		return $results;
	}
	
	/**
	 * @param int $product_hour_id
	 * @return array
	 */
	public function getProductHour($product_hour_id){
		
		$sql = "SELECT * FROM " . $this->db->table("product_hours") . " WHERE product_hour_id = '" . (int)$product_hour_id . "'";
		$query = $this->db->query($sql);
		
		return $query->row;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductHours($product_id){
		$product_hours = array();
		
		$sql = "SELECT * FROM " . $this->db->table("product_hours") . " WHERE product_id = '" . (int)$product_id . "' ORDER BY general ASC, date_from ASC, month_from ASC, day_mon DESC, time_from ASC";
		$query = $this->db->query($sql);

		foreach($query->rows as $result){
			$product_hours[$result['product_hour_id']] = $result;
		}
		return $product_hours;
	}
	
	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductHoursDetail($product_id){
		$product_hours = $this->getProductHours($product_id);
		
		$hours = array();
		foreach ($product_hours as $hour) {
			$hours[$hour['product_hour_id']]['product_hour_id'] = $hour['product_hour_id'];
			
			//START - set Status
			switch ($hour['status']){
				case 0:
					$status = "Closed";
					break;
				case 1:
					$status = "Open";
					break;
				case 2:
					$status = "Temporary Closed";
					break;
			}
			$hours[$hour['product_hour_id']]['status'] = $status;
			//END
			
			//START - set Condition
			if($hour['general'] == 3) { //condition: specific date
				$hours[$hour['product_hour_id']]['date'] = $hour['date_from']." - ".$hour['date_to'];
			}
			else if($hour['general'] == 2) { //condition:specific month
				switch ($hour['month_from']){
					case 1:
						$month = "JAN";
						break;
					case 2:
						$month = "FEB";
						break;
					case 3:
						$month = "MAR";
						break;
					case 4:
						$month = "APR";
						break;
					case 5:
						$month = "MAY";
						break;
					case 6:
						$month = "JUN";
						break;
					case 7:
						$month = "JUL";
						break;
					case 8:
						$month = "AUG";
						break;
					case 9:
						$month = "SEP";
						break;
					case 10:
						$month = "OCT";
						break;
					case 11:
						$month = "NOV";
						break;
					case 12:
						$month = "DEC";
						break;
				}
				$month_from = $month;
				
				switch ($hour['month_to']){
					case 1:
						$month = "JAN";
						break;
					case 2:
						$month = "FEB";
						break;
					case 3:
						$month = "MAR";
						break;
					case 4:
						$month = "APR";
						break;
					case 5:
						$month = "MAY";
						break;
					case 6:
						$month = "JUN";
						break;
					case 7:
						$month = "JUL";
						break;
					case 8:
						$month = "AUG";
						break;
					case 9:
						$month = "SEP";
						break;
					case 10:
						$month = "OCT";
						break;
					case 11:
						$month = "NOV";
						break;
					case 12:
						$month = "DEC";
						break;
				}
				$month_to = $month;
				
				$month_eml_from = $hour['month_eml_from'];
				if($month_eml_from != '') { $month_eml_from .= " "; }
				
				$month_eml_to = $hour['month_eml_to'];
				if($month_eml_to != '') { $month_eml_to .= " "; }
				
				$hours[$hour['product_hour_id']]['date'] = $month_eml_from.$month_from." - ".$month_eml_to.$month_to;
			}
			else { //condition: none
				$hours[$hour['product_hour_id']]['date'] = "Normal";
			}
			//END
			
			//START - set Day
			$hours[$hour['product_hour_id']]['day'] = '';
			
			$count = 0;
			$cont = 0;
			if($hour['day_mon']==true) {
				if($hour['day_tue']==true) { //head of string
					$hours[$hour['product_hour_id']]['day'] .= 'Mon';
					$cont = 0;
				}
				else if($hour['day_tue']==false) { //Standalone
					$hours[$hour['product_hour_id']]['day'] .= 'Mon';
				}
				$count += 1;
			}
			if($hour['day_tue']==true) {
				$day_before = $hour['day_mon'];
				$day_after = $hour['day_wed'];
				$weekday = 'Tue';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_wed']==true) {
				$day_before = $hour['day_tue'];
				$day_after = $hour['day_thu'];
				$weekday = 'Wed';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_thu']==true) {
				$day_before = $hour['day_wed'];
				$day_after = $hour['day_fri'];
				$weekday = 'Thu';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_fri']==true) {
				$day_before = $hour['day_thu'];
				$day_after = $hour['day_sat'];
				$weekday = 'Fri';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_sat']==true) {
				$day_before = $hour['day_fri'];
				$day_after = $hour['day_sun'];
				$weekday = 'Sat';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_sun']==true) {
				$day_before = $hour['day_sat'];
				$weekday = 'Sun';
				if($day_before==true) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_holiday']==true) {
				$hours[$hour['product_hour_id']]['day'] .= ' &#38; Holiday';
			}
			
			if($hour['day_mon']==true && $hour['day_tue']==true && $hour['day_wed']==true && $hour['day_thu']==true && $hour['day_fri']==true && $hour['day_sat']==true && $hour['day_sun']==true && $hour['day_holiday']==true) { 
				$hours[$hour['product_hour_id']]['day'] = 'Everyday';
			}
			else if($hour['day_mon']==true && $hour['day_tue']==true && $hour['day_wed']==true && $hour['day_thu']==true && $hour['day_fri']==true && $hour['day_sat']==true && $hour['day_sun']==true && $hour['day_holiday']==false) { 
				$hours[$hour['product_hour_id']]['day'] = 'Everyday except Holiday';
			}
			else if($hour['day_mon']==true && $hour['day_tue']==true && $hour['day_wed']==true && $hour['day_thu']==true && $hour['day_fri']==true && $hour['day_sat']==false && $hour['day_sun']==false) { 
				$hours[$hour['product_hour_id']]['day'] = 'Weekday'; 
				if($hour['day_holiday']==true) { $hours[$hour['product_hour_id']]['day'] .= ' &#38; Holiday'; }
			}
			else if($hour['day_mon']==false && $hour['day_tue']==false && $hour['day_wed']==false && $hour['day_thu']==false && $hour['day_fri']==false && $hour['day_sat']==true && $hour['day_sun']==true) {
				$hours[$hour['product_hour_id']]['day'] = 'Sat, Sun';
				if($hour['day_holiday']==true) { $hours[$hour['product_hour_id']]['day'] .= ' &#38; Holiday'; }
			}
			//END
			
			//START - set Time
			$time_from = date('H:i',strtotime($hour['time_from']));
			$time_to = date('H:i',strtotime($hour['time_to']));
			$hours[$hour['product_hour_id']]['time'] = $time_from." - ".$time_to;
			if($hour['time_from'] =='00:00:00' && $hour['time_to'] == '00:00:00') { $hours[$hour['product_hour_id']]['time'] = '24 hours';}
			//END
			
			//START - set Description
			if($hour['description']) { $hours[$hour['product_hour_id']]['description'] = $hour['description']; }
			//END
		}
		
		return $hours;
	}
	
	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductHoursShort($product_id){
		$product_hours = $this->getProductHours($product_id);
		
		$hours = array();
		foreach ($product_hours as $hour) {
			$hours[$hour['product_hour_id']]['product_hour_id'] = $hour['product_hour_id'];
			if($hour['status'] != 1) { break; }
			
			//START - set Condition
			if($hour['general'] == 3) { //condition: specific date
				$hours[$hour['product_hour_id']]['date'] = $hour['date_from']." - ".$hour['date_to'];
			}
			else if($hour['general'] == 2) { //condition:specific month
				switch ($hour['month_from']){
					case 1:
						$month = "JAN";
						break;
					case 2:
						$month = "FEB";
						break;
					case 3:
						$month = "MAR";
						break;
					case 4:
						$month = "APR";
						break;
					case 5:
						$month = "MAY";
						break;
					case 6:
						$month = "JUN";
						break;
					case 7:
						$month = "JUL";
						break;
					case 8:
						$month = "AUG";
						break;
					case 9:
						$month = "SEP";
						break;
					case 10:
						$month = "OCT";
						break;
					case 11:
						$month = "NOV";
						break;
					case 12:
						$month = "DEC";
						break;
				}
				$month_from = $month;
				
				switch ($hour['month_to']){
					case 1:
						$month = "JAN";
						break;
					case 2:
						$month = "FEB";
						break;
					case 3:
						$month = "MAR";
						break;
					case 4:
						$month = "APR";
						break;
					case 5:
						$month = "MAY";
						break;
					case 6:
						$month = "JUN";
						break;
					case 7:
						$month = "JUL";
						break;
					case 8:
						$month = "AUG";
						break;
					case 9:
						$month = "SEP";
						break;
					case 10:
						$month = "OCT";
						break;
					case 11:
						$month = "NOV";
						break;
					case 12:
						$month = "DEC";
						break;
				}
				$month_to = $month;
				
				$month_eml_from = $hour['month_eml_from'];
				if($month_eml_from != '') { $month_eml_from .= " "; }
				
				$month_eml_to = $hour['month_eml_to'];
				if($month_eml_to != '') { $month_eml_to .= " "; }
				
				$hours[$hour['product_hour_id']]['date'] = $month_eml_from.$month_from." - ".$month_eml_to.$month_to;
			}
			else { //condition: none
			}
			//END
			
			//START - set Day
			$hours[$hour['product_hour_id']]['day'] = '';
			
			if($hour['day_mon']==true) { $hours[$hour['product_hour_id']]['day'] .= 'M'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_tue']==true) { $hours[$hour['product_hour_id']]['day'] .= 'T'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_wed']==true) { $hours[$hour['product_hour_id']]['day'] .= 'W'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_thu']==true) { $hours[$hour['product_hour_id']]['day'] .= 'T'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_fri']==true) { $hours[$hour['product_hour_id']]['day'] .= 'F'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_sat']==true) { $hours[$hour['product_hour_id']]['day'] .= 'S'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_sun']==true) { $hours[$hour['product_hour_id']]['day'] .= 'S'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_holiday']==true) { $hours[$hour['product_hour_id']]['day'] .= '*'; }
			//END
			
			//START - set Time
			$time_from = date('H:i',strtotime($hour['time_from']));
			$time_to = date('H:i',strtotime($hour['time_to']));
			$hours[$hour['product_hour_id']]['time'] = $time_from." - ".$time_to;
			if($hour['time_from'] =='00:00:00' && $hour['time_to'] == '00:00:00') { $hours[$hour['product_hour_id']]['time'] = '24 hours';}
			//END
			
			//START - set Description
			if($hour['description']) { $hours[$hour['product_hour_id']]['description'] = $hour['description'];
			}
			//END
			if($hours[$hour['product_hour_id']]['description']!=''){ $strings[$hour['product_hour_id']] .= $hours[$hour['product_hour_id']]['description']."&nbsp;&nbsp;&nbsp;";}
			if($hours[$hour['product_hour_id']]['date']!=''){ $strings[$hour['product_hour_id']] .= $hours[$hour['product_hour_id']]['date']."&nbsp;&nbsp;&nbsp;";}
			if($hours[$hour['product_hour_id']]['day']!=''){ $strings[$hour['product_hour_id']] .= $hours[$hour['product_hour_id']]['day']."&nbsp;&nbsp;&nbsp;";}
			if($hours[$hour['product_hour_id']]['time']!=''){ $strings[$hour['product_hour_id']] .= $hours[$hour['product_hour_id']]['time']."&nbsp;&nbsp;&nbsp;";}
		}
		
		return $strings;
	}
	
	/**
	 * @param int $product_price_id
	 * @return array
	 */
	public function getProductPrice($product_price_id){
		
		$sql = "SELECT * FROM " . $this->db->table("product_prices") . " WHERE product_price_id = '" . (int)$product_price_id . "'";
		$query = $this->db->query($sql);
		
		return $query->row;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductPrices($product_id){
		$product_prices = array();
		
		$sql = "SELECT * FROM " . $this->db->table("product_prices") . " WHERE product_id = '" . (int)$product_id . "' ORDER BY amount DESC";
		$query = $this->db->query($sql);

		foreach($query->rows as $result){
			$product_prices[$result['product_price_id']] = $result;
		}
		return $product_prices;
	}
	
	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductPricesDetail($product_id){
		$product_prices = $this->getProductPrices($product_id);
		
		$prices = array();
		foreach ($product_prices as $price) {
			$prices[$price['product_price_id']]['product_price_id'] = $price['product_price_id'];
			$prices[$price['product_price_id']]['name'] = $price['name'];
			
			if($price['amount'] > 0 ) {
				$prices[$price['product_price_id']]['amount'] = $this->currency->format($price['amount'],$price['currency_code'])."&nbsp;per&nbsp;".$price['unit'];
			}
			else {
				$prices[$price['product_price_id']]['amount'] = "Free";
			}
			
			$count = 0;
			//START - set Condition
			if($price['product_hour_id'] != 0) {
				if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
				$prices[$price['product_price_id']]['condition'] .= "<i class='fa fa-clock-o'></i>";
				$count += 1;
			}
			
			switch ($price['gender']){
				case 'M':
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "<i class='fa fa-mars' title='Male'></i>";
					$count += 1;
					break;
				case 'F':
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "<i class='fa fa-venus' title='Female'></i>";
					$count += 1;
					break;
			}
			
			switch ($price['age']){
				case 1:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "&#8805;".$price['min_age']." age";
					$count += 1;
					break;
				case 2:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "&#8804;".$price['max_age']." age";
					$count += 1;
					break;
				case 3:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= $price['min_age']." ~ ".$price['max_age']." age";
					$count += 1;
					break;
			}
			
			switch ($price['pax']){
				case 1:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "&#8805;".$price['min_pax']." pax";
					$count += 1;
					break;
				case 2:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "&#8804;".$price['max_pax']." pax";
					$count += 1;
					break;
				case 3:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= $price['min_pax']." ~ ".$price['max_pax']." pax";
					$count += 1;
					break;
			}
			
			if($price['duration'] != 0) {
				if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
				$prices[$price['product_price_id']]['condition'] .= $price['duration']."&nbsp;".$price['duration_unit'];
				$count += 1;
			}
			
			if($price['early_booking'] != 0) {
				if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
				$prices[$price['product_price_id']]['condition'] .= $price['early_booking']." days before visit";
				$count += 1;
			}
			//END
		}
		
		return $prices;
	}
	
	//2016/03/29 ADDED by TREVOL
	public function searchProductsByKeyword($keyword){
		if ($keyword){
			$sql = "SELECT * FROM ".$this->db->table("products")." c LEFT JOIN " . $this->db->table("product_descriptions") . " cd ON (c.product_id = cd.product_id) LEFT JOIN " . $this->db->table("products_to_categories") . " cds ON (c.product_id = cds.product_id) WHERE c.status = '1' AND cd.name LIKE '%".$keyword."%'";
			$query = $this->db->query($sql);
			
			$products = array ();
			if ($query->num_rows){
				foreach ($query->rows as $value){
					$products[$value['product_id']] = $value;
				}
			}
			
			return $products;

		} else{
			return array ();
		}
	}
}
