<?php
/*------------------------------------------------------------------------------
TREVOL
------------------------------------------------------------------------------*/
if(!defined('DIR_CORE')){
	header('Location: static_pages/');
}

final class ATrip{
	
	//START: set common data
		private $data = array();
		private $config;
		private $cache;
		private $db;
		private $request;
	//END
	
	//START: set common table
		private $table = "trip";
	//END
		
	public function __construct($registry){
		//START: get registry
			$this->cache = $registry->get('cache');
			$this->config = $registry->get('config');
			$this->db = $registry->get('db');
			$this->request = $registry->get('request');
		//END
		
		//START: set data
			$this->data['code'] = '';
			$this->data['trip_id'] = '';
			$this->data['plan_id'] = '';
			$this->data['owner_id'] = '';
		//END
		
		//START: set code
			if($this->request->is_POST('trip')) {
				$this->data['code'] = $this->request->post['trip'];
			}
			else if($this->request->is_GET('trip')) {
				$this->data['code'] = $this->request->get['trip'];
			}
			else {
				unset($this->data['code']);
			}
		//END
		
		//START: set plan_id
			if($this->request->is_POST('plan')) {
				$this->data['plan_id'] = $this->request->post['plan'];
			}
			else if($this->request->is_GET('trip')) {
				$this->data['plan_id'] = $this->request->get['plan'];
			}
			else {
				unset($this->data['plan_id']);
			}
		//END
		
		//START: get data
			if(isset($this->data['code'])) {
				$sql = '
					SELECT trip_id, user_id
					FROM '.$this->db->table('trip').'
					WHERE code = "' . $this->data['code'] . '" 
					LIMIT 1
				';
				$query = $this->db->query($sql);
				
				if($query->num_rows > 0) {
					//START: [valid code]
						$result = $query->row;
						$this->data['trip_id'] = $result['trip_id'];
						$this->data['owner_id'] = $result['user_id'];
						
						//START: verify plan_id
							$sql = '
								SELECT plan_id, selected
								FROM '.$this->db->table('trip_plan').'
								WHERE trip_id = "' . (int)$this->data['trip_id'] . '" 
							';
							$query = $this->db->query($sql);
							$result = $query->rows;
							
							if(isset($this->data['plan_id']) && isset($result[$this->data['plan_id']])) {
							}
							else {
								//START: [invalid plan_id || no plan_id] get selected plan
									foreach($result as $plan) {
										if($plan['selected'] == 1) {
											$this->data['plan_id'] = $plan['plan_id'];
										}
									}
								//END
							}
						//END
					//END
				}
				else {
					//START: [invalid code]
						unset($this->data['code']);
						unset($this->data['trip_id']);
						unset($this->data['plan_id']);
						unset($this->data['owner_id']);
					//END
				}
			}
			else {
				unset($this->data['trip_id']);
				unset($this->data['plan_id']);
				unset($this->data['owner_id']);
			}
		//END
	}
	
	public function getCode() {
		return $this->data['code'];
	}
	
	public function getTripId() {
		return $this->data['trip_id'];
	}
	
	public function getPlanId() {
		return $this->data['plan_id'];
	}
	
	public function getOwnerId() {
		return $this->data['owner_id'];
	}
	
	public function hasTrip() {
		if(isset($this->data['code'])) {
			return $this->data['code'];
		}
		else {
			return false;
		}
	}
	
	public function hasPlan() {
		if(isset($this->data['plan_id'])) {
			return $this->data['plan_id'];
		}
		else {
			return false;
		}
	}
}