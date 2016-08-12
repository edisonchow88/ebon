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
						$output[$result['user_id']]['fullname'] = ucwords($result['fullname']);
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
	}
?>