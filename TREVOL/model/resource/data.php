<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelResourceData extends Model{
	
	//START: Set Table
		private $table = "data";
		private $table_alias = "data_alias";
		private $table_description = "data_description";
		private $table_dataset = "dataset";
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
		public function getData($data_id='',$dataset_id='') {
			if($data_id == '') {
				$sql = "
					SELECT *, t1.data_id
					FROM " . $this->db->table($this->table) . " t1 
					LEFT JOIN ".$this->db->table($this->table_alias)." t2 
					ON t2.alias_id = ( SELECT tt2.alias_id 
						FROM ".$this->db->table($this->table_alias)." AS tt2 
						WHERE tt2.data_id = t1.data_id
						ORDER BY tt2.ranking DESC
						LIMIT 1
					)
					LEFT JOIN ".$this->db->table($this->table_description)." t3 
					ON t1.data_id = t3.data_id 
				";
				if($dataset_id != '') {
					$sql .= "
						WHERE t1.dataset_id = '" . (int)$dataset_id . "'
					";
				}
				$sql .= "
					GROUP BY t1.data_id 
					ORDER BY t1.sort_order ASC 
				";
			}
			else {
				$sql = "
					SELECT *, t1.data_id 
					FROM " . $this->db->table($this->table) . " t1 
					LEFT JOIN ".$this->db->table($this->table_alias)." t2 
					ON t2.alias_id = ( SELECT tt2.alias_id 
						FROM ".$this->db->table($this->table_alias)." AS tt2 
						WHERE tt2.data_id = t1.data_id
						ORDER BY tt2.ranking DESC
						LIMIT 1
					)
					LEFT JOIN ".$this->db->table($this->table_description)." t3 
					ON t1.data_id = t3.data_id 
				";
				if($dataset_id != '') {
					$sql .= "
						WHERE t1.dataset_id = '" . (int)$dataset_id . "' AND t1.data_id = '" . (int)$data_id . "' 
					";
				}
				else {
					$sql .= "
						WHERE t1.data_id = '" . (int)$data_id . "' 
					";
				}
				$sql .= "
					GROUP BY t1.data_id 
				";
	
			}
			$query = $this->db->query($sql);
			
			//START: Set Output
			if($data_id == '') {
				foreach($query->rows as $result){
					$output[$result['data_id']] = $result;
					$output[$result['data_id']]['name'] = ucwords($result['name']);
					$output[$result['data_id']]['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
					$output[$result['data_id']]['label'] = $this->getDataset($result['dataset_id']);
				}
			}
			else {
				$result = $query->row;
				$output = $query->row;
				$output['name'] = ucwords($result['name']);
				$output['language'] = $this->language->getLanguageDetailsByID($result['language_id']);
				$output['label'] = $this->getDataset($result['dataset_id']);
			}
			//END
			
			return $output;
		}
		
		public function getDataByDatasetId($dataset_id) {
			return $this->getData('',$dataset_id);
		}
		
		public function addData($data) {
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
			
			$data_id = $this->db->getLastId();
			
			//START: Run Chain Reaction
				$data['data_id'] = $data_id;
				$this->addDataAlias($data);
				$this->addDataDescription($data);
			//END
			
			$this->cache->delete('data');
			
			return $data_id;
		}
		
		public function editData($data_id, $data) {
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
						WHERE data_id = '" . (int)$data_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: Run Chain Reaction
				$language_id = $data['language_id'];
				$this->editDataAliasByDataIdAndLanguageId($data_id, $language_id, $data);
				$this->editDataDescriptionByDataIdAndLanguageId($data_id, $language_id, $data);
			//END
			
			$this->cache->delete('data');
			return true;
		}
		
		public function deleteData($data_id) {
			//START: Run SQL
				$sql = "
					DELETE FROM " . $this->db->table($this->table) . " 
					WHERE data_id = '" . (int)$data_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: Run Chain Reaction
				$this->deleteDataAliasByDataId($data_id);
				$this->deleteDataDescriptionByDataId($data_id);
			//END
			
			$this->cache->delete('data');
			return true;
		}
	//END
	
	//START: [Alias]
		public function getDataAlias($alias_id='',$data_id='') {
			//START: Run SQL
				if($alias_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_alias) . " 
					";
					if($data_id != '') {
						$sql .= "
							WHERE data_id = '" . (int)$data_id . "' 
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
					if($data_id != '') {
						$sql .= "
							WHERE data_id = '" . (int)$data_id . "' AND alias_id = '" . (int)$alias_id . "' 
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
		
		public function getDataAliasByDataId($data_id) {
			return $this->getDataAlias('',$data_id);
		}
		
		public function addDataAlias($data) {
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
			
			$this->cache->delete('data_alias');
			
			return $alias_id;
		}
		
		public function editDataAlias($alias_id, $data) {
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
			
			$this->cache->delete('data_alias');
			return true;
		}
		
		public function editDataAliasByDataIdAndLanguageId($data_id, $language_id, $data) {
			if($data_id == '' || $language_id == '') { return false; }
			
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
							WHERE data_id = '" . (int)$data_id . "' AND language_id = '" . (int)$language_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('data_alias');
			return true;
		}
		
		public function deleteDataAlias($alias_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_alias) . " 
						WHERE alias_id = '" . (int)$alias_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('data_alias');
			return true;
		}
		
		public function deleteDataAliasByDataId($data_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_alias) . " 
						WHERE data_id = '" . (int)$data_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('data_alias');
			return true;
		}
	//END
	
	//START: [Description]
		public function getDataDescription($description_id='',$data_id='') {
			//START: Run SQL
				if($description_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_description) . " 
					";
					if($data_id != '') {
						$sql .= "
							WHERE data_id = '" . (int)$data_id . "' 
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
					if($data_id != '') {
						$sql .= "
							WHERE data_id = '" . (int)$data_id . "' AND description_id = '" . (int)$description_id . "' 
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
		
		public function getDataDescriptionByDataId($data_id) {
			return $this->getDataDescription('',$data_id);
		}
		
		public function addDataDescription($data) {
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
			
			$this->cache->delete('data_description');
			
			return $description_id;
		}
		
		public function editDataDescription($description_id, $data) {
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
			
			$this->cache->delete('data_description');
			return true;
		}
		
		public function editDataDescriptionByDataIdAndLanguageId($data_id, $language_id, $data) {
			if($data_id == '' || $language_id == '') { return false; }
			
			//START: [Main Table]
			
				//START: Set Data
					$fields = $this->getFields($this->db->table($this->table_description));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_description) . " 
							SET " . implode(',', $update) . "
							WHERE data_id = '" . (int)$data_id . "' AND language_id = '" . (int)$language_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
			//END
			
			$this->cache->delete('data_description');
			return true;
		}
		
		public function deleteDataDescription($description_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_description) . " 
						WHERE description_id = '" . (int)$description_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('data_description');
			return true;
		}
		
		public function deleteDataDescriptionByDataId($data_id) {
			//START: [Main Table]
			
				//START: table
					$sql = "
						DELETE FROM " . $this->db->table($this->table_description) . " 
						WHERE data_id = '" . (int)$data_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
			//END
			
			$this->cache->delete('data_description');
			return true;
		}
	//END
	
	//START: [Datasetset]
		public function getDataset($dataset_id='') {
			if($dataset_id == '') {
				$sql = "
					SELECT *
					FROM " . $this->db->table($this->table_dataset) . "
					ORDER BY category ASC, name ASC 
				";
			}
			else {
				$sql = "
					SELECT *
					FROM " . $this->db->table($this->table_dataset) . "
					WHERE dataset_id = '" . (int)$dataset_id . "' 
				";
	
			}
			$query = $this->db->query($sql);
			
			//START: Set Output
                if($dataset_id == '') {
                    foreach($query->rows as $result){
                        $output[$result['dataset_id']] = $result;
                        $output[$result['dataset_id']]['name'] = ucwords($result['name']);
						$output[$result['dataset_id']]['category'] = ucwords($result['category']);
                    }
                }
                else {
                    $result = $query->row;
                    $output = $query->row;
                    $output['name'] = ucwords($result['name']);
					$output['category'] = ucwords($result['category']);
                }
			//END
			
			return $output;
		}
		
		public function addDataset($dataset) {
			//START: Run SQL
				$fields = $this->getFields($this->db->table($this->table_dataset));
				
				$update = array();
				foreach($fields as $f){
					if(isset($dataset[$f])) {
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($dataset[$f])) . "'";
					}
				}
				
				if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
				
				$sql = "
					INSERT INTO `" . $this->db->table($this->table_dataset) . "` 
					SET " . implode(',', $update) . "
				";
				$query = $this->db->query($sql);
			//END
			
			$dataset_id = $this->db->getLastId();
			
			$this->cache->delete('dataset');
			
			return $dataset_id;
		}
		
		public function editDataset($dataset_id, $dataset) {
			//START: Run SQL
				$fields = $this->getFields($this->db->table($this->table_dataset));
				
				$update = array();
				foreach($fields as $f){
					if(isset($dataset[$f]))
						$update[$f] = $f . " = '" . $this->db->escape(strtolower($dataset[$f])) . "'";
				}
				if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
				
				if(!empty($update)){
					$sql = "
						UPDATE " . $this->db->table($this->table_dataset) . " 
						SET " . implode(',', $update) . "
						WHERE dataset_id = '" . (int)$dataset_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			$this->cache->delete('dataset');
			return true;
		}
		
		public function deleteDataset($dataset_id) {
			//START: Run SQL
				$sql = "
					DELETE FROM " . $this->db->table($this->table_dataset) . " 
					WHERE dataset_id = '" . (int)$dataset_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
            //START: Run Chain Reaction
            //END
            
			$this->cache->delete('dataset');
			return true;
		}
	//END
}

?>