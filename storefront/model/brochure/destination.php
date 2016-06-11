<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL, 2016/01/15
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
/** @noinspection PhpUndefinedClassInspection */
/**
 * Class ModelBrochureDestination
 * @property ModelBrochureAttraction $model_brochure_attraction
 */
class ModelBrochureDestination extends Model {
	/**
	 * @param int $destination_id
	 * @return array
	 */
	public function getDestination($destination_id) {
		$language_id = (int)$this->config->get('storefront_language_id');
		$query = $this->db->query("SELECT DISTINCT *,
										(SELECT COUNT(p2c.attraction_id) as cnt
										 FROM ".$this->db->table('attractions_to_destinations')." p2c
										 INNER JOIN " . $this->db->table('attractions')." p ON p.attraction_id = p2c.attraction_id
										 WHERE p.status = '1' AND p2c.destination_id = c.destination_id) as attractions_count
									FROM " . $this->db->table("destinations") . " c
									LEFT JOIN " . $this->db->table("destination_descriptions") . " cd ON (c.destination_id = cd.destination_id AND cd.language_id = '" . $language_id . "')
									LEFT JOIN " . $this->db->table("destinations_to_stores") . " c2s ON (c.destination_id = c2s.destination_id)
									WHERE c.destination_id = '" . (int)$destination_id . "'
										AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
										AND c.status = '1'");
		
		return $query->row;
	}

	/**
	 * @param int $parent_id
	 * @param int $limit
	 * @return array
	 */
	public function getDestinations($parent_id = 0, $limit=0) {
		$language_id = (int)$this->config->get('storefront_language_id');
		$cache_name = 'destination.list.'. $parent_id.'.'.$limit;
		$cache = $this->cache->get($cache_name, $language_id, (int)$this->config->get('config_store_id'));
		if(is_null($cache)){
			$query = $this->db->query("SELECT *
										FROM " . $this->db->table("destinations") . " c
										LEFT JOIN " . $this->db->table("destination_descriptions") . " cd ON (c.destination_id = cd.destination_id AND cd.language_id = '" . $language_id . "')
										LEFT JOIN " . $this->db->table("destinations_to_stores") . " c2s ON (c.destination_id = c2s.destination_id)
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
	public function getDestinationsData($data, $mode = 'default') {

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
						  c.destination_id,
						  (SELECT count(*) as cnt
						  	FROM ".$this->db->table('attractions_to_destinations')." p2c
						  	INNER JOIN " . $this->db->table('attractions')." p ON p.attraction_id = p2c.attraction_id
						  	WHERE p2c.destination_id = c.destination_id AND p.status = '1') as attractions_count ";
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
			$where = " c.destination_id IN (".implode(', ',$ids).")";
		}

		$where = $where ? 'WHERE '.$where : '';

		$sql = "SELECT ". $total_sql ."
				FROM " . $this->db->table('destinations')." c
				LEFT JOIN " . $this->db->table('destination_descriptions')." cd
					ON (c.destination_id = cd.destination_id AND cd.language_id = '" . $language_id . "')
				INNER JOIN " . $this->db->table('destinations_to_stores')." cs
					ON (c.destination_id = cs.destination_id AND cs.store_id = '" . $store_id . "')
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
		$destination_data = array();
		foreach ($query->rows as $result) {
			$destination_data[] = array(
				'destination_id' => $result['destination_id'],
				'name'    => $result['name'],
				'status'  	  => $result['status'],
				'sort_order'  => $result['sort_order'],
				'attractions_count'=>$result['attractions_count']

			);
		}
		return $destination_data;
	}

	/**
	 * @return array
	 */
	public function getAllDestinations(){
		return $this->getDestinations(-1);
	}

	/**
	 * @param int $parent_id
	 * @return int
	 */
	public function getTotalDestinationsByDestinationId($parent_id = 0) {
		$query = $this->db->query("SELECT COUNT(*) AS total
									FROM " . $this->db->table("destinations") . " c
									LEFT JOIN " . $this->db->table("destinations_to_stores") . " c2s ON (c.destination_id = c2s.destination_id)
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
	public function getDestinationsDetails($parent_id = 0, $path = '') {
		$language_id = (int)$this->config->get('storefront_language_id');
		$store_id = (int)$this->config->get('config_store_id');
		$this->load->model('brochure/attraction');
		$this->load->model('brochure/provider');
		$resource = new AResource('image');
		$cash_name = 'destination.details.'.$parent_id;
		$destinations = $this->cache->get( $cash_name, $language_id, $store_id );
		if ( count($destinations) ) {
			return $destinations;
		}
		
		$results = $this->getDestinations($parent_id);
		
		foreach ($results as $result) {
			if (!$path) {
			        $new_path = $result['destination_id'];
			} else {
			        $new_path = $path . '_' . $result['destination_id'];
			}
			
			$brands = array();
			
			if($parent_id == 0) {

			    $data['filter'] = array();
			    $data['filter']['destination_id'] = $result['destination_id'];
			    $data['filter']['status'] = 1;
			    
			    $prods = $this->model_brochure_attraction->getAttractions($data);
			    
			    foreach( $prods as $prod ) {
			        if( $prod['provider_id'] ) {
			                $brand = $this->model_brochure_provider->getProvider($prod['provider_id']);
			        
			                $brands[$prod['provider_id']] = array(
			                        'name' => $brand['name'],
			                        'href' => $this->html->getSEOURL('attraction/provider', '&provider_id=' .$brand['provider_id'], '&encode')
			                );
			        }
			    }
			}

			$thumbnail = $resource->getMainThumb('destinations',
			                                     $result['destination_id'],
			                                     $this->config->get('config_image_destination_width'),
			                                     $this->config->get('config_image_destination_height'),true);
			
			$destinations[] = array(
			        'destination_id' => $result['destination_id'],
			        'name' => $result['name'],
			        'children' => $this->getDestinationsDetails($result['destination_id'], $new_path),
			        'href' => $this->html->getSEOURL('attraction/destination', '&path=' . $new_path, '&encode'),
			        'brands' => $brands,
			        'attraction_count' => count($prods),
			        'thumb' => $thumbnail['thumb_url'],
			);
		}
		$this->cache->set( $cash_name, $destinations, $language_id, $store_id );
		return $destinations;
	}

	/**
	 * @param array $destinations
	 * @return int
	 */
	public function getDestinationsAttractionsCount($destinations=array()){
		$destinations = (array)$destinations;
		foreach($destinations as &$val){
			$val = (int)$val;
		} unset($val);
		$destinations = array_unique($destinations);

		$query = $this->db->query("SELECT COUNT(DISTINCT p2c.attraction_id) AS total
									FROM " . $this->db->table("attractions_to_destinations") . " p2c
									INNER JOIN " . $this->db->table('attractions')." p ON p.attraction_id = p2c.attraction_id
									WHERE p.status = '1' AND p2c.destination_id IN (".implode(', ',$destinations).");");

		return (int)$query->row['total'];
	}


	/**
	 * @param array $destinations
	 * @return array
	 */
	public function getDestinationsBrands($destinations=array()){
		$destinations = (array)$destinations;
		foreach($destinations as &$val){
			$val = (int)$val;
		} unset($val);
		$destinations = array_unique($destinations);

		$sql = "SELECT DISTINCT p.provider_id, m.name
				FROM ".$this->db->table('attractions')." p
				LEFT JOIN ".$this->db->table('providers')." m ON p.provider_id = m.provider_id
				WHERE p.attraction_id IN (SELECT DISTINCT p2c.attraction_id
									   FROM " . $this->db->table('attractions_to_destinations') . " p2c
									   INNER JOIN " . $this->db->table('attractions')." p ON p.attraction_id = p2c.attraction_id
									   WHERE p.status = '1' AND p2c.destination_id IN (".implode(', ',$destinations)."));";

		$query = $this->db->query($sql);
		return $query->rows;
	}

	/**
	 * @param int $destination_id
	 * @return string
	 */
	public function buildPath($destination_id) {
		$query = $this->db->query("SELECT c.destination_id, c.parent_id
		                            FROM " . $this->db->table("destinations") . " c
		                            WHERE c.destination_id = '" . (int)$destination_id . "'
		                            ORDER BY c.sort_order");
		
		$destination_info = $query->row;
		if ($destination_info['parent_id']) {
			return $this->buildPath($destination_info['parent_id']) . "_" . $destination_info['destination_id'];
		} else {
			return $destination_info['destination_id'];
		}
	}
}
