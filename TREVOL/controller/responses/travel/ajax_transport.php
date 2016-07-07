<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTravelAjaxTransport extends AController {
	
	public $data = array();

	public function main() {
		$this->loadModel('travel/transport');
		
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
		$transport_id = $this->data['transport_id']; 
		$result = $this->model_travel_transport->getTransport($transport_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$transport_id = $this->model_travel_transport->addTransport($this->data); 
		$this->session->data['success'] = 'Success: New <b>Transport #'.$transport_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$transport_id = $this->data['transport_id']; 
		$execution = $this->model_travel_transport->editTransport($transport_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Transport #".$transport_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$transport_id = $this->data['transport_id']; 
		$execution = $this->model_travel_transport->deleteTransport($transport_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Transport #".$transport_id."</b> has been deleted";
			
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
		
		if($this->data['icon'] == '') {
			$result['warning'][] = 'Please input <b>Icon</b>';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}