<?php
	if(!defined('DIR_CORE')){
		header('Location: static_pages/');
	}
	
	class ModelAccountUser extends Model{
		
		//START: Set Table
			private $table = "user";
			private $table_group = "user_role";
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
			public function getUser($user_id='') {
				if($user_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table) . " 
						ORDER BY user_id DESC 
					";
				}
				else {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table) . " 
						WHERE user_id = '" . (int)$user_id . "' 
					";
		
				}
				$query = $this->db->query($sql);
				
				//START: Set Output
				if($user_id == '') {
					foreach($query->rows as $result){
						$output[$result['user_id']] = $result;
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
				}
				//END
				
				return $output;
			}
			
			public function getUserByKeyword($keyword) {
				//START: run SQL
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table) . " 
						WHERE email LIKE '%" . $keyword . "%' 
						OR fullname LIKE '%" . $keyword . "%'
						LIMIT 10 
					";
					$query = $this->db->query($sql);
				//END
				//START: Set Output
					$output = array();
					foreach($query->rows as $result){
						$output[$result['user_id']] = $result;
					}
				//END
				
				return $output;
			}
			
			public function addUser($data) {
				//START: Run SQL
					$fields = $this->getFields($this->db->table($this->table));
					
					$update = array();
					
					if(isset($data['password'])) { $data['password'] = AEncryption::getHash($data['password']); }
					
					foreach($fields as $f){
						if(isset($data[$f])) {
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
						}
					}
					
					$update['role_id'] = "role_id = '2'";
					if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					
					$sql = "
						INSERT INTO `" . $this->db->table($this->table) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
				$user_id = $this->db->getLastId();
				
				//START: Run Chain Reaction
				//END
				
				$this->cache->delete('user');
				
				return $user_id;
			}
			
			public function editUser($user_id, $data) {
				//START: set data
					$fields = $this->getFields($this->db->table($this->table));
					
					$update = array();
					foreach($fields as $f) {
						if($data[$f] == 'NULL') {
							$update[$f] = $f . " = NULL";
						}
						else if(isset($data[$f])) {
							$update[$f] = $f . " = '" . $this->db->escape($data[$f]) . "'";
						}
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
				//END
				
				//START: run sql
					if(!empty($update)) {
						$sql = "
							UPDATE " . $this->db->table($this->table) . " 
							SET " . implode(',', $update) . "
							WHERE user_id = '" . (int)$user_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
				//START: run chain reaction
				//END
				
				//START: clear cache
					$this->cache->delete('user');
				//END
				
				//START: return
					return true;
				//END
			}
			
			public function addPhoto($user_id, $photo_id) {
				//START: run sql
					$sql = "
						UPDATE " . $this->db->table($this->table) . " 
						SET photo_id = '" . $this->db->escape($photo_id) . "'
						WHERE user_id = '" . (int)$user_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
				//START: clear cache
					$this->cache->delete('user');
				//END
				
				//START: return
					return true;
				//END
			}
			
			public function verify($email, $password){
				//START: run SQL
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table) . " 
						WHERE email = '" . $this->db->escape($email) . "'
						AND password = '" . $this->db->escape(AEncryption::getHash($password)) . "' 
						AND status = '1'
					";
					$query = $this->db->query($sql);
				//END
				
				//START: verify output
					if($query->num_rows < 1) { 
						return false; 
					}
					else {
						return true;
					}
				//END
			}
		//END
		
		//START: [User Group]
			public function getRole($role_id='') {
				if($role_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_group) . " 
						ORDER BY role_id DESC 
					";
				}
				else {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table_group) . " 
						WHERE role_id = '" . (int)$role_id . "' 
					";
		
				}
				$query = $this->db->query($sql);
				
				//START: Set Output
				if($role_id == '') {
					foreach($query->rows as $result){
						$output[$result['role_id']] = $result;
						$output[$result['role_id']]['name'] = ucwords($result['name']);
						$output[$result['role_id']]['description'] = ucfirst($result['description']);
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
					$output['name'] = ucwords($result['name']);
                    $output['description'] = ucfirst($result['description']);
				}
				//END
				
				return $output;
			}
		//END
		
		//START: [Extra]
			public function verifyEmail($email) {
				$sql = "
					SELECT COUNT(*) as count
					FROM " . $this->db->table($this->table) . " 
					WHERE email = '" . $this->db->escape($email) . "' 
				";
				$query = $this->db->query($sql);
				
				//START: Set Output
					$result = $query->row;
					if($result['count'] == 0) { 
						$output = true;
					}
					else {
						$output = false;
					}
				//END
				
				return $output;
			}
		//END
	}
?>