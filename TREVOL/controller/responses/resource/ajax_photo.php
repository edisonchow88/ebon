<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesResourceAjaxPhoto extends AController {
	public function main() {
		$this->loadModel('resource/photo');
		
		if($this->request->get['action'] == 'try_add') { $this->try_add(); }
		else if($this->request->post['action'] == "add") { 
			$this->add(); 
			$redirect = $this->html->getSecureURL('resource/photo');
			$this->redirect($redirect);
		}
		else if($this->request->post['action'] == "edit") { $this->edit(); }
		else if($this->request->post['action'] == "delete") { $this->delete(); }
		else { $this->session->data['warning'] = "Error: No action has been sent via POST"; }
	}
	
	public function try_add() {
		$request = $this->request->files;
		foreach($request as $e) {
			foreach($e as $key => $value) {
				$file[$key] = $value;
			}
		}
		
		$ds = DIRECTORY_SEPARATOR; 
		$file['tmp_name'] = str_replace('\/',$ds,$file['tmp_name']);
		
		$result = $file;
		
		$result['warning'] = '';
		if($file['type'] != "image/jpeg" && $file['type'] != "image/png" && $file['type'] != "image/gif") {
			$result['warning'][] = "The file is not JPG or PNG or GIF.";
		}
		if($file['size'] > 2000000) {
			$result['warning'][] = "Size of the image exceeded 2 Mb.";
		}
		
		$response = json_encode($result);
		echo $response;	
	}
	
	public function add() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
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
			$this->session->data['warning'] = "Error: Fail to upload new photo due to invalid file type.";
			return false;
		}
		$data['photo_type'] = $photo_type;
		
		//add row to database
		$photo_id = $this->model_resource_photo->addPhoto($data); 
		
		//name the photo
		$ds = DIRECTORY_SEPARATOR;
		$upload_directory = DIR_RESOURCE . "photo" . $ds . "cropped" . $ds;
		$upload_file = $upload_directory . $photo_id . $photo_type;
		
		$tmp_name = $_FILES['file']['tmp_name'];
		$this->session->data['success'] = $tmp_name." yes ".$upload_file;
		
		//move the photo
		if (move_uploaded_file($tmp_name, $upload_file)) {
			$this->session->data['success'] = "Success: New <b>Photo #".$photo_id."</b> has been added";
		} else {
			$this->session->data['warning'] = "Error: Please check the folder permission";
		}
	}
	
	public function edit() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
		$photo_id = $data['photo_id']; 
		if($this->model_resource_photo->editPhoto($photo_id, $data)) {
			$this->session->data['success'] = "Success: <b>Photo #".$photo_id."</b> has been modified";
		}
		else {
			$this->session->data['warning'] = "Error: Fail to edit <b>Photo #".$photo_id."</b>";
		}
	}
	
	public function delete() {
		$photo_id = $this->request->post['photo_id'];
		$execution = $this->model_resource_photo->deletePhoto($photo_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Photo #".$photo_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
		else {
			$result['warning'][] = "Error: Fail to delete <b>Photo #".$photo_id."</b>";
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		foreach($_POST as $key => $value) {
			$data[$key] = $value;
		}
		unset($data['action']); //avoid insert non-exist column
		
		$error = array();
		
		if(count($error) > 0) { 
			//if contain error, show alerts
			$error_list = 'Warning:<ul>';
			foreach($error as $text) {
				$error_list .= '<li>'.$text.'</li>';
			}
			$error_list .= '</ul>';
			$this->session->data['warning'] = $error_list;
			
			if($data['photo_id'] != '') {
				$redirect = $this->html->getSecureURL('resource/photo_form','&photo_id='.$data['photo_id']);
			}
			else {
				$redirect = $this->html->getSecureURL('resource/photo_form');
			}
			$this->redirect($redirect);
			
			return "failed";
		} else {
			//if no error, return $data
			return $data;
		}
	}
}