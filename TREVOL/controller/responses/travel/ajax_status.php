<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTravelAjaxStatus extends AController {
	
	public $data = array();

	public function main() {
		$this->loadModel('travel/status');
		
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
		$status_id = $this->data['status_id']; 
		$result = $this->model_travel_status->getStatus($status_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$status_id = $this->model_travel_status->addStatus($this->data); 
		$this->session->data['success'] = 'Success: New <b>Trip Status #'.$status_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$status_id = $this->data['status_id']; 
		$execution = $this->model_travel_status->editStatus($status_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Trip Status #".$status_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$status_id = $this->data['status_id']; 
		$execution = $this->model_travel_status->deleteStatus($status_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Trip Status #".$status_id."</b> has been deleted";
			
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
		
		if($this->data['color'] == '') {
			$result['warning'][] = 'Please input <b>Color</b>';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}