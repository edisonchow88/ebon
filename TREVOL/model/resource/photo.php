<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelResourcePhoto extends Model{
	
	private $table = "photo";
	private $path = "resources/photo/cropped/";
	private $default_width = "100px";
	
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
	
	public function getPhoto($photo_id='',$width='') {
		if($photo_id == '0') { return; } //avoid return an array
		if($width=='') { $width = $this->default_width; }
		
		$photo = array();
		
		if($photo_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " 
				ORDER BY photo_id ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " 
				WHERE photo_id = '" . (int)$photo_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($photo_id == '') {
			foreach($query->rows as $result){
				$output[$result['photo_id']] = $result;
				$output[$result['photo_id']]['width'] = $width;
				$output[$result['photo_id']]['path'] = $this->path.$result['filename'];
				
				$photo['path'] = $output[$result['photo_id']]['path'];
				$photo['name'] = $result['filename'];
				$photo['width'] = $width;
				$output[$result['photo_id']]['photo'] = $photo;
			}
		}
		else {
			$output = $query->row;
			$output['width'] = $width;
			$output['path'] = $this->path.$output['filename'];
			
			$photo['path'] = $output[$result['photo_id']]['path'];
			$photo['name'] = $result['filename'];
			$photo['width'] = $width;
			$output['photo'] = $photo;
		}
		
		return $output;
	}
	
	public function addPhoto($data) {
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
				$photo_id = $this->db->getLastId();
			//END
			
			//START: update database
				$sql = "
					UPDATE " . $this->db->table($this->table) . " 
					SET filename = '" . $photo_id . $this->db->escape($data['photo_type']) . "' 
					WHERE photo_id = '" . (int)$photo_id . "'
				";
				$query = $this->db->query($sql);
			//END
			
			//START: clear cache
				$this->cache->delete('photo');
			//END
			
			//START: return
				return $photo_id;
			//END
	}
	
	public function editPhoto($photo_id, $data) {
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
						WHERE photo_id = '" . (int)$photo_id . "'
					";
					$query = $this->db->query($sql);
				}
			//END
			
			//START: clear cache
				$this->cache->delete('photo');
			//END
			
			//START: return
				return true;
			//END
		}
		
		public function deletePhoto($photo_id) {
			$photo = $this->getPhoto($photo_id);

			if(unlink($photo['path'])) {
				//START: run sql
					$sql = "
						DELETE FROM " . $this->db->table($this->table) . " 
						WHERE photo_id = '" . (int)$photo_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
				//START: run chain reaction
				//END
				
				//START: clear cache
					$this->cache->delete('photo');
				//END
				
				//START: return
					return true;
				//END
			}
			else {
				//START: return
					return false;
				//END
			}
		}
}

?>