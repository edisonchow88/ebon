<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelTravelPlan extends Model{
	
	private $table = "trip_plan";
	private $table_description = "trip_plan_description";
	
	public function getFields($table) {
		$sql = "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$table."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$output[] = $result['COLUMN_NAME'];
		}
		return $output;
	}
	
	public function getDefaults($table) {
		$sql = "SELECT * FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$table."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$output[$result['COLUMN_NAME']] = $result['COLUMN_DEFAULT'];
		}
		return $output;
	}
	
	public function getPlan($plan_id='',$trip_id='') {
		$plan = array();
		
		if($plan_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.plan_id = t2.plan_id 
			";
			if($trip_id != '') { $sql .= " WHERE t1.trip_id = '" . (int)$this->db->escape($trip_id) . "' "; }
			$sql .= "
				ORDER BY t1.trip_id DESC, t1.sort_order ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.plan_id = t2.plan_id 
				WHERE t1.plan_id = '" . (int)$plan_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($plan_id == '') {
			foreach($query->rows as $result){
				$output[$result['plan_id']] = $result;
				$output[$result['plan_id']]['name'] = ucwords($result['name']);
				$output[$result['plan_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				$output[$result['plan_id']]['trip'] = $this->model_travel_trip->getTrip($result['trip_id']); //IMPORTANT: need to call model at controller
				$output[$result['plan_id']]['transport'] = $this->model_travel_transport->getTransport($result['transport_id']); //IMPORTANT: need to call model at controller
			}
		}
		else {
			$result = $query->row;
			$output = $query->row;
			$output['name'] = ucwords($result['name']);
			$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
			$output['trip'] = $this->model_travel_trip->getTrip($result['trip_id']); //IMPORTANT: need to call model at controller
			$output['transport'] = $this->model_travel_transport->getTransport($result['transport_id']); //IMPORTANT: need to call model at controller
		}
		
		return $output;
	}
	
	public function getPlanByTripId($trip_id) {
		return $this->getPlan('',$trip_id);
	}
	
	public function addPlan($data) {
		//START: table
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		
		$sql = "
			INSERT INTO `" . $this->db->table($this->table) . "` 
			SET " . implode(',', $update) . "
		";
		$query = $this->db->query($sql);
		//END
		
		$plan_id = $this->db->getLastId();
		
		//START: update latest date
		$update = array();
		$update[] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'";
		$update[] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'";
		$sql = "
			UPDATE " . $this->db->table($this->table) . " 
			SET " . implode(',', $update) . "
			WHERE plan_id = '" . (int)$plan_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		//START:table_description
		$fields = $this->getFields($this->db->table($this->table_description));
		
		$update = array();
		$update[] = "plan_id = '" . $plan_id. "'";
		
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		
		$sql = "
			INSERT INTO `" . $this->db->table($this->table_description) . "` 
			SET " . implode(',', $update) . "
		";
		$query = $this->db->query($sql);
		//END
		
		$this->cache->delete('plan');
		
		return $plan_id;
	}
	
	public function editPlan($plan_id, $data) {
		//START: table
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		$update[] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'";
		
		if(!empty($update)){
			$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET " . implode(',', $update) . "
				WHERE plan_id = '" . (int)$plan_id . "'
			";
			$query = $this->db->query($sql);
		}
		//END
		
		//START: table_description
		$fields = $this->getFields($this->db->table($this->table_description));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		
		if(!empty($update)){
			$sql = "
				UPDATE " . $this->db->table($this->table_description) . " 
				SET " . implode(',', $update) . "
				WHERE plan_id = '" . (int)$plan_id . "'
			";
			$query = $this->db->query($sql);
		}
		//END
		
		$this->cache->delete('plan');
		return true;
	}
	
	public function deletePlan($plan_id) {
		//START: table
		$sql = "
			DELETE FROM " . $this->db->table($this->table) . " 
			WHERE plan_id = '" . (int)$plan_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		//START: table_description
		$sql = "
			DELETE FROM " . $this->db->table($this->table_description) . " 
			WHERE plan_id = '" . (int)$plan_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		$this->cache->delete('plan');
		return true;
	}
}

?>