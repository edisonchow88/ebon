<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelGuideDestination extends Model{
	
	//START: Set Table
		private $table = "destination";
		private $table_alias = "destination_alias";
		private $table_description = "destination_description";
		private $table_image = "destination_image";
		private $table_tag = "destination_tag";
		private $table_relation = "destination_relation";
		private $table_google = "destination_google";
		private $table_wikipedia = "destination_wikipedia";
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
		public function getDestination($destination_id='',$keyword='') {
			if($destination_id == '') {
				$sql = "
					SELECT *, t1.destination_id
					FROM " . $this->db->table($this->table) . " t1 
					LEFT JOIN ".$this->db->table($this->table_alias)." t2 
					ON t2.alias_id = ( SELECT tt2.alias_id 
						FROM ".$this->db->table($this->table_alias)." AS tt2 
						WHERE tt2.destination_id = t1.destination_id
						ORDER BY tt2.ranking DESC
						LIMIT 1
					)
					LEFT JOIN ".$this->db->table($this->table_description)." t3 
					ON t1.destination_id = t3.destination_id 
					LEFT JOIN ".$this->db->table($this->table_image)." t4
					ON t1.destination_id = t4.destination_id 
					LEFT JOIN ".$this->db->table($this->table_tag)." t5
					ON t1.destination_id = t5.destination_id 
				";
				if($keyword != '') {
					$sql .= "
						WHERE t2.name LIKE '%".$keyword."%' 
					";
				}
				$sql .= "	
					GROUP BY t1.destination_id 
					ORDER BY t1.destination_id DESC 
				";
			}
			else {
				$sql = "
					SELECT *, t1.destination_id 
					FROM " . $this->db->table($this->table) . " t1 
					LEFT JOIN ".$this->db->table($this->table_alias)." t2 
					ON t2.alias_id = ( SELECT tt2.alias_id 
						FROM ".$this->db->table($this->table_alias)." AS tt2 
						WHERE tt2.destination_id = t1.destination_id
						ORDER BY tt2.ranking DESC
						LIMIT 1
					)
					LEFT JOIN ".$this->db->table($this->table_description)." t3 
					ON t1.destination_id = t3.destination_id 
					LEFT JOIN ".$this->db->table($this->table_image)." t4
					ON t1.destination_id = t4.destination_id 
					LEFT JOIN ".$this->db->table($this->table_tag)." t5
					ON t1.destination_id = t5.destination_id 
					WHERE t1.destination_id = '" . (int)$destination_id . "' 
					GROUP BY t1.destination_id 
				";
	
			}
			$query = $this->db->query($sql);
			
			//START: Set Output
			if($destination_id == '') {
				foreach($query->rows as $result){
					$output[$result['destination_id']] = $result;
					$output[$result['destination_id']]['name'] = ucwords($result['name']);
					$output[$result['destination_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
					//START: set data for json
						//IMPORTANT: remember to load model at controller
						if(isset($result['tag_id'])) { $output[$result['destination_id']]['tag'] = $this->model_resource_tag->getTag($result['tag_id']); }
						if(isset($result['image_id'])) { 
							$output[$result['destination_id']]['image'] = $this->model_resource_image->getImage($result['image_id'],'30px');
						}
						else { 
							$google_image = $this->getDestinationGoogleImageByDestinationId($result['destination_id']);
							$image['path'] = $google_image[0]['url'];
							$image['name'] = ucwords($result['name']);
							$image['width'] = '30px';
							$output[$result['destination_id']]['image'] = $image;
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
						$google_image = $this->getDestinationGoogleImageByDestinationId($result['destination_id']);
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
		
		public function getDestinationSummary($destination_id) {
			$result['alias'] = $this->getDestinationAliasByDestinationId($destination_id);
			$result['description'] = $this->getDestinationDescriptionByDestinationId($destination_id);
			$result['destination'] = $this->getDestinationDestinationByDestinationId($destination_id);
			$result['google'] = $this->getDestinationGoogleByDestinationId($destination_id);
			$result['wikipedia'] = $this->getDestinationWikipediaByDestinationId($destination_id);
			
			foreach($result as $key => $value) {
				$output[$key] = count($value); 
			}
			
			$output['destination_id'] = $destination_id;
			
			return $output;
		}
		
		public function getDestinationByKeyword($keyword='') {
			//START: Run SQL
				$sql = "
					SELECT DISTINCT destination_id, name
					FROM " . $this->db->table($this->table_alias) . " 
					WHERE name LIKE '%".$keyword."%' 
					ORDER BY name asc 
					LIMIT 5
				";
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				foreach($query->rows as $result) {
					$output[$result['destination_id']] = $result;
					$output[$result['destination_id']]['name'] = ucwords($result['name']);
					$output[$result['destination_id']]['destination'] = array_values($this->getDestinationDestinationByDestinationId($result['destination_id']));
					if(count($output[$result['destination_id']]['destination']) < 1) { $output[$result['destination_id']]['destination'][0]['name'] = ''; }
				}
			//END
			
			return $output;
		}
		
		public function addDestination($data) {
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
			
			$destination_id = $this->db->getLastId();
			
			//START: Run Chain Reaction
				$data['destination_id'] = $destination_id;
				$this->addDestinationAlias($data);
				$this->addDestinationDescription($data);
				if($data['g_place_id'] != '') { $this->addDestinationGoogle($data); }
				if($data['w_title'] != '') { $this->addDestinationWikipedia($data); }
			//END
			
			$this->cache->delete('destination');
			
			return $destination_id;
		}
		
		public function editDestination($destination_id, $data) {
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
						WHERE destination_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			$this->cache->delete('destination');
			return true;
		}
		
		public function deleteDestination($destination_id) {
			//START: Run SQL
				$sql = "
					DELETE FROM " . $this->db->table($this->table) . " 
					WHERE destination_id = '" . (int)$destination_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: Run Chain Reaction
				$this->deleteDestinationAliasByDestinationId($destination_id);
				$this->deleteDestinationDescriptionByDestinationId($destination_id);
				$this->deleteDestinationGoogleByDestinationId($destination_id);
				$this->deleteDestinationWikipediaByDestinationId($destination_id);
			//END
			
			$this->cache->delete('destination');
			return true;
		}
		
		public function toggleDestinationStatus($destination_id) {
			//START: Run SQL
				$sql = "
					SELECT `status` 
					FROM " . $this->db->table($this->table) . " 
					WHERE  destination_id = '" . (int)$destination_id . "'
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
				WHERE destination_id = '" . (int)$destination_id . "'
			";
			$query = $this->db->query($sql);
			//END
			
			$this->cache->delete('destination');
			return $new_status;
		}
	//END
	
	//START: [Alias]
		public function getDestinationAlias($alias_id='',$destination_id='') {
			//START: Run SQL
				if($alias_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_alias) . " 
					";
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' 
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
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' AND alias_id = '" . (int)$alias_id . "' 
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
		
		public function getDestinationAliasByDestinationId($destination_id) {
			return $this->getDestinationAlias('',$destination_id);
		}
		
		public function addDestinationAlias($data) {
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
			
			$this->cache->delete('destination_alias');
			
			return $alias_id;
		}
		
		public function editDestinationAlias($alias_id, $data) {
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
			
			$this->cache->delete('destination_alias');
			return true;
		}
		
		public function deleteDestinationAlias($alias_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_alias) . " 
						WHERE alias_id = '" . (int)$alias_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_alias');
			return true;
		}
		
		public function deleteDestinationAliasByDestinationId($destination_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_alias) . " 
						WHERE destination_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_alias');
			return true;
		}
	//END
	
	//START: [Description]
		public function getDestinationDescription($description_id='',$destination_id='') {
			//START: Run SQL
				if($description_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_description) . " 
					";
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' 
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
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' AND description_id = '" . (int)$description_id . "' 
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
		
		public function getDestinationDescriptionByDestinationId($destination_id) {
			return $this->getDestinationDescription('',$destination_id);
		}
		
		public function addDestinationDescription($data) {
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
			
			$this->cache->delete('destination_description');
			
			return $description_id;
		}
		
		public function editDestinationDescription($description_id, $data) {
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
			
			$this->cache->delete('destination_description');
			return true;
		}
		
		public function deleteDestinationDescription($description_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_description) . " 
						WHERE description_id = '" . (int)$description_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_description');
			return true;
		}
		
		public function deleteDestinationDescriptionByDestinationId($destination_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_description) . " 
						WHERE destination_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_description');
			return true;
		}
	//END
	
	//START: [Destination]
		public function getDestinationDestination($relation_id='',$destination_id='') {
			//START: Run SQL
				if($relation_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_destination) . " 
					";
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' 
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
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' AND relation_id = '" . (int)$relation_id . "' 
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
		
		public function getDestinationDestinationByDestinationId($destination_id) {
			return $this->getDestinationDestination('',$destination_id);
		}
		
		public function addDestinationDestination($data) {
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
			
			$this->cache->delete('destination_destination');
			
			return $relation_id;
		}
		
		public function editDestinationDestination($relation_id, $data) {
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
			
			$this->cache->delete('destination_destination');
			return true;
		}
		
		public function deleteDestinationDestination($relation_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_destination) . " 
						WHERE relation_id = '" . (int)$relation_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_destination');
			return true;
		}
		
		public function deleteDestinationDestinationByDestinationId($destination_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_destination) . " 
						WHERE destination_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_destination');
			return true;
		}
	//END
	
	//START: [Google]
		public function getDestinationGoogle($google_id='',$destination_id='') {
			//START: Run SQL
				if($google_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_google) . " 
					";
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' 
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
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' AND google_id = '" . (int)$google_id . "' 
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
		
		public function getDestinationGoogleByDestinationId($destination_id) {
			return $this->getDestinationGoogle('',$destination_id);
		}
		
		public function addDestinationGoogle($data) {
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
			
			$this->cache->delete('destination_google');
			
			return $google_id;
		}
		
		public function editDestinationGoogle($google_id, $data) {
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
			
			$this->cache->delete('destination_google');
			return true;
		}
		
		public function deleteDestinationGoogle($google_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_google) . " 
						WHERE google_id = '" . (int)$google_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_google');
			return true;
		}
		
		public function deleteDestinationGoogleByDestinationId($destination_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_google) . " 
						WHERE destination_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_google');
			return true;
		}
	//END
	
	//START: [Wikipedia]
		public function getDestinationWikipedia($wikipedia_id='',$destination_id='') {
			//START: Run SQL
				if($wikipedia_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_wikipedia) . " 
					";
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' 
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
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' AND wikipedia_id = '" . (int)$wikipedia_id . "' 
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
		
		public function getDestinationWikipediaByDestinationId($destination_id) {
			return $this->getDestinationWikipedia('',$destination_id);
		}
		
		public function addDestinationWikipedia($data) {
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
			
			$this->cache->delete('destination_wikipedia');
			
			return $wikipedia_id;
		}
		
		public function editDestinationWikipedia($wikipedia_id, $data) {
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
			
			$this->cache->delete('destination_wikipedia');
			return true;
		}
		
		public function deleteDestinationWikipedia($wikipedia_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_wikipedia) . " 
						WHERE wikipedia_id = '" . (int)$wikipedia_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_wikipedia');
			return true;
		}
		
		public function deleteDestinationWikipediaByDestinationId($destination_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_wikipedia) . " 
						WHERE destination_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_wikipedia');
			return true;
		}
	//END
	
	//START: Extra
		public function getDestinationGoogleImageByDestinationId($destination_id) {
			//START: Run SQL
				$sql = "
					SELECT `g_photo`
					FROM " . $this->db->table($this->table_google) . " 
					WHERE destination_id = '" . (int)$destination_id . "'
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