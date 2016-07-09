<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelTravelActivity extends Model{
	
	private $table = "trip_activity";
	private $table_description = "trip_activity_description";
	
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
	
	public function getActivity($activity_id='',$line_id='') {
		$activity = array();
		
		if($activity_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.activity_id = t2.activity_id 
			";
			if($line_id != '') { $sql .= " WHERE t1.line_id = '" . (int)$this->db->escape($line_id) . "' "; }
			$sql .= "
				ORDER BY t1.activity_id DESC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.activity_id = t2.activity_id 
				WHERE t1.activity_id = '" . (int)$activity_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		//START: output
		if($activity_id == '') {
			foreach($query->rows as $result){
				$output[$result['activity_id']] = $result;
				$output[$result['activity_id']]['name'] = ucwords($result['name']);
				$output[$result['activity_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				$output[$result['activity_id']]['line'] = $this->model_travel_line->getLine($result['line_id']); //IMPORTANT: load model at controller
				$output[$result['activity_id']]['day'] = $this->model_travel_day->getDay($result['day_id']); //IMPORTANT:  load model at controller
				$output[$result['activity_id']]['tag'] = $this->model_resource_tag->getTag($result['tag_id']); //IMPORTANT:  load model at controller
				$output[$result['activity_id']]['image'] = $this->model_resource_image->getImage($result['image_id'],'30px'); //IMPORTANT:  load model at controller
			}
		}
		else {
			$result = $query->row;
			$output = $query->row;
			$output['name'] = ucwords($result['name']);
			$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
			$output['line'] = $this->model_travel_line->getLine($result['line_id']); //IMPORTANT: load model at controller
			$output['day'] = $this->model_travel_day->getDay($result['day_id']); //IMPORTANT:  load model at controller
			$output['tag'] = $this->model_resource_tag->getTag($result['tag_id']); //IMPORTANT: need to call model at controller
			$output['image'] = $this->model_resource_image->getImage($result['image_id'],'30px'); //IMPORTANT: need to call model at controller
		}
		//END
		
		return $output;
	}
	
	public function getActivityByLineId($line_id) {
		return $this->getActivity('',$line_id);
	}
	
	public function addActivity($data) {
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
		
		$activity_id = $this->db->getLastId();
		
		//START:table_description
		$fields = $this->getFields($this->db->table($this->table_description));
		
		$update = array();
		$update[] = "activity_id = '" . $activity_id. "'";
		
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
		
		$this->cache->delete('activity');
		
		return $activity_id;
	}
	
	public function editActivity($activity_id, $data) {
		//START: table
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		
		if(!empty($update)){
			$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET " . implode(',', $update) . "
				WHERE activity_id = '" . (int)$activity_id . "'
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
				WHERE activity_id = '" . (int)$activity_id . "'
			";
			$query = $this->db->query($sql);
		}
		//END
		
		$this->cache->delete('activity');
		return true;
	}
	
	public function deleteActivity($activity_id) {
		//START: table
		$sql = "
			DELETE FROM " . $this->db->table($this->table) . " 
			WHERE activity_id = '" . (int)$activity_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		//START: table_description
		$sql = "
			DELETE FROM " . $this->db->table($this->table_description) . " 
			WHERE activity_id = '" . (int)$activity_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		$this->cache->delete('activity');
		return true;
	}
}

?>