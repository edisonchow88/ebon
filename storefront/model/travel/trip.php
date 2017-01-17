<?php
if(!defined('DIR_CORE')){
	header('Location: static_pages/');
}

class ModelTravelTrip extends Model{
	
	private $table = "trip";
	private $table_status = "trip_status";
	private $table_status_description = "trip_status_description";
	private $table_mode = "trip_mode";
	private $table_mode_description = "trip_mode_description";
	private $table_member = "trip_member";
	private $table_member_status = "trip_member_status";
	private $table_member_status_description = "trip_member_status_description";
	private $table_country = "trip_country";
	private $table_month = "trip_month";
	private $table_plan = "trip_plan";
	private $table_day = "trip_day";
	private $table_line = "trip_line";
	private $table_photo = "trip_photo";
	private $table_sample = "trip_sample";
	private $table_line_mode ="trip_line_mode";
	private $table_path = "path";
	private $table_path_custom = "path_custom";
	
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
		/*
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
				if($query->num_rows > 0) {
					if($trip_id == '') {
						foreach($query->rows as $result){
							$output[$result['trip_id']] = $result;
							$output[$result['trip_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
							$output[$result['trip_id']]['status'] = $this->getStatus($result['status_id']);
						}
					}
					else {
						$result = $query->row;
						$output = $query->row;
						$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
						$output['status'] = $this->getStatus($result['status_id']);
					}
				}
				else {
					return false;
				}
			//END
			
			return $output;
		}
		*/
		public function getTrip($trip_id) {
			//START: run sql
				$sql = "
					SELECT 
						t1.name, 
						t1.trip_id, 
						t1.user_id, 
						t1.date_modified, 
						t_user.email, 
						t_country_description.name as country,
						t_plan.plan_id, 
						t_plan.mode_id,
						t_plan.travel_date
					FROM " . $this->db->table($this->table) . " t1
					JOIN ".$this->db->table('user'). " t_user
					ON t1.user_id = t_user.user_id 
					JOIN ".$this->db->table($this->table_country). " t_country
					ON t1.trip_id = t_country.trip_id 
					JOIN ".$this->db->table('country_descriptions'). " t_country_description
					ON t_country.country_id = t_country_description.country_id 
					JOIN ".$this->db->table($this->table_plan). " t_plan
					ON t1.trip_id = t_plan.trip_id 
					WHERE t1.trip_id = ".$trip_id."
					GROUP BY t1.trip_id
				";
				$query = $this->db->query($sql);
			//END
			//START: set output
				$result = $query->row;
				//START
					$day = $this->getDayByPlanId($result['plan_id']);
					$num_of_day = count($day);
					$result['num_of_day'] = $num_of_day;
				//END
				//START
					$member = $this->getMemberByTripId($result['trip_id']);
					$num_of_member = count($member);
					$result['num_of_member'] = $num_of_member;
				//END
				$output = $result;
				return $output;
			//END
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
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
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
				
				//START: set data
					$country['trip_id'] = $trip_id;
					$country['country_id'] = $data['country_id'];
				//END
				
				$this->addCountry($country);
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
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
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
				$this->deleteSample("",$trip_id);
				$this->deleteTripPhotoByTripId($trip_id);
				$this->deleteCountryByTripId($trip_id);
				$this->deleteMemberByTripId($trip_id);
				
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
					ORDER BY t1.mode_id ASC 
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
	
	//START: [member]
		public function getMember($trip_member_id='') {
			$member = array();
			
			if($member_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_member) . " t1 
					LEFT JOIN ".$this->db->table($this->table_member_status)." t2 
					ON t1.status_id = t2.status_id
					LEFT JOIN ".$this->db->table($this->table_member_status_description)." t3 
					ON t1.status_id = t3.status_id
					ORDER BY t2.priority DESC, t1.fullname ASC
				";
			}
			else {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_member) . " t1 
					LEFT JOIN ".$this->db->table($this->table_member_status)." t2 
					ON t1.status_id = t2.status_id 
					LEFT JOIN ".$this->db->table($this->table_member_status_description)." t3 
					ON t1.status_id = t3.status_id 
					WHERE t1.trip_member_id = '" . (int)$trip_member_id . "' 
				";
	
			}
			$query = $this->db->query($sql);
			
			if($member_id == '') {
				foreach($query->rows as $result){
					$output[$result['trip_member_id']] = $result;
					$output[$result['trip_member_id']]['fullname'] = $result['fullname'];
				}
			}
			else {
				$result = $query->row;
				$output = $query->row;
				$output['fullname'] = $result['fullname'];
			}
			
			return $output;
		}
		
		public function getMemberByTripId($trip_id='') {
			//START: run sql
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_member) . " t1 
					LEFT JOIN ".$this->db->table($this->table_member_status)." t2 
					ON t1.status_id = t2.status_id 
					LEFT JOIN ".$this->db->table($this->table_member_status_description)." t3 
					ON t1.status_id = t3.status_id 
					WHERE t1.trip_id = '" . (int)$trip_id . "' 
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				foreach($query->rows as $result){
					$output[$result['trip_member_id']] = $result;
					$output[$result['trip_member_id']]['fullname'] = $result['fullname'];
				}
			//END
			
			return $output;
		}
		
		public function addMember($data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_member));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f]))
						$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
				}
				if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_member) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: get id
				$trip_member_id = $this->db->getLastId();
				$data['trip_member_id'] = $trip_member_id;
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('member');
			//END
			
			//START: return
				return $trip_member_id;
			//END
		}
		
		public function editMember($trip_member_id, $data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_member));
				
				$update = array();
				foreach($fields as $f) {
					if(isset($data[$f])) {
						$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
					}
				}
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				if(!empty($update)) {
					$sql = "
						UPDATE " . $this->db->table($this->table_member) . " 
						SET " . implode(',', $update) . "
						WHERE trip_member_id = '" . (int)$trip_member_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('member');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteMember($trip_member_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_member) . " 
					WHERE trip_member_id = '" . (int)$trip_member_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('member');
			//END
			
			//START: return
				return true;
			//END
		}
        
        public function deleteMemberByTripId($trip_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_member) . " 
					WHERE trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('member');
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
				if($query->num_rows > 0) {
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
				}
				else {
					return false;
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
				$this->sortDay($plan_id);
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
		
		public function sortDay($plan_id) {
			$day = $this->getDayByPlanId($plan_id);
			$i = 0;
			foreach($day as $d) {
				$i += 1;
				$data['sort_order'] = $i;
				$this->editDay($d['day_id'],$data);
			}
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
						$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
					}
				}
			}
			if(isset($update['currency']) && $data['currency'] != 'NULL') { 
				$update['currency'] = "currency = '" . $this->db->escape(strtoupper($data['currency'])) . "'"; 
			}
			if(isset($update['title']) && $data['title'] != 'NULL') { 
				$update['title'] = "title = '" . $this->db->escape($data['title']) . "'"; 
			}
			if(isset($update['description']) && $data['description'] != 'NULL') { 
				$update['description'] = "description = '" . $this->db->escape($data['description']) . "'"; 
			}
			if(isset($update['note']) && $data['note'] != 'NULL') { 
				$update['note'] = "note = '" . $this->db->escape($data['note']) . "'"; 
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
			if(isset($update['currency']) && $data['currency'] != 'NULL') { 
				$update['currency'] = "currency = '" . $this->db->escape(strtoupper($data['currency'])) . "'"; 
			}
			if(isset($update['title']) && $data['title'] != 'NULL') { 
				$update['title'] = "title = '" . $this->db->escape($data['title']) . "'"; 
			}
			if(isset($update['description']) && $data['description'] != 'NULL') { 
				$update['description'] = "description = '" . $this->db->escape($data['description']) . "'"; 
			}
			if(isset($update['note']) && $data['note'] != 'NULL') { 
				$update['note'] = "note = '" . $this->db->escape($data['note']) . "'"; 
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
	
	//START: [extra]
		public function getPlanDetail($plan_id) {
			$plan = $this->getPlan($plan_id);
			$day = $this->getDayByPlanId($plan_id);
			foreach($day as $key => $value) {
				$day[$key]['line'] = array_values($this->getLineByDayId($key));
			}
			$day = array_values($day);
			$plan['day'] = $day;
			return $plan;
		}
		
		public function getTripByUserId($user_id) {
			$trip = array();
			
			//START: run sql
				$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table) . " 
						WHERE user_id = '" . (int)$user_id . "' 
						ORDER BY status_id DESC
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($query->num_rows > 0) {
					foreach($query->rows as $result){
						$output[$result['trip_id']] = $result;
						$output[$result['trip_id']]['status'] = $this->getStatus($result['status_id']);
					}
				}
				else {
					return false;
				}
			//END
			
			return $output;
		}
		
		public function getUpcomingTripByUserId($user_id) {
			$trip = array();
			
			//START: run sql
				$sql = "
						SELECT t1.status_id AS `member_status_id`, t2.*, t2.user_id AS `host_id`, t3.plan_id, t3.travel_date, COUNT(t4.day_id) AS `num_of_day`
						FROM " . $this->db->table($this->table_member) . " t1
						LEFT JOIN ".$this->db->table($this->table)." t2 
						ON t1.trip_id = t2.trip_id 
						LEFT JOIN ".$this->db->table($this->table_plan)." t3 
						ON t1.trip_id = t3.trip_id 
						LEFT JOIN ".$this->db->table($this->table_day)." t4 
						ON t3.plan_id = t4.plan_id 
						AND t3.selected = 1
						WHERE t1.user_id = '" . (int)$user_id . "'
						AND t1.status_id > 1
						AND t1.removed = 0
						GROUP BY t1.trip_id
						ORDER BY t3.travel_date ASC, t2.name ASC
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($query->num_rows > 0) {
					foreach($query->rows as $result){
						$output[$result['trip_id']] = $result;
						if($result['status_id'] == 1) {
							$output[$result['trip_id']]['type'] = 'upcoming';
						}
						else if($result['status_id'] == 0) {
							$output[$result['trip_id']]['type'] = 'cancelled';
						}
						if(isset($result['travel_date'])) {
							$output[$result['trip_id']]['end_date'] = date('Y-m-d', strtotime('+'.($result['num_of_day'] - 1).' days',strtotime($result['travel_date'])));
							if(date('Y-m-d') > $output[$result['trip_id']]['end_date']) { unset($output[$result['trip_id']]); }
						}
					}
				}
				else {
					return false;
				}
			//END
			
			return $output;
		}
		
		public function getPastTripByUserId($user_id) {
			$trip = array();
			
			//START: run sql
				$sql = "
						SELECT t1.status_id AS `member_status_id`, t2.*, t2.user_id AS `host_id`, t3.plan_id, t3.travel_date, COUNT(t4.day_id) AS `num_of_day`
						FROM " . $this->db->table($this->table_member) . " t1
						LEFT JOIN ".$this->db->table($this->table)." t2 
						ON t1.trip_id = t2.trip_id 
						LEFT JOIN ".$this->db->table($this->table_plan)." t3 
						ON t1.trip_id = t3.trip_id 
						LEFT JOIN ".$this->db->table($this->table_day)." t4 
						ON t3.plan_id = t4.plan_id 
						AND t3.selected = 1
						WHERE t1.user_id = '" . (int)$user_id . "'
						AND t1.status_id > 1
						AND t1.removed = 0
						AND NOT(t3.travel_date IS NULL)
						GROUP BY t1.trip_id
						ORDER BY t3.travel_date ASC
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($query->num_rows > 0) {
					foreach($query->rows as $result){
						$output[$result['trip_id']] = $result;
						if($result['status_id'] == 1) {
							$output[$result['trip_id']]['type'] = 'past';
						}
						else if($result['status_id'] == 0) {
							$output[$result['trip_id']]['type'] = 'cancelled';
						}
						if(isset($result['travel_date'])) {
							$output[$result['trip_id']]['end_date'] = date('Y-m-d', strtotime('+'.($result['num_of_day'] - 1).' days',strtotime($result['travel_date'])));
							if(date('Y-m-d') <= $output[$result['trip_id']]['end_date']) { unset($output[$result['trip_id']]); }
						}
					}
				}
				else {
					return false;
				}
			//END
			
			return $output;
		}
		
		public function getInvitedTripByUserId($user_id) {
			$trip = array();
			
			//START: run sql
				$sql = "
						SELECT t1.status_id AS `member_status_id`, t2.*, t2.user_id AS `host_id`, t3.plan_id, t3.travel_date, COUNT(t4.day_id) AS `num_of_day`
						FROM " . $this->db->table($this->table_member) . " t1
						LEFT JOIN ".$this->db->table($this->table)." t2 
						ON t1.trip_id = t2.trip_id 
						LEFT JOIN ".$this->db->table($this->table_plan)." t3 
						ON t1.trip_id = t3.trip_id 
						LEFT JOIN ".$this->db->table($this->table_day)." t4 
						ON t3.plan_id = t4.plan_id 
						AND t3.selected = 1
						WHERE t1.user_id = '" . (int)$user_id . "'
						AND t1.status_id = 1
						AND t1.removed = 0
						GROUP BY t1.trip_id
						ORDER BY t3.travel_date ASC, t2.name ASC
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($query->num_rows > 0) {
					foreach($query->rows as $result){
						$output[$result['trip_id']] = $result;
						$output[$result['trip_id']]['type'] = 'invited';
						if(isset($result['travel_date'])) {
							$output[$result['trip_id']]['end_date'] = date('Y-m-d', strtotime('+'.($result['num_of_day'] - 1).' days',strtotime($result['travel_date'])));
						}
					}
				}
				else {
					return false;
				}
			//END
			
			return $output;
		}
		
		public function getRemovedTripByUserId($user_id) {
			$trip = array();
			
			//START: run sql
				$sql = "
						SELECT t1.status_id AS `member_status_id`, t2.*, t2.user_id AS `host_id`, t3.plan_id, t3.travel_date, COUNT(t4.day_id) AS `num_of_day`
						FROM " . $this->db->table($this->table_member) . " t1
						LEFT JOIN ".$this->db->table($this->table)." t2 
						ON t1.trip_id = t2.trip_id 
						LEFT JOIN ".$this->db->table($this->table_plan)." t3 
						ON t1.trip_id = t3.trip_id 
						LEFT JOIN ".$this->db->table($this->table_day)." t4 
						ON t3.plan_id = t4.plan_id 
						AND t3.selected = 1
						WHERE t1.user_id = '" . (int)$user_id . "'
						AND t1.removed = 1
						AND t1.deleted = 0
						GROUP BY t1.trip_id
						ORDER BY t3.travel_date ASC, t2.name ASC
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($query->num_rows > 0) {
					foreach($query->rows as $result){
						$output[$result['trip_id']] = $result;
						$output[$result['trip_id']]['type'] = 'removed';
						if(isset($result['travel_date'])) {
							$output[$result['trip_id']]['end_date'] = date('Y-m-d', strtotime('+'.($result['num_of_day'] - 1).' days',strtotime($result['travel_date'])));
						}
					}
				}
				else {
					return false;
				}
			//END
			
			return $output;
		}
		
		public function getActiveTripByUserId($user_id) {
			$trip = array();
			
			//START: run sql
				$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table) . " 
						WHERE user_id = '" . (int)$user_id . "' 
						AND removed = 0
						ORDER BY status_id DESC
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($query->num_rows > 0) {
					foreach($query->rows as $result){
						$output[$result['trip_id']] = $result;
						$output[$result['trip_id']]['status'] = $this->getStatus($result['status_id']);
					}
				}
				else {
					return false;
				}
			//END
			
			return $output;
		}
		
		/*
		
		public function getRemovedTripByUserId($user_id) {
			$trip = array();
			
			//START: run sql
				$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table) . " 
						WHERE user_id = '" . (int)$user_id . "' 
						AND removed = 1
						ORDER BY status_id DESC
				";
				$query = $this->db->query($sql);
			//END
			
			//START: set output
				if($query->num_rows > 0) {
					foreach($query->rows as $result){
						$output[$result['trip_id']] = $result;
						$output[$result['trip_id']]['status'] = $this->getStatus($result['status_id']);
					}
				}
				else {
					return false;
				}
			//END
			
			return $output;
		}
		*/
		
		public function removeUserOfTrip($user_id,$trip_id) {
			//START: run sql
				$sql = "
					UPDATE " . $this->db->table($this->table_member) . " 
					SET removed = '1'
					WHERE user_id = '" . (int)$user_id . "'
					AND trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('trip_member');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function restoreUserOfTrip($user_id,$trip_id) {
			//START: run sql
				$sql = "
					UPDATE " . $this->db->table($this->table_member) . " 
					SET removed = '0'
					WHERE user_id = '" . (int)$user_id . "'
					AND trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('trip_member');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteUserOfTrip($user_id,$trip_id) {
			//START: run sql
				$sql = "
					UPDATE " . $this->db->table($this->table_member) . " 
					SET deleted = '1'
					WHERE user_id = '" . (int)$user_id . "'
					AND trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('trip_member');
			//END
			
			//START: verify condition to delete trip completely
				$sql = "
					SELECT COUNT(user_id) AS `num_of_deleted_user`
					FROM " . $this->db->table($this->table_member) . " 
					WHERE deleted = '1'
					AND trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
				$result = $query->row;
				
				$sql = "
					SELECT COUNT(user_id) AS `num_of_user`
					FROM " . $this->db->table($this->table_member) . " 
					WHERE trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
				$result2 = $query->row;
				
				if($result['num_of_deleted_user'] == $result2['num_of_user']) { 
					$this->deleteTrip($trip_id);
				}
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function cancelTrip($trip_id) {
			//START: run sql
				$sql = "
					UPDATE " . $this->db->table($this->table) . " 
					SET status_id = '0'
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
		
		public function resumeTrip($trip_id) {
			//START: run sql
				$sql = "
					UPDATE " . $this->db->table($this->table) . " 
					SET status_id = '1'
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
	
	//START: [country]
		public function getCountry($trip_country_id='') {
			if($trip_country_id == '') {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_country) . "
					ORDER BY priority DESC, country_id ASC
				";
			}
			else {
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_country) . "
					WHERE trip_country_id = '" . (int)$trip_country_id . "' 
				";
	
			}
			$query = $this->db->query($sql);
			
			if($trip_country_id == '') {
				foreach($query->rows as $result){
					$output[$result['trip_country_id']] = $result;
				}
			}
			else {
				$result = $query->row;
				$output = $query->row;
			}
			
			return $output;
		}
        
        public function getCountryByTripId($trip_id) {
        	//START: run sql
                $sql = "
                    SELECT * 
                    FROM " . $this->db->table($this->table_country) . "
                    WHERE trip_id = '" . (int)$trip_id . "' 
					ORDER BY priority DESC, country_id ASC
                ";
				$query = $this->db->query($sql);
            //END
            
            //START: set output
            	foreach($query->rows as $result){
					$output[$result['trip_country_id']] = $result;
				}
            //END
            
            //START: return output
            	return $output;
            //END
        }
		
		public function addCountry($data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_country));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f]))
						$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
				}
				if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_country) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: get id
				$trip_country_id = $this->db->getLastId();
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('trip_country');
			//END
			
			//START: return
				return $trip_country_id;
			//END
		}
		
		public function editCountry($trip_country_id, $data) {
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_country));
				
				$update = array();
				foreach($fields as $f) {
					if(isset($data[$f])) {
						$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
					}
				}
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
			//END
			
			//START: run sql
				if(!empty($update)) {
					$sql = "
						UPDATE " . $this->db->table($this->table_country) . " 
						SET " . implode(',', $update) . "
						WHERE trip_country_id = '" . (int)$trip_country_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('trip_country');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteCountry($trip_country_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_country) . " 
					WHERE trip_country_id = '" . (int)$trip_country_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('trip_country');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deleteCountryByTripId($trip_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table_country) . " 
					WHERE trip_id = '" . (int)$trip_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('trip_country');
			//END
			
			//START: return
				return true;
			//END
		}
	
		public function getSample($country_id) {
			
			if(!$country_id) {
				$sql = "
					SELECT *
					FROM " . $this->db->table($this->table_sample) . "
					ORDER BY ranking DESC
				";
			}
			
			else {
				//retrive sample_id with selected country id
				$sql = "
					SELECT " . $this->db->table($this->table_country) . ".trip_id
					FROM " . $this->db->table($this->table_country) . ", " . $this->db->table($this->table_sample) . "
					WHERE " . $this->db->table($this->table_country) . ".trip_id = " . $this->db->table($this->table_sample) . ".trip_id
					AND " . $this->db->table($this->table_country) . ".country_id = '" .$country_id. "' 
					ORDER BY ranking DESC
				";	
					
			}
			$query = $this->db->query($sql);
			
			//echo $query->row; return;
			
			foreach($query->rows as $sample_trip_id){
				$sql = "
						SELECT * 
						FROM " . $this->db->table($this->table) . " 
						WHERE trip_id = '" . $sample_trip_id['trip_id'] . "' 
				";	
				
				$query = $this->db->query($sql);
				
				$sql = "
						SELECT " . $this->db->table($this->table_day) . ".day_id
						FROM " . $this->db->table($this->table_plan) . " , " . $this->db->table($this->table_day) . "
						WHERE " . $this->db->table($this->table_plan) . ".plan_id = " . $this->db->table($this->table_day) . ".plan_id
						AND trip_id = '" . $sample_trip_id['trip_id'] . "' 
				";	
				
				$query2 = $this->db->query($sql); 
				$no_of_day = COUNT($query2);
				
				$output[$sample_trip_id['trip_id']]	= $query->row;
			}

			return $output;
			}
	//END
	//START: [template]
		public function getTemplateByFilter($country_id="",$month="",$mode_id="",$duration="") {
			//START: set sql
				$sql_country = "";
				$sql_month = "";
				$sql_mode = "";
				
				if($country_id != "" && $country_id != 0) { 
					$sql_country_condition = "
						AND t_country.country_id = ".$country_id."
					";
				}
				if($month != "" && $month != 0) { 
					$sql_month_condition = "
						AND t_month.month = ".$month."
					";
				}
				if($mode_id != "" && $mode_id != 0) { 
					$sql_mode_condition = "
						AND t_plan.mode_id = ".$mode_id."
					";
				}
				$sql = "
					SELECT 
						t1.name, 
						t1.trip_id, 
						t1.user_id, 
						t1.date_modified, 
						t_user.email, 
						t_country_description.name as country,
						t_plan.plan_id, 
						t_plan.mode_id, 
						group_concat(DISTINCT t_month.month ORDER BY t_month.month ASC) as month
					FROM " . $this->db->table($this->table) . " t1
					JOIN ".$this->db->table('user'). " t_user
					ON t1.user_id = t_user.user_id 
					JOIN ".$this->db->table($this->table_country). " t_country
					ON t1.trip_id = t_country.trip_id 
					JOIN ".$this->db->table('country_descriptions'). " t_country_description
					ON t_country.country_id = t_country_description.country_id 
					JOIN ".$this->db->table($this->table_month). " t_month
					ON t1.trip_id = t_month.trip_id 
					JOIN ".$this->db->table($this->table_plan). " t_plan
					ON t1.trip_id = t_plan.trip_id 
					WHERE t1.templated = 1
					".$sql_country_condition."
					".$sql_month_condition."
					".$sql_mode_condition."
					GROUP BY t1.trip_id
				";
				$query = $this->db->query($sql);
			//END
			//START: set output
				if($query->num_rows > 0) {
					foreach($query->rows as $result){
						$day = $this->getDayByPlanId($result['plan_id']);
						$num_of_day = count($day);
						$result['month'] = explode(',',$result['month']);
						$result['num_of_day'] = $num_of_day;
						if($duration == "" || $duration == 0) { 
							$output[$result['trip_id']] = $result;
						}
						else {
							if($num_of_day == $duration) { 
								$output[$result['trip_id']] = $result;
							}
						}
					}
				}
				else {
					return false;
				}
			//END
			
			return $output;	
		}
	//END
	
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
	
		public function getActiveMode() {
			
				//retrive transport mode with selected line_id
				$sql = "
					SELECT * 
					FROM " . $this->db->table($this->table_mode) . " t1 
					LEFT JOIN ".$this->db->table($this->table_mode_description)." t2 
					ON t1.mode_id = t2.mode_id 
					WHERE t1.status = '1'
					ORDER BY t1.mode_id DESC 
				";	
				$query = $this->db->query($sql);
				$output = $query->rows;
							
				return $output;
			}
		//END
	
	
		public function addLineMode($line_id, $mode_id) {
			if (!$mode_id) $mode_id = "2";
			
			if(!$line_id) {
				return;
			}else {
				//add new line with given mode
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_line_mode) . "` 
					SET line_id = '" .$line_id. "', mode_id = '" .$mode_id. "'
				";	
			}
			
			$query = $this->db->query($sql);
			
			if ($query == true) {
				$output['line_id'] = $line_id;
				$output['mode_id'] = $mode_id;
				return $output;
			}else {
				return false;									
			}
		}
		//END
		
		public function editLineMode($line_id, $mode_id, $path_id, $path_custom_id) {
			if (!$mode_id) $mode_id = "2";
			if (!$path_id) $path_id ="0";
			if(!$line_id) {
				return;
			}else {
				//add new line with given mode
				$sql = "
					UPDATE `" . $this->db->table($this->table_line_mode) . "` 
					SET mode_id = '" .$mode_id. "', path_id = '" . $path_id. "', path_custom_id = '" . $path_custom_id. "'
					WHERE line_id = '" .$line_id. "'
				";	
			}
			
			$query = $this->db->query($sql);
			
			if ($query == true) {
				$output = $mode_id;
				return $output;
			}else {
				return false;									
			}
		}
		//END
		
		public function getLineMode($line_id) {
			
			if(!$line_id) {
				return;
			}else {
				//retrive transport mode with selected line_id
				$sql = "
					SELECT line_id, mode_id, path_id,path_custom_id
					FROM " . $this->db->table($this->table_line_mode) . "
					WHERE line_id = '" .$line_id. "' 	
				";				
			}
				$query = $this->db->query($sql);
				$output = $query->row;
										
				return $output;
			}
	//END
		
		public function getPathById($path_id) {
			if(!$path_id) {
				return;
			}else {
				$sql = "
					SELECT path_id, distance, duration, path
					FROM " . $this->db->table($this->table_path) . "
					WHERE path_id = '" .$path_id. "' 	
				";				
			}
				$query = $this->db->query($sql);
				$output = $query->row;
										
				return $output;
			}
	//END
		
		public function getPathByCoor($coor, $mode_id) {

			if($coor && $mode_id) {
				$sql = "
					SELECT *
					FROM " . $this->db->table($this->table_path) . "
					WHERE mode_id = '" .$mode_id. "' 
					AND ori_lat = ".$coor['ori_lat']." 
					AND ori_lng = ".$coor['ori_lng']." 
					AND des_lat = ".$coor['des_lat']."
					AND des_lng = ".$coor['des_lng']."				
				";				
			}
				$query = $this->db->query($sql);
				$output = $query->row;
				
			return $output;
		}
		
		public function getCustomPathByPathId($path_id, $user_id) {

			if($path_id && $user_id ) {
				$sql = "
					SELECT *
					FROM " . $this->db->table($this->table_path_custom) . "
					WHERE path_id = '" .$path_id. "' 	
					AND user_id = '" .$user_id. "'		
				";				
			}
				$query = $this->db->query($sql);
				$output = $query->row;
				
			return $output;
		}
		
		public function getCustomPathAuto($path_id) {

			if($path_id) {
				$distance_sql = "
					SELECT distance
					FROM " . $this->db->table($this->table_path_custom) . "
					WHERE path_id = '" .$path_id. "'
					AND distance != '0'
					ORDER BY distance ASC
				";				
				
				$duration_sql = "
					SELECT duration
					FROM " . $this->db->table($this->table_path_custom) . "
					WHERE path_id = '" .$path_id. "'
					AND duration != '0'
					ORDER BY duration ASC
				";				
				
				}
	
			$query = $this->db->query($distance_sql);			
			$query2 = $this->db->query($duration_sql);		
			foreach($query->rows as $result){
				$list['distance'][] = $result['distance'];
				
			}
			foreach($query2->rows as $result){
				$list['duration'][] = $result['duration'];
				
			}
			
			$count_distance = COUNT($list['distance']);
			$count_duration = COUNT($list['duration']);
			if ($count_distance> 12) {
				$middle_index_distance = floor($count_distance/2);
				sort($list['distance'], SORT_NUMERIC);
				$output['distance_median'] = $list['distance'][$middle_index_distance];
				
				if ($count_distance % 2 == 0) {
					$output['distance_median']= ($output['distance_median'] + $list['distance'][$middle_index_distance - 1]) / 2;
				}
			}
			
			if ($count_duration> 12) {
				$middle_index_duration = floor($count_duration/2);
				sort($list['duration'], SORT_NUMERIC);
				$output['duration_median'] = $list['duration'][$middle_index_duration];
				
				if ($count_duration % 2 == 0) {
					$output['duration_median']= ($output['duration_median'] + $list['duration'][$middle_index_duration - 1]) / 2;
				}
			}
			//$output['distancelist']= $list['distance'];
			//$output['durationlist']= $list['duration'];
			// problem with median 
			// if the range between both value seperate too much
			return $output;
			
			/* // mean (averange) of value
			if($path_id) {
				$distance_sql = "
					SELECT distance,duration
					FROM " . $this->db->table($this->table_path_custom) . "
					WHERE path_id = '" .$path_id. "'
				";				
				}
				
			
						
				
			$query = $this->db->query($distance_sql);
			$count_distance= 0;
			$count_duration= 0;	
			foreach($query->rows as $result){
				if ($result['distance'] != 0) {
					$output['distance'][] = $result['distance'];
					$count_distance ++;
				}
				if ($result['duration'] != 0) {
					$output['duration'][] = $result['duration'];
					$count_duration ++;
				]
			}
								
			if ($count_distance>12) {
				$output['distance_mean'] = array_sum($output['distance'])/$count_distance;
			}
			if ($count_duration>12) {
				$output['duration_mean'] = array_sum($output['duration'])/$count_duration;
			}*/	
		}
		
		
		
		
		/*public function add_line_mode($data){
			
			//set data
			$fields = $this->getFields($this->db->table($this->table_line_mode));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f]))
						$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
				}
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_line_mode) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			//START: get id
				$trip_line_mode_id = $this->db->getLastId();
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('trip_line_mode');
			//END
			
			//START: return
				return $trip_line_mode_id;
			//END
	}
*/
	public function addPath($data){
			//verify:
			$path = $this->getPathByCoor($data['coor'], $data['mode_id']);
						
			if (!$path) { 
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_path));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f])) {
						if($data[$f] == 'NULL') {
							$update[$f] = $f . " = NULL";
						}
						else {
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
						}
					}
				}
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_path) . "` 
					SET " . implode(',', $update) . "
				";
								
				$query = $this->db->query($sql);
			//END
	
			//START: get id
				$path_id = $this->db->getLastId();
			//END
			
			//START: run chain reaction
				$this->editLineMode($data['line_id'], $data['mode_id'], $path_id);
			//END
	
			//START: clear cache
				$this->cache->delete('path');
			//END
		
			//START: return
				return $path_id;
			//END
			}	
	}
	
	public function addCustomPath($data){
			//verify:
			$path = $this->getCustomPathByPathId($data['path_id'], $data['user_id']);
									
			if (!$path) { 
			//START: set data
				$fields = $this->getFields($this->db->table($this->table_path_custom));
				
				$update = array();
				foreach($fields as $f){
					if(isset($data[$f])) {
						if($data[$f] == 'NULL') {
							$update[$f] = $f . " = NULL";
						}
						else {
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
						}
					}
				}
			//END
			
			//START: run sql
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_path_custom) . "` 
					SET " . implode(',', $update) . "
				";
								
				$query = $this->db->query($sql);
			//END
	
			//START: get id
				$path_custom_id = $this->db->getLastId();
			//END
			
			//START: run chain reaction
				$this->editLineMode($data['line_id'], $data['mode_id'], $path_id, $path_custom_id);
			//END
	
			//START: clear cache
				$this->cache->delete('path_custom');
			//END
		
			//START: return
				return $path_custom_id;
			//END
			}		
	}
	
	public function editCustomPath($data){
			
			$fields = $this->getFields($this->db->table($this->table_path_custom));
			
			$update = array();
			foreach($fields as $f){
				if(isset($data[$f])) {
					if($data[$f] == 'NULL') {
						$update[$f] = $f . " = NULL";
					}
					else {
						$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
					}
				}
			}
		//END
		
		//START: run sql
			$sql = "
				UPDATE " . $this->db->table($this->table_path_custom) . " 
				SET " . implode(',', $update) . "
				WHERE path_id = '" .$data['path_id']. "'	
				AND user_id = '" .$data['user_id']. "'
				AND path_custom_id = '" .$data['path_custom_id']. "'
			";
									
			$query = $this->db->query($sql);
		//END

		//START: get id
			if ($query) $path_custom_id = $data['path_custom_id'];
		//END
		
		//START: run chain reaction
			$this->editLineMode($data['line_id'], $data['mode_id'], $data['path_id'], $path_custom_id);
		//END

		//START: clear cache
			$this->cache->delete('path_custom');
		//END
	
		//START: return
			return $path_custom_id;
		//END
				
	}
}

?>