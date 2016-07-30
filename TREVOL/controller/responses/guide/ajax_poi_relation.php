<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesGuideAjaxPoiRelation extends AController {
	
	public $data = array();

	public function main() {
		//START: load model
		$this->loadModel('guide/poi');
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
		else if($action == 'search_poi') { $this->search_poi(); }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'No action has been sent via POST'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function get() {
		$relation_id = $this->data['relation_id']; 
		$result = $this->model_guide_poi->getPoiRelation($relation_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		if($this->data['relation'] == 'parent') {
			$this->data['parent_id'] = $this->data['target_id'];
		}
		else if($this->data['relation'] == 'child') {
			$this->data['parent_id'] = $this->data['poi_id'];
			$this->data['poi_id'] = $this->data['target_id'];
		}
		
		$relation_id = $this->model_guide_poi->addPoiRelation($this->data); 
		$this->session->data['success'] = 'Success: New <b>Poi Relation #'.$relation_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$relation_id = $this->data['relation_id']; 
		$execution = $this->model_guide_poi->editPoiRelation($relation_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Relation #".$relation_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$relation_id = $this->data['relation_id']; 
		$execution = $this->model_guide_poi->deletePoiRelation($relation_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>Poi Relation #".$relation_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function search_poi() {
		$keyword = $this->data['keyword'];
		$poi = $this->model_guide_poi->getPoiByKeyword($keyword);
		foreach($poi as $p) {
			if(isset($p['destination'])) {
				$poi[$p['poi_id']]['destination'] = $this->model_guide_destination->getDestinationSpecialTagByDestinationId($p['destination'][0]['destination_id']);
			}
		}
		$response = json_encode(array_values($poi));
		echo $response;
	}
	
	public function verify() {
		//START: set requirement
		if($this->data['poi_id'] == '') {
			$result['warning'][] = 'Please input <b>Poi</b>';
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