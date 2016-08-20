<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesAccountAjaxUser extends AController {
	
	public $data = array();

	public function main() {
		$this->loadModel('account/user');
		
		foreach($_POST as $key => $value) {
			$this->data[$key] = $value;
		}
		
		$action = $this->data['action'];
		unset($this->data['action']);
		
		if($action == 'login') { $this->login(); }
		else if($action == 'logout') { $this->logout(); }
		else if($action == 'signup') { $this->signup(); }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = '[System Error] Invalid action'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function login() {
		//START: verify login
			if($this->verify_login() == 'failed') { return; }
		//END
		
		//START: set session
			$this->session->data['email'] = $this->data['email'];
			$this->session->data['password'] = $this->data['password'];
		//END
		
		//START: set session (to pass information to refreshed page to trigger related function)
			$this->session->data['account_action'] = 'login';
		//END
		
		//START: return responseText
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function logout() {
		//START: set session (to pass information to refreshed page to trigger related function)
			$this->session->data['account_action'] = 'logout';
		//END
		
		//START: return responseText
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function verify_login() {
		if($this->data['email'] == '') {
			$result['warning'][] = '<b>Email</b> is missing.';
		}
		
		if($this->data['password'] == '') {
			$result['warning'][] = '<b>Password</b> is missing.';
		}
		
		if($this->data['email'] != '' && $this->data['password'] != '') {
			$user = $this->model_account_user->verify($this->data['email'],$this->data['password']);
			if($user == false) {
				$result['warning'][] = 'Invalid email or password.';
			}
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}