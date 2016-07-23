<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesResourceAjaxData extends AController {
	
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
		$data_id = $this->data['data_id']; 
		$result = $this->model_resource_data->getData($data_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$data_id = $this->model_resource_data->addData($this->data); 
		$this->session->data['success'] = 'Success: New <b>Data #'.$data_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$data_id = $this->data['data_id']; 
		$execution = $this->model_resource_data->editData($data_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Data #".$data_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$data_id = $this->data['data_id']; 
		$execution = $this->model_resource_data->deleteData($data_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Data #".$data_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: set requirement
			if($this->data['dataset_id'] == '') {
				$result['warning'][] = 'Please input <b>Dataset</b>';
			}
			
			if($this->data['name'] == '') {
				$result['warning'][] = 'Please input <b>Name</b>';
			}
			
			if($this->data['value'] == '') {
				$result['warning'][] = 'Please input <b>Value</b>';
			}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}