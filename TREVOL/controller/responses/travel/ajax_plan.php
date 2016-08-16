<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTravelAjaxPlan extends AController {
	
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
		$plan_id = $this->data['plan_id']; 
		$result = $this->model_travel_trip->getPlan($plan_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function review() {
		$this->get();
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$plan_id = $this->model_travel_trip->addPlan($this->data); 
		$this->session->data['success'] = 'Success: New <b>Trip Plan #'.$plan_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$plan_id = $this->data['plan_id']; 
		$execution = $this->model_travel_trip->editPlan($plan_id, $this->data); 
		if($execution === true) { 
			$this->session->data['success'] = "Success: <b>Trip Plan #".$plan_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$plan_id = $this->data['plan_id']; 
		$execution = $this->model_travel_trip->deletePlan($plan_id); 
		if($execution === true) { 
			$this->session->data['success'] = "Success: <b>Trip Plan #".$plan_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: set requirement
			if($this->data['trip_id'] == '') {
				$result['warning'][] = '<b>Trip</b> is missing';
			}
			
			if($this->data['mode_id'] == '') {
				$result['warning'][] = '<b>Mode</b> is missing';
			}
			
			if($this->data['sort_order'] == '') {
				$result['warning'][] = '<b>Sort Order</b> is missing';
			}
			
			if($this->data['selected'] == '') {
				$result['warning'][] = '<b>Selected</b> is missing';
			}
			
			if($this->data['language_id'] == '') {
				$result['warning'][] = '<b>Language</b> is missing';
			}
			
			if($this->data['name'] == '') {
				$result['warning'][] = '<b>Name</b> is missing';
			}
		//END
		
		//START: convert data format
			foreach($this->data as $key => $value) {
				if($value == '') {
					$this->data[$key] = 'NULL';
				}
			}
		//END
		
		//START: return warning if failed
			if(count($result['warning']) > 0) { 
				$response = json_encode($result);
				echo $response;	
				return 'failed';
			}
		//END
	}
}