<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTravelAjaxDay extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
		$this->loadModel('travel/trip');
		$this->loadModel('travel/status');
		$this->loadModel('travel/plan');
		$this->loadModel('travel/mode');
		$this->loadModel('travel/line');
		$this->loadModel('travel/day');
		$this->loadModel('user/user');
		$this->loadModel('resource/tag');
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
		$day_id = $this->data['day_id']; 
		$result = $this->model_travel_day->getDay($day_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$day_id = $this->model_travel_day->addDay($this->data); 
		$this->session->data['success'] = 'Success: New <b>Trip Day #'.$day_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$day_id = $this->data['day_id']; 
		$execution = $this->model_travel_day->editDay($day_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Trip Day #".$day_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$day_id = $this->data['day_id']; 
		$execution = $this->model_travel_day->deleteDay($day_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Trip Day #".$day_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: set requirement
		if($this->data['line_id'] == '') {
			$result['warning'][] = 'Please input <b>Line</b>';
		}
		
		if($this->data['date'] == '') {
			$result['warning'][] = 'Please input <b>Date</b>';
		}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}