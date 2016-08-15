<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelTravelTrip extends Model{
	
	private $table = "trip";
	private $table_description = "trip_description";
	private $table_status = "trip_status";
	private $table_status_description = "trip_status_description";
	private $table_mode = "trip_mode";
	private $table_mode_description = "trip_mode_description";
	private $table_plan = "trip_plan";
	private $table_plan_description = "trip_plan_description";
	private $table_day = "trip_day";
	private $table_day_description = "trip_day_description";
	private $table_line = "trip_line";
	private $table_line_description = "trip_line_description";
	
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
	
	//START: [trip]
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
					$output[$result['trip_id']]['status'] = $this->getStatus($result['status_id']);
				}
			}
			else {
				$result = $query->row;
				$output = $query->row;
				$output['name'] = ucwords($result['name']);
				$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				$output['status'] = $this->getStatus($result['status_id']);
			}
			
			return $output;
		}
		
		public function addTrip($data) {
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
			
			$trip_id = $this->db->getLastId();
			
			//START:table_description
			$fields = $this->getFields($this->db->table($this->table_description));
			
			$update = array();
			$update[] = "trip_id = '" . $trip_id. "'";
			
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
			
			$this->cache->delete('trip');
			
			return $trip_id;
		}
		
		public function editTrip($trip_id, $data) {
			//table
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
					WHERE trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			}
			
			//table_description
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
					WHERE trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			}
			
			$this->cache->delete('trip');
			return true;
		}
		
		public function deleteTrip($trip_id) {
			//table
			$sql = "
				DELETE FROM " . $this->db->table($this->table) . " 
				WHERE trip_id = '" . (int)$trip_id . "'
			";
			$query = $this->db->query($sql);
			
			//table_description
			$sql = "
				DELETE FROM " . $this->db->table($this->table_description) . " 
				WHERE trip_id = '" . (int)$trip_id . "'
			";
			$query = $this->db->query($sql);
			
			$this->cache->delete('trip');
			return true;
		}
	//END
	
	//START: [status]
		public function getStatus($status_id='') {
			$status = array();
			
			if($status_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_status) . " t1 
					LEFT JOIN ".$this->db->table($this->table_status_description)." t2 
					ON t1.status_id = t2.status_id 
					ORDER BY t1.sort_order ASC 
				";
			}
			else {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_status) . " t1 
					LEFT JOIN ".$this->db->table($this->table_status_description)." t2 
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
			$fields = $this->getFields($this->db->table($this->table_status));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			$sql = "
				INSERT INTO `" . $this->db->table($this->table_status) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$status_id = $this->db->getLastId();
			
			//START:table_description
			$fields = $this->getFields($this->db->table($this->table_status_description));
			
			$update = array();
			$update[] = "status_id = '" . $status_id. "'";
			
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			
			$sql = "
				INSERT INTO `" . $this->db->table($this->table_status_description) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('status');
			
			return $status_id;
		}
		
		public function editStatus($status_id, $data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_status));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			if(!empty($update)){
				$sql = "
					UPDATE " . $this->db->table($this->table_status) . " 
					SET " . implode(',', $update) . "
					WHERE status_id = '" . (int)$status_id . "'
				";
				$query = $this->db->query($sql);
			}
			//END
			
			//START: table_description
			$fields = $this->getFields($this->db->table($this->table_status_description));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			
			if(!empty($update)){
				$sql = "
					UPDATE " . $this->db->table($this->table_status_description) . " 
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
				DELETE FROM " . $this->db->table($this->table_status) . " 
				WHERE status_id = '" . (int)$status_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			//START: table_description
			$sql = "
				DELETE FROM " . $this->db->table($this->table_status_description) . " 
				WHERE status_id = '" . (int)$status_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('status');
			return true;
		}
	//END
	
	//START: [mode]
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
		
		public function addMode($data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_mode));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			$sql = "
				INSERT INTO `" . $this->db->table($this->table_mode) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$mode_id = $this->db->getLastId();
			
			//START:table_description
			$fields = $this->getFields($this->db->table($this->table_mode_description));
			
			$update = array();
			$update[] = "mode_id = '" . $mode_id. "'";
			
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			
			$sql = "
				INSERT INTO `" . $this->db->table($this->table_mode_description) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('mode');
			
			return $mode_id;
		}
		
		public function editMode($mode_id, $data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_mode));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			if(!empty($update)){
				$sql = "
					UPDATE " . $this->db->table($this->table_mode) . " 
					SET " . implode(',', $update) . "
					WHERE mode_id = '" . (int)$mode_id . "'
				";
				$query = $this->db->query($sql);
			}
			//END
			
			//START: table_description
			$fields = $this->getFields($this->db->table($this->table_mode_description));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			
			if(!empty($update)){
				$sql = "
					UPDATE " . $this->db->table($this->table_mode_description) . " 
					SET " . implode(',', $update) . "
					WHERE mode_id = '" . (int)$mode_id . "'
				";
				$query = $this->db->query($sql);
			}
			//END
			
			$this->cache->delete('mode');
			return true;
		}
		
		public function deleteMode($mode_id) {
			//START: table
			$sql = "
				DELETE FROM " . $this->db->table($this->table_mode) . " 
				WHERE mode_id = '" . (int)$mode_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			//START: table_description
			$sql = "
				DELETE FROM " . $this->db->table($this->table_mode_description) . " 
				WHERE mode_id = '" . (int)$mode_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('mode');
			return true;
		}
	//END
	
	//START: [plan]
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
		
		public function getPlanByTripId($trip_id) {
			return $this->getPlan('',$trip_id);
		}
		
		public function addPlan($data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_plan));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			$sql = "
				INSERT INTO `" . $this->db->table($this->table_plan) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$plan_id = $this->db->getLastId();
			
			//START:table_description
			$fields = $this->getFields($this->db->table($this->table_plan_description));
			
			$update = array();
			$update[] = "plan_id = '" . $plan_id. "'";
			
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			
			$sql = "
				INSERT INTO `" . $this->db->table($this->table_plan_description) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('plan');
			
			return $plan_id;
		}
		
		public function editPlan($plan_id, $data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_plan));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			if(!empty($update)){
				$sql = "
					UPDATE " . $this->db->table($this->table_plan) . " 
					SET " . implode(',', $update) . "
					WHERE plan_id = '" . (int)$plan_id . "'
				";
				$query = $this->db->query($sql);
			}
			//END
			
			//START: table_description
			$fields = $this->getFields($this->db->table($this->table_plan_description));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			
			if(!empty($update)){
				$sql = "
					UPDATE " . $this->db->table($this->table_plan_description) . " 
					SET " . implode(',', $update) . "
					WHERE plan_id = '" . (int)$plan_id . "'
				";
				$query = $this->db->query($sql);
			}
			//END
			
			$this->cache->delete('plan');
			return true;
		}
		
		public function deletePlan($plan_id) {
			//START: table
			$sql = "
				DELETE FROM " . $this->db->table($this->table_plan) . " 
				WHERE plan_id = '" . (int)$plan_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			//START: table_description
			$sql = "
				DELETE FROM " . $this->db->table($this->table_plan_description) . " 
				WHERE plan_id = '" . (int)$plan_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('plan');
			return true;
		}
	//END
	
	//START: [day]
		public function getDay($day_id='',$line_id='') {
			$day = array();
			
			if($day_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_day) . " t1 
					LEFT JOIN ".$this->db->table($this->table_day_description)." t2 
					ON t1.day_id = t2.day_id 
				";
				if($line_id != '') { $sql .= " WHERE t1.line_id = '" . (int)$this->db->escape($line_id) . "' "; }
				$sql .= "
					ORDER BY t1.day_id DESC 
				";
			}
			else {
				$sql = "
					SELECT * 
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
		
		public function getDayByLineId($line_id) {
			return $this->getDay('',$line_id);
		}
		
		public function addDay($data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_day));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			$sql = "
				INSERT INTO `" . $this->db->table($this->table_day) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$day_id = $this->db->getLastId();
			
			//START:table_description
			$fields = $this->getFields($this->db->table($this->table_day_description));
			
			$update = array();
			$update[] = "day_id = '" . $day_id. "'";
			
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			
			$sql = "
				INSERT INTO `" . $this->db->table($this->table_day_description) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('day');
			
			return $day_id;
		}
		
		public function editDay($day_id, $data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_day));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			if(!empty($update)){
				$sql = "
					UPDATE " . $this->db->table($this->table_day) . " 
					SET " . implode(',', $update) . "
					WHERE day_id = '" . (int)$day_id . "'
				";
				$query = $this->db->query($sql);
			}
			//END
			
			//START: table_description
			$fields = $this->getFields($this->db->table($this->table_day_description));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			
			if(!empty($update)){
				$sql = "
					UPDATE " . $this->db->table($this->table_day_description) . " 
					SET " . implode(',', $update) . "
					WHERE day_id = '" . (int)$day_id . "'
				";
				$query = $this->db->query($sql);
			}
			//END
			
			$this->cache->delete('day');
			return true;
		}
		
		public function deleteDay($day_id) {
			//START: table
			$sql = "
				DELETE FROM " . $this->db->table($this->table_day) . " 
				WHERE day_id = '" . (int)$day_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			//START: table_description
			$sql = "
				DELETE FROM " . $this->db->table($this->table_day_description) . " 
				WHERE day_id = '" . (int)$day_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('day');
			return true;
		}
	//END
	
	//START: [line]
		public function getLine($line_id='',$plan_id='') {
			$line = array();
			
			if($line_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_line) . " 
				";
				if($plan_id != '') { 
					$sql .= " 
						WHERE plan_id = '" . (int)$this->db->escape($plan_id) . "' 
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
					$output[$result['line_id']]['plan'] = $this->getPlan($result['plan_id']);
				}
			}
			else {
				$output = $result = $query->row;
				$output['plan'] = $this->getPlan($result['plan_id']);
			}
			
			return $output;
		}
		
		public function getLineByPlanId($plan_id) {
			return $this->getLine('',$plan_id);
		}
		
		public function addLine($data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_line));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			$sql = "
				INSERT INTO `" . $this->db->table($this->table_line) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$line_id = $this->db->getLastId();
			
			$this->cache->delete('line');
			
			return $line_id;
		}
		
		public function editLine($line_id, $data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_line));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f]))
					$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
			}
			if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			
			if(!empty($update)){
				$sql = "
					UPDATE " . $this->db->table($this->table_line) . " 
					SET " . implode(',', $update) . "
					WHERE line_id = '" . (int)$line_id . "'
				";
				$query = $this->db->query($sql);
			}
			//END
			
			$this->cache->delete('line');
			return true;
		}
		
		public function deleteLine($line_id) {
			//START: table
			$sql = "
				DELETE FROM " . $this->db->table($this->table_line) . " 
				WHERE line_id = '" . (int)$line_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('line');
			return true;
		}
	//END
}

?>