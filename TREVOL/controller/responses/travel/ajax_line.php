<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTravelAjaxLine extends AController {
	
	public $data = array();

	public function main() {
		$this->loadModel('travel/trip');
		$this->loadModel('travel/status');
		$this->loadModel('travel/transport');
		$this->loadModel('travel/plan');
		$this->loadModel('travel/line');
		$this->loadModel('resource/tag');
		$this->loadModel('user/user');
		
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
		$line_id = $this->data['line_id']; 
		$result = $this->model_travel_line->getLine($line_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$line_id = $this->model_travel_line->addLine($this->data); 
		$this->session->data['success'] = 'Success: New <b>Trip Line #'.$line_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$line_id = $this->data['line_id']; 
		$execution = $this->model_travel_line->editLine($line_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Trip Line #".$line_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$line_id = $this->data['line_id']; 
		$execution = $this->model_travel_line->deleteLine($line_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Trip Line #".$line_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: Requirement
		if($this->data['plan_id'] == '') {
			$result['warning'][] = 'Please input <b>Plan</b>';
		}
		
		if($this->data['tag_id'] == '') {
			$result['warning'][] = 'Please input <b>Tag</b>';
		}
		//END: Requirement
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}