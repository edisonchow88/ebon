<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceTagTypePost extends AController {
  	public function main() {
		$this->loadModel('resource/tag');
		
		if($this->request->post['action'] == "add") { $this->add(); }
		else if($this->request->post['action'] == "edit") { $this->edit(); }
		else if($this->request->post['action'] == "delete") { $this->delete(); }
		else { $this->session->data['warning'] = "Error: No action has been sent via POST"; }
		
		$redirect = $this->html->getSecureURL('resource/tag_type_list');
		$this->redirect($redirect);
	}
	
	public function add() {
		$data['type_name'] = $this->request->post['type_name'];
		$data['type_color'] = $this->request->post['type_color'];
		
		$tag_type_id = $this->model_resource_tag->addTagType($data); 
		$this->session->data['success'] = "Success: New <b>Tag Type #".$tag_type_id."</b> has been added";
	}
	
	public function edit() {
		$tag_type_id = $this->request->post['tag_type_id'];
		
		$data['tag_type_id'] = $this->request->post['tag_type_id'];
		$data['type_name'] = $this->request->post['type_name'];
		$data['type_color'] = $this->request->post['type_color'];
		
		$this->model_resource_tag->editTagType($tag_type_id, $data); 
		$this->session->data['success'] = "Success: <b>Tag Type #".$tag_type_id."</b> has been modified";
	}
	
	public function delete() {
		$tag_type_id = $this->request->post['tag_type_id'];
		
		$this->model_resource_tag->deleteTagType($tag_type_id); 
		$this->session->data['success'] = "Success: <b>Tag Type #".$tag_type_id."</b> has been deleted";
	}
}
?>

