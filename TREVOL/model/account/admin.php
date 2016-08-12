<?php
	if(!defined('DIR_CORE') || !IS_ADMIN){
		header('Location: static_pages/');
	}
	
	class ModelAccountAdmin extends Model{
		
		//START: Set Table
			private $table = "admin";
			private $table_group = "admin_role";
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
			public function getAdmin($admin_id='') {
				if($admin_id == '') {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table) . " 
						ORDER BY admin_id DESC 
					";
				}
				else {
					$sql = "
						SELECT *
						FROM " . $this->db->table($this->table) . " 
						WHERE admin_id = '" . (int)$admin_id . "' 
					";
		
				}
				$query = $this->db->query($sql);
				
				//START: Set Output
				if($admin_id == '') {
					foreach($query->rows as $result){
						$output[$result['admin_id']] = $result;
						$output[$result['admin_id']]['fullname'] = ucwords($result['fullname']);
					}
				}
				else {
					$result = $query->row;
					$output = $query->row;
					$output['fullname'] = ucwords($result['fullname']);
				}
				//END
				
				return $output;
			}
			
			public function addAdmin($data) {
				//START: Run SQL
					$fields = $this->getFields($this->db->table($this->table));
					
					$update = array();
					
					if(isset($data['password'])) { $data['password'] = AEncryption::getHash($data['password']); }
					
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
				
				$admin_id = $this->db->getLastId();
				
				//START: Run Chain Reaction
				//END
				
				$this->cache->delete('admin');
				
				return $admin_id;
			}
			
			public function editAdmin($admin_id, $data) {
				//START: Run SQL
					$fields = $this->getFields($this->db->table($this->table));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
					if(isset($update['date_added'])) { unset($update['date_added']); }
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table) . " 
							SET " . implode(',', $update) . "
							WHERE admin_id = '" . (int)$admin_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
				$this->cache->delete('admin');
				return true;
			}
			
			public function deleteAdmin($admin_id) {
				//START: Run SQL
					$sql = "
						DELETE FROM " . $this->db->table($this->table) . " 
						WHERE admin_id = '" . (int)$admin_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
				//START: Run Chain Reaction
				//END
				
				$this->cache->delete('admin');
				return true;
			}
		//END
		
		//START: [Admin Group]
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
			
			public function addRole($data) {
				//START: Run SQL
					$fields = $this->getFields($this->db->table($this->table_group));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f])) {
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
						}
					}
					
					if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					$sql = "
						INSERT INTO `" . $this->db->table($this->table_group) . "` 
						SET " . implode(',', $update) . "
					";
					$query = $this->db->query($sql);
				//END
				
				$role_id = $this->db->getLastId();
				
				//START: Run Chain Reaction
				//END
				
				$this->cache->delete('role');
				
				return $role_id;
			}
			
			public function editRole($role_id, $data) {
				//START: Run SQL
					$fields = $this->getFields($this->db->table($this->table_group));
					
					$update = array();
					foreach($fields as $f){
						if(isset($data[$f]))
							$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
					}
					if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
					
					if(!empty($update)){
						$sql = "
							UPDATE " . $this->db->table($this->table_group) . " 
							SET " . implode(',', $update) . "
							WHERE role_id = '" . (int)$role_id . "'
						";
						$query = $this->db->query($sql);
					}
				//END
				
				$this->cache->delete('role');
				return true;
			}
			
			public function deleteRole($role_id) {
				//START: Run SQL
					$sql = "
						DELETE FROM " . $this->db->table($this->table_group) . " 
						WHERE role_id = '" . (int)$role_id . "'
					";
					$query = $this->db->query($sql);
				//END
				
				//START: Run Chain Reaction
				//END
				
				$this->cache->delete('role');
				return true;
			}
		//END
		
		//START: [Extra]
			public function countAdminByRoleId($role_id='') {
				$sql = "
					SELECT COUNT(*) as count
					FROM " . $this->db->table($this->table) . " 
					WHERE role_id = '" . (int)$role_id . "' 
				";
				$query = $this->db->query($sql);
				
				//START: Set Output
					$result = $query->row;
					$output = $result['count'];
				//END
				
				return $output;
			}
			
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