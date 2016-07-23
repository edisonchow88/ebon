<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesResourceAjaxDataAlias extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
		$this->loadModel('resource/data');
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
		$alias_id = $this->data['alias_id']; 
		$result = $this->model_resource_data->getDataAlias($alias_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$alias_id = $this->model_resource_data->addDataAlias($this->data); 
		$this->session->data['success'] = 'Success: New <b>Data Alias #'.$alias_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$alias_id = $this->data['alias_id']; 
		$execution = $this->model_resource_data->editDataAlias($alias_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Data Alias #".$alias_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$alias_id = $this->data['alias_id']; 
		$execution = $this->model_resource_data->deleteDataAlias($alias_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Data Alias #".$alias_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: set requirement
			if($this->data['language_id'] == '') {
				$result['warning'][] = 'Please input <b>Language</b>';
			}
			
			if($this->data['name'] == '') {
				$result['warning'][] = 'Please input <b>Name</b>';
			}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}