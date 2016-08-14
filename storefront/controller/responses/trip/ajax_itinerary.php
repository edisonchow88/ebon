<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTripAjaxItinerary extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: testing script
			foreach($_POST as $key => $value) {
				$this->data[$key] = $value;
			}	
			
			$text = html_entity_decode($this->data['send']);
			$json = json_decode($text,true);
			
			$this->loadModel('travel/trip');
			$this->loadModel('travel/status');
			$this->loadModel('account/user');
			
			$trip = $this->model_travel_trip->getTrip($json['trip_id']);
			
			var_dump($trip);
			return;
			
			if($action == 'get_trip') { $this->get_trip(); return; }
			else { 
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
				$result['warning'][] = 'System Failure: Please contact Admin.'; 
				$response = json_encode($result);
				echo $response;	
			}
		//END
		
		//START: set modal
		//END
		
		//START: set data
		//END
		
		//START: set result
		//END
		
		//START: set modal
		//END
		
		//START: set link
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
		//END
		
		//START: set template 
			$this->processTemplate('responses/trip/ajax_itinerary.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
	
	public function get_trip() {
		$result['trip'] = $this->model_travel_trip->getTrip($this->data[$trip_id]);
		
		$result['success'][] = '';
		$response = json_encode($result);
		echo $response;
	}
}