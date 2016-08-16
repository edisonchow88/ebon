<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTravelAjaxMode extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
			$this->loadModel('travel/trip');
		//END
		
		foreach($_POST as $key => $value) {
			$this->data[$key] = $value;
		}
		
		$action = $this->data['action'];
		unset($this->data['action']);
		
		if($action == 'get') { $this->get(); }
		else if($action == 'review') { $this->review(); }
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
		$mode_id = $this->data['mode_id']; 
		$result = $this->model_travel_trip->getMode($mode_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function review() {
		$this->get();
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$mode_id = $this->model_travel_trip->addMode($this->data); 
		$this->session->data['success'] = 'Success: New <b>Mode #'.$mode_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$mode_id = $this->data['mode_id']; 
		$execution = $this->model_travel_trip->editMode($mode_id, $this->data); 
		if($execution === true) { 
			$this->session->data['success'] = "Success: <b>Mode #".$mode_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$mode_id = $this->data['mode_id']; 
		$execution = $this->model_travel_trip->deleteMode($mode_id); 
		if($execution === true) { 
			$this->session->data['success'] = "Success: <b>Mode #".$mode_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: set requirement
			if($this->data['language_id'] == '') {
				$result['warning'][] = '<b>Language</b> is missing';
			}
			
			if($this->data['name'] == '') {
				$result['warning'][] = '<b>Name</b> is missing';
			}
			
			if($this->data['icon'] == '') {
			$result['warning'][] = '<b>Icon</b> is missing';
		}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}