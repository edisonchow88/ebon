<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesAccountAjaxUser extends AController {
	
	public $data = array();

	public function main() {
		$this->loadModel('account/user');	
		$this->loadModel('resource/photo');
		
		foreach($_POST as $key => $value) {
			$this->data[$key] = $value;
		}
		
		$action = $this->data['action'];
		unset($this->data['action']);
		
		if($action == 'login') { $this->login(); }
		else if($action == 'logout') { $this->logout(); }
		else if($action == 'signup') { $this->signup(); }
		else if($action == 'get_user') { $this->get_user(); }
		else if($action == 'edit_user') { $this->edit_user(); }
		else if($action == 'upload_user_photo') { $this->upload_user_photo(); return; }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = '[System Error] Invalid action'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function signup() {
		//START: verify signup
			if($this->verify_signup() == 'failed') { return; }
		//END
		
		//START: set data
			unset($this->data['confirm_password']);
		//END
		
		//START: sign up
			$user_id = $this->model_account_user->addUser($this->data);
		//END
		
		//START: set session
			$this->session->data['email'] = $this->data['email'];
			$this->session->data['password'] = $this->data['password'];
		//END
		
		//START: set session (to pass information to refreshed page to trigger related function)
			$this->session->data['account_action'] = 'signup';
		//END
		
		//START: return responseText
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		//END
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
	
	public function verify_signup() {
		$email = filter_var($this->data['email'], FILTER_SANITIZE_EMAIL); // Remove all illegal characters from email
		if($this->data['email'] == '') {
			$result['warning'][] = '<b>Email</b> is missing';
		}
		else if($this->model_account_user->verifyEmail($this->data['email']) != true) {
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
		else if($this->data['password'] != $this->data['confirm_password'] && $this->data['password'] != '' && $this->data['confirm_password'] != '') {
			$result['warning'][] = '<b>Confirm Password</b> do not match <b>Password</b>';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
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
	
	public function get_user() {
		$user_id = $this->data['user_id'];
		$result = $this->model_account_user->getUser($user_id);
		if(isset($result['photo_id'])) {
			$result['photo'] = $this->model_resource_photo->getPhoto($result['photo_id']);
		}
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit_user() {
		//START: set data
			$data = $this->data;
		//END
		
		//START: process data
			foreach($data as $key => $value) {
				if($value == '') {
					$data[$key] = 'NULL';
				}
			}
		//END
		
		//START: execute function
			$execution = $this->model_account_user->editUser($data['user_id'], $data);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'User Updated';
			}
			else {
				$result['warning'] = 'System Error'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
    }
	
	public function upload_user_photo() {
		//START: set data
			$data = $this->data;
			$user_id = $this->data['user_id'];
			$data['size'] = $_FILES['file']['size'];
			$data['photo_type'] = $_FILES['file']['type'];
		//END
		//verify file type
			$file_type = $_FILES['file']['type'];
			if($file_type == "image/jpeg") {
				$photo_type = ".jpg";
			}
			else if($file_type == "image/png") {
				$photo_type = ".png";
			}
			else if($file_type == "image/gif") {
				$photo_type = ".gif";
			}
			else {
				$result['warning'][] = "Error: Fail to upload new photo due to invalid file type.";
				$response = json_encode($result);
				echo $response;	
				return;
			}
			$data['photo_type'] = $photo_type;
		//END
		//START: check existed photo
			$user = $this->model_account_user->getUser($user_id);
			$existing_photo_id = $user['photo_id'];
		//END
		//START: add photo or edit photo
			if($existing_photo_id > 0) {
				$photo_id = $this->model_resource_photo->editPhoto($existing_photo_id, $data);
				$ds = DIRECTORY_SEPARATOR;
				unlink(DIR_RESOURCE . "photo" . $ds . "cropped" . $ds . $existing_photo_id . $photo_type);
			}
			else {
				$photo_id = $this->model_resource_photo->addPhoto($data);
			}
		//END
		//START: add photo to user
			$data['photo_id'] = $photo_id;
			$user_photo_id = $this->model_account_user->addPhoto($data['user_id'], $photo_id);
		//END
		//START: name the photo
			$ds = DIRECTORY_SEPARATOR;
			$upload_directory = DIR_RESOURCE . "photo" . $ds . "cropped" . $ds;
			$upload_file = $upload_directory . $photo_id . $photo_type;
			
			$tmp_name = $_FILES['file']['tmp_name'];
		//END
		
		//START: move the photo
			if (move_uploaded_file($tmp_name, $upload_file)) {
				$result['success'][] = "Success: New <b>Photo #".$photo_id."</b> has been added";
			} else {
				$result['warning'][] = "Error: Please check the folder permission";
			}
		//END
		
		$result['photo'] = $this->model_resource_photo->getPhoto($photo_id);
		$response = json_encode($result);
		echo $response;	
		return;	
	}
}