<?php
if(!defined('DIR_CORE')){
	header('Location: static_pages/');
}

class ModelTravelTrip extends Model{
	
	private $table = "trip";
	private $table_description = "trip_description";
	private $table_plan = "trip_plan";
	private $table_plan_description = "trip_plan_description";
	private $table_mode = "trip_mode";
	private $table_mode_description = "trip_mode_description";
	private $table_line = "trip_line";
	private $table_day = "trip_day";
	private $table_day_description = "trip_day_description";
	private $table_activity = "trip_activity";
	private $table_activity_description = "trip_activity_description";
	
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
	
	//START: [Trip]
		public function getTrip($trip_id='') {
			$trip = array();
			
			if($trip_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table) . " t1 
					LEFT JOIN ".$this->db->table($this->table_description)." t2 
					ON t1.trip_id = t2.trip_id 
					ORDER BY t1.travel_date DESC 
				";
			}
			else {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table) . " t1 
					LEFT JOIN ".$this->db->table($this->table_description)." t2 
					ON t1.trip_id = t2.trip_id 
					WHERE t1.trip_id = '" . (int)$trip_id . "' 
				";
	
			}
			$query = $this->db->query($sql);
			
			if($trip_id == '') {
				foreach($query->rows as $result){
					$output[$result['trip_id']] = $result;
					$output[$result['trip_id']]['name'] = ucwords($result['name']);
					$output[$result['trip_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
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
	//END
	
	//START: [Plan]
		public function getPlan($plan_id='',$trip_id='') {
			$plan = array();
			
			if($plan_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_plan) . " t1 
					LEFT JOIN ".$this->db->table($this->table_plan_description)." t2 
					ON t1.plan_id = t2.plan_id 
				";
				if($trip_id != '') { $sql .= " WHERE t1.trip_id = '" . (int)$this->db->escape($trip_id) . "' "; }
				$sql .= "
					ORDER BY t1.trip_id DESC, t1.sort_order ASC 
				";
			}
			else {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_plan) . " t1 
					LEFT JOIN ".$this->db->table($this->table_plan_description)." t2 
					ON t1.plan_id = t2.plan_id 
					WHERE t1.plan_id = '" . (int)$plan_id . "' 
				";
	
			}
			$query = $this->db->query($sql);
			
			if($plan_id == '') {
				foreach($query->rows as $result){
					$output[$result['plan_id']] = $result;
					$output[$result['plan_id']]['name'] = ucwords($result['name']);
					$output[$result['plan_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
					$output[$result['plan_id']]['trip'] = $this->getTrip($result['trip_id']);
					$output[$result['plan_id']]['mode'] = $this->getMode($result['mode_id']);
				}
			}
			else {
				$result = $query->row;
				$output = $query->row;
				$output['name'] = ucwords($result['name']);
				$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				$output['trip'] = $this->getTrip($result['trip_id']);
				$output['mode'] = $this->getMode($result['mode_id']);
			}
			
			return $output;
		}
	//END
	
	//START: [Mode]
		public function getMode($mode_id='') {
			$mode = array();
			
			if($mode_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_mode) . " t1 
					LEFT JOIN ".$this->db->table($this->table_mode_description)." t2 
					ON t1.mode_id = t2.mode_id 
					ORDER BY t2.name ASC 
				";
			}
			else {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_mode) . " t1 
					LEFT JOIN ".$this->db->table($this->table_mode_description)." t2 
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
	//END
	
	//START: [Line]
		public function getLine($line_id='',$day_id='') {
			$line = array();
			
			if($line_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_line) . " 
				";
				if($day_id != '') { 
					$sql .= " 
						WHERE day_id = '" . (int)$this->db->escape($day_id) . "' 
					"; 
				}
				$sql .= "
					ORDER BY sort_order ASC 
				";
			}
			else {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_line) . " 
					WHERE line_id = '" . (int)$line_id . "' 
				";
	
			}
			$query = $this->db->query($sql);
			
			if($line_id == '') {
				foreach($query->rows as $result){
					$output[$result['line_id']] = $result;
				}
			}
			else {
				$output = $result = $query->row;
			}
			
			return $output;
		}
		
		public function getLineByDayId($day_id) {
			return $this->getLine('',$day_id);
		}
	//END
	
	//START: [day]
		public function getDay($day_id='',$plan_id='') {
			$day = array();
			
			if($day_id == '') {
				$sql = "
					SELECT *, t1.day_id
					FROM " . $this->db->table($this->table_day) . " t1 
					LEFT JOIN ".$this->db->table($this->table_day_description)." t2 
					ON t1.day_id = t2.day_id 
				";
				if($plan_id != '') { $sql .= " WHERE t1.plan_id = '" . (int)$this->db->escape($plan_id) . "' "; }
				$sql .= "
					ORDER BY t1.sort_order ASC 
				";
			}
			else {
				$sql = "
					SELECT *, t1.day_id 
					FROM " . $this->db->table($this->table_day) . " t1 
					LEFT JOIN ".$this->db->table($this->table_day_description)." t2 
					ON t1.day_id = t2.day_id 
					WHERE t1.day_id = '" . (int)$day_id . "' 
				";
	
			}
			$query = $this->db->query($sql);
			
			//START: output
			if($day_id == '') {
				foreach($query->rows as $result){
					$output[$result['day_id']] = $result;
					$output[$result['day_id']]['name'] = ucwords($result['name']);
					$output[$result['day_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				}
			}
			else {
				$result = $query->row;
				$output = $query->row;
				$output['name'] = ucwords($result['name']);
				$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
			}
			//END
			
			return $output;
		}
		
		/*
		public function getDayByLineId($line_id) {
			return $this->getDay('',$line_id);
		}
		*/
		
		public function getDayByPlanId($plan_id) {
			return $this->getDay('',$plan_id);
		}
	//END
	
	//START: [activity]
		public function getActivity($activity_id='',$line_id='') {
			$activity = array();
			
			if($activity_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_activity) . " t1 
					LEFT JOIN ".$this->db->table($this->table_activity_description)." t2 
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
					FROM " . $this->db->table($this->table_activity) . " t1 
					LEFT JOIN ".$this->db->table($this->table_activity_description)." t2 
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
					/*
					$output[$result['activity_id']]['line'] = $this->getLine($result['line_id']);
					$output[$result['activity_id']]['day'] = $this->getDay($result['day_id']);
					$output[$result['activity_id']]['tag'] = $this->model_resource_tag->getTag($result['tag_id']); //IMPORTANT:  load model at controller
					$output[$result['activity_id']]['image'] = $this->model_resource_image->getImage($result['image_id'],'30px'); //IMPORTANT:  load model at controller
					*/
				}
			}
			else {
				$result = $query->row;
				$output = $query->row;
				$output['name'] = ucwords($result['name']);
				$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				/*
				$output['line'] = $this->getLine($result['line_id']);
				$output['day'] = $this->getDay($result['day_id']);
				$output['tag'] = $this->model_resource_tag->getTag($result['tag_id']); //IMPORTANT: need to call model at controller
				$output['image'] = $this->model_resource_image->getImage($result['image_id'],'30px'); //IMPORTANT: need to call model at controller
				*/
			}
			//END
			
			return $output;
		}
		
		public function getActivityByLineId($line_id) {
			return $this->getActivity('',$line_id);
		}
	//END
	
	//START: [combo]
		public function getPlanDetail($plan_id) {
			$day = $this->getDayByPlanId($plan_id);
			
			foreach($day as $day_id => $d) {
				unset($line); //reset
				$line = $this->getLineByDayId($d['day_id']);
				if(count($line) > 0) {
					foreach($line as $line_id => $l) {
						if($l['type'] == 'poi') {
							$content = $this->getActivity($l['id']);
						}
						$line[$line_id]['content'] = $content;
					}
					$line = array_values($line);
					$day[$day_id]['line'] = $line;
					$day[$day_id]['percentage'] = count($line)*10;
				}
				else {
					$day[$day_id]['line'] = '';
					$day[$day_id]['percentage'] = 0;
				}
			}
			$day = array_values($day);
			
			$output['day'] = $day;
		
			return $output;
		}
	//END
}

?>