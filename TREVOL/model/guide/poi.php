<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelGuidePoi extends Model{
	
	//START: Set Table
		private $table = "poi";
		private $table_alias = "poi_alias";
		private $table_description = "poi_description";
		private $table_image = "poi_image";
		private $table_tag = "poi_tag";
		private $table_relation = "poi_relation";
		private $table_google = "poi_google";
		private $table_wikipedia = "poi_wikipedia";
	//END
	
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
				LEFT JOIN ".$this->db->table($this->table_alias)." t2 
				ON t2.alias_id = ( SELECT tt2.alias_id 
					FROM ".$this->db->table($this->table_alias)." AS tt2 
					WHERE tt2.poi_id = t1.poi_id
					ORDER BY tt2.ranking DESC
					LIMIT 1
				)
				LEFT JOIN ".$this->db->table($this->table_description)." t3 
				ON t1.poi_id = t3.poi_id 
				LEFT JOIN ".$this->db->table($this->table_image)." t4
				ON t1.poi_id = t4.poi_id 
				LEFT JOIN ".$this->db->table($this->table_tag)." t5
				ON t1.poi_id = t5.poi_id 
				GROUP BY t1.poi_id 
				ORDER BY t1.poi_id DESC 
			";
		}
		else {
			$sql = "
				SELECT *, t1.poi_id 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_alias)." t2 
				ON t2.alias_id = ( SELECT tt2.alias_id 
					FROM ".$this->db->table($this->table_alias)." AS tt2 
					WHERE tt2.poi_id = t1.poi_id
					ORDER BY tt2.ranking DESC
					LIMIT 1
				)
				LEFT JOIN ".$this->db->table($this->table_description)." t3 
				ON t1.poi_id = t3.poi_id 
				LEFT JOIN ".$this->db->table($this->table_image)." t4
				ON t1.poi_id = t4.poi_id 
				LEFT JOIN ".$this->db->table($this->table_tag)." t5
				ON t1.poi_id = t5.poi_id 
				WHERE t1.poi_id = '" . (int)$poi_id . "' 
				GROUP BY t1.poi_id 
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
	
	//START: [Alias]
		public function getPoiAlias($alias_id='',$poi_id='') {
			$alias = array();
			
			//START: Run SQL
				if($alias_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_alias) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' 
						";
					}
					$sql .= "
						ORDER BY alias_id DESC 
					";
				}
				else {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_alias) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' AND t1.alias_id = '" . (int)$alias_id . "' 
						";
					}
					else {
						$sql .= "
							WHERE alias_id = '" . (int)$alias_id . "' 
						";
					}
				}
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				if($alias_id == '') {
					foreach($query->rows as $result){
						$output[$result['alias_id']] = $result;
						$output[$result['alias_id']]['name'] = ucwords($result['name']);
						$output[$result['alias_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
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
		
		public function getPoiAliasByPoiId($poi_id) {
			return $this->getPoiAlias('',$poi_id);
		}
		
		public function addPoiAlias($data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_alias));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f])) {
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
						}
					}
				
					if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
				//END
				
				//START: Run SQL
					$sql = "
						INSERT INTO `" . $this->db->table($this->table_alias) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$alias_id = $this->db->getLastId();
			
			$this->cache->delete('poi_alias');
			
			return $alias_id;
		}
		
		public function editPoiAlias($alias_id, $data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_alias));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_alias) . " 
							SET " . implode(',', $update) . "
							WHERE alias_id = '" . (int)$alias_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('poi_alias');
			return true;
		}
		
		public function deletePoiAlias($alias_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_alias) . " 
						WHERE alias_id = '" . (int)$alias_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_alias');
			return true;
		}
	//END
	
	//START: [Google]
		public function getPoiGoogle($google_id='',$poi_id='') {
			$google = array();
			
			//START: Run SQL
				if($google_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_google) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' 
						";
					}
					$sql .= "
						ORDER BY google_id DESC 
					";
				}
				else {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_google) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' AND t1.google_id = '" . (int)$google_id . "' 
						";
					}
					else {
						$sql .= "
							WHERE google_id = '" . (int)$google_id . "' 
						";
					}
				}
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				if($google_id == '') {
					foreach($query->rows as $result){
						$output[$result['google_id']] = $result;
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
				}
			//END
			
			return $output;
		}
		
		public function getPoiGoogleByPoiId($poi_id) {
			return $this->getPoiGoogle('',$poi_id);
		}
		
		public function addPoiGoogle($data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_google));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f])) {
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
						}
					}
				
					if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
				//END
				
				//START: Run SQL
					$sql = "
						INSERT INTO `" . $this->db->table($this->table_google) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$google_id = $this->db->getLastId();
			
			$this->cache->delete('poi_google');
			
			return $google_id;
		}
		
		public function editPoiGoogle($google_id, $data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_google));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[] = $f . " = '" . $this->db->escape($data[$f]) . "'";
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_google) . " 
							SET " . implode(',', $update) . "
							WHERE google_id = '" . (int)$google_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('poi_google');
			return true;
		}
		
		public function deletePoiGoogle($google_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_google) . " 
						WHERE google_id = '" . (int)$google_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_google');
			return true;
		}
	//END
}

?>