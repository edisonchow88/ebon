<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelTravelTrip extends Model{
	
	private $table = "trip";
	private $table_description = "trip_description";
	
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
	
	public function getTrip($trip_id='') {
		$trip = array();
		
		if($trip_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.trip_id = t2.trip_id 
				ORDER BY t1.travel_date DESC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.trip_id = t2.trip_id 
				WHERE t1.trip_id = '" . (int)$trip_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($trip_id == '') {
			foreach($query->rows as $result){
				$output[$result['trip_id']] = $result;
				$output[$result['trip_id']]['name'] = ucwords($result['name']);
				$output[$result['trip_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				$output[$result['trip_id']]['user'] = $this->model_user_user->getUser($result['user_id']); //IMPORTANT: need to call model at controller in order to work
			}
		}
		else {
			$result = $query->row;
			$output = $query->row;
			$output['name'] = ucwords($result['name']);
			$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
			$output['user'] = $this->model_user_user->getUser($result['user_id']); //IMPORTANT: need to call model at controller in order to work
		}
		
		return $output;
	}
	
	public function addTrip($data) {
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
		
		$trip_id = $this->db->getLastId();
		
		//START: update latest date
		$update = array();
		$update[] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'";
		$update[] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'";
		$sql = "
			UPDATE " . $this->db->table($this->table) . " 
			SET " . implode(',', $update) . "
			WHERE trip_id = '" . (int)$trip_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		//START:table_description
		$fields = $this->getFields($this->db->table($this->table_description));
		
		$update = array();
		$update[] = "trip_id = '" . $trip_id. "'";
		
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
		
		$this->cache->delete('trip');
		
		return $trip_id;
	}
	
	public function editTrip($trip_id, $data) {
		//table
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
				WHERE trip_id = '" . (int)$trip_id . "'
			";
			$query = $this->db->query($sql);
		}
		
		//table_description
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
				WHERE trip_id = '" . (int)$trip_id . "'
			";
			$query = $this->db->query($sql);
		}
		
		$this->cache->delete('trip');
		return true;
	}
	
	public function deleteTrip($trip_id) {
		//table
		$sql = "
			DELETE FROM " . $this->db->table($this->table) . " 
			WHERE trip_id = '" . (int)$trip_id . "'
		";
		$query = $this->db->query($sql);
		
		//table_description
		$sql = "
			DELETE FROM " . $this->db->table($this->table_description) . " 
			WHERE trip_id = '" . (int)$trip_id . "'
		";
		$query = $this->db->query($sql);
		
		$this->cache->delete('trip');
		return true;
	}
}

?>