<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceImagePost extends AController {
  	public function main() {
		$this->loadModel('resource/image');
		
		if($this->request->post['action'] == "add") { $this->add(); }
		else if($this->request->post['action'] == "edit") { $this->edit(); }
		else if($this->request->post['action'] == "delete") { $this->delete(); }
		else { $this->session->data['warning'] = "Error: No action has been sent via POST"; }
		
		$redirect = $this->html->getSecureURL('resource/image_list');
		$this->redirect($redirect);
	}
	
	public function add() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
		$image_id = $this->model_resource_image->addImage($data); 
		$this->session->data['success'] = "Success: New <b>Image #".$image_id."</b> has been added";
	}
	
	public function edit() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
		$image_id = $data['image_id']; 
		if($this->model_resource_image->editImage($image_id, $data)) {
			$this->session->data['success'] = "Success: <b>Image #".$image_id."</b> has been modified";
		}
		else {
			$this->session->data['warning'] = "Error: Fail to edit <b>Image #".$image_id."</b>";
		}
	}
	
	public function delete() {
		$image_id = $this->request->post['image_id'];
		
		if($this->model_resource_image->deleteImage($image_id)) {
			$this->session->data['success'] = "Success: <b>Image #".$image_id."</b> has been deleted";
		}
		else {
			$this->session->data['warning'] = "Error: Fail to delete <b>Image #".$image_id."</b>";
		}
	}
	
	public function verify() {
		foreach($_POST as $key => $value) {
			$data[$key] = $value;
		}
		unset($data['action']); //avoid insert non-exist column
		
		//$data['tag_time_id'] = json_decode($data['tag_time_id']);
		if($data['tag_time_id'] != '[]') { //avoid add empty row to database
			$string = $data['tag_time_id']; 
			$string = str_replace("[","",$string);
			$string = str_replace("]","",$string);
			$tag_time = explode("},{",$string);
			$i = 0;
			foreach($tag_time as $tag) {
				$tag = str_replace("{","",$tag);
				$tag = str_replace("}","",$tag);
				$properties = explode(",",$tag);
				$tag_time[$i] = array();
				foreach($properties as $property) {
					$property = str_replace("&quot;","",$property);
					$property = explode(":",$property);
					$tag_time[$i][$property[0]] = $property[1];
				};
				$i += 1;
			}
			$data['tag_time_id'] = $tag_time;
		} 
		
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
			
			if($data['image_id'] != '') {
				$redirect = $this->html->getSecureURL('resource/image_form','&image_id='.$data['image_id']);
			}
			else {
				$redirect = $this->html->getSecureURL('resource/image_form');
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

