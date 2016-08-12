<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesAccountAjaxAdmin extends AController {
	
	public $data = array();

	public function main() {
		$this->loadModel('account/admin');
		
		foreach($_POST as $key => $value) {
			$this->data[$key] = $value;
		}
		
		$action = $this->data['action'];
		unset($this->data['action']);
		
		if($action == 'get') { $this->get(); }
		else if($action == 'add') { $this->add(); }
		else if($action == 'edit') { $this->edit(); }
		else if($action == 'delete') { $this->delete(); }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'No action has been sent via POST'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function get() {
		$admin_id = $this->data['admin_id']; 
		$result = $this->model_account_admin->getAdmin($admin_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify_add() == 'failed') { return; }
		
		$admin_id = $this->model_account_admin->addAdmin($this->data); 
		$this->session->data['success'] = 'Success: New <b>Admin #'.$admin_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify_edit() == 'failed') { return; }
		
		$admin_id = $this->data['admin_id']; 
		$execution = $this->model_account_admin->editAdmin($admin_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Admin #".$admin_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$admin_id = $this->data['admin_id']; 
		$execution = $this->model_account_admin->deleteAdmin($admin_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Admin #".$admin_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify_add() {
		
		if($this->data['role_id'] == '') {
			$result['warning'][] = '<b>Admin Group</b> is missing';
		}
		
		$email = filter_var($this->data['email'], FILTER_SANITIZE_EMAIL); // Remove all illegal characters from email
		if($this->data['email'] == '') {
			$result['warning'][] = '<b>Email</b> is missing';
		}
		else if($this->model_account_admin->verifyEmail($this->data['email']) != true) {
			$result['warning'][] = '<b>Email</b> is already being used';
		}
		else if (filter_var($email, FILTER_VALIDATE_EMAIL) === false && $this->data['email'] != '') {
			$result['warning'][] = '<b>Email</b> is not valid';
		}
		
		if($this->data['password'] == '') {
			$result['warning'][] = '<b>Password</b> is missing';
		}
		else {
			if (strlen($this->data['password']) < 8) {
				$result['warning'][] = "<b>Password</b> must be at least 8 characters";
			}
			
			if (!preg_match("#[0-9]+#", $this->data['password'])) {
				$result['warning'][] = "<b>Password</b> must include at least one number";
			}
		
			if (!preg_match("#[a-zA-Z]+#", $this->data['password'])) {
				$result['warning'][] = "<b>Password</b> must include at least one letter";
			} 
		}
		
		if($this->data['confirm_password'] == '') {
			$result['warning'][] = '<b>Confirm Password</b> is missing';
		}
		
		if($this->data['password'] != $this->data['confirm_password'] && $this->data['password'] != '' && $this->data['confirm_password'] != '') {
			$result['warning'][] = '<b>Password</b> do not match <b>Confirm Password</b>';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	public function verify_edit() {
		if($this->data['role_id'] == '') {
			$result['warning'][] = '<b>Role</b> is missing';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}