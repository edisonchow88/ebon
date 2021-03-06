<?php
if(!defined('DIR_CORE')){
	header('Location: static_pages/');
}

class ModelResourceImage extends Model{
	
	private $table = "image";
	private $table_tag = "image_tag";
	private $path = "resources/image/cropped/";
	private $default_width = "120px";
	
	public function getImage($image_id='',$width='') {
		if($image_id == '0') { return; } //avoid return an array
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
				$output[$result['image_id']]['image'] = "<img id='image-".$output[$result['image_id']]['image_id']."' src='".$output[$result['image_id']]['path']."' title='".$output[$result['image_id']]['name']."' width='".$width."'/>";
			}
		}
		else {
			$output = $query->row;
			$output['name'] = ucwords($output['name']);
			$output['width'] = $width;
			$output['path'] = $this->path.$output['filename'];
			$output['image'] = "<img id='image-".$output['image_id']."' src='".$output['path']."' title='".$output['name']."' width='".$width."'/>";
		}
		
		return $output;
	}
	
	public function getImageByKeyword($keyword='',$width='',$limit='',$offset='') {
		if($width=='') { $width = $this->default_width; }
		//START: Run SQL
			$sql = "
				SELECT SQL_CALC_FOUND_ROWS DISTINCT image_id, name, filename
				FROM " . $this->db->table($this->table) . " 
				WHERE name LIKE '%".$keyword."%' 
				ORDER BY name asc 
			";
			if($limit != '') {
				$sql .= "LIMIT ".$limit." ";
			}
			if($offset != '') {
				$sql .= "OFFSET ".$offset." ";
			}
			$query = $this->db->query($sql);
		//END
		
		//START: Set Output
			foreach($query->rows as $result) {
				$output[$result['image_id']] = $result;
				$output[$result['image_id']]['name'] = ucwords($result['name']);
				$output[$result['image_id']]['width'] = $width;
				$output[$result['image_id']]['path'] = $this->path.$result['filename'];
				$output[$result['image_id']]['image'] = "<img id='image-".$output[$result['image_id']]['image_id']."' src='".$output[$result['image_id']]['path']."' title='".$output[$result['image_id']]['name']."' width='".$width."'/>";
			}
		//END
		
		//START: Run SQL
			$sql = "
				SELECT FOUND_ROWS() AS `count`;
			";
			$query = $this->db->query($sql);
		//END
		
		//START: Set Output
			$output['count'] = $query->row['count'];
		//END
		
		return $output;
	}
	
	public function addImage($data) {
		$sql = "
				INSERT INTO `" . $this->db->table($this->table) . "` 
				SET 
					name = '" . $this->db->escape(strtolower($data['name'])) . "', 
					size = '" . $this->db->escape($data['size']) . "', 
					photographer = '" . $this->db->escape($data['photographer']) . "', 
					link = '" . $this->db->escape($data['link']) . "', 
					image_source_id = '" . $this->db->escape($data['image_source_id']) . "', 
					image_license_id = '" . $this->db->escape($data['image_license_id']) . "', 
					date_added = NOW(), 
					date_modified = NOW() 
			";
		$query = $this->db->query($sql);
		
		$image_id = $this->db->getLastId();
		
		$sql = "UPDATE " . $this->db->table($this->table) . " 
			SET 
				filename = '" . $image_id . $this->db->escape($data['image_type']) . "' 
			WHERE image_id = '" . (int)$image_id . "'
		";
		$query = $this->db->query($sql);
		
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
		//delete image file
		$image = $this->getImage($image_id);
		if(unlink($image['path'])) {
		
		//delete row from database
		$sql = "
				DELETE FROM " . $this->db->table($this->table) . " 
				WHERE image_id = '" . (int)$image_id . "'
			";
		$query = $this->db->query($sql);
		
		//delete cache
		$this->cache->delete('image');
		
		return true;
		}
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