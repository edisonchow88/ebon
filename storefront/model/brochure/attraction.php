<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL, 2016/01/15
------------------------------------------------------------------------------*/
if (!defined('DIR_CORE')){
	header('Location: static_pages/');
}

/** @noinspection PhpUndefinedClassInspection */
class ModelBrochureAttraction extends Model{
	/**
	 * @param int $attraction_id
	 * @return array
	 */
	public function getAttraction($attraction_id){
		if (!(int)$attraction_id){
			return array ();
		}
		$query = $this->db->query(
				"SELECT DISTINCT *,
						pd.name AS name,
						m.name AS provider,
						ss.name AS stock_status,
						lcd.unit as length_class_name, " .
				$this->_sql_avg_rating_string() . ", " .
				$this->_sql_final_price_string() . " " .
				$this->_sql_join_string() .
				" LEFT JOIN " . $this->db->table("length_class_descriptions") . " lcd
									ON (p.length_class_id = lcd.length_class_id
										AND lcd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
				WHERE p.attraction_id = '" . (int)$attraction_id . "'
						AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
						AND p.date_available <= NOW() AND p.status = '1'");
		return $query->row;
	}

	/**
	 * Check if attraction or any option value require tracking stock subtract = 1
	 * @param int $attraction_id
	 * @return int
	 */
	public function isStockTrackable($attraction_id){
		if (!(int)$attraction_id){
			return 0;
		}
		//check main attraction
		$query = $this->db->query("SELECT subtract
									FROM " . $this->db->table("attractions") . " p
									WHERE p.attraction_id = '" . (int)$attraction_id . "'");

		$track_status = (int)$query->row['subtract'];
		//check attraction option values
		$query = $this->db->query("SELECT pov.subtract AS subtract
									FROM " . $this->db->table("attraction_options") . " po
									LEFT JOIN " . $this->db->table("attraction_option_values") . " pov
										ON (po.attraction_option_id = pov.attraction_option_id)
									WHERE po.attraction_id = '" . (int)$attraction_id . "'");

		foreach ($query->rows as $row){
			$track_status += $row['subtract'];
		}
		return $track_status;
	}

	/**
	 *
	 * Check if attraction or any option has any stock available
	 * @param int $attraction_id
	 * @return int
	 */
	public function hasAnyStock($attraction_id){
		if (!(int)$attraction_id){
			return 0;
		}
		//check main attraction
		$query = $this->db->query("SELECT quantity
									FROM " . $this->db->table("attractions") . " p
									WHERE p.attraction_id = '" . (int)$attraction_id . "'");

		$total_quantity = (int)$query->row['quantity'];
		//check attraction option values
		$query = $this->db->query("SELECT pov.quantity AS quantity
									FROM " . $this->db->table("attraction_options") . " po
									LEFT JOIN " . $this->db->table("attraction_option_values") . " pov
										ON (po.attraction_option_id = pov.attraction_option_id)
									WHERE po.attraction_id = '" . (int)$attraction_id . "'");
		foreach ($query->rows as $row){
			$total_quantity += $row['quantity'];
		}
		return $total_quantity;
	}

	public function getAttractionDataForCart($attraction_id){
		if (!(int)$attraction_id){
			return array ();
		}
		$query = $this->db->query(
				"SELECT *, wcd.unit AS weight_class, mcd.unit AS length_class
                FROM " . $this->db->table("attractions") . " p
                LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd
                    ON (p.attraction_id = pd.attraction_id
                            AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
                LEFT JOIN " . $this->db->table("weight_classes") . " wc ON (p.weight_class_id = wc.weight_class_id)
                LEFT JOIN " . $this->db->table("weight_class_descriptions") . " wcd
                    ON (wc.weight_class_id = wcd.weight_class_id
                            AND wcd.language_id = '" . (int)$this->config->get('storefront_language_id') . "' )
                LEFT JOIN " . $this->db->table("length_classes") . " mc ON (p.length_class_id = mc.length_class_id)
                LEFT JOIN " . $this->db->table("length_class_descriptions") . " mcd ON (mc.length_class_id = mcd.length_class_id)
                WHERE p.attraction_id = '" . (int)$attraction_id . "' AND p.date_available <= NOW() AND p.status = '1'");

		return $query->row;
	}

	/**
	 * @param int $destination_id
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getAttractionsByDestinationId($destination_id, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20){
		$sql = "SELECT *,
						p.attraction_id,
						" . $this->_sql_final_price_string() . ",
						pd.name AS name, 
						pd.blurb,
						m.name AS provider,
						ss.name AS stock,
						" . $this->_sql_avg_rating_string() . ",
						" . $this->_sql_review_count_string() . "
		" . $this->_sql_join_string() . "
		LEFT JOIN " . $this->db->table("attractions_to_destinations") . " p2c
			ON (p.attraction_id = p2c.attraction_id)
		WHERE p.status = '1' AND p.date_available <= NOW()
				AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
				AND p2c.destination_id = '" . (int)$destination_id . "'";

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
	 * @param int $destination_id
	 * @return int
	 */
	public function getTotalAttractionsByDestinationId($destination_id = 0){
		$query = $this->db->query("SELECT COUNT(*) AS total
									FROM " . $this->db->table("attractions_to_destinations") . " p2c
									LEFT JOIN " . $this->db->table("attractions") . " p ON (p2c.attraction_id = p.attraction_id)
									LEFT JOIN " . $this->db->table("attractions_to_stores") . " p2s ON (p.attraction_id = p2s.attraction_id)
									WHERE p.status = '1' AND p.date_available <= NOW()
										AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
										AND p2c.destination_id = '" . (int)$destination_id . "'");

		return $query->row['total'];
	}

	/**
	 * @param int $provider_id
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getAttractionsByProviderId($provider_id, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20){
		if (!(int)$provider_id){
			return array ();
		}
		$sql = "SELECT *, p.attraction_id,
						" . $this->_sql_final_price_string() . ",
						pd.name AS name, 
						pd.blurb,
						m.name AS provider,
						ss.name AS stock,
						" . $this->_sql_avg_rating_string() . ",
						" . $this->_sql_review_count_string() . "
		" . $this->_sql_join_string() . "
		WHERE p.status = '1' AND p.date_available <= NOW()
			AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
			AND m.provider_id = '" . (int)$provider_id . "'";

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
	 * @param int $provider_id
	 * @return int
	 */
	public function getTotalAttractionsByProviderId($provider_id = 0){
		$query = $this->db->query("SELECT COUNT(*) AS total
									FROM " . $this->db->table("attractions") . "
									WHERE status = '1'
											AND date_available <= NOW()
											AND provider_id = '" . (int)$provider_id . "'");

		return $query->row['total'];
	}

	/**
	 * @param string $tag
	 * @param int $destination_id
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getAttractionsByTag($tag, $destination_id = 0, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20){
		if ($tag){
			$sql = "SELECT *, p.attraction_id,
							" . $this->_sql_final_price_string() . ",
							pd.name AS name, 
							m.name AS provider, 
							ss.name AS stock,
							" . $this->_sql_avg_rating_string() . ",
							" . $this->_sql_review_count_string() . "
					" . $this->_sql_join_string() . "
					LEFT JOIN " . $this->db->table("attraction_tags") . " pt ON (p.attraction_id = pt.attraction_id AND pt.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					WHERE p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
						AND (LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($tag)) . "'";

			$keywords = explode(" ", $tag);

			foreach ($keywords as $keyword){
				$sql .= " OR LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($keyword)) . "'";
			}

			$sql .= ")";

			if ($destination_id){
				$data = array ();

				foreach (explode(',', $destination_id) as $destination_id){
					$data[] = "'" . (int)$destination_id . "'";
				}

				$sql .= " AND p.attraction_id IN (SELECT attraction_id
												FROM " . $this->db->table("attractions_to_destinations") . "
												WHERE destination_id IN (" . implode(",", $data) . "))";
			}

			$sql .= " AND p.status = '1' AND p.date_available <= NOW() GROUP BY p.attraction_id";

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

			$attractions = array ();

			foreach ($query->rows as $value){
				$attractions[$value['attraction_id']] = $this->getAttraction($value['attraction_id']);
			}

			return $attractions;
		}
		return array ();
	}

	/**
	 * @param string $keyword
	 * @param int $destination_id
	 * @param bool $description
	 * @param bool $model
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getAttractionsByKeyword($keyword, $destination_id = 0, $description = false, $model = false, $sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 20){
		if ($keyword){
			$sql = "SELECT  *,
							p.attraction_id,  
							" . $this->_sql_final_price_string() . ",
							pd.name AS name, 
							pd.blurb,
							m.name AS provider,
							ss.name AS stock,
							" . $this->_sql_avg_rating_string() . ",
							" . $this->_sql_review_count_string() . "
			" . $this->_sql_join_string() . "
		    LEFT JOIN " . $this->db->table("attraction_tags") . " pt ON (p.attraction_id = pt.attraction_id)
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

			if ($destination_id){
				$data = array ();

				$this->load->model('brochure/destination');
				$string = rtrim($this->getPath($destination_id), ',');
				$destination_ids = explode(',', $string);

				foreach ($destination_ids as $destination_id){
					$data[] = "'" . (int)$destination_id . "'";
				}

				$sql .= " AND p.attraction_id IN (SELECT attraction_id
												FROM " . $this->db->table("attractions_to_destinations") . "
												WHERE destination_id IN (" . implode(", ", $data) . "))";
			}

			$sql .= " AND p.status = '1' AND p.date_available <= NOW()
					 GROUP BY p.attraction_id";

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
			$attractions = array ();
			if ($query->num_rows){
				foreach ($query->rows as $value){
					$attractions[$value['attraction_id']] = $value;
				}
			}
			return $attractions;

		} else{
			return array ();
		}
	}

	/**
	 * @param string $keyword
	 * @param int $destination_id
	 * @param bool $description
	 * @param bool $model
	 * @return int
	 */
	public function getTotalAttractionsByKeyword($keyword, $destination_id = 0, $description = false, $model = false){
		$keyword = trim($keyword);
		if ($keyword){
			$sql = "SELECT COUNT( DISTINCT p.attraction_id ) AS total
					FROM " . $this->db->table("attractions") . " p
					LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd
								ON (p.attraction_id = pd.attraction_id AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					LEFT JOIN " . $this->db->table("attractions_to_stores") . " p2s
								ON (p.attraction_id = p2s.attraction_id)
					LEFT JOIN " . $this->db->table("attraction_tags") . " pt ON (p.attraction_id = pt.attraction_id)
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

			if ($destination_id){
				$data = array ();

				$this->load->model('brochure/destination');

				$string = rtrim($this->getPath($destination_id), ',');
				$destination_ids = explode(',', $string);

				foreach ($destination_ids as $destination_id){
					$data[] = "destination_id = '" . (int)$destination_id . "'";
				}

				$sql .= " AND p.attraction_id IN (SELECT attraction_id FROM " . $this->db->table("attractions_to_destinations") . " WHERE " . implode(" OR ", $data) . ")";
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
	 * @param int $destination_id
	 * @return int
	 */
	public function getTotalAttractionsByTag($tag, $destination_id = 0){
		$tag = trim($tag);
		if ($tag){

			$sql = "SELECT COUNT(DISTINCT p.attraction_id) AS total
					FROM " . $this->db->table("attractions") . " p
					LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd ON (p.attraction_id = pd.attraction_id AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					LEFT JOIN " . $this->db->table("attraction_tags") . " pt ON (p.attraction_id = pt.attraction_id AND pt.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					LEFT JOIN " . $this->db->table("attractions_to_stores") . " p2s ON (p.attraction_id = p2s.attraction_id)
					LEFT JOIN " . $this->db->table("providers") . " m ON (p.provider_id = m.provider_id)
					LEFT JOIN " . $this->db->table("stock_statuses") . " ss ON (p.stock_status_id = ss.stock_status_id AND ss.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					WHERE p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
						AND (LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($tag)) . "'";

			$keywords = explode(" ", $tag);

			foreach ($keywords as $keyword){
				$sql .= " OR LCASE(pt.tag) = '" . $this->db->escape(mb_strtolower($keyword)) . "'";
			}

			$sql .= ")";

			if ($destination_id){
				$data = array ();

				$this->load->model('brochure/destination');

				$string = rtrim($this->getPath($destination_id), ',');
				$destination_ids = explode(',', $string);

				foreach ($destination_ids as $destination_id){
					$data[] = "destination_id = '" . (int)$destination_id . "'";
				}
				$sql .= " AND p.attraction_id IN (SELECT attraction_id FROM " . $this->db->table("attractions_to_destinations") . " WHERE " . implode(" OR ", $data) . ")";
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
	 * @param int $destination_id
	 * @return string
	 */
	public function getPath($destination_id){
		$string = $destination_id . ',';

		$results = $this->model_brochure_destination->getDestinations((int)$destination_id);

		foreach ($results as $result){
			$string .= $this->getPath($result['destination_id']);
		}

		return $string;
	}

	/**
	 * @param int $limit
	 * @return array
	 */
	public function getLatestAttractions($limit){
		$cache = $this->cache->get('attraction.latest.' . $limit, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		if (is_null($cache)){
			$sql = "SELECT *,
					pd.name AS name,
					m.name AS provider,
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
			$this->cache->set('attraction.latest.' . $limit, $cache, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		}

		return $cache;
	}

	/**
	 * @param int $limit
	 * @return array
	 */
	public function getPopularAttractions($limit = 0){

		$sql = "SELECT *,
						pd.name AS name,
						m.name AS provider,
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
	public function getFeaturedAttractions($limit){
		$attraction_data = $this->cache->get('attraction.featured.' . $limit, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		if (is_null($attraction_data)){
			$sql = "SELECT f.*, pd.*, ss.name AS stock, p.*
					FROM " . $this->db->table("attractions_featured") . " f
					LEFT JOIN " . $this->db->table("attractions") . " p ON (f.attraction_id = p.attraction_id)
					LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd ON (f.attraction_id = pd.attraction_id AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					LEFT JOIN " . $this->db->table("attractions_to_stores") . " p2s ON (p.attraction_id = p2s.attraction_id)
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
			$attraction_data = $query->rows;
			$this->cache->set('attraction.featured.' . $limit, $attraction_data, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		}
		return $attraction_data;
	}

	/**
	 * @param $limit
	 * @return array
	 */
	public function getBestSellerAttractions($limit){
		$attraction_data = $this->cache->get('attraction.bestseller.' . $limit, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));

		if (is_null($attraction_data)){
			$attraction_data = array ();

			$sql = "SELECT op.attraction_id, SUM(op.quantity) AS total
					FROM " . $this->db->table("order_attractions") . " op
					LEFT JOIN `" . $this->db->table("orders") . "` o ON (op.order_id = o.order_id)
					LEFT JOIN " . $this->db->table("attractions") . " p ON p.attraction_id = op.attraction_id
					WHERE o.order_status_id > '0' AND p.status = '1' AND p.date_available <= NOW()
					GROUP BY op.attraction_id
					ORDER BY total DESC";
			if ((int)$limit){
				$sql .= " LIMIT " . (int)$limit;
			}
			$query = $this->db->query($sql);


			if ($query->num_rows){
				$attractions = array ();
				foreach ($query->rows as $result){
					$attractions[] = (int)$result['attraction_id'];
				}

				if ($attractions){
					$sql = "SELECT pd.*, ss.name AS stock, p.*
							FROM " . $this->db->table("attractions") . " p
							LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd ON (p.attraction_id = pd.attraction_id AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
							LEFT JOIN " . $this->db->table("attractions_to_stores") . " p2s ON (p.attraction_id = p2s.attraction_id)
							LEFT JOIN " . $this->db->table("stock_statuses") . " ss
								ON (p.stock_status_id = ss.stock_status_id
									AND ss.language_id = '" . (int)$this->config->get('storefront_language_id') . "') 
							WHERE p.attraction_id IN (" . implode(', ', $attractions) . ")
								AND p.status = '1' AND p.date_available <= NOW()
								AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'";
					$attraction_query = $this->db->query($sql);

					if ($attraction_query->num_rows){
						foreach ($attraction_query->rows as $result){
							$data[$result['attraction_id']] = $result;
						}
						// resort by totals
						foreach ($attractions as $id){
							if (isset($data[$id])){
								$attraction_data[] = $data[$id];
							}
						}
					}
				}
			}

			$this->cache->set('attraction.bestseller.' . $limit, $attraction_data, $this->config->get('storefront_language_id'), (int)$this->config->get('config_store_id'));
		}

		return $attraction_data;
	}

	/**
	 * @param int $attraction_id
	 * @return null
	 */
	public function updateViewed($attraction_id){
		if (empty($attraction_id)){
			return null;
		}
		$this->db->query("UPDATE " . $this->db->table("attractions") . "
						  SET viewed = viewed + 1
						  WHERE attraction_id = '" . (int)$attraction_id . "'");
	}

	/**
	 * @param int $attraction_id
	 * @param int $status
	 * @return null
	 */
	public function updateStatus($attraction_id, $status = 0){
		if (empty($attraction_id)){
			return null;
		}
		$this->db->query("UPDATE " . $this->db->table("attractions") . "
						SET status = " . (int)$status . "
						WHERE attraction_id = '" . (int)$attraction_id . "'");
		$this->cache->delete('attraction');
	}

	/**
	 * check if attraction option is group option
	 * if yes, return array of possible groups for option_value_id
	 *
	 * @param $attraction_id
	 * @param $option_id
	 * @param $option_value_id
	 * @return array
	 */
	public function getAttractionGroupOptions($attraction_id, $option_id, $option_value_id){
		if (empty($attraction_id) || empty($option_id)){
			return array ();
		}
		$attraction_option = $this->db->query(
				"SELECT group_id FROM " . $this->db->table("attraction_options") . "
			WHERE attraction_id = '" . (int)$attraction_id . "'
				AND attraction_option_id = '" . (int)$option_id . "' ");
		if (!$attraction_option->row['group_id']){
			return array ();
		}
		//get all option values of group
		$option_values = $this->db->query(
				"SELECT pov.*, povd.name
			 FROM " . $this->db->table("attraction_options") . " po
			 LEFT JOIN " . $this->db->table("attraction_option_values") . " pov ON (po.attraction_option_id = pov.attraction_option_id)
			 LEFT JOIN  " . $this->db->table("attraction_option_value_descriptions") . " povd
					ON (pov.attraction_option_value_id = povd.attraction_option_value_id AND povd.language_id = '" . (int)$this->config->get('storefront_language_id') . "' )
			 WHERE po.group_id = '" . (int)$attraction_option->row['group_id'] . "'
			 ORDER BY pov.sort_order ");

		//find attribute_value_id of option_value
		//find all option values with attribute_value_id
		//for each option values find group id
		//add each group values to result array
		$result = array ();
		$attribute_value_id = null;
		foreach ($option_values->rows as $row){
			if ($row['attraction_option_value_id'] == $option_value_id){
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
				if ($row['group_id'] == $group_id && $row['attraction_option_id'] != $option_id){
					$result[$row['attraction_option_id']][$row['attraction_option_value_id']] = array (
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
	 * @param int $attraction_id
	 * @return array
	 */
	public function getAttractionOptions($attraction_id){
		if (!(int)$attraction_id){
			return array ();
		}
		$language_id = (int)$this->config->get('storefront_language_id');
		$attraction_option_data = $this->cache->get('attraction.options.' . $attraction_id, $language_id);
		$elements = HtmlElementFactory::getAvailableElements();
		if (is_null($attraction_option_data)){
			$attraction_option_data = array ();
			$attraction_option_query = $this->db->query(
					"SELECT po.*, pod.option_placeholder, pod.error_text
                FROM " . $this->db->table("attraction_options") . " po
                LEFT JOIN " . $this->db->table("attraction_option_descriptions") . " pod
                	ON pod.attraction_option_id = po.attraction_option_id AND pod.language_id =  '" . $language_id . "'
                WHERE po.attraction_id = '" . (int)$attraction_id . "'
                    AND po.group_id = 0
                    AND po.status = 1
                ORDER BY po.sort_order"
			);
			if ($attraction_option_query){
				foreach ($attraction_option_query->rows as $attraction_option){

					$attribute_values = array ();
					$attraction_option_value_data = array ();
					$attraction_option_value_query = $this->db->query(
							"SELECT *
                            FROM " . $this->db->table("attraction_option_values") . "
                            WHERE attraction_option_id = '" . (int)$attraction_option['attraction_option_id'] . "'
                            ORDER BY sort_order"
					);
					if ($attraction_option_value_query){
						foreach ($attraction_option_value_query->rows as $attraction_option_value){
							if ($attraction_option_value['attribute_value_id']){
								//skip duplicate attributes values if it is not grouped parent/child
								if (in_array($attraction_option_value['attribute_value_id'], $attribute_values)){
									continue;
								}
								$attribute_values[] = $attraction_option_value['attribute_value_id'];
							}
							$pd_opt_val_description_qr = $this->db->query(
									"SELECT *
                                    FROM " . $this->db->table("attraction_option_value_descriptions") . "
                                    WHERE attraction_option_value_id = '" . (int)$attraction_option_value['attraction_option_value_id'] . "'
                                    AND language_id = '" . (int)$language_id . "'"
							);

							// ignore option value with 0 quantity and disabled subtract
							if ((!$attraction_option_value['subtract'])
									|| (!$this->config->get('config_nostock_autodisable'))
									|| ($attraction_option_value['quantity'] && $attraction_option_value['subtract'])
							){
								$attraction_option_value_data[$attraction_option_value['attraction_option_value_id']] = array (
										'attraction_option_value_id' => $attraction_option_value['attraction_option_value_id'],
										'attribute_value_id'      => $attraction_option_value['attribute_value_id'],
										'grouped_attribute_data'  => $attraction_option_value['grouped_attribute_data'],
										'group_id'                => $attraction_option_value['group_id'],
										'name'                    => $pd_opt_val_description_qr->row['name'],
										'option_placeholder'      => $attraction_option['option_placeholder'],
										'regexp_pattern'          => $attraction_option['regexp_pattern'],
										'error_text'              => $attraction_option['error_text'],
										'settings'                => $attraction_option['settings'],
										'children_options_names'  => $pd_opt_val_description_qr->row['children_options_names'],
										'sku'                     => $attraction_option_value['sku'],
										'price'                   => $attraction_option_value['price'],
										'prefix'                  => $attraction_option_value['prefix'],
										'weight'                  => $attraction_option_value['weight'],
										'weight_type'             => $attraction_option_value['weight_type'],
										'quantity'                => $attraction_option_value['quantity'],
										'subtract'                => $attraction_option_value['subtract'],
										'default'                 => $attraction_option_value['default'],
								);
							}
						}
					}
					$prd_opt_description_qr = $this->db->query(
							"SELECT *
                        FROM " . $this->db->table("attraction_option_descriptions") . "
                        WHERE attraction_option_id = '" . (int)$attraction_option['attraction_option_id'] . "'
                            AND language_id = '" . (int)$language_id . "'"
					);

					$attraction_option_data[$attraction_option['attraction_option_id']] = array (
							'attraction_option_id'  => $attraction_option['attraction_option_id'],
							'attribute_id'       => $attraction_option['attribute_id'],
							'group_id'           => $attraction_option['group_id'],
							'name'               => $prd_opt_description_qr->row['name'],
							'option_placeholder' => $attraction_option['option_placeholder'],
							'option_value'       => $attraction_option_value_data,
							'sort_order'         => $attraction_option['sort_order'],
							'element_type'       => $attraction_option['element_type'],
							'html_type'          => $elements[$attraction_option['element_type']]['type'],
							'required'           => $attraction_option['required'],
							'regexp_pattern'     => $attraction_option['regexp_pattern'],
							'error_text'         => $attraction_option['error_text'],
							'settings'           => $attraction_option['settings'],
					);
				}
			}

			$this->cache->set('attraction.options.' . $attraction_id, $attraction_option_data, $language_id);
		}
		return $attraction_option_data;
	}

	/**
	 * @param int $attraction_id
	 * @param int $attraction_option_id
	 * @return array
	 */
	public function getAttractionOption($attraction_id, $attraction_option_id){
		if (!(int)$attraction_id || !(int)$attraction_option_id){
			return array ();
		}

		$query = $this->db->query("SELECT *
						FROM " . $this->db->table("attraction_options") . " po
						LEFT JOIN " . $this->db->table("attraction_option_descriptions") . " pod ON (po.attraction_option_id = pod.attraction_option_id)
						WHERE po.attraction_option_id = '" . (int)$attraction_option_id . "'
							AND po.attraction_id = '" . (int)$attraction_id . "'
							AND pod.language_id = '" . (int)$this->config->get('storefront_language_id') . "'
						ORDER BY po.sort_order");
		return $query->row;
	}

	/**
	 * @param $attraction_id
	 * @param $attraction_option_id
	 * @return array
	 */
	public function getAttractionOptionValues($attraction_id, $attraction_option_id){
		if (!(int)$attraction_id || !(int)$attraction_option_id){
			return array ();
		}
		$query = $this->db->query(
				"SELECT *
                 FROM " . $this->db->table("attraction_option_values") . " pov
                 WHERE pov.attraction_option_id = '" . (int)$attraction_option_id . "'
                    AND pov.attraction_id = '" . (int)$attraction_id . "'
                 ORDER BY pov.sort_order");
		return $query->rows;
	}

	/**
	 * @param int $attraction_id
	 * @param int $attraction_option_value_id
	 * @return array
	 */
	public function getAttractionOptionValue($attraction_id, $attraction_option_value_id){
		if (!(int)$attraction_id || !(int)$attraction_option_value_id){
			return array ();
		}

		$query = $this->db->query(
				"SELECT *, COALESCE(povd.name,povd2.name) as name
                FROM " . $this->db->table("attraction_option_values") . " pov
                LEFT JOIN " . $this->db->table("attraction_option_value_descriptions") . " povd
                        ON (pov.attraction_option_value_id = povd.attraction_option_value_id
                                AND povd.language_id = '" . (int)$this->config->get('storefront_language_id') . "' )
                LEFT JOIN " . $this->db->table("attraction_option_value_descriptions") . " povd2
                        ON (pov.attraction_option_value_id = povd2.attraction_option_value_id
                                AND povd2.language_id = '1' )
                WHERE pov.attraction_option_value_id = '" . (int)$attraction_option_value_id . "'
                    AND pov.attraction_id = '" . (int)$attraction_id . "'
                ORDER BY pov.sort_order");
		return $query->row;
	}


	/**
	 * Check if any of inputed options are required and provided
	 * @param int $attraction_id
	 * @param array $input_options
	 * @return array
	 */
	public function validateAttractionOptions($attraction_id, $input_options){

		$errors = array ();
		if (empty($attraction_id) && empty($input_options)){
			return array ();
		}
		$attraction_options = $this->getAttractionOptions($attraction_id);
		if (is_array($attraction_options) && $attraction_options){
			foreach ($attraction_options as $option){

				if ($option['required']){
					if (empty($input_options[$option['attraction_option_id']])){
						$errors[] = $option['name'] . ': ' . $this->language->get('error_required_options');
					}
				}

				if ($option['regexp_pattern'] && !preg_match($option['regexp_pattern'], (string)$input_options[$option['attraction_option_id']])){
					$errors[] = $option['name'] . ': ' . $option['error_text'];
				}

			}
		}

		return $errors;
	}

	/**
	 * @param int $attraction_id
	 * @return array
	 */
	public function getAttractionTags($attraction_id){
		if (!(int)$attraction_id){
			return array ();
		}
		$query = $this->db->query("SELECT *
									FROM " . $this->db->table("attraction_tags") . "
									WHERE attraction_id = '" . (int)$attraction_id . "'
											AND language_id = '" . (int)$this->config->get('storefront_language_id') . "'");

		return $query->rows;
	}

	/**
	 * @param int $attraction_id
	 * @return array
	 */
	public function getAttractionDownloads($attraction_id){
		if (!(int)$attraction_id){
			return array ();
		}

		$query = $this->db->query(
				"SELECT *
					 FROM " . $this->db->table("attractions_to_downloads") . " p2d
					 LEFT JOIN " . $this->db->table("downloads") . " d ON (p2d.download_id = d.download_id)
					 LEFT JOIN " . $this->db->table("download_descriptions") . " dd
					 	ON (d.download_id = dd.download_id
					 			AND dd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
					 WHERE p2d.attraction_id = '" . (int)$attraction_id . "'");

		return $query->rows;
	}

	/**
	 * @param int $attraction_id
	 * @return array
	 */
	public function getAttractionRelated($attraction_id){
		$attraction_data = array ();
		if (!(int)$attraction_id){
			return array ();
		}

		$attraction_related_query = $this->db->query(
				"SELECT *
				 FROM " . $this->db->table("attractions_related") . "
				 WHERE attraction_id = '" . (int)$attraction_id . "'");

		foreach ($attraction_related_query->rows as $result){
			$attraction_query = $this->db->query(
					"SELECT DISTINCT *,
							pd.name AS name,
							m.name AS provider,
							ss.name AS stock,
							" . $this->_sql_avg_rating_string() . ", " .
					$this->_sql_review_count_string() .
					$this->_sql_join_string() . "
					WHERE p.attraction_id = '" . (int)$result['related_id'] . "'
						AND p2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
						AND p.date_available <= NOW() AND p.status = '1'");

			if ($attraction_query->num_rows){
				$attraction_data[$result['related_id']] = $attraction_query->row;
			}
		}

		return $attraction_data;
	}

	/**
	 * @param int $attraction_id
	 * @return array
	 */
	public function getDestinations($attraction_id){
		if (!(int)$attraction_id){
			return array ();
		}
		$query = $this->db->query("SELECT *
									FROM " . $this->db->table("attractions_to_destinations") . "
									WHERE attraction_id = '" . (int)$attraction_id . "'");
		return $query->rows;
	}

	private function _sql_avg_rating_string(){
		$sql = " ( SELECT AVG(r.rating)
						 FROM " . $this->db->table("reviews") . " r
						 WHERE p.attraction_id = r.attraction_id
						 GROUP BY r.attraction_id 
				 ) AS rating ";
		return $sql;
	}

	private function _sql_review_count_string(){
		$sql = " ( SELECT COUNT(rw.review_id)
						 FROM " . $this->db->table("reviews") . " rw
						 WHERE p.attraction_id = rw.attraction_id
						 GROUP BY rw.attraction_id
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
					FROM " . $this->db->table("attraction_specials") . " p2sp
					WHERE p2sp.attraction_id = p.attraction_id
							AND p2sp.customer_group_id = '" . $customer_group_id . "'
							AND ((p2sp.date_start = '0000-00-00' OR p2sp.date_start < NOW())
							AND (p2sp.date_end = '0000-00-00' OR p2sp.date_end > NOW()))
					ORDER BY p2sp.priority ASC, p2sp.price ASC LIMIT 1
				 ) ";
		$sql = "COALESCE( " . $sql . ", p.price) as final_price";

		return $sql;
	}

	private function _sql_join_string(){

		return "FROM " . $this->db->table("attractions") . " p
				LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd
					ON (p.attraction_id = pd.attraction_id
							AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "')
				LEFT JOIN " . $this->db->table("attractions_to_stores") . " p2s ON (p.attraction_id = p2s.attraction_id)
				LEFT JOIN " . $this->db->table("providers") . " m ON (p.provider_id = m.provider_id)
				LEFT JOIN " . $this->db->table("stock_statuses") . " ss
						ON (p.stock_status_id = ss.stock_status_id
								AND ss.language_id = '" . (int)$this->config->get('storefront_language_id') . "')";
	}


	public function getAttractionsAllInfo($attractions = array ()){
		if (!$attractions) return false;

		//special prices
		if ($this->customer->isLogged()){
			$customer_group_id = (int)$this->customer->getCustomerGroupId();
		} else{
			$customer_group_id = (int)$this->config->get('config_customer_group_id');
		}
		$language_id = (int)$this->config->get('storefront_language_id');
		$store_id = (int)$this->config->get('config_store_id');

		$output = $this->cache->get('attraction.all_info.' . md5(implode('', $attractions)) . '.' . $customer_group_id, $language_id, $store_id);
		if (is_null($output)){ // if no cache

			$sql = "SELECT attraction_id, price
					FROM " . $this->db->table("attraction_specials") . "
					WHERE attraction_id IN (" . implode(', ', $attractions) . ")
							AND customer_group_id = '" . $customer_group_id . "'
							AND ((date_start = '0000-00-00' OR date_start < NOW())
							AND (date_end = '0000-00-00' OR date_end > NOW()))
					ORDER BY attraction_id ASC, priority ASC, price ASC";
			$result = $this->db->query($sql);
			$temp = '';
			$specials = array ();
			foreach ($result->rows as $row){
				if ($row['attraction_id'] != $temp){
					$specials[$row['attraction_id']] = $row['price'];
				}
				$temp = $row['attraction_id'];
			}
			//avg-rating
			if ($this->config->get('enable_reviews')){
				$sql = "SELECT attraction_id, AVG(rating) AS total
						FROM " . $this->db->table("reviews") . "
						WHERE status = '1' AND attraction_id IN (" . implode(', ', $attractions) . ")
						GROUP BY attraction_id";
				$result = $this->db->query($sql);
				$rating = array ();
				foreach ($result->rows as $row){
					$rating[$row['attraction_id']] = (int)$row['total'];
				}
			} else{
				$rating = false;
			}

			// discounts
			$sql = "SELECT attraction_id, price
					FROM " . $this->db->table("attraction_discounts") . "
					WHERE attraction_id IN (" . implode(', ', $attractions) . ")
						AND customer_group_id = '" . (int)$customer_group_id . "'
						AND quantity = '1'
						AND ((date_start = '0000-00-00' OR date_start < NOW())
						AND (date_end = '0000-00-00' OR date_end > NOW()))
					ORDER BY  attraction_id ASC, priority ASC, price ASC";
			$result = $this->db->query($sql);
			$temp = '';
			$discounts = array ();
			foreach ($result->rows as $row){
				if ($row['attraction_id'] != $temp){
					$discounts[$row['attraction_id']] = $row['price'];
				}
				$temp = $row['attraction_id'];
			}

			// options
			$sql = "SELECT po.attraction_id,
							po.attraction_option_id,
							po.regexp_pattern,
							pov.attraction_option_value_id,
							pov.sku,
							pov.quantity,
							pov.subtract,
							pov.price,
							pov.prefix,
							pod.name as option_name,
							pod.error_text as error_text,
							povd.name as value_name,
							po.sort_order
						FROM " . $this->db->table("attraction_options") . " po
						LEFT JOIN " . $this->db->table("attraction_option_values") . " pov
							ON pov.attraction_option_id = po.attraction_option_id
						LEFT JOIN " . $this->db->table("attraction_option_value_descriptions") . " povd
							ON (povd.attraction_option_value_id = pov.attraction_option_value_id
									AND povd.language_id='" . $language_id . "')
						LEFT JOIN " . $this->db->table("attraction_option_descriptions") . " pod
							ON (pod.attraction_option_id = po.attraction_option_id
								AND pod.language_id='" . $language_id . "') 
						WHERE po.attraction_id in (" . implode(', ', $attractions) . ")
						ORDER BY pov.attraction_option_id, pov.attraction_id, po.sort_order, pov.sort_order";
			$result = $this->db->query($sql);
			$temp = $temp2 = '';
			$options = array ();
			foreach ($result->rows as $row){

				if ($row['attraction_id'] != $temp){
					$temp2 = '';
				}

				if ($row['attraction_option_id'] != $temp2){
					$options[$row['attraction_id']][$row['attraction_option_id']] = array (
							'attraction_option_id' => $row['attraction_option_id'],
							'name'              => $row['option_name'],
							'sort_order'        => $row['sort_order']
					);
				}
				$options[$row['attraction_id']][$row['attraction_option_id']]['option_value'][] = array (
						'attraction_option_value_id' => $row['attraction_option_value_id'],
						'name'                    => $row['value_name'],
						'sku'                     => $row['sku'],
						'price'                   => $row['price'],
						'prefix'                  => $row['prefix']
				);
				$temp = $row['attraction_id'];
				$temp2 = $row['attraction_option_id'];
			}

			foreach ($attractions as $attraction){
				$output[$attraction]['special'] = $specials[$attraction];
				$output[$attraction]['discount'] = $discounts[$attraction];
				$output[$attraction]['options'] = $options[$attraction];
				$output[$attraction]['rating'] = $rating !== false ? (int)$rating[$attraction] : false;
			}
			$this->cache->set('attraction.all_info.' . md5(implode('', $attractions)) . '.' . $customer_group_id, $output, $language_id, $store_id);
		}
		return $output;
	}

	public function getAttractions($data = array (), $mode = 'default'){

		if (!empty($data['content_language_id'])){
			$language_id = ( int )$data['content_language_id'];
		} else{
			$language_id = (int)$this->config->get('storefront_language_id');
		}

		if ($data || $mode == 'total_only'){

			$filter = (isset($data['filter']) ? $data['filter'] : array ());

			if ($mode == 'total_only'){
				$sql = "SELECT COUNT(DISTINCT p.attraction_id) as total
						FROM " . $this->db->table("attractions") . " p
						LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd
							ON (p.attraction_id = pd.attraction_id)";
			} else{
				$sql = "SELECT *,
								p.attraction_id,
								" . $this->_sql_final_price_string() . ",
								pd.name AS name,
								m.name AS provider,
								ss.name AS stock,
								" . $this->_sql_avg_rating_string() . ",
								" . $this->_sql_review_count_string() . "
						" . $this->_sql_join_string();
			}

			if (isset($filter['destination_id']) && !is_null($filter['destination_id'])){
				$sql .= " LEFT JOIN " . $this->db->table("attractions_to_destinations") . " p2c ON (p.attraction_id = p2c.attraction_id)";
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
			if (isset($filter['destination_id']) && !is_null($filter['destination_id'])){
				$sql .= " AND p2c.destination_id = '" . (int)$filter['destination_id'] . "'";
			}
			if (isset($filter['provider_id']) && !is_null($filter['provider_id'])){
				$sql .= " AND p.provider_id = '" . (int)$filter['provider_id'] . "'";
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
			$attraction_data = $this->cache->get('attraction', $language_id);

			if (!$attraction_data){
				$query = $this->db->query("SELECT *
											FROM " . $this->db->table("attractions") . " p
											LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd ON (p.attraction_id = pd.attraction_id)
											WHERE pd.language_id = '" . $language_id . "' AND p.date_available <= NOW() AND p.status = '1'
											ORDER BY pd.name ASC");
				$attraction_data = $query->rows;
				$this->cache->set('attraction', $attraction_data, $language_id);
			}

			return $attraction_data;
		}
	}

	/**
	 * @param array $data
	 * @return array|null
	 */
	public function getTotalAttractions($data = array ()){
		return $this->getAttractions($data, 'total_only');
	}

	/**
	 * @param string $sort
	 * @param string $order
	 * @param int $start
	 * @param int $limit
	 * @return array
	 */
	public function getAttractionSpecials($sort = 'p.sort_order', $order = 'ASC', $start = 0, $limit = 0){
		$limit = (int)$limit;
		$promoton = new APromotion();
		$results = $promoton->getAttractionSpecials($sort, $order, $start, $limit);

		return $results;
	}

}
