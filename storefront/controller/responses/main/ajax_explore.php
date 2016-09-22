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
		
		if($action == 'search') { $this->search(); return; }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'System Failure: Please contact Admin.'; 
			$response = json_encode($result);
			echo $response;	
		}
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
						$destination_id = $this->data['destination_id'];
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
			}
			else if($place['type'] == 'poi') {
				$result = $this->model_guide_poi->getPoi($place['type_id']);
			}
		}
		else {
			$result = false;
		}
		$response = json_encode($result);
		echo $response;
	}
}