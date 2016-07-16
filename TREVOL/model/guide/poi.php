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
		private $table_destination = "poi_destination";
		private $table_relation = "poi_relation";
		private $table_google = "poi_google";
		private $table_wikipedia = "poi_wikipedia";
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
		public function getPoi($poi_id='') {
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
			
			//START: Set Output
			if($poi_id == '') {
				foreach($query->rows as $result){
					$output[$result['poi_id']] = $result;
					$output[$result['poi_id']]['name'] = ucwords($result['name']);
					$output[$result['poi_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
					//START: set data for json
						//IMPORTANT: remember to load model at controller
						if(isset($result['tag_id'])) { $output[$result['poi_id']]['tag'] = $this->model_resource_tag->getTag($result['tag_id']); }
						if(isset($result['image_id'])) { 
							$output[$result['poi_id']]['image'] = $this->model_resource_image->getImage($result['image_id'],'30px');
						}
						else { 
							$google_image = $this->getPoiGoogleImageByPoiId($result['poi_id']);
							$image['path'] = $google_image[0]['url'];
							$image['name'] = ucwords($result['name']);
							$image['width'] = '30px';
							$output[$result['poi_id']]['image'] = $image;
						}
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
					if(isset($result['tag_id'])) { $output['tag'] = $this->model_resource_tag->getTag($result['tag_id']); }
					if(isset($result['image_id'])) { 
						$output['image'] = $this->model_resource_image->getImage($result['image_id'],'30px');
					}
					else { 
						$google_image = $this->getPoiGoogleImageByPoiId($result['poi_id']);
						$image['path'] = $google_image[0]['url'];
						$image['name'] = ucwords($result['name']);
						$image['width'] = '30px';
						$output['image'] = $image;
					}
				//END
			}
			//END
			
			return $output;
		}
		
		public function getPoiSummary($poi_id) {
			$result['alias'] = $this->getPoiAliasByPoiId($poi_id);
			$result['description'] = $this->getPoiDescriptionByPoiId($poi_id);
			$result['google'] = $this->getPoiGoogleByPoiId($poi_id);
			$result['wikipedia'] = $this->getPoiWikipediaByPoiId($poi_id);
			
			foreach($result as $key => $value) {
				$output[$key] = count($value); 
			}
			
			$output['poi_id'] = $poi_id;
			
			return $output;
		}
		
		public function addPoi($data) {
			//START: Run SQL
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
			
			//START: Run Chain Reaction
				$data['poi_id'] = $poi_id;
				$this->addPoiAlias($data);
				$this->addPoiDescription($data);
				if($data['g_place_id'] != '') { $this->addPoiGoogle($data); }
				if($data['w_title'] != '') { $this->addPoiWikipedia($data); }
			//END
			
			$this->cache->delete('poi');
			
			return $poi_id;
		}
		
		public function editPoi($poi_id, $data) {
			//START: Run SQL
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
						WHERE poi_id = '" . (int)$poi_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			$this->cache->delete('poi');
			return true;
		}
		
		public function deletePoi($poi_id) {
			//START: Run SQL
				$sql = "
					DELETE FROM " . $this->db->table($this->table) . " 
					WHERE poi_id = '" . (int)$poi_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: Run Chain Reaction
				$this->deletePoiAliasByPoiId($poi_id);
				$this->deletePoiDescriptionByPoiId($poi_id);
				$this->deletePoiGoogleByPoiId($poi_id);
				$this->deletePoiWikipediaByPoiId($poi_id);
			//END
			
			$this->cache->delete('poi');
			return true;
		}
		
		public function togglePoiStatus($poi_id) {
			//START: Run SQL
				$sql = "
					SELECT `status` 
					FROM " . $this->db->table($this->table) . " 
					WHERE  poi_id = '" . (int)$poi_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			$result = $query->row;
			$old_status = $result['status'];
			
			//START: Set New Status
			if($old_status == 0) {
				$new_status = 1;
			}
			else if($old_status == 1) 
			{
				$new_status = 0;
			}
			//END
			
			//START: Run SQL
			$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET status = '" . $new_status . "'
				WHERE poi_id = '" . (int)$poi_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('poi');
			return $new_status;
		}
	//END
	
	//START: [Alias]
		public function getPoiAlias($alias_id='',$poi_id='') {
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
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
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
		
		public function deletePoiAliasByPoiId($poi_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_alias) . " 
						WHERE poi_id = '" . (int)$poi_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_alias');
			return true;
		}
	//END
	
	//START: [Description]
		public function getPoiDescription($description_id='',$poi_id='') {
			//START: Run SQL
				if($description_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_description) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' 
						";
					}
					$sql .= "
						ORDER BY description_id DESC 
					";
				}
				else {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_description) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' AND t1.description_id = '" . (int)$description_id . "' 
						";
					}
					else {
						$sql .= "
							WHERE description_id = '" . (int)$description_id . "' 
						";
					}
				}
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				if($description_id == '') {
					foreach($query->rows as $result){
						$output[$result['description_id']] = $result;
						$output[$result['description_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
					$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				}
			//END
			
			return $output;
		}
		
		public function getPoiDescriptionByPoiId($poi_id) {
			return $this->getPoiDescription('',$poi_id);
		}
		
		public function addPoiDescription($data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_description));
					
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
						INSERT INTO `" . $this->db->table($this->table_description) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$description_id = $this->db->getLastId();
			
			$this->cache->delete('poi_description');
			
			return $description_id;
		}
		
		public function editPoiDescription($description_id, $data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_description));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_description) . " 
							SET " . implode(',', $update) . "
							WHERE description_id = '" . (int)$description_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('poi_description');
			return true;
		}
		
		public function deletePoiDescription($description_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_description) . " 
						WHERE description_id = '" . (int)$description_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_description');
			return true;
		}
		
		public function deletePoiDescriptionByPoiId($poi_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_description) . " 
						WHERE poi_id = '" . (int)$poi_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_description');
			return true;
		}
	//END
	
	//START: [Destination]
		public function getPoiDestination($relation_id='',$poi_id='') {
			//START: Run SQL
				if($relation_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_destination) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' 
						";
					}
					$sql .= "
						ORDER BY relation_id DESC 
					";
				}
				else {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_destination) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' AND t1.relation_id = '" . (int)$relation_id . "' 
						";
					}
					else {
						$sql .= "
							WHERE relation_id = '" . (int)$relation_id . "' 
						";
					}
				}
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				if($relation_id == '') {
					foreach($query->rows as $result){
						$output[$result['relation_id']] = $result;
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
				}
			//END
			
			return $output;
		}
		
		public function getPoiDestinationByPoiId($poi_id) {
			return $this->getPoiDestination('',$poi_id);
		}
		
		public function addPoiDestination($data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_destination));
					
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
						INSERT INTO `" . $this->db->table($this->table_destination) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$relation_id = $this->db->getLastId();
			
			$this->cache->delete('poi_destination');
			
			return $relation_id;
		}
		
		public function editPoiDestination($relation_id, $data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_destination));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_destination) . " 
							SET " . implode(',', $update) . "
							WHERE relation_id = '" . (int)$relation_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('poi_destination');
			return true;
		}
		
		public function deletePoiDestination($relation_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_destination) . " 
						WHERE relation_id = '" . (int)$relation_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_destination');
			return true;
		}
		
		public function deletePoiDestinationByPoiId($poi_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_destination) . " 
						WHERE poi_id = '" . (int)$poi_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_destination');
			return true;
		}
	//END
	
	//START: [Google]
		public function getPoiGoogle($google_id='',$poi_id='') {
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
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
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
		
		public function deletePoiGoogleByPoiId($poi_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_google) . " 
						WHERE poi_id = '" . (int)$poi_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_google');
			return true;
		}
	//END
	
	//START: [Wikipedia]
		public function getPoiWikipedia($wikipedia_id='',$poi_id='') {
			//START: Run SQL
				if($wikipedia_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_wikipedia) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' 
						";
					}
					$sql .= "
						ORDER BY wikipedia_id DESC 
					";
				}
				else {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_wikipedia) . " 
					";
					if($poi_id != '') {
						$sql .= "
							WHERE poi_id = '" . (int)$poi_id . "' AND t1.wikipedia_id = '" . (int)$wikipedia_id . "' 
						";
					}
					else {
						$sql .= "
							WHERE wikipedia_id = '" . (int)$wikipedia_id . "' 
						";
					}
				}
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				if($wikipedia_id == '') {
					foreach($query->rows as $result){
						$output[$result['wikipedia_id']] = $result;
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
				}
			//END
			
			return $output;
		}
		
		public function getPoiWikipediaByPoiId($poi_id) {
			return $this->getPoiWikipedia('',$poi_id);
		}
		
		public function addPoiWikipedia($data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_wikipedia));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f])) {
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
						}
					}
				
					if(isset($update['w_date_added'])) { $update['w_date_added'] = "w_date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
					if(isset($update['w_date_modified'])) { $update['w_date_modified'] = "w_date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
				//END
				
				//START: Run SQL
					$sql = "
						INSERT INTO `" . $this->db->table($this->table_wikipedia) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$wikipedia_id = $this->db->getLastId();
			
			$this->cache->delete('poi_wikipedia');
			
			return $wikipedia_id;
		}
		
		public function editPoiWikipedia($wikipedia_id, $data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_wikipedia));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
					}
					if(isset($update['w_date_modified'])) { $update['w_date_modified'] = "w_date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_wikipedia) . " 
							SET " . implode(',', $update) . "
							WHERE wikipedia_id = '" . (int)$wikipedia_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('poi_wikipedia');
			return true;
		}
		
		public function deletePoiWikipedia($wikipedia_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_wikipedia) . " 
						WHERE wikipedia_id = '" . (int)$wikipedia_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_wikipedia');
			return true;
		}
		
		public function deletePoiWikipediaByPoiId($poi_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_wikipedia) . " 
						WHERE poi_id = '" . (int)$poi_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('poi_wikipedia');
			return true;
		}
	//END
	
	//START: Extra
		public function getPoiGoogleImageByPoiId($poi_id) {
			//START: Run SQL
				$sql = "
					SELECT `g_photo`
					FROM " . $this->db->table($this->table_google) . " 
					WHERE poi_id = '" . (int)$poi_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: Set Result
				$result = $query->row;
			//END
			
			//START: Set Output
				$result = $result['g_photo'];
				$result = htmlspecialchars_decode($result);
				$result = json_decode($result,true);
				$output = $result;
			//END
			
			return $output;
		}
	//END
}

?>