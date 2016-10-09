<?php
if(!defined('DIR_CORE')){
	header('Location: static_pages/');
}

class ModelExploreFavourite extends Model{
	//START: Set Table
		private $table = "favourite";
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
		public function getFavouriteByUserId($user_id) {
			//START: run sql
				$sql = "
					SELECT *
					FROM " . $this->db->table($this->table) . "
					WHERE user_id = '" . (int)$user_id . "'
				";
				$query = $this->db->query($sql);
			//END
			//START: Set Output
				$result = $query->rows;
				$output = array();
				if($query->num_rows == 0) {
					return false;
				}
				foreach($result as $key => $value) {
					$output[] = $result[$key]['place_id'];
				}
			//END
			return $output;
		}
		
		public function addFavourite($data) {
			/*
			//START: verify existance
				if(hasFavourite($data)) { return; }
			//END
			*/
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
			
			$favourite_id = $this->db->getLastId();
			
			//START: Run Chain Reaction
			//END
			
			$this->cache->delete('favourite');
			
			return $favourite_id;
		}
		
		public function deleteFavouriteByPlaceIdAndUserId($place_id, $user_id) {
			//START: run sql
				$sql = "
					DELETE FROM " . $this->db->table($this->table) . " 
					WHERE place_id = '" . $place_id . "' AND user_id = '" . (int)$user_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: run chain reaction
			//END
			
			//START: clear cache
				$this->cache->delete('favourite');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function hasFavourite($data) {
			//START: Run SQL
				$sql = "
					SELECT *
					FROM " . $this->db->table($this->table) . "
					WHERE user_id = '" . (int)$user_id . "' AND place_id = '" . (int)$place_id . "'
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
				else {
					$output = true;
				}
			//END
			return $output;
		}
	//END
}
?>