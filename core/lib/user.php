<?php
/*------------------------------------------------------------------------------
TREVOL
------------------------------------------------------------------------------*/
if(!defined('DIR_CORE')){
	header('Location: static_pages/');
}

final class AUser{
	
	//START: set common data
		private $data = array();
		private $config;
		private $cache;
		private $db;
		private $request;
		private $session;
		private $dcrypt;
	//END
	
	//START: set common table
		private $table = "user";
		private $table_group = "user_role";
	//END
	
	private function getUser($user_id) {
		//START: run SQL
			$sql = "
				SELECT *
				FROM " . $this->db->table($this->table) . " 
				WHERE user_id = '" . (int)$user_id . "' 
				AND status = '1'
			";
			$query = $this->db->query($sql);
		//END
		
		//START: set output
			$result = $query->row;
			$output = $query->row;
			$output['fullname'] = ucwords($result['fullname']);
		//END
		
		//START: verify output
			if($query->num_rows < 1) { return false; }
		//END
		
		return $output;
	}
		
	public function __construct($registry){
		//START: get registry
			$this->cache = $registry->get('cache');
			$this->config = $registry->get('config');
			$this->db = $registry->get('db');
			$this->request = $registry->get('request');
			$this->session = $registry->get('session');
			$this->dcrypt = $registry->get('dcrypt');
		//END
		
		//START: set data
			$this->data['user_id'] = '';
			$this->data['role_id'] = '';
			$this->data['email'] = '';
		//END
		
		//START: detect action
			if(isset($this->session->data['account_action'])){
				$action = $this->session->data['account_action'];
				if($action == 'logout') {
					$this->logout();
					return;
				}
				else if($action == 'login') {
					$this->login($this->session->data['email'],$this->session->data['password']);
					unset($this->session->data['email']);
					unset($this->session->data['password']);
				}
				unset($this->session->data['account_action']);
			}
		//END
		
		//START: detect session
			if(isset($this->session->data['user_id'])){
				$user_id = $this->session->data['user_id'];
				$user = $this->getUser($user_id);
				
				//START: [if failed]
					if($user == false) {
						$this->logout();
						return;
					}
				//END
				
				//START: [if success]
					foreach($this->data as $key => $value) {
						$this->data[$key] = $user[$key];
					}
				//END
			} else if(isset($this->request->cookie['user'])) {
				//START: [unauthenticated user]
					$encryption = new AEncryption($this->config->get('encryption_key'));
					$this->unauth_user = unserialize($encryption->decrypt($this->request->cookie['user']));
				//user is not valid or not from the same store (under the same domain)
				if(
					$this->unauth_user['script_name'] != $this->request->server['SCRIPT_NAME']
					|| !$this->isValidEnabledCustomer()
				){
					//clean up
					$this->unauth_user = array();
					//expire unauth cookie
					unset($_COOKIE['user']);
					setcookie('user', '', time() - 3600, dirname($this->request->server['PHP_SELF']));
				}
				//END
			}
		//END
	}
	
	public function login($email, $password){
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
		
		//START: set output
			$result = $query->row;
			$output = $query->row;
			$output['fullname'] = ucwords($result['fullname']);
		//END
		
		//START: verify output
			if($query->num_rows < 1) { return false; }
		//END
		
		//START: [class data]
			foreach($this->data as $key => $value) {
				$this->data[$key] = $user[$key];
			}
		//END
		
		//START: [session]
			$this->session->data['user_id'] = $output['user_id'];
		//END
		
		//START: [cookie] for unauthenticated user (expire in 1 year)
			$cookie_data = array();
			foreach($this->data as $key => $value) {
				$cookie_data[$key] = $user[$key];
			}
			$encryption = new AEncryption($this->config->get('encryption_key'));
			$user_data = $encryption->encrypt(serialize(array($cookie_data)));
			setcookie(	
				'user',
				$user_data, 
				time() + 60 * 60 * 24 * 365, 
				dirname($this->request->server['PHP_SELF']), 
				null,
				(defined('HTTPS') && HTTPS),
				true
			);
		//END
		
		return true;
	}
	
	public function logout() {
		//START: [session]
			unset($this->session->data['user_id']);
			unset($this->session->data['trip_id']);
			unset($this->session->data['plan_id']);
		//END
		
		//START: [data]
			foreach($this->data as $key => $value) {
				$this->data[$key] = '';
			}
		//END

		//START: [cookie]
			unset($_COOKIE['user']);
			setcookie('user', '', time() - 3600, dirname($this->request->server['PHP_SELF']));
		//END
	}
	
	public function isLogged(){
		if($this->data['user_id'] != '') {
			return $this->data['user_id'];
		}
		else {
			return false;
		}
	}
	
	public function getUserId(){
		return $this->data['user_id'];
	}
	
	public function getRoleId(){
		return $this->data['role_id'];
	}
	
	public function getEmail(){
		return $this->data['email'];
	}
}