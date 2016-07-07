<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesDatabaseAjaxDatabase extends AController {
	
	public $data = array();

	public function main() {
		$this->loadModel('database/database');
		
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
		$database_id = $this->data['database_id']; 
		$result = $this->model_database_database->getDatabase($database_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$database_id = $this->model_database_database->addDatabase($this->data); 
		$this->session->data['success'] = 'Success: New <b>Database #'.$database_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$database_id = $this->data['database_id']; 
		$execution = $this->model_database_database->editDatabase($database_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Database #".$database_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$database_id = $this->data['database_id']; 
		$execution = $this->model_database_database->deleteDatabase($database_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Database #".$database_id."</b> has been deleted";
			
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