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
		//START: check php upload file error
			if ($_FILES['file']['error'] != 0) {
				$result['warning'][] = 'System Error ' . $_FILES['file']['error'];
				$response = json_encode($result);
				echo $response;	
				return;	
			}
		//END
		//START: get file
			$filename = $_FILES['file']['tmp_name'];
			$file_type = $_FILES['file']['type'];
		//END
		//START: verify file type
			if($file_type == "image/jpeg") {
				$photo_type = ".jpg";
				$image_create_func = 'imagecreatefromjpeg';
				$image_save_func = 'imagejpeg';
			}
			else if($file_type == "image/png") {
				$photo_type = ".png";
				$image_create_func = 'imagecreatefrompng';
				 $image_save_func = 'imagepng';
			}
			else if($file_type == "image/gif") {
				$photo_type = ".gif";
				$image_save_func = 'imagegif';
				$new_image_ext = 'gif';
			}
			else {
				$result['warning'][] = "Unknown Image Type";
				$response = json_encode($result);
				echo $response;	
				return;
			}
		//END
		//START: [image]
			//START: get exif
				$exif = exif_read_data($_FILES['file']['tmp_name']);
			//END
			//START: get old dimension
				list($old_width, $old_height) = getimagesize($filename);
			//END
			//START: set new dimension
				$new_width = '300';
				$new_height = '300';
				$edge = min($old_width, $old_height);
			//END
			//START: set cropped point
				if($old_width > $old_height) {
					$src_x = ($old_width - $old_height) / 2;
					$src_y = 0;
				}
				else if($old_height > $old_width) {
					$src_x = 0;
					$src_y = ($old_height - $old_width) / 2;
				}
			//END
			//START: resample
				$old_image =  $image_create_func($filename);
				$new_image = imagecreatetruecolor($new_width, $new_width);
				imagecopyresampled($new_image, $old_image, 0, 0, $src_x, $src_y, $new_width, $new_height, $edge, $edge);
			//END
			//START: rotate image
				if(!empty($exif['Orientation'])) {
					switch($exif['Orientation']) {
						case 8:
							$new_image = imagerotate($new_image,90,0);
							break;
						case 3:
							$new_image = imagerotate($new_image,180,0);
							break;
						case 6:
							$new_image = imagerotate($new_image,-90,0);
							break;
					}
				}
			//END
		//END
		//START: [database]
			//START: set data
				$data = $this->data;
				$data['photo_type'] = $photo_type;
				$data['size'] = 0;
				$user_id = $this->data['user_id'];
			//END
			//START: check existing photo
				$user = $this->model_account_user->getUser($user_id);
				$photo_id = $user['photo_id'];
			//END
			//START: add photo or edit photo
				if($photo_id > 0) {
					$ds = DIRECTORY_SEPARATOR;
					$execution = $this->model_resource_photo->editPhoto($photo_id, $data);
					unlink(DIR_RESOURCE . "photo" . $ds . "cropped" . $ds . $photo_id . $photo_type);
				}
				else {
					$photo_id = $this->model_resource_photo->addPhoto($data);
					//START: add photo to user
						$user_photo_id = $this->model_account_user->addPhoto($user_id, $photo_id);
					//END
				}
			//END
		//END
		//START: [file]
			//START: name image
				$ds = DIRECTORY_SEPARATOR;
				$upload_directory = DIR_RESOURCE . "photo" . $ds . "cropped" . $ds;
				$upload_filename = $upload_directory . $photo_id . $photo_type;
			//END
			//START: save image
				$execution = $image_save_func($new_image,$upload_filename);
			//END
		//END
		//START: save file
			if ($execution) {
				$result['success'][] = "Photo Updated";
			} else {
				$result['warning'][] = "System Failed";
			}
		//END
		//START: return response
			$result['photo'] = $this->model_resource_photo->getPhoto($photo_id);
			$response = json_encode($result);
			echo $response;	
			return;	
		//END
	}
}