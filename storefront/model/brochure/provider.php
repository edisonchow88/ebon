<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL, 2016/01/15
------------------------------------------------------------------------------*/
if (!defined('DIR_CORE')){
	header('Location: static_pages/');
}
class ModelBrochureProvider extends Model{
	public function getProvider($provider_id){
		$query = $this->db->query("SELECT *
									FROM " . $this->db->table("providers") . " m
									LEFT JOIN " . $this->db->table("providers_to_stores") . " m2s ON (m.provider_id = m2s.provider_id)
									WHERE m.provider_id = '" . (int)$provider_id . "'
										AND m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'");

		return $query->row;
	}

	/**
	 * @param array $data
	 * @return array
	 */
	public function getProviders($data = array ()){
		if (!$data){
			$provider = $this->cache->get('provider', '', (int)$this->config->get('config_store_id'));
		}

		if (isset($data['start']) || isset($data['limit'])){
			if ($data['start'] < 0){
				$data['start'] = 0;
			}
			if ($data['limit'] < 1){
				$data['limit'] = 0;
			}
		}

		if (!$provider){
			$sql = "SELECT *
					FROM " . $this->db->table("providers") . " m
					LEFT JOIN " . $this->db->table("providers_to_stores") . " m2s ON (m.provider_id = m2s.provider_id)
					WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "'
					ORDER BY sort_order, LCASE(m.name) ASC";

			if ($data['limit']){
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}

			$query = $this->db->query($sql);
			$provider = $query->rows;
			if (!$data['limit']){
				$this->cache->set('provider', $provider, '', (int)$this->config->get('config_store_id'));
			}
		}
		return $provider;
	}

	/**
	 * @param $attraction_id
	 * @return array
	 */
	public function getProviderByAttractionId($attraction_id){
		$query = $this->db->query("SELECT *
										FROM " . $this->db->table("providers") . " m
										RIGHT JOIN " . $this->db->table("attractions") . " p ON (m.provider_id = p.provider_id)
										WHERE p.attraction_id = '" . (int)$attraction_id . "'");
		return $query->rows;
	}

	/**
	 * @param array $data
	 * @return array
	 */
	public function getProvidersData($data = array ()){
		$sql = "SELECT *,
						(SELECT count(*) as cnt
				        FROM " . $this->db->table('attractions') . " p
				        WHERE p.provider_id = m.provider_id and p.status=1) as attractions_count
					FROM " . $this->db->table("providers") . " m
					LEFT JOIN " . $this->db->table("providers_to_stores") . " m2s ON (m.provider_id = m2s.provider_id)";

		$sql .= " WHERE m2s.store_id = '" . (int)$this->config->get('config_store_id') . "' ";
		if (!empty($data['subsql_filter'])){
			$sql .= ' AND ' . $data['subsql_filter'];
		}
		$sql .= " ORDER BY sort_order, LCASE(m.name) ASC";

		$query = $this->db->query($sql);
		return $query->rows;
	}
}