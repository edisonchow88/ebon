<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelGuidePoi extends Model{
	
	private $table = "poi";
	private $table_description = "poi_description";
	private $table_image = "poi_image";
	private $table_tag = "poi_tag";
	private $table_relation = "poi_relation";
	
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
	
	public function getPoi($poi_id='') {
		$poi = array();
		
		if($poi_id == '') {
			$sql = "
				SELECT *, t1.poi_id
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.poi_id = t2.poi_id 
				LEFT JOIN ".$this->db->table($this->table_image)." t3
				ON t1.poi_id = t3.poi_id 
				LEFT JOIN ".$this->db->table($this->table_tag)." t4
				ON t1.poi_id = t4.poi_id 
				GROUP BY t1.poi_id 
				ORDER BY t1.poi_id DESC 
			";
		}
		else {
			$sql = "
				SELECT *, t1.poi_id 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.poi_id = t2.poi_id 
				LEFT JOIN ".$this->db->table($this->table_image)." t3 
				ON t1.poi_id = t3.poi_id 
				LEFT JOIN ".$this->db->table($this->table_tag)." t4
				ON t1.poi_id = t4.poi_id 
				GROUP BY t1.poi_id 
				WHERE t1.poi_id = '" . (int)$poi_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		//START: output
		if($poi_id == '') {
			foreach($query->rows as $result){
				$output[$result['poi_id']] = $result;
				$output[$result['poi_id']]['name'] = ucwords($result['name']);
				$output[$result['poi_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				//START: set data for json
				//IMPORTANT: remember to load model at controller
				if(isset($result['tag_id'])) $output[$result['poi_id']]['tag'] = $this->model_resource_tag->getTag($result['tag_id']);
				if(isset($result['image_id'])) $output[$result['poi_id']]['image'] = $this->model_resource_image->getImage($result['image_id'],'30px');
				//END
			}
		}
		else {
			$result = $query->row;
			$output = $query->row;
			$output['name'] = ucwords($result['name']);
			$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
			//START: set data for json
			//IMPORTANT: remember to load model at controller
			if(isset($result['tag_id'])) $output['tag'] = $this->model_resource_tag->getTag($result['tag_id']);
			if(isset($result['image_id'])) $output['image'] = $this->model_resource_image->getImage($result['image_id'],'30px');
			//END
		}
		//END
		
		return $output;
	}
	
	public function addPoi($data) {
		//START: table
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f])) {
				$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
		}
		
		if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
		if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
		
		$sql = "
			INSERT INTO `" . $this->db->table($this->table) . "` 
			SET " . implode(',', $update) . "
		";
		$query = $this->db->query($sql);
		//END
		
		$poi_id = $this->db->getLastId();
		
		//START:table_description
		$fields = $this->getFields($this->db->table($this->table_description));
		
		$update = array();
		$update[] = "poi_id = '" . $poi_id. "'";
		
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
		
		$this->cache->delete('poi');
		
		return $poi_id;
	}
	
	public function editPoi($poi_id, $data) {
		//START: table
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
		
		if(!empty($update)){
			$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET " . implode(',', $update) . "
				WHERE poi_id = '" . (int)$poi_id . "'
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
				WHERE poi_id = '" . (int)$poi_id . "'
			";
			$query = $this->db->query($sql);
		}
		//END
		
		$this->cache->delete('poi');
		return true;
	}
	
	public function deletePoi($poi_id) {
		//START: table
		$sql = "
			DELETE FROM " . $this->db->table($this->table) . " 
			WHERE poi_id = '" . (int)$poi_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		//START: table_description
		$sql = "
			DELETE FROM " . $this->db->table($this->table_description) . " 
			WHERE poi_id = '" . (int)$poi_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		$this->cache->delete('poi');
		return true;
	}
}

?>