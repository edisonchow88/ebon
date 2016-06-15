<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelResourceImageSource extends Model{
	
	private $table = "image_source";
	
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
	
	public function getImageSource($image_source_id='') {
		if($image_source_id == '') {
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
				WHERE image_source_id = '" . (int)$image_source_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($image_source_id == '') {
			foreach($query->rows as $result){
				$output[$result['image_source_id']] = $result;
			}
		}
		else {
			$output = $query->row;
		}
		
		return $output;
	}
	
	public function addImageSource($data) {
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
		
		$image_source_id = $this->db->getLastId();
		
		$this->cache->delete('image_source');
		
		return $image_source_id;
	}
	
	public function editImageSource($image_source_id, $data) {
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape($data[$f]) . "'";
		}
		
		if(!empty($update)){
			$sql = "UPDATE " . $this->db->table($this->table) . " 
				SET " . implode(',', $update) . "
				WHERE image_source_id = '" . (int)$image_source_id . "'
			";
			$query = $this->db->query($sql);
		}
		
		$this->cache->delete('image_source');
		
		return true;
	}
	
	public function deleteImageSource($image_source_id) {
		$sql = "
				DELETE FROM " . $this->db->table($this->table) . " 
				WHERE image_source_id = '" . (int)$image_source_id . "'
			";
		$query = $this->db->query($sql);
		
		$this->cache->delete('image_source');
		
		return true;
	}
}

?>