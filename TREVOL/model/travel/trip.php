<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelTravelTrip extends Model{
	
	private $table = "trip";
	private $table_status = "trip_status";
	private $table_status_description = "trip_status_description";
	private $table_mode = "trip_mode";
	private $table_mode_description = "trip_mode_description";
	private $table_plan = "trip_plan";
	private $table_plan_description = "trip_plan_description";
	private $table_day = "trip_day";
	private $table_line = "trip_line";
	
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
			
			//START: run sql
				if($trip_id == '') {
					$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table) . " 
						ORDER BY trip_id DESC 
					";
				}
				else {
					$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table) . " 
						WHERE trip_id = '" . (int)$trip_id . "' 
					";
		
				}
				$query = $this->db->query($sql);
			//END
			
			//START: set output
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
			//END
			
			return $output;
		}
		
		public function addTrip($data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f])) {
						if($data[$f] == 'NULL') {
							$update[$f] = $f . " = NULL";
						}
						else {
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
						}
					}
				}
				if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set id 
				$trip_id = $this->db->getLastId();
			//END
			
			//START: clear cache
				$this->cache->delete('trip');
			//END
			
			//START: return
				return $trip_id;
			//END
		}
		
		public function editTrip($trip_id, $data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f])) {
						if($data[$f] == 'NULL') {
							$update[$f] = $f . " = NULL";
						}
						else {
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
						}
					}
				}
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				if(!empty($update)){
					$sql = "
						UPDATE " . $this->db->table($this->table) . " 
						SET " . implode(',', $update) . "
						WHERE trip_id = '" . (int)$trip_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: clear cache
				$this->cache->delete('trip');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteTrip($trip_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table) . " 
					WHERE trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('trip');
			//END
			
			//START: return
				return true;
			//END
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
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_status));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f]))
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
				}
				if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_status) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: get id
				$status_id = $this->db->getLastId();
				$data['status_id'] = $status_id;
			//END
			
			//START: run chain reaction
				$this->addStatusDescription($data);
			//END
			
			//START: clear cache
				$this->cache->delete('status');
			//END
			
			//START: return
				return $status_id;
			//END
		}
		
		public function editStatus($status_id, $data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_status));
				
				$update = array();
				foreach($fields as $f) {
					if(isset($data[$f])) {
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
				}
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				if(!empty($update)) {
					$sql = "
						UPDATE " . $this->db->table($this->table_status) . " 
						SET " . implode(',', $update) . "
						WHERE status_id = '" . (int)$status_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: run chain reaction
				if(isset($data['language_id'])) {
					$this->editStatusDescriptionByStatusIdAndLanguageId($status_id, $data['language_id'], $data);
				}
			//END
			
			//START: clear cache
				$this->cache->delete('status');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteStatus($status_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_status) . " 
					WHERE status_id = '" . (int)$status_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: run chain reaction
				$this->deleteStatusDescriptionByStatusId($status_id);
			//END
			
			//START: clear cache
				$this->cache->delete('status');
			//END
			
			//START: return
				return true;
			//END
		}
	//END
	
	//START: [status description]
		public function addStatusDescription($data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_status_description));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f]))
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
				}
				if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_status_description) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: get id
				$description_id = $this->db->getLastId();
			//END
			
			//START: clear cache
				$this->cache->delete('status_description');
			//END
			
			//START: return
				return $description_id;
			//END
		}
		
		public function editStatusDescriptionByStatusIdAndLanguageId($status_id, $language_id, $data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_status_description));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f]))
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
				}
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				if(!empty($update)){
					$sql = "
						UPDATE " . $this->db->table($this->table_status_description) . " 
						SET " . implode(',', $update) . "
						WHERE status_id = '" . (int)$status_id . "' 
						AND language_id = '" . (int)$language_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: clear cache
				$this->cache->delete('status_description');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteStatusDescriptionByStatusId($status_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_status_description) . " 
					WHERE status_id = '" . (int)$status_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('status_description');
			//END
			
			//START: return
				return true;
			//END
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
					ORDER BY t1.mode_id DESC 
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
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_mode));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f]))
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
				}
				if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_mode) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: get id
				$mode_id = $this->db->getLastId();
				$data['mode_id'] = $mode_id;
			//END
			
			//START: run chain reaction
				$this->addModeDescription($data);
			//END
			
			//START: clear cache
				$this->cache->delete('mode');
			//END
			
			//START: return
				return $mode_id;
			//END
		}
		
		public function editMode($mode_id, $data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_mode));
				
				$update = array();
				foreach($fields as $f) {
					if(isset($data[$f])) {
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
				}
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				if(!empty($update)) {
					$sql = "
						UPDATE " . $this->db->table($this->table_mode) . " 
						SET " . implode(',', $update) . "
						WHERE mode_id = '" . (int)$mode_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: run chain reaction
				if(isset($data['language_id'])) {
					$this->editModeDescriptionByModeIdAndLanguageId($mode_id, $data['language_id'], $data);
				}
			//END
			
			//START: clear cache
				$this->cache->delete('mode');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteMode($mode_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_mode) . " 
					WHERE mode_id = '" . (int)$mode_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: run chain reaction
				$this->deleteModeDescriptionByModeId($mode_id);
			//END
			
			//START: clear cache
				$this->cache->delete('mode');
			//END
			
			//START: return
				return true;
			//END
		}
	//END
	
	//START: [mode description]
		public function addModeDescription($data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_mode_description));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f]))
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
				}
				if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_mode_description) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: get id
				$description_id = $this->db->getLastId();
			//END
			
			//START: clear cache
				$this->cache->delete('mode_description');
			//END
			
			//START: return
				return $description_id;
			//END
		}
		
		public function editModeDescriptionByModeIdAndLanguageId($mode_id, $language_id, $data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_mode_description));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f]))
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
				}
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				if(!empty($update)){
					$sql = "
						UPDATE " . $this->db->table($this->table_mode_description) . " 
						SET " . implode(',', $update) . "
						WHERE mode_id = '" . (int)$mode_id . "' 
						AND language_id = '" . (int)$language_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: clear cache
				$this->cache->delete('mode_description');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteModeDescriptionByModeId($mode_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_mode_description) . " 
					WHERE mode_id = '" . (int)$mode_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('mode_description');
			//END
			
			//START: return
				return true;
			//END
		}
	//END
	
	//START: [plan]
		public function getPlan($plan_id='',$trip_id='') {
			$plan = array();
			
			//START: run sql
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
			//END
			
			//START: set output
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
			//END
			
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
				if(isset($data[$f])) {
					if($data[$f] == 'NULL') {
						$update[$f] = $f . " = NULL";
					}
					else {
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
				}
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
				if(isset($data[$f])) {
					if($data[$f] == 'NULL') {
						$update[$f] = $f . " = NULL";
					}
					else {
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
				}
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
		public function getDay($day_id='',$plan_id='') {
			$day = array();
			
			//START: run sql
				if($day_id == '') {
					$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table_day) . "
					";
					if($plan_id != '') { $sql .= " WHERE plan_id = '" . (int)$this->db->escape($plan_id) . "' "; }
					$sql .= "
						ORDER BY plan_id DESC, sort_order ASC 
					";
				}
				else {
					$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table_day) . " 
						WHERE day_id = '" . (int)$day_id . "' 
					";
		
				}
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($day_id == '') {
					foreach($query->rows as $result){
						$output[$result['day_id']] = $result;
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
				}
			//END
			
			//START: return
				return $output;
			//END
		}
		
		public function getDayByPlanId($plan_id) {
			return $this->getDay('',$plan_id);
		}
		
		public function addDay($data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_day));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f])) {
						if($data[$f] == 'NULL') {
							$update[$f] = $f . " = NULL";
						}
						else {
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
						}
					}
				}
				if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql	
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_day) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('day');
			//END
			
			//START: return
				$day_id = $this->db->getLastId();
				return $day_id;
			//END
		}
		
		public function editDay($day_id, $data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_day));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f])) {
						if($data[$f] == 'NULL') {
							$update[$f] = $f . " = NULL";
						}
						else {
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
						}
					}
				}
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				if(!empty($update)){
					$sql = "
						UPDATE " . $this->db->table($this->table_day) . " 
						SET " . implode(',', $update) . "
						WHERE day_id = '" . (int)$day_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: clear cache
				$this->cache->delete('day');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteDay($day_id) {
			//START: verify
				$day = $this->getDay($day_id);
				$plan_id = $day['plan_id'];
				$days = $this->getDayByPlanId($plan_id);
				if(count($days) <= 1) {
					$output['warning'][] = 'Cannot have less than one day.';
					return $output;
				}
			//END
			
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_day) . " 
					WHERE day_id = '" . (int)$day_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('day');
			//END
			
			//START: return
				return true;
			//END
		}
	//END
	
	//START: [line]
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
		
		public function getLineByPlanId($plan_id) {
			return $this->getLine('',$plan_id);
		}
		
		public function addLine($data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_line));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f])) {
					if($data[$f] == 'NULL') {
						$update[$f] = $f . " = NULL";
					}
					else {
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
				}
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
				if(isset($data[$f])) {
					if($data[$f] == 'NULL') {
						$update[$f] = $f . " = NULL";
					}
					else {
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
				}
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