<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelTravelStatus extends Model{
	
	private $table = "trip_status";
	private $table_description = "trip_status_description";
	
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
	
	public function getStatus($status_id='') {
		$status = array();
		
		if($status_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.status_id = t2.status_id 
				ORDER BY t1.sort_order ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.status_id = t2.status_id 
				WHERE t1.status_id = '" . (int)$status_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($status_id == '') {
			foreach($query->rows as $result){
				$output[$result['status_id']] = $result;
				$output[$result['status_id']]['name'] = ucwords($result['name']);
				$output[$result['status_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
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
	
	public function addStatus($data) {
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
		
		$status_id = $this->db->getLastId();
		
		//START:table_description
		$fields = $this->getFields($this->db->table($this->table_description));
		
		$update = array();
		$update[] = "status_id = '" . $status_id. "'";
		
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
		
		$this->cache->delete('status');
		
		return $status_id;
	}
	
	public function editStatus($status_id, $data) {
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
				WHERE status_id = '" . (int)$status_id . "'
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
				WHERE status_id = '" . (int)$status_id . "'
			";
			$query = $this->db->query($sql);
		}
		//END
		
		$this->cache->delete('status');
		return true;
	}
	
	public function deleteStatus($status_id) {
		//START: table
		$sql = "
			DELETE FROM " . $this->db->table($this->table) . " 
			WHERE status_id = '" . (int)$status_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		//START: table_description
		$sql = "
			DELETE FROM " . $this->db->table($this->table_description) . " 
			WHERE status_id = '" . (int)$status_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		$this->cache->delete('status');
		return true;
	}
}

?>