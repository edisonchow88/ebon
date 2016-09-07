<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTripAjaxItinerary extends AController {
	
	public $data = array();
	
	public function main() {
		//START: testing script
			foreach($_POST as $key => $value) {
				$this->data[$key] = $value;
			}
			
			$this->loadModel('account/user');	
			$this->loadModel('travel/trip');	
			
			if($this->data['action'] == 'refresh_trip') { $this->refresh_trip(); return; }
			else if($this->data['action'] == 'refresh_plan') { $this->refresh_plan(); return; }
			else if($this->data['action'] == 'search_all') { $this->search_all(); return; }
			else if($this->data['action'] == 'save_trip') { $this->save_trip(); return; }
			else if($this->data['action'] == 'new_trip') { $this->new_trip(); return; }
			else { 
				//IMPORTANT: Return responseText in order for xmlhttp to function properly 
				$result['warning'][] = '<b>ERROR: Invalid action</b><br/>Please contact Admin.'; 
				$response = json_encode($result);
				echo $response;	
				return;
			}
			
		//END
	}
	
	public function refresh_trip() {
		$result = $this->model_travel_trip->getTrip($this->data['trip_id']);
		$response = json_encode($result);
		echo $response;
	}
	
	public function refresh_plan() {
		$result = $this->model_travel_trip->getPlanDetail($this->data['plan_id']);
		$response = json_encode($result);
		echo $response;
	}
	
	public function search_all() {
		$this->loadModel('guide/poi');
		$this->loadModel('guide/destination');
		$this->loadModel('resource/tag');
		$this->loadModel('resource/image');
		
		$keyword = $this->data['keyword'];
		$execution = $this->model_guide_poi->getAllByKeyword($keyword);
		$response = json_encode(array_values($execution));
		echo $response;
	}
	
	public function new_trip() {
		//START: run verification
			if($this->verify_new_trip() == 'failed') { return; }
		//END
		
		//START: create trip & get trip_id
			$trip_data['user_id'] = $this->data['user_id'];
			$trip_data['status_id'] = 1;
			$trip_data['language_id'] = $this->data['language_id'];
			$trip_data['name'] = 'Untitled Trip';
			$trip_id = $this->model_travel_trip->addTrip($trip_data);
		//END
		
		//START: get code
			$trip = $this->model_travel_trip->getTrip($trip_id);
			$code = $trip['code'];
		//END
		
		//START: set redirect
			$result['redirect'] = $this->html->getSecureURL('trip/itinerary','&trip='.$code);
		//END
		
		//START: response
			$result['success'][] = 'Trip created'; 
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function save_trip() {
		//START: run verification
			if($this->verify_save_trip() == 'failed') { return; }
		//END
		
		//START: create trip & get trip_id
			$trip_data['user_id'] = $this->data['user_id'];
			$trip_data['status_id'] = 1;
			$trip_data['language_id'] = $this->data['language_id'];
			$trip_data['name'] = $this->data['name'];
			$trip_id = $this->model_travel_trip->addTrip($trip_data);
		//END
		
		//START: create plan & get plan_id
			$plan = $this->model_travel_trip->getPlanByTripId($trip_id);
			$plan = array_values($plan);
			$plan = $plan[0];
			$plan_id = $plan['plan_id'];
			unset($plan);
		//END
		
		//START: delete auto generated first day
			$execution = $this->model_travel_trip->deleteDayByPlanId($plan_id);
		//END
		
		//START: get plan data
			$plan = json_decode(html_entity_decode($this->data['plan']),true);
			$plan_data['name'] = $plan['name'];
			$plan_data['travel_date'] = $plan['travel_date'];
			if($plan_data['travel_date'] == '') { $plan_data['travel_date'] = 'NULL'; }
			$execution = $this->model_travel_trip->editPlan($plan_id, $plan_data);
			
			foreach($plan['day'] as $day) {
				$day_data = $day;
				$day_data['plan_id'] = $plan_id;
				unset($day_data['day_id']);
				$day_id = $this->model_travel_trip->addDay($day_data);
				
				foreach($day['line'] as $line) {
					$line_data = $line;
					$line_data['day_id'] = $day_id;
					unset($line_data['line_id']);
					$line_id = $this->model_travel_trip->addLine($line_data);
				}
			}
		//END
		
		//START: get code
			$trip = $this->model_travel_trip->getTrip($trip_id);
			$code = $trip['code'];
		//END
		
		//START: get code
			$trip = $this->model_travel_trip->getTrip($trip_id);
			$code = $trip['code'];
		//END
		
		//START: set redirect
			$result['redirect'] = $this->html->getSecureURL('trip/itinerary','&trip='.$code);
		//END
		
		//START: response
			$result['success'][] = 'Trip saved'; 
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function verify_new_trip() {
		$trip = $this->model_travel_trip->getTripByUserId($this->data['user_id']);
		$role = $this->model_account_user->getRole($this->data['role_id']);
		$max_active_trip = (int)$role['max_active_trip'];
		
		if(count($trip) >= $max_active_trip) {
			$result['exceeded_quota'] = $role;
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	public function verify_save_trip() {
		$trip = $this->model_travel_trip->getTripByUserId($this->data['user_id']);
		$role = $this->model_account_user->getRole($this->data['role_id']);
		$max_active_trip = (int)$role['max_active_trip'];
		
		if(count($trip) >= $max_active_trip) {
			$result['exceeded_quota'] = $role;
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
		
		if($this->data['name'] == '') {
			$result['warning'][] = '<b>Trip Name</b> is missing.';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	/*
	public function get_trip() {
		$text = html_entity_decode($this->data['send']);
		$json = json_decode($text,true);
		
		$this->loadModel('travel/trip');
		$this->loadModel('resource/tag');
		$this->loadModel('resource/image');
		
		$result['plan'] = $this->model_travel_trip->getAllLineByPlanId($json['plan_id']);
		$result['success'][] = '';
		
		$response = json_encode($result);
		echo $response;
	}
	*/
}