<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTripAjaxGuide extends AController {
	
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
		
		if($action == 'view') { $this->view(); return; }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'System Failure: Please contact Admin.'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function view() {
		if(isset($this->data['destination_id']) && $this->data['destination_id'] != '') { 
			$destination_id = $this->data['destination_id'];
			//START: set data
				$data = $this->model_guide_destination->getDestination($destination_id);
			//END
			
			//START: set result
				if(count($data) > 0) {
					foreach($data as $key => $value) { $result['current'][$key] = $data[$key]; }
				}
			//END
			
			//START: set data
				$data = $this->model_guide_destination->getDestinationChild($destination_id);
			//END
			
			//START: set result
				if(count($data) > 0) {
					
					$result['count'] = $data['count'];
					unset($data['count']);
					
					foreach($data as $row) {
						$destination_id = $row['destination_id'];
						foreach($row as $key => $value) { $result['child'][$destination_id][$key] = $row[$key]; }	
						$result['child'][$destination_id]['image'] = $row['image']['image'];	
					}
					
					$result['child'] = array_values($result['child']);
				}
			//END
		}
		else if(isset($this->data['poi_id'])) { 
			$poi_id = $this->data['poi_id']; 
		}
		
		
		
		$result['success'][] = 'Page is loaded'; 
		 
		$response = json_encode($result);
		echo $response;
	}
}