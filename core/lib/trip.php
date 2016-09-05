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
			$this->data['trip_id'] = '';
			$this->data['plan_id'] = '';
		//END
		
		//START: set trip_id
			if($this->request->is_POST('trip_id')) {
				$this->data['trip_id'] = $this->request->post['trip_id'];
			}
			else if($this->request->is_GET('trip_id')) {
				$this->data['trip_id'] = $this->request->get['trip_id'];
			}
			else {
				unset($this->data['trip_id']);
			}
		//END
		
		//START: set plan_id
			if($this->request->is_POST('plan_id')) {
				$this->data['plan_id'] = $this->request->post['plan_id'];
			}
			else if($this->request->is_GET('plan_id')) {
				$this->data['plan_id'] = $this->request->get['plan_id'];
			}
			else {
				unset($this->data['plan_id']);
			}
		//END
		
		//START: set owner_id
			$sql = '
				SELECT user_id
				FROM '.$this->db->table('trip').'
				WHERE trip_id = "' . (int)$this->data['trip_id'] . '" 
				LIMIT 1
			';
			$query = $this->db->query($sql);
			$result = $query->row;
			$this->data['owner_id'] = $result['user_id'];
		//END
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
		if(isset($this->data['trip_id'])) {
			return $this->data['trip_id'];
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