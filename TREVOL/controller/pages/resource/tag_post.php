<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceTagPost extends AController {
  	public function main() {
		$this->loadModel('resource/tag');
		
		if($this->request->post['action'] == "add") { $this->add(); }
		else if($this->request->post['action'] == "edit") { $this->edit(); }
		else if($this->request->post['action'] == "delete") { $this->delete(); }
		else { $this->session->data['warning'] = "Error: No action has been sent via POST"; }
		
		$redirect = $this->html->getSecureURL('resource/tag_list');
		$this->redirect($redirect);
	}
	
	public function add() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
		$tag_id = $this->model_resource_tag->addTag($data); 
		$this->session->data['success'] = "Success: New <b>Tag #".$tag_id."</b> has been added";
	}
	
	public function edit() {
		$data = $this->verify();
		if($data == 'failed' ) { return; }
		
		$tag_id = $data['tag_id']; 
		$this->model_resource_tag->editTag($tag_id, $data); 
		$this->session->data['success'] = "Success: <b>Tag #".$tag_id."</b> has been modified";
	}
	
	public function delete() {
		$tag_id = $this->request->post['tag_id'];
		
		$this->model_resource_tag->deleteTag($tag_id); 
		$this->session->data['success'] = "Success: <b>Tag #".$tag_id."</b> has been deleted";
		
	}
	
	public function verify() {
		$data['tag_id'] = $this->request->post['tag_id'];
		$data['tag_type_id'] = $this->request->post['tag_type_id'];
		$data['icon'] = $this->request->post['icon'];
		$data['language_id'] = $this->request->post['language_id'];
		$data['name'] = $this->request->post['name'];
		$data['description'] = $this->request->post['description'];
		
		if($this->request->post['parent'] != '[]') { //avoid add empty row to database
			$string = $this->request->post['parent']; 
			$string = str_replace("[","",$string);
			$string = str_replace("]","",$string);
			$parent = explode("},{",$string);
			$i = 0;
			foreach($parent as $tag) {
				$tag = str_replace("{","",$tag);
				$tag = str_replace("}","",$tag);
				$properties = explode(",",$tag);
				$parent[$i] = array();
				foreach($properties as $property) {
					$property = str_replace("&quot;","",$property);
					$property = explode(":",$property);
					$parent[$i][$property[0]] = $property[1];
				};
				$i += 1;
			}
			$data['parent'] = $parent;
		}
		
		if($this->request->post['child'] != '[]') { //avoid add empty row to database
			$string = $this->request->post['child']; 
			$string = str_replace("[","",$string);
			$string = str_replace("]","",$string);
			$child = explode("},{",$string);
			$i = 0;
			foreach($child as $tag) {
				$tag = str_replace("{","",$tag);
				$tag = str_replace("}","",$tag);
				$properties = explode(",",$tag);
				$child[$i] = array();
				foreach($properties as $property) {
					$property = str_replace("&quot;","",$property);
					$property = explode(":",$property);
					$child[$i][$property[0]] = $property[1];
				};
				$i += 1;
			}
			$data['child'] = $child;
		}
		
		if($this->request->post['similar'] != '[]') { //avoid add empty row to database
			$string = $this->request->post['similar']; 
			$string = str_replace("[","",$string);
			$string = str_replace("]","",$string);
			$similar = explode("},{",$string);
			$i = 0;
			foreach($similar as $tag) {
				$tag = str_replace("{","",$tag);
				$tag = str_replace("}","",$tag);
				$properties = explode(",",$tag);
				$similar[$i] = array();
				foreach($properties as $property) {
					$property = str_replace("&quot;","",$property);
					$property = explode(":",$property);
					$similar[$i][$property[0]] = $property[1];
				};
				$i += 1;
			}
			$data['similar'] = $similar;
		}
		
		$error = array();
		if($data['tag_type_id'] == '') { $error[] = "Please select a tag type."; }
		if($data['language_id'] == '') { $error[] = "Please select a language."; }
		if($data['name'] == '') { $error[] = "Please key in the name."; }
		
		if(count($error) > 0) { 
			//if contain error, show alerts
			$error_list = 'Warning:<ul>';
			foreach($error as $text) {
				$error_list .= '<li>'.$text.'</li>';
			}
			$error_list .= '</ul>';
			$this->session->data['warning'] = $error_list;
			
			if($data['tag_id'] != '') {
				$redirect = $this->html->getSecureURL('resource/tag_form','&tag_id='.$data['tag_id']);
			}
			else {
				$redirect = $this->html->getSecureURL('resource/tag_form');
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

