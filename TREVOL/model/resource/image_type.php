<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelResourceImageType extends Model{
	
	private $table = "image_type";
	
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
	
	public function getImageType($image_type_id='') {
		if($image_type_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " 
				ORDER BY sort_order ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " 
				WHERE image_type_id = '" . (int)$image_type_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($image_type_id == '') {
			foreach($query->rows as $result){
				$output[$result['image_type_id']] = $result;
			}
		}
		else {
			$output = $query->row;
		}
		
		return $output;
	}
	
	public function addImageType($data) {
		//this function is limited to ONE table only
		$keys = array();
		$values = array();
		foreach($data as $key => $value) {
			$keys[] = $key;
			$values[] = "'".$value."'";
		}
		$field_keys = implode(", ", $keys);
		$field_values = implode(", ", $values);
		
		$sql = "
				INSERT INTO `" . $this->db->table($this->table) . "`
				(".$field_keys.")
				VALUES (".$field_values.")
			";
		$query = $this->db->query($sql);
		
		$image_type_id = $this->db->getLastId();
		
		$this->cache->delete('image_type');
		
		return $image_type_id;
	}
	
	public function editImageType($image_type_id, $data) {
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape($data[$f]) . "'";
		}
		
		if(!empty($update)){
			$sql = "UPDATE " . $this->db->table($this->table) . " 
				SET " . implode(',', $update) . "
				WHERE image_type_id = '" . (int)$image_type_id . "'
			";
			$query = $this->db->query($sql);
		}
		
		$this->cache->delete('image_type');
		
		return true;
	}
	
	public function deleteImageType($image_type_id) {
		$sql = "
				DELETE FROM " . $this->db->table($this->table) . " 
				WHERE image_type_id = '" . (int)$image_type_id . "'
			";
		$query = $this->db->query($sql);
		
		$this->cache->delete('image_type');
		
		return true;
	}
}

?>