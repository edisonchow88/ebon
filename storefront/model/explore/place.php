<?php
if(!defined('DIR_CORE')){
	header('Location: static_pages/');
}

class ModelExplorePlace extends Model{
	//START: Set Table
		private $table = "google";
		private $table_destination = "destination_google";
		private $table_poi = "poi_google";
	//END
	
	//START: Set Common Function
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
	//END
	
	//START: [General]
		public function getPlaceByPlaceId($place_id) {
			//START: run sql
				$sql = "
					(SELECT *, 'destination' as type, destination_id as type_id
					FROM " . $this->db->table($this->table_destination) . "
					WHERE g_place_id = '" . $place_id . "' )
					UNION
					(SELECT *, 'poi' as type, poi_id as type_id
					FROM " . $this->db->table($this->table_poi) . "
					WHERE g_place_id = '" . $place_id . "' )
					LIMIT 1
				";
				$query = $this->db->query($sql);
			//END
			//START: Set Output
				$result = $query->row;
				$output = $query->row;
				if($query->num_rows == 0) {
					$output = false;
				}
			//END
			return $output;
		}
	//END
	
	//START: [Google]
		public function verifyGoogleByPlaceId($place_id) {
			//START: run sql
				$sql = "
					SELECT g_place_id
					FROM " . $this->db->table($this->table) . "
					WHERE g_place_id = '" . $place_id . "'
					LIMIT 1
				";
				$query = $this->db->query($sql);
			//END
			//START: Set Output
				if($query->num_rows == 0) {
					$output = false;
				}
				else {
					$output = true;
				}
			//END
			return $output;
		}
		
		public function getGoogleByPlaceId($place_id) {
			//START: run sql
				$sql = "
					SELECT *
					FROM " . $this->db->table($this->table) . "
					WHERE g_place_id = '" . $place_id . "'
					LIMIT 1
				";
				$query = $this->db->query($sql);
			//END
			//START: Set Output
				$result = $query->row;
				$output = $query->row;
				if($query->num_rows == 0) {
					$output = false;
				}
			//END
			return $output;
		}
		
		public function addGoogle($data) {
			//START: Run SQL
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
				
				if(in_array('date_added',$fields)) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(in_array('date_modified',$fields)) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
				
				$sql = "
					INSERT INTO `" . $this->db->table($this->table) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			$google_id = $this->db->getLastId();
			
			//START: Run Chain Reaction
			//END
			
			$this->cache->delete('google');
			
			return $google_id;
		}
	//END
}
?>