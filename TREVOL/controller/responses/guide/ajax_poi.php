<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesGuideAjaxPoi extends AController {
	
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
		else if($action == 'toggle_status') { $this->toggle_status(); }
		else if($action == 'get_summary') { $this->get_summary(); }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'No action has been sent via POST'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function get() {
		$poi_id = $this->data['poi_id']; 
		$result = $this->model_guide_poi->getPoi($poi_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify_add() == 'failed') { return; }
		
		$poi_id = $this->model_guide_poi->addPoi($this->data); 
		$this->session->data['success'] = 'Success: New <b>Poi #'.$poi_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify_edit() == 'failed') { return; }
		
		$poi_id = $this->data['poi_id']; 
		$execution = $this->model_guide_poi->editPoi($poi_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi #".$poi_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$poi_id = $this->data['poi_id']; 
		$execution = $this->model_guide_poi->deletePoi($poi_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi #".$poi_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify_add() {
		//START: set requirement
			if($this->data['name'] == '') {
				$result['warning'][] = 'Please input <b>Name</b>';
			}
			
			if($this->data['blurb'] == '') {
				$result['warning'][] = 'Please input <b>Blurb</b>';
			}
			
			if($this->data['lat'] == '') {
				$result['warning'][] = 'Please input <b>Latitiude</b>';
			}
			
			if($this->data['lng'] == '') {
				$result['warning'][] = 'Please input <b>Longitude</b>';
			}
			
			if($this->data['status'] == '') {
				$result['warning'][] = 'Please input <b>Status</b>';
			}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	public function verify_edit() {
		//START: set requirement
			if($this->data['lat'] == '') {
				$result['warning'][] = 'Please input <b>Latitiude</b>';
			}
			
			if($this->data['lng'] == '') {
				$result['warning'][] = 'Please input <b>Longitude</b>';
			}
			
			if($this->data['status'] == '') {
				$result['warning'][] = 'Please input <b>Status</b>';
			}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	public function toggle_status() {
		$poi_id = $this->data['poi_id']; 
		$result = $this->model_guide_poi->togglePoiStatus($poi_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function get_summary() {
		$poi_id = $this->data['poi_id']; 
		$result = $this->model_guide_poi->getPoiSummary($poi_id);
		$response = json_encode($result);
		echo $response;
	}
}