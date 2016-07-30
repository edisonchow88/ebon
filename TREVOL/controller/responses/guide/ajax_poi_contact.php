<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesGuideAjaxPoiContact extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
		$this->loadModel('guide/poi');
		$this->loadModel('resource/tag');
		$this->loadModel('resource/image');
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
		$contact_id = $this->data['contact_id']; 
		$result = $this->model_guide_poi->getPoiContact($contact_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$contact_id = $this->model_guide_poi->addPoiContact($this->data); 
		$this->session->data['success'] = 'Success: New <b>Poi Contact #'.$contact_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$contact_id = $this->data['contact_id']; 
		$execution = $this->model_guide_poi->editPoiContact($contact_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Contact #".$contact_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$contact_id = $this->data['contact_id']; 
		$execution = $this->model_guide_poi->deletePoiContact($contact_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Contact #".$contact_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		//START: set requirement
			if($this->data['poi_id'] == '') {
				$result['warning'][] = 'Please input <b>Poi</b>';
			}
			
			if($this->data['contact'] == '' || $this->data['contact'] == 0) {
				$result['warning'][] = 'Please input <b>Contact</b>';
			}
			
			if($this->data['info'] == '') {
				$result['warning'][] = 'Please input <b>Info</b>';
			}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}