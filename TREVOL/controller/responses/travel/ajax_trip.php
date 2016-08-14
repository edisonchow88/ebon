<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTravelAjaxTrip extends AController {
	
	public $data = array();

	public function main() {
		$this->loadModel('travel/trip');
		$this->loadModel('travel/status');
		$this->loadModel('travel/plan');
		$this->loadModel('travel/mode');
		$this->loadModel('account/user');
		
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
		$trip_id = $this->data['trip_id']; 
		$result = $this->model_travel_trip->getTrip($trip_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$trip_id = $this->model_travel_trip->addTrip($this->data); 
		$this->session->data['success'] = 'Success: New <b>Trip #'.$trip_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$trip_id = $this->data['trip_id']; 
		$execution = $this->model_travel_trip->editTrip($trip_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Trip #".$trip_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$trip_id = $this->data['trip_id']; 
		$execution = $this->model_travel_trip->deleteTrip($trip_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Trip #".$trip_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		if($this->data['name'] == '') {
			$result['warning'][] = 'Please input <b>Name</b>';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}