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
}
?>