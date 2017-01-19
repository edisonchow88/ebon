<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesWizardAjaxTrip extends AController {
	
	public $data = array();
	public $response = array();
	
	public function main() {
		//START: identify action
			foreach($_POST as $key => $value) {
				$this->data[$key] = $value;
			}
			
			$this->loadModel('account/user');
			$this->loadModel('localisation/country');
			$this->loadModel('travel/trip');	
			
			if($this->data['action'] == 'refresh_template') { $this->refresh_template(); return; }
			else if ($this->data['action'] == 'use_template') { $this->use_template(); return; }
			else { 
				//IMPORTANT: Return responseText in order for xmlhttp to function properly 
				$result['warning'][] = '<b>ERROR: Invalid action</b><br/>Please contact Admin.'; 
				$response = json_encode($result);
				echo $response;	
				return;
			}
			
		//END
	}
	
	public function refresh_template() {
		$country_id = $this->data['country_id'];
		$month = $this->data['month'];
		$mode_id = $this->data['mode_id'];
		$duration = $this->data['duration'];
		
		$result = $this->model_travel_trip->getTemplateByFilter($country_id,$month,$mode_id,$duration);
		if($result != false) { $result = array_values($result); } else { $result = array(); }
		$response['template'] = $result;
		
		$response = json_encode($response);
		echo $response;
	}
	
	

	public function use_template() {
		$user_id = $this->user->getUserId();
		$trip_id = 	$this->data['trip_id'];
		$result = $this->model_travel_trip->copyTrip($trip_id, $user_id);
		
		$response = json_encode($result);
		echo $response;
		
	}
}