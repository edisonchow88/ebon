<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesGuideAjaxDestination extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
		$this->loadModel('guide/destination');
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
		$destination_id = $this->data['destination_id']; 
		$result = $this->model_guide_destination->getDestination($destination_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify_add() == 'failed') { return; }
		
		$destination_id = $this->model_guide_destination->addDestination($this->data); 
		$this->session->data['success'] = 'Success: New <b>Destination #'.$destination_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify_edit() == 'failed') { return; }
		
		$destination_id = $this->data['destination_id']; 
		$execution = $this->model_guide_destination->editDestination($destination_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Destination #".$destination_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$destination_id = $this->data['destination_id']; 
		$execution = $this->model_guide_destination->deleteDestination($destination_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Destination #".$destination_id."</b> has been deleted";
			
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
		$destination_id = $this->data['destination_id']; 
		$result = $this->model_guide_destination->toggleDestinationStatus($destination_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function get_summary() {
		$destination_id = $this->data['destination_id']; 
		$result = $this->model_guide_destination->getDestinationSummary($destination_id);
		$response = json_encode($result);
		echo $response;
	}
}