<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTravelAjaxLine extends AController {
	
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
		$line_id = $this->data['line_id']; 
		$result = $this->model_travel_trip->getLine($line_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function review() {
		$this->get();
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$line_id = $this->model_travel_trip->addLine($this->data); 
		$this->session->data['success'] = 'Success: New <b>Trip Line #'.$line_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$line_id = $this->data['line_id']; 
		$execution = $this->model_travel_trip->editLine($line_id, $this->data); 
		if($execution === true) { 
			$this->session->data['success'] = "Success: <b>Trip Line #".$line_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$line_id = $this->data['line_id']; 
		$execution = $this->model_travel_trip->deleteLine($line_id); 
		if($execution === true) { 
			$this->session->data['success'] = "Success: <b>Trip Line #".$line_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: set requirement
			if($this->data['day_id'] == '') {
				$result['warning'][] = '<b>Day</b> is missing';
			}
			
			if($this->data['type'] == '') {
				$result['warning'][] = '<b>Type</b> is missing';
			}
			
			if($this->data['sort_order'] == '') {
				$result['warning'][] = '<b>Sort Order</b> is missing';
			}
		//END
		
		//START: convert data format for NULL
			foreach($this->data as $key => $value) {
				if($value == '') {
					$this->data[$key] = 'NULL';
				}
			}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}