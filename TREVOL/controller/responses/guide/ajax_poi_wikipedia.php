<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesGuideAjaxPoiWikipedia extends AController {
	
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
		$wikipedia_id = $this->data['wikipedia_id']; 
		$result = $this->model_guide_poi->getPoiWikipedia($wikipedia_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$wikipedia_id = $this->model_guide_poi->addPoiWikipedia($this->data); 
		$this->session->data['success'] = 'Success: New <b>Poi Wikipedia #'.$wikipedia_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$wikipedia_id = $this->data['wikipedia_id']; 
		$execution = $this->model_guide_poi->editPoiWikipedia($wikipedia_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Wikipedia #".$wikipedia_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$wikipedia_id = $this->data['wikipedia_id']; 
		$execution = $this->model_guide_poi->deletePoiWikipedia($wikipedia_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Wikipedia #".$wikipedia_id."</b> has been deleted";
			
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
		
		if($this->data['w_title'] == '') {
			$result['warning'][] = 'Please input <b>Title</b>';
		}
		
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}