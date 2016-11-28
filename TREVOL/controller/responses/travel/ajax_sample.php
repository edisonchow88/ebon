<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTravelAjaxSample extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
			$this->loadModel('travel/trip');
			$this->loadModel('account/user');
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
		$sample_id = $this->data['sample_id']; 
		$result = $this->model_travel_trip->getSample($sample_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify("add") == 'failed') { return; }
		
		$data = $this->model_travel_trip->addSample($this->data); 
		$this->session->data['success'] = 'Success: Trip #'.$data["trip_id"].' has added into sample as <b>Sample #'.$data["sample_id"].'</b>';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify("edit") == 'failed') { return; }
		
		$sample_id = $this->data['sample_id']; 
		$execution = $this->model_travel_trip->editSample($sample_id, $this->data); 
		if($execution === true) { 
			$this->session->data['success'] = "Success: <b>Sample #".$sample_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$sample_id = $this->data['sample_id']; 
		$execution = $this->model_travel_trip->deleteSample($sample_id); 
		if($execution === true) { 
			$this->session->data['success'] = "Success: <b>Sample #".$sample_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify($action) {
		//START: set requirement
			if($action == "add" && $this->data['trip_id'] == '') {
				$result['warning'][] = '<b>Language</b> is missing';
			}
			if($action == "edit" && $this->data['trip_id'] == '') {
				$result['warning'][] = '<b>Language</b> is missing';
			}
			
			if($action == "edit" && $this->data['sample_id'] == '') {
				$result['warning'][] = '<b>Language</b> is missing';
			}
		//END
		
		//START: convert data format for NULL
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