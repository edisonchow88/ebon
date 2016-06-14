<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceImageSourcePost extends AController {
  	public function main() {
		$this->loadModel('resource/image');
		
		if($this->request->post['action'] == "add") { $this->add(); }
		else if($this->request->post['action'] == "edit") { $this->edit(); }
		else if($this->request->post['action'] == "delete") { $this->delete(); }
		else { $this->session->data['warning'] = "Error: No action has been sent via POST"; }
		
		$redirect = $this->html->getSecureURL('resource/image_source_list');
		$this->redirect($redirect);
	}
	
	public function add() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
		$image_source_id = $this->model_resource_image->addImageSource($data); 
		$this->session->data['success'] = "Success: New <b>Image Source #".$image_source_id."</b> has been added";
	}
	
	public function edit() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
		$image_source_id = $data['image_source_id']; 
		$this->model_resource_image->editImageSource($image_source_id, $data); 
		$this->session->data['success'] = "Success: <b>Image Source #".$image_source_id."</b> has been modified";
	}
	
	public function delete() {
		$image_source_id = $this->request->post['image_source_id'];
		
		$this->model_resource_image->deleteImageSource($image_source_id); 
		$this->session->data['success'] = "Success: <b>Image Source #".$image_source_id."</b> has been deleted";
		
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
			
			if($data['image_source_id'] != '') {
				$redirect = $this->html->getSecureURL('resource/image_source_form','&image_source_id='.$data['image_source_id']);
			}
			else {
				$redirect = $this->html->getSecureURL('resource/image_source_form');
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

