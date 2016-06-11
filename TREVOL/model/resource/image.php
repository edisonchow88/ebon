<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelResourceImage extends Model{
	
	private $table = "image";
	private $path = "resources/image/cropped/";
	private $default_width = "100px";
	
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
	
	public function getImage($image_id='',$width='') {
		if($width=='') { $width = $this->default_width; }
		
		$image = array();
		
		if($image_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " 
				ORDER BY image_id ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " 
				WHERE image_id = '" . (int)$image_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($image_id == '') {
			foreach($query->rows as $result){
				$output[$result['image_id']] = $result;
				$output[$result['image_id']]['name'] = ucwords($result['name']);
				$output[$result['image_id']]['width'] = $width;
				$output[$result['image_id']]['path'] = $this->path.$result['filename'];
				$output[$result['image_id']]['image'] = "<img src='".$output[$result['image_id']]['path']."' title='".$output[$result['image_id']]['name']."' width='".$width."'/>";
			}
		}
		else {
			$output = $query->row;
			$output['name'] = ucwords($output['name']);
			$output['width'] = $width;
			$output['path'] = $this->path.$output['filename'];
			$output['image'] = "<img src='".$output['path']."' title='".$output['name']."' width='".$width."'/>";
		}
		
		return $output;
	}
	
	public function addImage($data) {
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
		
		$image_id = $this->db->getLastId();
		
		$this->cache->delete('image');
		
		return $image_id;
	}
	
	public function editImage($image_id, $data) {
		$fields = $this->getFields();
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape($data[$f]) . "'";
		}
		
		if(!empty($update)){
			$sql = "UPDATE " . $this->db->table($this->table) . " 
				SET " . implode(',', $update) . "
				WHERE image_id = '" . (int)$image_id . "'
			";
			$query = $this->db->query($sql);
		}
		
		$this->cache->delete('image');
	}
	
	public function deleteImage($image_id) {
		$sql = "
				DELETE FROM " . $this->db->table($this->table) . " 
				WHERE image_id = '" . (int)$image_id . "'
			";
		$query = $this->db->query($sql);
		
		$this->cache->delete('image');
	}
	
	//destination
	public function getImageByDestinationId($destination_id,$width='') {
		$sql = "
				SELECT * 
				FROM " . $this->db->table('destination_image') . " 
				WHERE destination_id = '" . (int)$destination_id . "' 
				ORDER BY sort_order ASC
			";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['sort_order']] = $this->getImage($result['image_id'],$width);
		}
		return $output;
	}
}

?>