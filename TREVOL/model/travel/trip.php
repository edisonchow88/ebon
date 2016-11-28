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
	private $table_day = "trip_day";
	private $table_line = "trip_line";
	private $table_photo = "trip_photo";
	private $table_sample = "trip_sample";
	
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
			
			//START: generate code
				$id = str_pad($trip_id, 4, '0', STR_PAD_LEFT);
				$index[0] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
				$index[1] = 'abcdefghijklmnopqrstuvwxyz';
				$index[2] = '987654321';
				$index['a'] = $index[0].$index[1].$index[0].$index[1];
				$index['b'] = $index[0].$index[2].$index[1].$index[0].$index[2].$index[1];
				$index['c'] = $index[1].$index[0].$index[2].$index[1].$index[0].$index[2];
				$index['d'] = $index[1].$index[2].$index[0].$index[1].$index[2].$index[0];
				$index['e'] = $index[2].$index[0].$index[1].$index[2].$index[0].$index[1];
				$index['f'] = $index[2].$index[1].$index[0].$index[2].$index[1].$index[0];
				$year = gmdate('y');
				$month = gmdate('m');
				$day = gmdate('d');
				$minute = gmdate('i');
				$second = gmdate('s');
				$id1 = substr($id,-1,1);
				$id2 = substr($id,-2,1);
				$id3 = substr($id,-3,1);
				$code = '';
				$code .= substr($index['a'],$second,1);
				$code .= substr($index['c'],$day,1);
				$code .= substr($index['e'],$id1,1);
				$code .= substr($index['b'],$month,1);
				$code .= substr($index['d'],$id3,1);
				$code .= substr($index['f'],$year,1);
				$code .= substr($index['a'],$id2,1);
				$code .= substr($index['d'],$minute,1);
				
				$sql = "
					UPDATE " . $this->db->table($this->table) . " 
					SET code = '" . $code . "'
					WHERE trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: run chain reaction
				//START: set data
					$plan['trip_id'] = $trip_id;
					$plan['mode_id'] = 1;
					$plan['name'] = 'Plan 1';
					$plan['sort_order'] = 1;
					$plan['selected'] = 1;
					$plan['travel_date'] = NULL;
				//END
				$this->addPlan($plan);
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
			
			//START: run chain reaction
				$this->deletePlanByTripId($trip_id);
				$this->deleteTripPhotoByTripId($trip_id);
				$this->deleteSample("",$trip_id);
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
						FROM " . $this->db->table($this->table_plan) . " 
					";
					if($trip_id != '') { $sql .= " WHERE trip_id = '" . (int)$this->db->escape($trip_id) . "' "; }
					$sql .= "
						ORDER BY trip_id DESC, sort_order ASC 
					";
				}
				else {
					$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table_plan) . " 
						WHERE plan_id = '" . (int)$plan_id . "' 
					";
		
				}
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($plan_id == '') {
					foreach($query->rows as $result){
						$output[$result['plan_id']] = $result;
						$output[$result['plan_id']]['name'] = ucwords($result['name']);
						$output[$result['plan_id']]['trip'] = $this->getTrip($result['trip_id']);
						$output[$result['plan_id']]['mode'] = $this->getMode($result['mode_id']);
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
					$output['name'] = ucwords($result['name']);
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
			//START: set data
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
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_plan) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set id
				$plan_id = $this->db->getLastId();
			//END
			
			//START: run chain reaction
				//START: set data
					$day['plan_id'] = $plan_id;
					$day['sort_order'] = 1;
				//END
				$this->addDay($day);
			//END
			
			//START: clear cache
				$this->cache->delete('plan');
			//END
			
			return $plan_id;
		}
		
		public function editPlan($plan_id, $data) {
			//START: set data
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
			//END
			
			//START: run sql
				if(!empty($update)){
					$sql = "
						UPDATE " . $this->db->table($this->table_plan) . " 
						SET " . implode(',', $update) . "
						WHERE plan_id = '" . (int)$plan_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: clear cache
				$this->cache->delete('plan');
			//END
			
			return true;
		}
		
		public function deletePlan($plan_id) {
			//START: verify
				$plan = $this->getPlan($plan_id);
				$trip_id = $plan['trip_id'];
				$plans = $this->getPlanByTripId($trip_id);
				if(count($plans) <= 1) {
					$output['warning'][] = '<b>Trip</b> cannot have less than one plan.';
					return $output;
				}
			//END
			
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_plan) . " 
					WHERE plan_id = '" . (int)$plan_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: run chain reaction
				$this->deleteDayByPlanId($plan_id);
			//END
			
			//START: clear cache
				$this->cache->delete('plan');
			//END
			
			return true;
		}
		
		public function deletePlanByTripId($trip_id) {
			//START: get all child
				$plan = $this->getPlanByTripId($trip_id);
			//END
			
			//START: run chain reaction
				foreach($plan as $p) {
					$this->deleteDayByPlanId($p['plan_id']);
				}
			//END
			
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_plan) . " 
					WHERE trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('plan');
			//END
			
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
					$output['warning'][] = '<b>Plan</b> cannot have less than one day.';
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
			
			//START: run chain reaction
				$this->deleteLineByDayId($day_id);
			//END
			
			//START: clear cache
				$this->cache->delete('day');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteDayByPlanId($plan_id) {
			//START: get all child
				$day = $this->getDayByPlanId($plan_id);
			//END
			
			//START: run chain reaction
				foreach($day as $d) {
					$this->deleteLineByDayId($d['day_id']);
				}
			//END
			
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_day) . " 
					WHERE plan_id = '" . (int)$plan_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('day');
			//END
			
			return true;
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
		
		public function getLineByDayId($day_id) {
			return $this->getLine('',$day_id);
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
		
		public function deleteLineByDayId($day_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_line) . " 
					WHERE day_id = '" . (int)$day_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('line');
			//END
			
			return true;
		}
	//END
	
	//START: [photo]
		public function getTripPhoto($trip_photo_id='',$trip_id='') {
			$photo = array();
			
			if($trip_photo_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_photo) . " 
				";
				if($trip_id != '') { 
					$sql .= " 
						WHERE trip_id = '" . (int)$this->db->escape($trip_id) . "' 
					"; 
				}
				$sql .= "
					ORDER BY sort_order ASC 
				";
			}
			else {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_photo) . " 
					WHERE trip_photo_id = '" . (int)$trip_photo_id . "' 
				";
	
			}
			$query = $this->db->query($sql);
			
			if($trip_photo_id == '') {
				foreach($query->rows as $result){
					$output[$result['trip_photo_id']] = $result;
				}
			}
			else {
				$output = $result = $query->row;
			}
			
			return $output;
		}
		
		public function getTripPhotoByTripId($trip_id) {
			return $this->getTripPhoto('',$trip_id);
		}
		
		public function addTripPhoto($data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_photo));
			
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
				INSERT INTO `" . $this->db->table($this->table_photo) . "` 
				SET " . implode(',', $update) . "
			";
			$query = $this->db->query($sql);
			//END
			
			$trip_photo_id = $this->db->getLastId();
			
			$this->cache->delete('photo');
			
			return $trip_photo_id;
		}
		
		public function editTripPhoto($trip_photo_id, $data) {
			//START: table
			$fields = $this->getFields($this->db->table($this->table_photo));
			
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
					UPDATE " . $this->db->table($this->table_photo) . " 
					SET " . implode(',', $update) . "
					WHERE trip_photo_id = '" . (int)$trip_photo_id . "'
				";
				$query = $this->db->query($sql);
			}
			//END
			
			$this->cache->delete('photo');
			return true;
		}
		
		public function deleteTripPhoto($trip_photo_id) {
			//START: table
			$sql = "
				DELETE FROM " . $this->db->table($this->table_photo) . " 
				WHERE trip_photo_id = '" . (int)$trip_photo_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('photo');
			return true;
		}
		
		public function deleteTripPhotoByTripId($trip_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_photo) . " 
					WHERE trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('photo');
			//END
			
			return true;
		}
	//END
	
		public function getSampleExist($trip_id) {
			//START: run sql
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_sample) . " 
					WHERE trip_id = '" . (int)$trip_id . "' 
				";
				$query = $this->db->query($sql);
				$output = $query->row;
			//END

			return $output;
		}
	//END
		
		public function getSample($sample_id='') {
			$trip = array();
			
			//START: run sql
				if($sample_id == '') {
					$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table_sample) . " 
						ORDER BY sample_id DESC 
					";
				}
				else {
					$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table_sample) . " 
						WHERE sample_id = '" . (int)$sample_id . "' 
					";
		
				}
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($sample_id == '') {
					foreach($query->rows as $result){
						$output[$result['sample_id']] = $result;
						$output[$result['sample_id']]['trip_id'] = ucwords($result['trip_id']);
						$output[$result['sample_id']]['status'] = $result['status'];
						$output[$result['sample_id']]['ranking'] = $result['ranking'];
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
				}
			//END
			
			return $output;
		}
		
		public function addSample($data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_sample));
				
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
					INSERT INTO `" . $this->db->table($this->table_sample) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set id
				//$sample_id = $this->db->getLastId();
			  	$return['sample_id'] = $this->db->getLastId();
				$return['trip_id'] = $data['trip_id'];
			//END
			
			//START: clear cache
				$this->cache->delete('sample');
			//END
			
			
			return $return;
		}
		
		public function editSample($sample_id, $data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_sample));
				
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
			//END
			
			//START: run sql
				if(!empty($update)){
					$sql = "
						UPDATE " . $this->db->table($this->table_sample) . " 
						SET " . implode(',', $update) . "
						WHERE sample_id = '" . (int)$sample_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: clear cache
				$this->cache->delete('sample');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteSample($sample_id ="",$trip_id ="") {
			if ($sample_id != "") {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_sample) . " 
					WHERE sample_id = '" . (int)$sample_id . "'
				";
			
			}else if ($trip_id != "") {
				$sql = "
					DELETE FROM " . $this->db->table($this->table_sample) . " 
					WHERE trip_id = '" . (int)$trip_id . "'
				";			
			}
			$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('sample');
			//END
			
			//START: return
				return true;
			//END
		}
	//END
}


?>