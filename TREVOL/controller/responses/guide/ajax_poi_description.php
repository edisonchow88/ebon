<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesGuideAjaxPoiDescription extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
		$this->loadModel('guide/poi');
		$this->loadModel('resource/tag');
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
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'No action has been sent via POST'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function get() {
		$description_id = $this->data['description_id']; 
		$result = $this->model_guide_poi->getPoiDescription($description_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$description_id = $this->model_guide_poi->addPoiDescription($this->data); 
		$this->session->data['success'] = 'Success: New <b>Poi Description #'.$description_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$description_id = $this->data['description_id']; 
		$execution = $this->model_guide_poi->editPoiDescription($description_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Description #".$description_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$description_id = $this->data['description_id']; 
		$execution = $this->model_guide_poi->deletePoiDescription($description_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Description #".$description_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: set requirement
		if($this->data['poi_id'] == '') {
			$result['warning'][] = 'Please input <b>Poi</b>';
		}
		
		if($this->data['language_id'] == '') {
			$result['warning'][] = 'Please input <b>Language</b>';
		}
		
		if($this->data['blurb'] == '') {
			$result['warning'][] = 'Please input <b>Blurb</b>';
		}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}