<?php
/*------------------------------------------------------------------------------
TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}
class ModelUserAdmin extends Model {
	
	//START: General
		public function addAdmin($data) {
			$this->db->query("INSERT INTO " . $this->db->table("admin") . " 
							  SET username = '" . $this->db->escape($data['username']) . "',
								  password = '" . $this->db->escape(AEncryption::getHash($data['password'])) . "',
								  firstname = '" . $this->db->escape($data['firstname']) . "',
								  lastname = '" . $this->db->escape($data['lastname']) . "',
								  email = '" . $this->db->escape($data['email']) . "',
								  role_id = '" . (int)$data['role_id'] . "',
								  status = '" . (int)$data['status'] . "',
								  date_added = NOW()");
			return $this->db->getLastId();
		}
		
		public function editAdmin($admin_id, $data) {
	
			$fields = array('username', 'firstname', 'lastname', 'email', 'role_id', 'status',);
			$update = array();
			foreach ( $fields as $f ) {
				if ( isset($data[$f]) )
					$update[] = $f." = '".$this->db->escape($data[$f])."'";
			}
			if ( !empty($data['password']) )
					$update[] = "password = '". $this->db->escape(AEncryption::getHash($data['password'])) ."'";
	
			if ( !empty($update) ){
				$sql = "UPDATE " . $this->db->table("admin") . " SET ". implode(',', $update) ." WHERE admin_id = '" . (int)$admin_id . "'";
				$this->db->query( $sql );
			}
		}
		
		public function deleteAdmin($admin_id) {
			$this->db->query("DELETE FROM " . $this->db->table("admin") . " WHERE admin_id = '" . (int)$admin_id . "'");
		}
		
		public function getAdmin($admin_id) {
			$query = $this->db->query("SELECT * FROM " . $this->db->table("admin") . " WHERE admin_id = '" . (int)$admin_id . "'");
		
			return $query->row;
		}
		
		public function getAdmins($data = array(), $mode = 'default') {
			if ($mode == 'total_only') {
				$sql = "SELECT count(*) as total FROM " . $this->db->table("admin") . " ";
			} else {
				$sql = "SELECT * FROM " . $this->db->table("admin") . " ";		
			}
			if ( !empty($data['subsql_filter']) )
				$sql .= " WHERE ".$data['subsql_filter'];
	
			//If for total, we done bulding the query
			if ($mode == 'total_only') {
				$query = $this->db->query($sql);
				return $query->row['total'];
			}
	
			$sort_data = array(
				'username',
				'role_id',
				'status',
				'date_added'
			);	
				
			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY username";	
			}
				
			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
			
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}			
				
				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
				
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}
				
			$query = $this->db->query($sql);
		
			return $query->rows;
		}
	
		public function getTotalAdmins($data = array()) {
			return $this->getAdmins($data, 'total_only');
		}
	
		public function getTotalAdminsByRoleId($role_id) {
			$query = $this->db->query("SELECT COUNT(*) AS total FROM " . $this->db->table("admin") . " WHERE role_id = '" . (int)$role_id . "'");
			
			return $query->row['total'];
		}
	//END
	
	//START: Role
		public function addRole($data) {
	
			if(!isset($data['permission'])){
				$controllers = $this->getAllControllers();
				$types = array('access','modify');
				foreach($types as $type){
					foreach($controllers as $controller){
						$data['permission'][$type][$controller] = 0;
					}
				}
			}
			$this->db->query("INSERT INTO " . $this->db->table("admin_role") . " 
							  SET name = '" . $this->db->escape($data['name']) . "',
								  permission = '" . (isset($data['permission']) ? serialize($data['permission']) : '') . "'");
			return $this->db->getLastId();
		}
		
		public function editRole($role_id, $data) {
	
			$role_id = !$role_id ? $this->addRole($data['name']) : $role_id;
			$role = $this->getRole($role_id);
	
			$update = array();
			if ( isset($data['name']) )	$update[] = "name = '".$this->db->escape($data['name'])."'";
	
			if ( isset($data['permission']) )	{
				$p = $role['permission'];
	
				if ( isset($data['permission']['access']) ) {
					foreach( $data['permission']['access'] as $controller => $value ){
							$value = !in_array($value, array(null,0,1)) ? 0 : $value;
							$p['access'][$controller] = $value;
							if(!isset($p['modify'][ $controller ]) && !isset($data['permission']['modify'][$controller])){
								$p['modify'][ $controller ] = 0;
							}
					}
				}
				if ( isset($data['permission']['modify'])){
					foreach( $data['permission']['modify'] as $controller => $value ){
							$value = !in_array($value, array(null,0,1)) ? 0 : $value;
							$p['modify'][ $controller ] = $value;
							if(!isset($p['access'][ $controller ]) && !isset($data['permission']['access'][$controller])){
								$p['access'][ $controller ] = 0;
							}
					}
				}
				$update[] = "permission = '".serialize($p)."'";
			}
	
			if ( !empty($update) ){
				$this->db->query("UPDATE " . $this->db->table("admin_role") . " SET ". implode(',', $update) ." WHERE role_id = '" . (int)$role_id . "'");
			}
		}
		
		public function deleteRole($role_id) {
			$this->db->query("DELETE FROM " . $this->db->table("admin_role") . " WHERE role_id = '" . (int)$role_id . "'");
		}
	
		public function addPermission($admin_id, $type, $page) {
			$query = $this->db->query("SELECT DISTINCT role_id FROM " . $this->db->table("admin") . " WHERE admin_id = '" . (int)$admin_id . "'");
			
			if ($query->num_rows) {
				$role_query = $this->db->query("SELECT DISTINCT * FROM " . $this->db->table("admin_role") . " WHERE role_id = '" . (int)$query->row['role_id'] . "'");
			
				if ($role_query->num_rows) {
					$data = unserialize($role_query->row['permission']);
					$data[$type][$page] = 1;
					$this->db->query("UPDATE " . $this->db->table("admin_role") . " SET permission = '" . serialize($data) . "' WHERE role_id = '" . (int)$query->row['role_id'] . "'");
				}
			}
		}
		
		public function getRole($role_id) {
			$query = $this->db->query("SELECT DISTINCT * FROM " . $this->db->table("admin_role") . " WHERE role_id = '" . (int)$role_id . "'");
			
			$role = array(
				'name'       => $query->row['name'],
				'permission' => unserialize($query->row['permission'])
			);
			return $role;
		}
		
		public function getRoles($data = array()) {
			$sql = "SELECT *
					FROM " . $this->db->table("admin_role") . " 
					ORDER BY name";
				
			if (isset($data['order']) && ($data['order'] == 'DESC')) {
				$sql .= " DESC";
			} else {
				$sql .= " ASC";
			}
			
			if (isset($data['start']) || isset($data['limit'])) {
				if ($data['start'] < 0) {
					$data['start'] = 0;
				}			
	
				if ($data['limit'] < 1) {
					$data['limit'] = 20;
				}	
				
				$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
			}
				
			$query = $this->db->query($sql);
			return $query->rows;
		}
		
		public function getTotalRoles() {
			$sql = "SELECT COUNT(*) AS total FROM " . $this->db->table("admin_role") . " ";
			$query = $this->db->query($sql);
	
			return $query->row['total'];
		}
	
		/**
		 * method returns array with all controllers of admin section
		 * @param string $order
		 * @return array
		 */
		public function getAllControllers($order = 'asc'){
	
			$ignore = array('index/home',
							'common/layout',
							'common/login',
							'common/logout',
							'error/not_found',
							'error/permission',
							'common/footer',
							'common/header',
							'common/menu');
	
			$controllers_list = array();
			$files_pages = glob( DIR_APP_SECTION . 'controller/pages/*/*.php');
			$files_response = glob( DIR_APP_SECTION . 'controller/responses/*/*.php');
			$files = array_merge( $files_pages, $files_response);
	
			// looking for controllers inside core
			foreach ($files as $file) {
				$data = explode('/', dirname($file));
				$controller = end($data) . '/' . basename($file, '.php');
				if (!in_array($controller, $ignore)) {
					$controllers_list[] = $controller;
				}
			}
			// looking for controllers inside extensions
			$files_pages = glob( DIR_EXT . '/*/admin/controller/pages/*/*.php');
			$files_response = glob(  DIR_EXT . '/*/admin/controller/responses/*/*.php');
			$files = array_merge( $files_pages, $files_response);
			foreach ($files as $file) {
				$data = explode('/', dirname($file));
				$controller = end($data) . '/' . basename($file, '.php');
				if (!in_array($controller, $ignore)) {
					$controllers_list[] = $controller;
				}
			}
	
			$controllers_list = array_unique($controllers_list);
			sort($controllers_list,SORT_STRING);
			if($order=='desc'){
				$controllers_list = array_reverse($controllers_list);
			}
			return $controllers_list;
		}
	//END
}
