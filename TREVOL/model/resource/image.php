<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelResourceImage extends Model{
	
	private $table = "image";
	private $table_tag = "image_tag";
	private $path = "resources/image/cropped/";
	private $default_width = "100px";
	
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
		
		//add tag
		if($data['tag_time_id'] != '') {
			foreach($data['tag_time_id'] as $tag) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_tag) . " 
						SET 
							image_id = '" . (int)$this->db->escape($data['image_id']) . "', 
							tag_id = '" . (int)$this->db->escape($tag['tag_id']) . "'
					";
				$query = $this->db->query($sql);
			}
		}
		
		$this->cache->delete('image');
		
		return $image_id;
	}
	
	public function editImage($image_id, $data) {
		$sql = "UPDATE " . $this->db->table($this->table) . " 
			SET 
				image_id = '" . $this->db->escape($data['image_id']) . "', 
				name = '" . $this->db->escape($data['name']) . "', 
				filename = '" . $this->db->escape($data['filename']) . "', 
				size = '" . $this->db->escape($data['size']) . "', 
				photographer = '" . $this->db->escape($data['photographer']) . "', 
				link = '" . $this->db->escape($data['link']) . "', 
				image_source_id = '" . $this->db->escape($data['image_source_id']) . "', 
				image_license_id = '" . $this->db->escape($data['image_license_id']) . "', 
				date_modified = NOW() 
			WHERE image_id = '" . (int)$this->db->escape($data['image_id']) . "'
		";
		$query = $this->db->query($sql);
		
		//delete all tag
		$sql = "
				DELETE FROM " . $this->db->table($this->table_tag) . " 
				WHERE image_id = '" . (int)$this->db->escape($data['image_id']) . "'
			";
		$query = $this->db->query($sql);
		
		//add tag
		if($data['tag_time_id'] != '') {
			foreach($data['tag_time_id'] as $tag_time) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_tag) . " 
						SET 
							image_id = '" . (int)$this->db->escape($data['image_id']) . "', 
							tag_id = '" . (int)$this->db->escape($tag_time['tag_id']) . "'
					";
				$query = $this->db->query($sql);
			}
		}
		
		//delete destination
		
		/*
		$sql = "
				SELECT * FROM " . $this->db->table('destination_image') . " 
				WHERE image_id = '" . (int)$this->db->escape($data['image_id']) . "'
			";
		$query = $this->db->query($sql);
		$output = $query->rows;
		
		$difference = array_diff($output, $data['destination_id']);
		
		foreach($difference as $row) {
			$sql = "
				DELETE FROM " . $this->db->table('destination_image') . " 
				WHERE image_id = '" . (int)$this->db->escape($data['image_id']) . "' 
				AND destionation_id = '" . (int)$this->db->escape($row['destination_id']) . "' 
			";
			$query = $this->db->query($sql);
		}
		*/
		
		$sql = "
				DELETE FROM " . $this->db->table('destination_image') . " 
				WHERE image_id = '" . (int)$this->db->escape($data['image_id']) . "'
			";
		$query = $this->db->query($sql);
		
		//add destination
		if($data['destination_id'] != '') {
			foreach($data['destination_id'] as $destination) {
				$sql = "
						INSERT INTO " . $this->db->table('destination_image') . " 
						SET 
							image_id = '" . (int)$this->db->escape($data['image_id']) . "', 
							destination_id = '" . (int)$this->db->escape($destination['destination_id']) . "'
					";
				$query = $this->db->query($sql);
			}
		}
		
		$this->cache->delete('image');
		
		return true;
	}
	
	public function deleteImage($image_id) {
		$sql = "
				DELETE FROM " . $this->db->table($this->table) . " 
				WHERE image_id = '" . (int)$image_id . "'
			";
		$query = $this->db->query($sql);
		
		$this->cache->delete('image');
		
		return true;
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
			$output[$result['image_id']] = $this->getImage($result['image_id'],$width);
		}
		return $output;
	}
	
	//interest
	public function getImageByInterestId($interest_id,$width='') {
		$sql = "
				SELECT * 
				FROM " . $this->db->table('interest_image') . " 
				WHERE interest_id = '" . (int)$interest_id . "' 
				ORDER BY sort_order ASC
			";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['image_id']] = $this->getImage($result['image_id'],$width);
		}
		return $output;
	}
}

?>