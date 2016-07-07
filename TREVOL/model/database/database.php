<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelDatabaseDatabase extends Model{
	
	private $table = "database";
	
	public function getFields() {
		$sql = "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$this->db->table($this->table)."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$output[] = $result['COLUMN_NAME'];
		}
		return $output;
	}
	
	public function getDefaults() {
		$sql = "SELECT * FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$this->db->table($this->table)."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$output[$result['COLUMN_NAME']] = $result['COLUMN_DEFAULT'];
		}
		return $output;
	}
	
	public function getDatabase($database_id='') {
		$database = array();
		
		if($database_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . "
				ORDER BY sort_order ASC, name ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . "
				WHERE database_id = '" . (int)$database_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($database_id == '') {
			foreach($query->rows as $result){
				$output[$result['database_id']] = $result;
				$output[$result['database_id']]['folder'] = ucwords($result['folder']);
				$output[$result['database_id']]['filename'] = ucwords($result['filename']);
			}
		}
		else {
			$output = $query->row;
			$output['folder'] = ucwords($output['folder']);
			$output['filename'] = ucwords($output['filename']);
		}
		
		return $output;
	}
	
	public function addDatabase($data) {
		$keys = array();
		$values = array();
		foreach($data as $key => $value) {
			$keys[] = $key;
			$values[] = "'".$this->db->escape(strtolower($value))."'";
		}
		$field_keys = implode(", ", $keys);
		$field_values = implode(", ", $values);
		
		$sql = "
			INSERT INTO `" . $this->db->table($this->table) . "` 
			(".$field_keys.")
			VALUES (".$field_values.")
		";
		$query = $this->db->query($sql);
		
		$database_id = $this->db->getLastId();
		
		$this->cache->delete('database');
		
		return $database_id;
	}
	
	public function editDatabase($database_id, $data) {
		$fields = $this->getFields();
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		
		if(!empty($update)){
			$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET " . implode(',', $update) . "
				WHERE database_id = '" . (int)$database_id . "'
			";
			$query = $this->db->query($sql);
		}
		
		$this->cache->delete('database');
		return true;
	}
	
	public function deleteDatabase($database_id) {
		$sql = "
			DELETE FROM " . $this->db->table($this->table) . " 
			WHERE database_id = '" . (int)$database_id . "'
		";
		$query = $this->db->query($sql);
		
		$this->cache->delete('database');
		return true;
	}
}

?>