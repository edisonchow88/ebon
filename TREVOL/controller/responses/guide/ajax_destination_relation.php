<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesGuideAjaxDestinationRelation extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
		$this->loadModel('guide/destination');
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
		else if($action == 'search_destination') { $this->search_destination(); }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'No action has been sent via POST'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function get() {
		$relation_id = $this->data['relation_id']; 
		$result = $this->model_guide_destination->getDestinationRelation($relation_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		if($this->data['relation'] == 'parent') {
			$this->data['parent_id'] = $this->data['target_id'];
		}
		else if($this->data['relation'] == 'child') {
			$this->data['parent_id'] = $this->data['destination_id'];
			$this->data['destination_id'] = $this->data['target_id'];
		}
		
		$relation_id = $this->model_guide_destination->addDestinationRelation($this->data); 
		$this->session->data['success'] = 'Success: New <b>Destination Relation #'.$relation_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$relation_id = $this->data['relation_id']; 
		$execution = $this->model_guide_destination->editDestinationRelation($relation_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Destination Relation #".$relation_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$relation_id = $this->data['relation_id']; 
		$execution = $this->model_guide_destination->deleteDestinationRelation($relation_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Destination Relation #".$relation_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function search_destination() {
		$keyword = $this->data['keyword'];
		$execution = $this->model_guide_destination->getDestinationByKeyword($keyword);
		$response = json_encode(array_values($execution));
		echo $response;
	}
	
	public function verify() {
		//START: set requirement
		if($this->data['destination_id'] == '') {
			$result['warning'][] = 'Please input <b>Destination</b>';
		}
		
		if($this->data['target_id'] == '') {
			$result['warning'][] = 'Please input <b>Target</b>';
		}
		
		if($this->data['relation'] == '') {
			$result['warning'][] = 'Please input <b>Relation</b>';
		}
		//END
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}