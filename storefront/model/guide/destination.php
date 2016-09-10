<?php
if(!defined('DIR_CORE')){
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
	
	//START: set image size
		private $image_parent_width = '574px';
		private $image_child_width = '100px';
		private $image_row_width = '30px';
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
					SELECT *, t1.destination_id, GROUP_CONCAT(DISTINCT t4.image_id) as images, GROUP_CONCAT(DISTINCT t5.tag_id) as tags
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
					ON t4.relation_id = ( SELECT tt4.relation_id 
						FROM ".$this->db->table($this->table_image)." AS tt4 
						WHERE tt4.destination_id = t1.destination_id
						ORDER BY tt4.sort_order ASC
					)
					LEFT JOIN ".$this->db->table($this->table_tag)." t5
					ON t1.destination_id = t5.destination_id 
					LEFT JOIN ".$this->db->table($this->table_relation)." t6
					ON t1.destination_id = t6.destination_id 
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
					SELECT *, t1.destination_id, GROUP_CONCAT(DISTINCT t4.image_id) as images, GROUP_CONCAT(DISTINCT t5.tag_id) as tags
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
					ON t4.relation_id = ( SELECT tt4.relation_id 
						FROM ".$this->db->table($this->table_image)." AS tt4 
						WHERE tt4.destination_id = t1.destination_id
						ORDER BY tt4.sort_order ASC
					)
					LEFT JOIN ".$this->db->table($this->table_tag)." t5
					ON t1.destination_id = t5.destination_id 
					LEFT JOIN ".$this->db->table($this->table_relation)." t6
					ON t1.destination_id = t6.destination_id 
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
						if(isset($result['tag_id'])) { 
							$tags = explode(',',$result['tags']);
							if(count($tags) > 0) { 
								$output[$result['destination_id']]['tag'] = array();
								foreach($tags as $tag) {
									$output[$result['destination_id']]['tag'][] = $this->model_resource_tag->getTag($tag);
								}
							}
						}
						if(isset($result['image_id'])) { 
							$images = explode(',',$result['images']);
							if(count($images) > 0) { 
								$output[$result['destination_id']]['image'] = array();
								foreach($images as $image) {
									$output[$result['destination_id']]['image'][] = $this->model_resource_image->getImage($image,'100%');
								}
							}
						}
						else { 
							$google_image = $this->getDestinationGoogleImageByDestinationId($result['destination_id']);
							$image['path'] = $google_image[0]['url'];
							$image['name'] = ucwords($result['name']);
							$image['width'] = '100%';
							$image['image'] = '<img src="'.$image['path'].'" title="'.$image['name'].'" width="'.$image['width'].'" height="'.$image['width'].'"/>';
							$output[$result['destination_id']]['image'] = $image;
						}
						if(isset($result['parent_id'])) { 
							$output[$result['destination_id']]['parent'] = $this->model_guide_destination->getDestinationSpecialTagByDestinationId($result['parent_id']); 
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
					if(isset($result['tag_id'])) { 
						$tags = explode(',',$result['tags']);
						if(count($tags) > 0) { 
							$output['tag'] = array();
							foreach($tags as $tag) {
								$output['tag'][] = $this->model_resource_tag->getTag($tag);
							}
						}
					}
					if(isset($result['image_id'])) { 
						$images = explode(',',$result['images']);
						if(count($images) > 0) { 
							$output['image'] = array();
							foreach($images as $image) {
								$output['image'][] = $this->model_resource_image->getImage($image,$this->image_parent_width);
							}
						}
					}
					else { 
						$google_image = $this->getDestinationGoogleImageByDestinationId($result['destination_id']);
						$image['path'] = $google_image[0]['url'];
						$image['name'] = ucwords($result['name']);
						$image['width'] = $this->image_parent_width;
						$image['image'] = '<img src="'.$image['path'].'" title="'.$image['name'].'" width="'.$image['width'].'" height="'.$image['width'].'"/>';
						$output['image'][] = $image;
					}
					
					
					if(isset($result['parent_id'])) { 
						$output['parent'] = $this->model_guide_destination->getDestinationSpecialTagByDestinationId($result['parent_id']); 
					}
				//END
			}
			//END
			
			return $output;
		}
		
		public function getDestinationSpecialTagByDestinationId($destination_id) {
			//START: Run SQL
				$sql = "
					SELECT DISTINCT destination_id, name
					FROM " . $this->db->table($this->table_alias) . " 
					WHERE destination_id = '" . (int)$destination_id . "' 
					ORDER BY ranking desc 
					LIMIT 1
				";
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				$result = $query->row;
				$output = $query->row;
				$output['name'] = ucwords($result['name']);
				$output['type_color'] = '#5cb85c';
			//END
			
			return $output;
		}
		
		public function getDestinationSummary($destination_id) {
			$result['alias'] = $this->getDestinationAliasByDestinationId($destination_id);
			$result['description'] = $this->getDestinationDescriptionByDestinationId($destination_id);
			$result['image'] = $this->getDestinationImageByDestinationId($destination_id);
			$result['tag'] = $this->getDestinationTagByDestinationId($destination_id);
			$result['relation'] = $this->getDestinationRelationByDestinationId($destination_id);
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
					SELECT DISTINCT t1.destination_id, t1.name, t2.parent_id
					FROM " . $this->db->table($this->table_alias) . " t1
					LEFT JOIN ".$this->db->table($this->table_relation)." t2
					ON t1.destination_id = t2.destination_id 
					WHERE t1.name LIKE '%".$keyword."%' 
					ORDER BY t1.name asc 
					LIMIT 5
				";
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				foreach($query->rows as $result) {
					$output[$result['destination_id']] = $result;
					$output[$result['destination_id']]['name'] = ucwords($result['name']);
					if(isset($result['parent_id'])) { 
						$output[$result['destination_id']]['parent'] = $this->model_guide_destination->getDestinationSpecialTagByDestinationId($result['parent_id']); 
					}
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
				$this->deleteDestinationImageByDestinationId($destination_id);
				$this->deleteDestinationTagByDestinationId($destination_id);
				$this->deleteDestinationRelationByDestinationId($destination_id);
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
	
	//START: [Image]
		public function getDestinationImage($relation_id='',$destination_id='') {
			//START: Run SQL
				if($relation_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_image) . " 
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
						FROM " . $this->db->table($this->table_image) . " 
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
						if(isset($result['image_id'])) { 
							$output[$result['relation_id']]['image'] = $this->model_resource_image->getImage($result['image_id'],'100%');
						}
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
					if(isset($result['image_id'])) { 
						$output['image'] = $this->model_resource_image->getImage($result['image_id'],'100%');
					}
				}
			//END
			
			return $output;
		}
		
		public function getDestinationImageByDestinationId($destination_id) {
			return $this->getDestinationImage('',$destination_id);
		}
		
		public function addDestinationImage($data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_image));
					
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
						INSERT INTO `" . $this->db->table($this->table_image) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$relation_id = $this->db->getLastId();
			
			$this->cache->delete('destination_image');
			
			return $relation_id;
		}
		
		public function editDestinationImage($relation_id, $data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_image));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_image) . " 
							SET " . implode(',', $update) . "
							WHERE relation_id = '" . (int)$relation_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('destination_image');
			return true;
		}
		
		public function deleteDestinationImage($relation_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_image) . " 
						WHERE relation_id = '" . (int)$relation_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_image');
			return true;
		}
		
		public function deleteDestinationImageByDestinationId($destination_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_image) . " 
						WHERE destination_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_image');
			return true;
		}
	//END
	
	//START: [Tag]
		public function getDestinationTag($relation_id='',$destination_id='') {
			//START: Run SQL
				if($relation_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_tag) . " 
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
						FROM " . $this->db->table($this->table_tag) . " 
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
						if(isset($result['tag_id'])) { 
							$output[$result['relation_id']]['tag'] = $this->model_resource_tag->getTag($result['tag_id']); 
						}
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
					if(isset($result['tag_id'])) { 
						$output['tag'] = $this->model_resource_tag->getTag($result['tag_id']); 
					}
				}
			//END
			
			return $output;
		}
		
		public function getDestinationTagByDestinationId($destination_id) {
			return $this->getDestinationTag('',$destination_id);
		}
		
		public function addDestinationTag($data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_tag));
					
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
						INSERT INTO `" . $this->db->table($this->table_tag) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$relation_id = $this->db->getLastId();
			
			$this->cache->delete('destination_tag');
			
			return $relation_id;
		}
		
		public function editDestinationTag($relation_id, $data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_tag));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_tag) . " 
							SET " . implode(',', $update) . "
							WHERE relation_id = '" . (int)$relation_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('destination_tag');
			return true;
		}
		
		public function deleteDestinationTag($relation_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_tag) . " 
						WHERE relation_id = '" . (int)$relation_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_tag');
			return true;
		}
		
		public function deleteDestinationTagByDestinationId($destination_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_tag) . " 
						WHERE destination_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_tag');
			return true;
		}
	//END
	
	//START: [Relation]
		public function getDestinationRelation($relation_id='',$destination_id='') {
			//START: Run SQL
				if($relation_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_relation) . " 
					";
					if($destination_id != '') {
						$sql .= "
							WHERE destination_id = '" . (int)$destination_id . "' 
                            OR parent_id = '" . (int)$destination_id . "'
						";
					}
					$sql .= "
						ORDER BY relation_id DESC 
					";
				}
				else {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_relation) . " 
					";
					if($destination_id != '') {
						$sql .= "
							WHERE relation_id = '" . (int)$relation_id . "' 
                            AND (destination_id = '" . (int)$destination_id . "' 
                            OR parent_id = '" . (int)$destination_id . "')
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
						$output[$result['relation_id']]['target_id'] = $result['parent_id'];
						$output[$result['relation_id']]['relation'] = 'Parent';
						if($destination_id != '') {
							if($result['parent_id'] == $destination_id) {
								$output[$result['relation_id']]['destination_id'] = $result['parent_id'];
								$output[$result['relation_id']]['target_id'] = $result['destination_id'];
								$output[$result['relation_id']]['relation'] = 'Child';
							}
						}
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
					$output['target_id'] = $result['parent_id'];
					$output['relation'] = 'Parent';
					if($destination_id != '') {
						if($result['parent_id'] == $destination_id) {
							$output['destination_id'] = $result['parent_id'];
							$output['target_id'] = $result['destination_id'];
							$output['relation'] = 'Child';
						}
					}
				}
			//END
			
			return $output;
		}
		
		public function getDestinationRelationByDestinationId($destination_id) {
			return $this->getDestinationRelation('',$destination_id);
		}
		
		public function addDestinationRelation($data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_relation));
					
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
						INSERT INTO `" . $this->db->table($this->table_relation) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$relation_id = $this->db->getLastId();
			
			$this->cache->delete('destination_relation');
			
			return $relation_id;
		}
		
		public function editDestinationRelation($relation_id, $data) {
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_relation));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_relation) . " 
							SET " . implode(',', $update) . "
							WHERE relation_id = '" . (int)$relation_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('destination_relation');
			return true;
		}
		
		public function deleteDestinationRelation($relation_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_relation) . " 
						WHERE relation_id = '" . (int)$relation_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_relation');
			return true;
		}
		
		public function deleteDestinationRelationByDestinationId($destination_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_relation) . " 
						WHERE destination_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				//END
                
                //START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_relation) . " 
						WHERE parent_id = '" . (int)$destination_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('destination_relation');
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
	
	//START:
		public function getDestinationChild($destination_id,$limit='',$offset='') {
			//START: Run SQL
				$sql = "
					SELECT *, t1.destination_id, GROUP_CONCAT(DISTINCT t5.tag_id) as tags
					FROM " . $this->db->table($this->table_relation) . " t1
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
					ON t4.relation_id = ( SELECT tt4.relation_id 
						FROM ".$this->db->table($this->table_image)." AS tt4 
						WHERE tt4.destination_id = t1.destination_id
						ORDER BY tt4.sort_order ASC
						LIMIT 1
					)
					LEFT JOIN ".$this->db->table($this->table_tag)." t5
					ON t1.destination_id = t5.destination_id 
					LEFT JOIN ".$this->db->table($this->table)." t6
					ON t1.destination_id = t6.destination_id 
					WHERE t1.parent_id = '" . (int)$destination_id . "' 
					AND t6.status = '1'
					GROUP BY t1.destination_id 
					ORDER BY t2.name asc 
				";
				if($limit != '') {
					$sql .= "LIMIT ".$limit." ";
				}
				if($offset != '') {
					$sql .= "OFFSET ".$offset." ";
				}
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				foreach($query->rows as $result){
					$output[$result['destination_id']] = $result;
					$output[$result['destination_id']]['name'] = ucwords($result['name']);
					$output[$result['destination_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
					//START: set data for json
						//IMPORTANT: remember to load model at controller
						if(isset($result['tag_id'])) { 
							$tags = explode(',',$result['tags']);
							if(count($tags) > 0) { 
								$output[$result['destination_id']]['tag'] = array();
								foreach($tags as $tag) {
									$output[$result['destination_id']]['tag'][] = $this->model_resource_tag->getTag($tag);
								}
							}
						}
						if(isset($result['image_id'])) { 
							$output[$result['destination_id']]['image'] = $this->model_resource_image->getImage($result['image_id'],$image_child_width);
						}
						else { 
							$google_image = $this->getDestinationGoogleImageByDestinationId($result['destination_id']);
							$image['path'] = $google_image[0]['url'];
							$image['name'] = ucwords($result['name']);
							$image['width'] = '100%';
							$image['image'] = '<img src="'.$image['path'].'" title="'.$image['name'].'" width="'.$image['width'].'" height="'.$image['width'].'"/>';
							$output[$result['destination_id']]['image'] = $image;
						}
						if(isset($result['parent_id'])) { 
							$output[$result['destination_id']]['parent'] = $this->model_guide_destination->getDestinationSpecialTagByDestinationId($result['parent_id']); 
						}
					//END
				}
			//END
			
			//START: Run SQL
				$sql = "
					SELECT COUNT(DISTINCT t1.destination_id) AS count
					FROM " . $this->db->table($this->table_relation) . " t1
					LEFT JOIN ".$this->db->table($this->table)." t2
					ON t1.destination_id = t2.destination_id 
					WHERE t1.parent_id = '" . (int)$destination_id . "' 
					AND t2.status = '1' 
				";
				$query = $this->db->query($sql);
			//END
			
			//START: Set Output
				$output['count'] = $query->row['count'];
			//END
			
			return $output;
		}
	//END
}

?>