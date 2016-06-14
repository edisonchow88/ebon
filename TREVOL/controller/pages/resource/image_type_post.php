<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceImageTypePost extends AController {
  	public function main() {
		$this->loadModel('resource/image_type');
		
		if($this->request->post['action'] == "add") { $this->add(); }
		else if($this->request->post['action'] == "edit") { $this->edit(); }
		else if($this->request->post['action'] == "delete") { $this->delete(); }
		else { $this->session->data['warning'] = "Error: No action has been sent via POST"; }
		
		$redirect = $this->html->getSecureURL('resource/image_type_list');
		$this->redirect($redirect);
	}
	
	public function add() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
		$image_type_id = $this->model_resource_image_type->addImageType($data); 
		$this->session->data['success'] = "Success: New <b>Image Type #".$image_type_id."</b> has been added";
	}
	
	public function edit() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
		$image_type_id = $data['image_type_id']; 
		if($this->model_resource_image_type->editImageType($image_type_id, $data)) {
			$this->session->data['success'] = "Success: <b>Image Type #".$image_type_id."</b> has been modified";
		}
		else {
			$this->session->data['warning'] = "Error: Fail to edit <b>Image Type #".$image_type_id."</b>";
		}
	}
	
	public function delete() {
		$image_type_id = $this->request->post['image_type_id'];
		
		if($this->model_resource_image_type->deleteImageType($image_type_id)) {
			$this->session->data['success'] = "Success: <b>Image Type #".$image_type_id."</b> has been deleted";
		}
		else {
			$this->session->data['warning'] = "Error: Fail to delete <b>Image Type #".$image_type_id."</b>";
		}
		
	}
	
	public function verify() {
		foreach($_POST as $key => $value) {
			$data[$key] = $value;
		}
		unset($data['action']); //avoid insert non-exist column
		
		$error = array();
		if($data['name'] == '') { $error[] = "Please key in the name."; }
		
		if(count($error) > 0) { 
			//if contain error, show alerts
			$error_list = 'Warning:<ul>';
			foreach($error as $text) {
				$error_list .= '<li>'.$text.'</li>';
			}
			$error_list .= '</ul>';
			$this->session->data['warning'] = $error_list;
			
			if($data['image_type_id'] != '') {
				$redirect = $this->html->getSecureURL('resource/image_type_form','&image_type_id='.$data['image_type_id']);
			}
			else {
				$redirect = $this->html->getSecureURL('resource/image_type_form');
			}
			$this->redirect($redirect);
			
			return "failed";
		} else {
			//if no error, return $data
			return $data;
		}
	}
}
?>

