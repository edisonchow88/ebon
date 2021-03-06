<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesMainAjaxExplore extends AController {
	
	public $data = array();

	public function main() {
		
		//START: load model
			$this->loadModel('explore/place');
			$this->loadModel('guide/destination');
			$this->loadModel('guide/poi');
			$this->loadModel('resource/tag');
			$this->loadModel('resource/image');
		//END
			
		foreach($_POST as $key => $value) {
			$this->data[$key] = $value;
		}	
		
		$action = $this->data['action'];
		unset($this->data['action']);
		
		if($action == 'init') { $this->init(); return; }
		else if($action == 'search') { $this->search(); return; }
		else if($action == 'get_place') { $this->getPlace(); return; }
		else if($action == 'add_place') { $this->addPlace(); return; }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'System Failure: Please contact Admin.'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function init() {
		//START: get child destination
			//START: set data
				$data = $this->model_guide_destination->getDestinationChild(1);
			//END
			//START: set result
				if(count($data) > 0) {
					$result['count']['destination'] = $data['count'];
					unset($data['count']);
					
					foreach($data as $row) {
						$destination_id = $row['destination_id'];
						foreach($row as $key => $value) { $result['destination'][$destination_id][$key] = $row[$key]; }	
						$result['destination'][$destination_id]['image'] = $row['image']['image'];	
					}
					
					$result['destination'] = array_values($result['destination']);
				}
			//END
		//END
		
		$response = json_encode($result);
		echo $response;
	}
	
	public function search() {
		$place_id = $this->data['place_id'];
		$place = $this->model_explore_place->getPlaceByPlaceId($place_id);
		if($place != false) {
			if($place['type'] == 'destination') {
				$destination_id = $place['type_id'];
				
				//START: set data
					$data = $this->model_guide_destination->getDestination($destination_id);
				//END
				//START: modify data
					$data['description'] = html_entity_decode($data['description']);
				//END
				//START: set result
					if(count($data) > 0) {
						foreach($data as $key => $value) { $result['current'][$key] = $data[$key]; }
					}
				//END
				//START: get child destination
					//START: set data
						$data = $this->model_guide_destination->getDestinationChild($destination_id);
					//END
					//START: set result
						if(count($data) > 0) {
							$result['count']['destination'] = $data['count'];
							unset($data['count']);
							
							foreach($data as $row) {
								$destination_id = $row['destination_id'];
								foreach($row as $key => $value) { $result['destination'][$destination_id][$key] = $row[$key]; }	
								$result['destination'][$destination_id]['image'] = $row['image']['image'];	
							}
							
							$result['destination'] = array_values($result['destination']);
						}
					//END
				//END
				//START: get child poi
					//START: set data
						$destination_id = $place['type_id'];
						$data = $this->model_guide_poi->getPoiByDestinationId($destination_id);
					//END
					//END
					//START: set result
						if(count($data) > 0) {
							$result['count']['poi'] = $data['count'];
							unset($data['count']);
							
							foreach($data as $row) {
								$poi_id = $row['poi_id'];
								foreach($row as $key => $value) { $result['poi'][$poi_id][$key] = $row[$key]; }	
								$result['poi'][$poi_id]['image'] = $row['image']['image'];	
							}
							
							$result['poi'] = array_values($result['poi']);
						}
					//END
				//END
				$result['current']['type'] = 'destination';
			}
			else if($place['type'] == 'poi') {
				$poi_id = $place['type_id'];
				
				//START: set data
					$data = $this->model_guide_poi->getPoi($place['type_id']);
				//END
				
				//START: set result
					if(count($data) > 0) {
						foreach($data as $key => $value) { $result['current'][$key] = $data[$key]; }
					}
				//END
				
				//START: get parent destination
					//START: set data
						$data = $this->model_guide_destination->getDestination($result['current']['destination']['destination_id']);
					//END
					//START: set result
						$result['current']['parent'] = $data;
					//END
				//END
				
				$result['current']['type'] = 'poi';
			}
		}
		else {
			$result = false;
		}
		$response = json_encode($result);
		echo $response;
	}
	
	public function getPlace() {
		//START: set variable
			$place_id = $this->data['place_id'];
		//END
		//START: set result
			$result = $this->model_explore_place->getGoogleByPlaceId($place_id);
		//END
		//START: format result
			$result['place_id'] = $result['g_place_id'];
			$result['name'] = $result['g_name'];
			$result['photo'] = $result['g_photo'];
		//END
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
		
	}
	
	public function addPlace() {
		//START: set variable
			$place_id = $this->data['place_id'];
		//END
		//START: set data
			$data['g_place_id'] = $place_id;
			$data['g_name'] = $this->data['name'];
			$data['g_photo'] = $this->data['photo'];
			$data['country'] = $this->data['country'];
			$data['region'] = $this->data['region'];
			$data['city'] = $this->data['city'];
		//END
		//START: format data
			foreach($data as $key => $value) {
				if($value == '') { $data[$key] = 'NULL'; }
			}
		//END
		//START: verify place_id if exist
			$exist = $this->model_explore_place->verifyGoogleByPlaceId($place_id);
		//END
		//START: add place_id if not exist
			if($exist == false) {
				$google_id =  $this->model_explore_place->addGoogle($data);
			}
		//END
		//START: add favourite if logged in
			if($user_id != '') {
				$result = true;
			}
			else {
				$result = false;
			}
		//END
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
	}
}