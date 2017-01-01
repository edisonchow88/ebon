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
			
			$bypass = false;
			if ($this->data['action'] == 'get_distance_path') $bypass = true;
			
			if(!isset($_SESSION['user_id']) && $bypass == false) {
				$result['error']['code'] = 401; 
				$result['error']['title'] = 'Not Logged In'; 
				$result['error']['text'] = 'Please log in to continue'; 
				$response = json_encode($result);
				echo $response;
				die();
			}
			
			$this->loadModel('account/user');	
			$this->loadModel('resource/photo');
			$this->loadModel('localisation/country');
			$this->loadModel('travel/trip');	
			
			if($this->data['action'] == 'refresh_trip') { $this->refresh_trip(); return; }
			else if($this->data['action'] == 'refresh_plan') { $this->refresh_plan(); return; }
			else if($this->data['action'] == 'search_all') { $this->search_all(); return; }
			else if($this->data['action'] == 'save_trip') { $this->save_trip(); return; }
			else if($this->data['action'] == 'new_trip') { $this->new_trip(); return; }
			else if($this->data['action'] == 'load_trip') { $this->load_trip(); return; }
			else if($this->data['action'] == 'load_upcoming_trip') { $this->load_upcoming_trip(); return; }
			else if($this->data['action'] == 'load_past_trip') { $this->load_past_trip(); return; }
			else if($this->data['action'] == 'load_invited_trip') { $this->load_invited_trip(); return; }
			else if($this->data['action'] == 'load_removed_trip') { $this->load_removed_trip(); return; }
			else if($this->data['action'] == 'remove_trip') { $this->remove_trip(); return; }
			else if($this->data['action'] == 'remove_multi_trip') { $this->remove_multi_trip(); return; }
			else if($this->data['action'] == 'restore_trip') { $this->restore_trip(); return; }
			else if($this->data['action'] == 'cancel_trip') { $this->cancel_trip(); return; }
			else if($this->data['action'] == 'resume_trip') { $this->resume_trip(); return; }
			else if($this->data['action'] == 'delete_trip') { $this->delete_trip(); return; }
			else if($this->data['action'] == 'delete_multi') { $this->delete_multi(); return; }
			else if($this->data['action'] == 'clean_archive') { $this->clean_archive(); return; }
			else if($this->data['action'] == 'edit_trip_name') { $this->edit_trip_name(); return; }
			else if($this->data['action'] == 'save_trip_info') { $this->save_trip_info(); return; }
			else if($this->data['action'] == 'refresh_trip_photo') { $this->refresh_trip_photo(); return; }
			else if($this->data['action'] == 'upload_trip_photo') { $this->upload_trip_photo(); return; }
			else if($this->data['action'] == 'search_user') { $this->search_user(); return; }
			else if($this->data['action'] == 'refresh_member') { $this->refresh_member(); return; }
			else if($this->data['action'] == 'get_member') { $this->get_member(); return; }
			else if($this->data['action'] == 'add_member') { $this->add_member(); return; }
			else if($this->data['action'] == 'edit_member') { $this->edit_member(); return; }
			else if($this->data['action'] == 'delete_member') { $this->delete_member(); return; }
			else if($this->data['action'] == 'refresh_country') { $this->refresh_country(); return; }
			else if($this->data['action'] == 'get_country') { $this->get_country(); return; }
			else if($this->data['action'] == 'add_country') { $this->add_country(); return; }
			else if($this->data['action'] == 'delete_country') { $this->delete_country(); return; }
			else if($this->data['action'] == 'edit_plan_date') { $this->edit_plan_date(); return; }
			else if($this->data['action'] == 'add_day') { $this->add_day(); return; }
			else if($this->data['action'] == 'delete_day') { $this->delete_day(); return; }
			else if($this->data['action'] == 'sort_day') { $this->sort_day(); return; }
			else if($this->data['action'] == 'add_line') { $this->add_line(); return; }
			else if($this->data['action'] == 'edit_line') { $this->edit_line(); return; }
			else if($this->data['action'] == 'delete_line') { $this->delete_line(); return; }
			else if($this->data['action'] == 'sort_line') { $this->sort_line(); return; }
			else if($this->data['action'] == 'refresh_sample') { $this->refresh_sample(); return; }
			else if($this->data['action'] == 'sample_new_trip') { $this->sample_new_trip(); return; }
			else if($this->data['action'] == 'get_line_mode_path') { $this->get_line_mode_path(); return; }
			else if($this->data['action'] == 'get_distance_path') { $this->get_distance_path(); return; }
			else if($this->data['action'] == 'add_path') { $this->add_path(); return; }
			else if($this->data['action'] == 'edit_line_mode') { $this->edit_line_mode(); return; }
			else if($this->data['action'] == 'get_path_custom') { $this->get_path_custom(); return; }
			else if($this->data['action'] == 'add_path_custom') { $this->add_path_custom(); return; }
			else if($this->data['action'] == 'edit_path_custom') { $this->edit_path_custom(); return; }
			
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
		foreach($result['day'] as $day_id => $day) {
			foreach($day['line'] as $line_id => $line) {
				$time = $result['day'][$day_id]['line'][$line_id]['time'];
				if($time != 'NULL' && $time != '') {
					$result['day'][$day_id]['line'][$line_id]['time'] = substr($time,0,-3);
				}
			}
		}
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
			$trip_data['name'] = $this->data['name'];
			$trip_data['country_id'] = $this->data['country_id'];
			$trip_id = $this->model_travel_trip->addTrip($trip_data);
		//END
		
		//START: get user
			$user_id = $this->data['user_id'];
			$data = $this->model_account_user->getUser($user_id);
		//END
		
		//START: add user
			$data['user_id'] = $user_id;
			$data['trip_id'] = $trip_id;
			$data['status_id'] = 1;
			
			$trip_member_id = $this->model_travel_trip->addMember($data);
		//END
		
		//START: get code
			$trip = $this->model_travel_trip->getTrip($trip_id);
			$code = $trip['code'];
		//END
		
		//START: set redirect
			$result['redirect'] = $this->html->getSecureURL('trip/itinerary','&trip='.$code);
		//END
		
		//START: set response
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
		
		//START: get user
			$user_id = $this->data['user_id'];
			$data = $this->model_account_user->getUser($user_id);
		//END
		
		//START: add user
			$data['user_id'] = $user_id;
			$data['trip_id'] = $trip_id;
			$data['status_id'] = 1;
			
			$trip_member_id = $this->model_travel_trip->addMember($data);
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
		
		//START: set session
			$this->session->data['trip_action'] = 'save_trip';
		//END
		
		//START: set response
			$result['success'][] = 'Trip saved'; 
			$response = json_encode($result);
			if ($this->data['from_sample']) {
				return $result['redirect'];
			}else {
				echo $response;
			}
		//END
	}
	
	public function load_trip() {
		//START: get data
			$result['active_trip'] = $this->model_travel_trip->getActiveTripByUserId($this->data['user_id']);
			$result['removed_trip'] = $this->model_travel_trip->getRemovedTripByUserId($this->data['user_id']);
		//END
		
		//START: get variable
			$role = $this->model_account_user->getRole($this->data['role_id']);
			if($result['active_trip'] == false) {
				$result['num_of_active_trip'] = 0;
			}
			else {
				$result['num_of_active_trip'] = count($result['active_trip']);
			}
			if($result['removed_trip'] == false) {
				$result['num_of_removed_trip'] = 0;
			}
			else {
				$result['num_of_removed_trip'] = count($result['removed_trip']);
			}
			$result['max_active_trip'] = $role['max_active_trip'];
			$result['max_removed_trip'] = $role['max_removed_trip'];
			$result['usage_of_trip'] = $result['num_of_active_trip'] / $result['max_active_trip'] * 100;
			$result['usage_of_archive'] = $result['num_of_removed_trip'] / $result['max_removed_trip'] * 100;
		//END
		
		//START: process active trip
			if($result['active_trip'] != false) {
				foreach($result['active_trip'] as $trip_id => $trip) {
					$result['active_trip'][$trip_id] = $trip;
					$user = $this->model_account_user->getUser($trip['user_id']);
					$username = substr($user['email'], 0, strpos($user['email'], "@"));
					$result['active_trip'][$trip_id]['username'] = $username;
					$result['active_trip'][$trip_id]['url'] = $this->html->getSecureURL('trip/itinerary','&trip='.$trip['code']);
					
					$plan = array_values($this->model_travel_trip->getPlanByTripId($trip['trip_id']));
					$result['active_trip'][$trip_id]['travel_date'] = $plan[0]['travel_date'];
					$day = array_values($this->model_travel_trip->getDayByPlanId($plan[0]['plan_id']));
					$result['active_trip'][$trip_id]['num_of_day'] = count($day);
				}
			}
		//END
		
		//START: process removed trip
			if($result['removed_trip'] != false) {
				foreach($result['removed_trip'] as $trip_id => $trip) {
					$result['removed_trip'][$trip_id] = $trip;
					$user = $this->model_account_user->getUser($trip['user_id']);
					$username = substr($user['email'], 0, strpos($user['email'], "@"));
					$result['removed_trip'][$trip_id]['username'] = $username;
					$result['removed_trip'][$trip_id]['url'] = $this->html->getSecureURL('trip/itinerary','&trip='.$trip['code']);
				}
			}
		//END
		
		//START: convert trip to array
			$result['active_trip'] = array_values($result['active_trip']);
			$result['removed_trip'] = array_values($result['removed_trip']);
		//END
		
		//START: set response 
			$result['success'][] = 'Trips loaded'; 
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	
	public function load_upcoming_trip() {
		//START: get data
			$result['trip'] = $this->model_travel_trip->getUpcomingTripByUserId($this->data['user_id']);
		//END
		//START: process trip
			if($result['trip'] != false) {
				foreach($result['trip'] as $trip_id => $trip) {
					$result['trip'][$trip_id] = $trip;
					$result['trip'][$trip_id]['url'] = $this->html->getSecureURL('trip/itinerary','&trip='.$trip['code']);
				}
			}
		//END
		//START: convert to array
			$result['trip'] = array_values($result['trip']);
		//END
		//START: set response 
			$result['success'][] = 'Trips Loaded'; 
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function load_past_trip() {
		//START: get data
			$result['trip'] = $this->model_travel_trip->getPastTripByUserId($this->data['user_id']);
		//END
		//START: process trip
			if($result['trip'] != false) {
				foreach($result['trip'] as $trip_id => $trip) {
					$result['trip'][$trip_id] = $trip;
					$result['trip'][$trip_id]['url'] = $this->html->getSecureURL('trip/itinerary','&trip='.$trip['code']);
				}
			}
		//END
		//START: convert to array
			$result['trip'] = array_values($result['trip']);
		//END
		//START: set response 
			$result['success'][] = 'Trips Loaded'; 
			$response = json_encode($result);
			echo $response;
		//END
	} 
	
	public function load_invited_trip() {
		//START: get data
			$result['trip'] = $this->model_travel_trip->getInvitedTripByUserId($this->data['user_id']);
		//END
		//START: process trip
			if($result['trip'] != false) {
				foreach($result['trip'] as $trip_id => $trip) {
					$result['trip'][$trip_id] = $trip;
					$result['trip'][$trip_id]['url'] = $this->html->getSecureURL('trip/itinerary','&trip='.$trip['code']);
				}
			}
		//END
		//START: convert to array
			$result['trip'] = array_values($result['trip']);
		//END
		//START: set response 
			$result['success'][] = 'Trips Loaded'; 
			$response = json_encode($result);
			echo $response;
		//END
	} 
	
	public function load_removed_trip() {
		//START: get data
			$result['trip'] = $this->model_travel_trip->getRemovedTripByUserId($this->data['user_id']);
		//END
		//START: process trip
			if($result['trip'] != false) {
				foreach($result['trip'] as $trip_id => $trip) {
					$result['trip'][$trip_id] = $trip;
					$result['trip'][$trip_id]['url'] = $this->html->getSecureURL('trip/itinerary','&trip='.$trip['code']);
				}
			}
		//END
		//START: convert to array
			$result['trip'] = array_values($result['trip']);
		//END
		//START: set response 
			$result['success'][] = 'Trips Loaded'; 
			$response = json_encode($result);
			echo $response;
		//END
	} 
	
	public function remove_trip() {
		//START: set variable
			$trip_id = $this->data['trip_id'];
			$user_id = $this->data['user_id'];
		//END
		
		//START: excute function
			$execution = $this->model_travel_trip->removeUserOfTrip($user_id,$trip_id);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Trip Removed';
			}
			else {
				$result['warning'][] = 'System Error'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function remove_multi_trip() {
		//START: set variable
			$trip = $this->data['trip'];
			$user_id = $this->data['user_id'];
		//END
		
		//START: execute
			foreach($trip as $trip_id) {
				$execution = $this->model_travel_trip->removeUserOfTrip($user_id,$trip_id);
				if($execution == true) {
					$result['success'][] = 'Trip Removed';
				}
				else {
					$result['warning'][] = 'System Error';
				}
			}
		//END
		
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function restore_trip() {
		//START: set variable
			$trip_id = $this->data['trip_id'];
			$user_id = $this->data['user_id'];
		//END
		
		//START: excute function
			$execution = $this->model_travel_trip->restoreUserOfTrip($user_id,$trip_id);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Trip Restored';
			}
			else {
				$result['warning'][] = '<b>SYSTEM ERROR: Trip cannot be restored.</b><br/>Please contact admin.'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function cancel_trip() {
		//START: set variable
			$trip_id = $this->data['trip_id'];
		//END
		
		//START: excute function
			$execution = $this->model_travel_trip->cancelTrip($trip_id);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Trip Cancelled';
			}
			else {
				$result['warning'][] = 'System Error';
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function resume_trip() {
		//START: set variable
			$trip_id = $this->data['trip_id'];
		//END
		
		//START: excute function
			$execution = $this->model_travel_trip->resumeTrip($trip_id);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Trip Resumed';
			}
			else {
				$result['warning'][] = 'System Error';
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function delete_trip() {
		//START: set variable
			$trip_id = $this->data['trip_id'];
			$user_id = $this->data['user_id'];
		//END
		
		//START: excute function
			$execution = $this->model_travel_trip->deleteUserOfTrip($user_id,$trip_id);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Trip Deleted';
			}
			else {
				$result['warning'][] = 'System Error'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function delete_multi() {
		//START: set variable
			$trip = $this->data['trip'];
			$user_id = $this->data['user_id'];
		//END
		
		//START: execute
			foreach($trip as $trip_id) {
				$execution = $this->model_travel_trip->deleteUserOfTrip($user_id,$trip_id);
				if($execution == true) {
					$result['success'][] = 'Trip Deleted';
				}
				else {
					$result['warning'][] = 'System Error';
				}
			}
		//END
		
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	/*
	public function delete_trip() {
		//START: run verification
			//if($this->verify_delete_trip() == 'failed') { return; }
		//END
		
		//START: set variable
			$trip = $this->data['trip'];
		//END
		
		//START: execute
			foreach($trip as $trip_id) {
				$execution = $this->model_travel_trip->deleteTrip($trip_id);
				if($execution == true) {
					$result['success'][] = 'Trip deleted';
				}
				else {
					$result['warning'][] = 'System Error';
				}
			}
		//END
		
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function clean_archive() {
		//START: excute function
			$removed_trip = $this->model_travel_trip->getRemovedTripByUserId($this->data['user_id']);
			if($removed_trip != false) {
				foreach($removed_trip as $trip_id => $trip) {
					$execution = $this->model_travel_trip->deleteTrip($trip_id);
				}
			}
			else {
				$result['success'][] = 'Archive is empty';
			}
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Archive cleaned';
			}
			else {
				if($removed_trip != false) {
					$result['warning'][] = '<b>SYSTEM ERROR: Archive cannot be cleaned.</b><br/>Please contact admin.'; 
				}
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	*/
	
	public function verify_new_trip() {
		$active_trip = $this->model_travel_trip->getActiveTripByUserId($this->data['user_id']);
		$role = $this->model_account_user->getRole($this->data['role_id']);
		$max_active_trip = $role['max_active_trip'];
		if($active_trip != false) {
			$num_of_active_trip = count($active_trip);
		}
		else {
			$num_of_active_trip = 0;
		}
		
		if($max_active_trip != NULL) {
			if($num_of_active_trip >= $max_active_trip) {
				$result['exceeded_quota'] = $role;
				$response = json_encode($result);
				echo $response;	
				return 'failed';
			}
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	public function verify_save_trip() {
		$active_trip = $this->model_travel_trip->getActiveTripByUserId($this->data['user_id']);
		$role = $this->model_account_user->getRole($this->data['role_id']);
		$max_active_trip = $role['max_active_trip'];
		if($active_trip != false) {
			$num_of_active_trip = count($active_trip);
		}
		else {
			$num_of_active_trip = 0;
		}
		
		if($max_active_trip != NULL) {
			if($num_of_active_trip >= $max_active_trip) {
				$result['exceeded_quota'] = $role;
				$response = json_encode($result);
				echo $response;	
				return 'failed';
			}
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
	
	public function verify_remove_trip() {
		$removed_trip = $this->model_travel_trip->getRemovedTripByUserId($this->data['user_id']);
		$role = $this->model_account_user->getRole($this->data['role_id']);
		$max_removed_trip = $role['max_removed_trip'];
		if($removed_trip != false) {
			$num_of_removed_trip = count($removed_trip);
		}
		else {
			$num_of_removed_trip = 0;
		}
		
		if($max_removed_trip != NULL) {
			if($num_of_removed_trip >= $max_removed_trip) {
				$result['warning'][] = '<b>Trip cannot be removed.</b><br/>Your archive is full. Please clean it.';
			}
		}
		
		$user_id = $this->data['user_id'];
		$trip = $this->model_travel_trip->getTrip($this->data['trip_id']);
		$owner_id = $trip['user_id'];
		
		if($user_id != $owner_id) {
			$result['warning'][] = '<b>Action is not permitted.</b><br/>This action can only be performed by owner.';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	public function verify_restore_trip() {
		$active_trip = $this->model_travel_trip->getActiveTripByUserId($this->data['user_id']);
		$role = $this->model_account_user->getRole($this->data['role_id']);
		$max_active_trip = $role['max_active_trip'];
		if($active_trip != false) {
			$num_of_active_trip = count($active_trip);
		}
		else {
			$num_of_active_trip = 0;
		}
		
		if($max_active_trip != NULL) {
			if($num_of_active_trip >= $max_active_trip) {
				$result['warning'][] = '<b>Trip cannot be restored.</b><br/>You have reached the maximum number of trips for current account. Please consider to upgrade your account or remove some of the trips to archive.';
			}
		}
		
		$user_id = $this->data['user_id'];
		$trip = $this->model_travel_trip->getTrip($this->data['trip_id']);
		$owner_id = $trip['user_id'];
		
		if($user_id != $owner_id) {
			$result['warning'][] = '<b>Action is not permitted.</b><br/>This action can only be performed by owner.';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	public function verify_delete_trip() {
		$user_id = $this->data['user_id'];
		$trip = $this->model_travel_trip->getTrip($this->data['trip_id']);
		$owner_id = $trip['user_id'];
		
		if($user_id != $owner_id) {
			$result['warning'][] = '<b>Action is not permitted.</b><br/>This action can only be performed by owner.';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
	
	public function edit_trip_name() {
		//START: set data
			$trip_id = $this->data['trip_id'];
			$data['name'] = $this->data['name'];
		//END
		
		//START: execute function
			$execution = $this->model_travel_trip->editTrip($trip_id, $data);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Title updated';
			}
			else {
				$result['warning'][] = '<b>SYSTEM ERROR: Title cannot be updated.</b><br/>Please contact admin.'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function save_trip_info() {
		//START: set data
			$trip_id = $this->data['trip_id'];
			$data['name'] = $this->data['name'];
			$data['description'] = $this->data['description'];
		//END
		
		//START: execute function
			$execution = $this->model_travel_trip->editTrip($trip_id, $data);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Trip Info Updated';
			}
			else {
				$result['warning'][] = '<b>SYSTEM ERROR: Trip Info cannot be updated.</b><br/>Please contact admin.'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function refresh_trip_photo() {
		//START: set data
			$trip_id = $this->data['trip_id'];
		//END
		
		//START: get result
			$photo = $this->model_travel_trip->getTripPhotoByTripId($trip_id);
			foreach($photo as $k => $p) {
				$result['photo'][] = $this->model_resource_photo->getPhoto($p['photo_id']);
			}
		//END
		
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function upload_trip_photo() {
		//START: set data
			$data = $this->data;
			$data['trip_id'] = $this->data['trip_id'];
			$data['user_id'] = $this->data['user_id'];
			$data['size'] = $_FILES['file']['size'];
			$data['photo_type'] = $_FILES['file']['type'];
		//END
		
		//verify file type
		$file_type = $_FILES['file']['type'];
		if($file_type == "image/jpeg") {
			$photo_type = ".jpg";
		}
		else if($file_type == "image/png") {
			$photo_type = ".png";
		}
		else if($file_type == "image/gif") {
			$photo_type = ".gif";
		}
		else {
			$result['warning'][] = "Error: Fail to upload new photo due to invalid file type.";
			$response = json_encode($result);
			echo $response;	
			return;
		}
		$data['photo_type'] = $photo_type;
		
		//START: add photo
			$photo_id = $this->model_resource_photo->addPhoto($data); 
		//END
		//START: add photo to trip
			$data['photo_id'] = $photo_id;
			$trip_photo_id = $this->model_travel_trip->addTripPhoto($data);
		//END
		//START: name the photo
			$ds = DIRECTORY_SEPARATOR;
			$upload_directory = DIR_RESOURCE . "photo" . $ds . "cropped" . $ds;
			$upload_file = $upload_directory . $photo_id . $photo_type;
			
			$tmp_name = $_FILES['file']['tmp_name'];
		//END
		
		//START: move the photo
			if (move_uploaded_file($tmp_name, $upload_file)) {
				$result['success'][] = "Success: New <b>Photo #".$photo_id."</b> has been added";
			} else {
				$result['warning'][] = "Error: Please check the folder permission";
			}
		//END
		$response = json_encode($result);
		echo $response;	
		return;	
	}
	
	public function search_user() {
		$result = $this->model_account_user->getUserByKeyword($this->data['keyword']);
		$result = array_values($result);
		$response = json_encode($result);
		echo $response;
	}
	
	public function refresh_member() {
		$result = $this->model_travel_trip->getMemberByTripId($this->data['trip_id']);
		$result = array_values($result);
		$response = json_encode($result);
		echo $response;
	}
	
	public function get_member() {
		$result = $this->model_travel_trip->getMember($this->data['trip_member_id']);
		$result = array_values($result);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add_member() {
		//START: set data
			$data = $this->data;
		//END
		
		//START: execute function
			$result['trip_member_id'] = $this->model_travel_trip->addMember($data);
		//END
		
		//START: set response
			if($result['trip_member_id'] != '') {
				$result['success'] = 'Member Added';
			}
			else {
				$result['warning'] = 'System Error'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
    public function edit_member() {
		//START: set data
			$data = $this->data;
		//END
		
		//START: execute function
			$execution = $this->model_travel_trip->editMember($data['trip_member_id'], $data);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'Member Updated';
			}
			else {
				$result['warning'] = 'System Error'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
    }
    
	public function delete_member() {
		//START: set data
			$member = $this->data['member'];
		//END
		
		//START: execute function
			foreach($member as $trip_member_id) {
				$execution = $this->model_travel_trip->deleteMember($trip_member_id);
			}
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'Member Removed';
			}
			else {
				$result['warning'] = 'System Error'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function refresh_country() {
		$result = $this->model_travel_trip->getCountryByTripId($this->data['trip_id']);
		$result = array_values($result);
		$response = json_encode($result);
		echo $response;
	}
	
	public function get_country() {
		//START: set data
			$country_id = $this->data['country_id'];
			$trip_country_id = $this->data['trip_country_id'];
		//END
		
		//START: execute function
			$result = $this->model_localisation_country->getCountry($country_id);
		//END
		
		//START: set response
			$result['country_id'] = $country_id;
			$result['trip_country_id'] = $trip_country_id;
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function add_country() {
		//START: set data
			$data['trip_id'] = $this->data['trip_id'];
			$data['country_id'] = $this->data['country_id'];
		//END
		
		//START: execute function
			$result['trip_country_id'] = $this->model_travel_trip->addCountry($data);
		//END
		
		//START: set response
			if($result['trip_country_id'] != '') {
				$result['success'] = 'Country Added';
			}
			else {
				$result['warning'] = 'System Error'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function delete_country() {
		//START: set data
			$country = $this->data['country'];
		//END
		
		//START: execute function
			foreach($country as $trip_country_id) {
				$execution = $this->model_travel_trip->deleteCountry($trip_country_id);
			}
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'Country Removed';
			}
			else {
				$result['warning'] = 'System Error'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function edit_plan_date() {
		//START: set data
			$plan_id = $this->data['plan_id'];
			$data['travel_date'] = $this->data['travel_date'];
			if($data['travel_date'] == '') { $data['travel_date'] = 'NULL'; }
		//END
		
		//START: execute function
			$execution = $this->model_travel_trip->editPlan($plan_id, $data);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'Date updated';
			}
			else {
				$result['warning'] = 'ERROR: Fail to update Date'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function add_day() {
		//START: set data
			$data['plan_id'] = $this->data['plan_id'];
			$data['sort_order'] = $this->data['sort_order'];
		//END
		
		//START: execute function
			$result['day_id'] = $this->model_travel_trip->addDay($data);
		//END
		
		//START: set response
			if($result['day_id'] != '') {
				$result['success'] = 'Day added';
			}
			else {
				$result['warning'] = 'ERROR: Fail to add Day'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function delete_day() {
		//START: set data
			$day_id = $this->data['day_id'];
		//END
		
		//START: execute function
			$execution = $this->model_travel_trip->deleteDay($day_id);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'Day deleted';
			}
			else {
				$result['warning'] = 'ERROR: Fail to delete Day'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function sort_day() {
		//START: set data
			$order = $this->data['order'];
		//END
		
		//START: process order
			$order = json_decode(html_entity_decode($order), true);
		//END
		
		//START: execute function
			foreach($order as $o) {
				$day_id = $o['day_id'];
				$data['day_id'] = $o['day_id'];
				$data['sort_order'] = $o['sort_order'];
				$execution = $this->model_travel_trip->editDay($day_id, $data);
			}
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'Day sorted';
			}
			else {
				$result['warning'] = 'ERROR: Fail to sort Day'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function add_line() {
		//START: set data
			$data = $this->data['line'];
			$day_id = $data['day_id'];
			unset($data['line_id']);
			foreach($data as $key => $value) {
				if($value == '') {
					$data[$key] = 'NULL';
				}
			}
		//END
		
		//START: execute function
			$result['line_id'] = $this->model_travel_trip->addLine($data);
		//END
		
		//START: set response
			if($result['line_id'] != '') {
				$result['success'] = 'Activity added';
			}
			else {
				$result['warning'] = 'ERROR: Fail to add Activity'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function edit_line() {
		//START: set data
			$data = $this->data['line'];
			foreach($data as $key => $value) {
				if($value == '') {
					$data[$key] = 'NULL';
				}
			}
		//END
		
		//START: execute function
			$execution = $this->model_travel_trip->editLine($data['line_id'],$data);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'Activity updated';
			}
			else {
				$result['warning'] = 'ERROR: Fail to update Activity'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function delete_line() {
		//START: set data
			$line_id = $this->data['line_id'];
		//END
		
		//START: execute function
			$execution = $this->model_travel_trip->deleteLine($line_id);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'Line deleted';
			}
			else {
				$result['warning'] = 'ERROR: Fail to delete Line'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function sort_line() {
		//START: set data
			$order = $this->data['order'];
		//END
		
		//START: process order
			$order = json_decode(html_entity_decode($order), true);
		//END
		
		//START: execute function
			foreach($order as $o) {
				$line_id = $o['line_id'];
				$data['line_id'] = $o['line_id'];
				$data['day_id'] = $o['day_id'];
				$data['sort_order'] = $o['sort_order'];
				$execution = $this->model_travel_trip->editLine($line_id, $data);
			}
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'] = 'Activity sorted';
			}
			else {
				$result['warning'] = 'ERROR: Fail to sort Activity'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function refresh_sample() {

		$result = $this->model_travel_trip->getSample($this->data['country_id']);
		
		foreach ($result as $trip_id => $trip) {
			$user = $this->model_account_user->getUser($result[$trip_id]['user_id']);
			$username = substr($user['email'], 0, strpos($user['email'], "@"));
			$result[$trip_id]['username'] = $username;
			
			$plan = 	$this->model_travel_trip->getPlanByTripId($result[$trip_id]['trip_id']);
			$plan_id = array_keys($plan);
			$no_of_day = COUNT($this->model_travel_trip->getDayByPlanId($plan[$plan_id[0]]['plan_id']));
			$result[$trip_id]['no_of_day'] = $no_of_day;
						 
			$result[$trip_id]['url'] = $this->html->getSEOURL('trip/view','&trip='.$result[$trip_id]['code'].'&m=new&c='.$this->data['country_id']);
		}
		
		$response = json_encode($result);
		echo $response;
	}
	
	public function sample_new_trip() {
		$this->data['user_id'] = $this->user->getUserId();
		$this->data['language_id']= $this->language->getLanguageId();
		$this->data['from_sample']= "1";
		$result['redirect'] = $this->save_trip();
		
		//START: set response
		if($result['redirect'] == true) {
			$result['success'] = 'Trip Created';
		}
		else {
			$result['warning'] = 'ERROR: Fail to create Trip'; 
		}
	
		$response = json_encode($result);
		echo $response;
		//END
	}
		
	public function get_line_mode_path() {
		// DATABASE MODE need to read mode_id from database, if COOKIE MODE, then skip these function
		$result = $this->model_travel_trip->getLineMode($this->data['line_id']);
		$default_mode_id = $this->data['default_mode_id'];
		// create new data with this line_id, set mode to default mode_id 
		if (!$result['line_id']) {			
			$new_result = $this->model_travel_trip->addLineMode($this->data['line_id'],$default_mode_id);
			$result = $new_result;
		}
		// edit mode if given line_id with different mode_id, wont happen alot.
		if (!$result['mode_id']) {
			$result['mode_id'] = $this->model_travel_trip->editLineMode($this->data['line_id'],$default_mode_id);
		}
		
		// condition refresh after edit, add, delete, etc
		if ($this->data['condition'] == "refresh") {
			$result['path_id'] = "";
		}
		
		if ($result['path_id']) {
			$result['path'] = $this->model_travel_trip->getPathById($result['path_id']);	
		}
		
		if (!$result['path_id'] || !$result['path']) {
			$result['path'] = $this->model_travel_trip->getPathByCoor($this->data['coor'], $result['mode_id']);	
			$result['path_id'] = $result['path']['path_id'];
			
			if ($result['path']) {
				$this->model_travel_trip->editLineMode($this->data['line_id'], $result['mode_id'], $result['path_id']);	
			}
		}
					
		if ($result['path']) {
			$user_id = $this->data['user_id'] = $this->user->getUserId();
			// if data show ZERO RESULT from google, then get custom path data
			if ($result['path']['distance'] == "0" && $result['path']['duration'] == "0" && $user_id) {				
				$custom_path = $this->model_travel_trip->getCustomPathByPathId($result['path_id'], $user_id);
				$converted_value = $this->convertDistanceDurationToUnit($custom_path['distance'],$custom_path['duration']);
				$result['path']['custom_distance'] = $custom_path['distance'];
				$result['path']['custom_duration'] = $custom_path['duration'];
				$result['path']['custom_distance_text'] = $converted_value['distance_text'];
				$result['path']['custom_duration_text'] = $converted_value['duration_text'];
				if ($custom_path['path_custom_id']) {
					$this->model_travel_trip->editLineMode($this->data['line_id'], $result['mode_id'], $result['path_id'],$custom_path['path_custom_id']	);	
				}else {
					//get auto generated custom path.
					$auto_custom_path = $this->model_travel_trip->getCustomPathAuto($result['path_id']);
					$converted_value = $this->convertDistanceDurationToUnit($auto_custom_path['distance_median'],$auto_custom_path['duration_median']);
					$result['path']['auto_custom_distance_text'] = $converted_value['distance_text'];
					$result['path']['auto_custom_duration_text'] = $converted_value['duration_text'];
					//$result['check'] =$auto_custom_path;
					
				}
			}
			
			$converted_value = $this->convertDistanceDurationToUnit($result['path']['distance'],$result['path']['duration']);
			$result['path']['distance_text'] = $converted_value['distance_text'];
			$result['path']['duration_text'] = $converted_value['duration_text'];
		}
		
		$mode = $this->model_travel_trip->getMode($result['mode_id']);
		$result['mode_name'] = $mode['g_name'];	
		$result['mode_icon'] = $mode['icon'];
		
		$response = json_encode($result);
		echo $response;
	}
	
	// get path from database only when using cookies
	public function get_distance_path(){
		$mode = $this->model_travel_trip->getMode($this->data['mode_id']);
		$result['mode_id'] = $this->data['mode_id'];	
		$result['mode_name'] = $mode['g_name'];	
		$result['mode_icon'] = $mode['icon'];	
		$result['path'] = $this->model_travel_trip->getPathByCoor($this->data['coor'], $result['mode_id']);	
		$result['coor'] = $this->data['coor'];
		$result['path_id'] = $result['path']['path_id'];
		
		if ($result['path']) {
			$converted_value = $this->convertDistanceDurationToUnit($result['path']['distance'],$result['path']['duration']);
			$result['path']['distance_text'] = $converted_value['distance_text'];
			$result['path']['duration_text'] = $converted_value['duration_text'];
		}
		
		$response = json_encode($result);
		echo $response;
	}
	
	public function add_path(){

		foreach($this->data['coor'] as $key => $value) {
			$this->data[$key] = $value;
		}
		
		$execution = $this->model_travel_trip->addPath($this->data);

		//START: set response
		if($execution == true) {
			$result['success'] = 'Success';
		}
		else {
			$result['warning'] = 'ERROR: Fail to save'; 
		}
		$result['path_id'] = $execution;
		$response = json_encode($result);
		echo $response;
		
	}
	
	public function edit_line_mode(){
		$execution = $this->model_travel_trip->editLineMode($this->data['line_id'], $this->data['mode_id'],"0");	
		
		//START: set response
		if($execution == true) {
			$result['success'] = 'Success';
		}
		else {
			$result['warning'] = 'ERROR: Fail to save'; 
		}
		
		$response = json_encode($result);
		echo $response;	
		//END	
	}
	
	public function convertDistanceDurationToUnit($distance="", $duration=""){
		if (is_numeric($distance) && $distance > 99) {
			$unit = " km";
			$distance_text = number_format(round($distance/1000,1),1) .$unit;
		}elseif ($distance == 0) {
			$distance_text = "";
		}else {
			$unit = " m";
			$distance_text = $distance .$unit;
		}
		
		if (is_numeric($duration)) {
			$sec = (int)($duration%60);
			$min = (int)(($duration/60)%60);
			$hour = (int)(($duration/3600)%24);
			$day = (int)($duration/3600/24);
			
			if ($sec > 30) $min_round = 1;
			if ($min > 30) $hour_round = 1;
			
			$duration_text = "";
			$format_limit = 1;
			
			if ( $format_limit <= 2 )	{
				if ( $day == 1 ) {$duration_text .= $day." day "; $format_limit++;}
				else if ( $day > 1 ) {$duration_text .= $day." days "; $format_limit++;}				
			}
					
			if ( $format_limit <= 2 ) {
				if ($format_limit == 2 && $min > 30) $hour= $hour+1;
				if ( $hour == 1 ) {$duration_text .= $hour." hour "; $format_limit++;}
				else if ( $hour > 1 ) {$duration_text .= $hour." hours "; $format_limit++;}
			}
			
			if ( $format_limit <= 2 ) {
				if ($format_limit == 2 && $sec > 1) $min= $min+1;
				if ( $min == 1 ) {$duration_text .= $min." min "; $format_limit++;}
				else if ( $min > 1 ) {$duration_text .= $min." mins "; $format_limit++;}
			}
			
			//if (!$duration_text) { $duration_text .= "1 min "; }
		}
		
		$converted_value['distance_text']= $distance_text;
		$converted_value['duration_text']= $duration_text;

		return $converted_value;
	}
	
	//read data when open modal for custom transport
	public function get_path_custom(){
		$this->data['user_id'] = $this->user->getUserId();
		$result = $this->model_travel_trip->getCustomPathByPathId($this->data['path_id'], $this->data['user_id']);
				
		$converted_value = $this->convertDistanceDurationToUnit($result['distance'],$result['duration']);
		$result['distance_text'] = $converted_value['distance_text'];
		$result['duration_text'] = $converted_value['duration_text'];
		
		$response = json_encode($result);
		echo $response;
	}
	
	//save data at custom transport modal
	public function add_path_custom(){
		$this->data['user_id'] = $this->user->getUserId();
		$execution = $this->model_travel_trip->addCustomPath($this->data);

		//START: set response
		if($execution == true) {
			$result['success'] = 'Success';
		}
		else {
			$result['warning'] = 'ERROR: Fail to save'; 
		}
		
		$response = json_encode($result);
		echo $response;
		
	}
	
	public function edit_path_custom(){
		$this->data['user_id'] = $this->user->getUserId();
		$execution = $this->model_travel_trip->editCustomPath($this->data);

		//START: set response
		if($execution == true) {
			$result['success'] = 'Success';
		}
		else {
			$result['warning'] = 'ERROR: Fail to save'; 
		}
		$result['return'] = $execution;
		$response = json_encode($result);
		echo $response;
		
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