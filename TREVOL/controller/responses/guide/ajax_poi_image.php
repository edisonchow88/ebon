<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesGuideAjaxPoiImage extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
		$this->loadModel('guide/poi');
		$this->loadModel('resource/image');
		//END
		
		foreach($_POST as $key => $value) {
			$this->data[$key] = $value;
		}
		
		$action = $this->data['action'];
		unset($this->data['action']);
		
		if($action == 'get') { $this->get(); }
		else if($action == 'add') { $this->add(); }
		else if($action == 'edit') { $this->edit(); }
		else if($action == 'delete') { $this->delete(); }
		else if($action == 'load') { $this->load(); }
		else if($action == 'select') { $this->select(); }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'No action has been sent via POST'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function get() {
		$relation_id = $this->data['relation_id']; 
		$result = $this->model_guide_poi->getPoiImage($relation_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		//START: verify file type
			$file_type = $_FILES['image']['type'];
			if($file_type == "image/jpeg") {
				$image_type = ".jpg";
			}
			else if($file_type == "image/png") {
				$image_type = ".png";
			}
			else if($file_type == "image/gif") {
				$image_type = ".gif";
			}
			else {
				$this->session->data['warning'] = "Error: Fail to upload new image due to invalid file type.";
				return false;
			}
			$this->data['image_type'] = $image_type;
		//END
		
		//START: add row to database
			$image_id = $this->model_resource_image->addImage($this->data);
			$this->data['image_id'] = $image_id;
		//END 
		
		//START: name the image
			$ds = DIRECTORY_SEPARATOR;
			$upload_directory = DIR_RESOURCE . "image" . $ds . "cropped" . $ds;
			$upload_file = $upload_directory . $image_id . $image_type;
			
			$tmp_name = $_FILES['image']['tmp_name'];
			$this->session->data['success'] = $tmp_name." yes ".$upload_file;
		//END
			
		//START: move the image
			if (move_uploaded_file($tmp_name, $upload_file)) {
				$this->session->data['success'] = "Success: New <b>Image #".$image_id."</b> has been added";
			} else {
				$this->session->data['warning'] = "Error: Please check the folder permission";
			}
		//END
		
		//START: assign image to poi
			$relation_id = $this->model_guide_poi->addPoiImage($this->data); 
			$this->session->data['success'] = 'Success: New <b>Poi Image #'.$relation_id.'</b> has been added';
		//END
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$relation_id = $this->data['relation_id']; 
		$execution = $this->model_guide_poi->editPoiImage($relation_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Image #".$relation_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$relation_id = $this->data['relation_id']; 
		$execution = $this->model_guide_poi->deletePoiImage($relation_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Image #".$relation_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: set requirement
		if($_POST['action'] == 'add') {
			if($_FILES['image']['size'] <= 0) {
				$result['warning'][] = 'Please input <b>Image</b>';
			}
			else if($_FILES['image']['type'] != 'image/png' && $_FILES['image']['type'] != 'image/gif' && $_FILES['image']['type'] != 'image/jpg' && $_FILES['image']['type'] != 'image/jpeg') {
				$result['warning'][] = '<b>Image</b> is not JPG or PNG or GIF.';
			}
			
			if($this->data['poi_id'] == '') {
				$result['warning'][] = 'Please input <b>Poi</b>';
			}
			
			if($this->data['name'] == '') {
				$result['warning'][] = 'Please input <b>Name</b>';
			}
			
			if($this->data['image_source_id'] == '' || $this->data['image_source_id'] == 0) {
				$result['warning'][] = 'Please input <b>Source</b>';
			}
			
			if($this->data['image_license_id'] == '' || $this->data['image_license_id'] == 0) {
				$result['warning'][] = 'Please input <b>License</b>';
			}
		}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	public function load() {
		
		//START: set variable
			$keyword = $this->data['keyword'];
			$limit = $this->data['limit'];
			$offset = $this->data['offset'];
		//END
		
		//START: get image
			$result['image'] = $this->model_resource_image->getImageByKeyword($keyword,'100px',$limit,$offset);
			$result['count'] = $result['image']['count'];
			unset($result['image']['count']);
			$result['image'] = array_values($result['image']);
		//END
		
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function select() {
		//START: assign image to poi
			$relation_id = $this->model_guide_poi->addPoiImage($this->data); 
			$this->session->data['success'] = 'Success: New <b>Poi Image #'.$relation_id.'</b> has been added';
		//END
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
}