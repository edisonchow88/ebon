<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelTravelMode extends Model{
	
	private $table = "trip_mode";
	private $table_description = "trip_mode_description";
	
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
	
	public function getMode($mode_id='') {
		$mode = array();
		
		if($mode_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.mode_id = t2.mode_id 
				ORDER BY t2.name ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.mode_id = t2.mode_id 
				WHERE t1.mode_id = '" . (int)$mode_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($mode_id == '') {
			foreach($query->rows as $result){
				$output[$result['mode_id']] = $result;
				$output[$result['mode_id']]['name'] = ucwords($result['name']);
				$output[$result['mode_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
			}
		}
		else {
			$result = $query->row;
			$output = $query->row;
			$output['name'] = ucwords($result['name']);
			$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
		}
		
		return $output;
	}
	
	public function addMode($data) {
		//START: table
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
		if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
		
		$sql = "
			INSERT INTO `" . $this->db->table($this->table) . "` 
			SET " . implode(',', $update) . "
		";
		$query = $this->db->query($sql);
		//END
		
		$mode_id = $this->db->getLastId();
		
		//START:table_description
		$fields = $this->getFields($this->db->table($this->table_description));
		
		$update = array();
		$update[] = "mode_id = '" . $mode_id. "'";
		
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		
		$sql = "
			INSERT INTO `" . $this->db->table($this->table_description) . "` 
			SET " . implode(',', $update) . "
		";
		$query = $this->db->query($sql);
		//END
		
		$this->cache->delete('mode');
		
		return $mode_id;
	}
	
	public function editMode($mode_id, $data) {
		//START: table
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
		
		if(!empty($update)){
			$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET " . implode(',', $update) . "
				WHERE mode_id = '" . (int)$mode_id . "'
			";
			$query = $this->db->query($sql);
		}
		//END
		
		//START: table_description
		$fields = $this->getFields($this->db->table($this->table_description));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		
		if(!empty($update)){
			$sql = "
				UPDATE " . $this->db->table($this->table_description) . " 
				SET " . implode(',', $update) . "
				WHERE mode_id = '" . (int)$mode_id . "'
			";
			$query = $this->db->query($sql);
		}
		//END
		
		$this->cache->delete('mode');
		return true;
	}
	
	public function deleteMode($mode_id) {
		//START: table
		$sql = "
			DELETE FROM " . $this->db->table($this->table) . " 
			WHERE mode_id = '" . (int)$mode_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		//START: table_description
		$sql = "
			DELETE FROM " . $this->db->table($this->table_description) . " 
			WHERE mode_id = '" . (int)$mode_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		$this->cache->delete('mode');
		return true;
	}
}

?>