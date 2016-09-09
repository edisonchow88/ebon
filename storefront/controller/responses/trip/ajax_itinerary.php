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
			else if($this->data['action'] == 'load_trip') { $this->load_trip(); return; }
			else if($this->data['action'] == 'remove_trip') { $this->remove_trip(); return; }
			else if($this->data['action'] == 'restore_trip') { $this->restore_trip(); return; }
			else if($this->data['action'] == 'delete_trip') { $this->delete_trip(); return; }
			else if($this->data['action'] == 'clean_archive') { $this->clean_archive(); return; }
			else if($this->data['action'] == 'edit_trip_name') { $this->edit_trip_name(); return; }
			else if($this->data['action'] == 'edit_plan_date') { $this->edit_plan_date(); return; }
			else if($this->data['action'] == 'add_day') { $this->add_day(); return; }
			else if($this->data['action'] == 'delete_day') { $this->delete_day(); return; }
			else if($this->data['action'] == 'sort_day') { $this->sort_day(); return; }
			else if($this->data['action'] == 'add_line') { $this->add_line(); return; }
			else if($this->data['action'] == 'edit_line') { $this->edit_line(); return; }
			else if($this->data['action'] == 'delete_line') { $this->delete_line(); return; }
			else if($this->data['action'] == 'sort_line') { $this->sort_line(); return; }
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
		
		//START: set response
			$result['success'][] = 'Trip saved'; 
			$response = json_encode($result);
			echo $response;
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
	
	public function remove_trip() {
		//START: run verification
			if($this->verify_remove_trip() == 'failed') { return; }
		//END
		
		//START: excute function
			$execution = $this->model_travel_trip->removeTrip($this->data['trip_id']);
		//END
		
		//START: set redirect
			$result['redirect'] = $this->html->getSecureURL('trip/itinerary');
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Trip removed';
			}
			else {
				$result['warning'][] = '<b>SYSTEM ERROR: Trip cannot be removed.</b><br/>Please contact admin.'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function restore_trip() {
		//START: run verification
			if($this->verify_restore_trip() == 'failed') { return; }
		//END
		
		//START: excute function
			$execution = $this->model_travel_trip->restoreTrip($this->data['trip_id']);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Trip restored';
			}
			else {
				$result['warning'][] = '<b>SYSTEM ERROR: Trip cannot be restored.</b><br/>Please contact admin.'; 
			}
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function delete_trip() {
		//START: run verification
			if($this->verify_delete_trip() == 'failed') { return; }
		//END
		
		//START: excute function
			$execution = $this->model_travel_trip->deleteTrip($this->data['trip_id']);
		//END
		
		//START: set response
			if($execution == true) {
				$result['success'][] = 'Trip deleted';
			}
			else {
				$result['warning'][] = '<b>SYSTEM ERROR: Trip cannot be deleted.</b><br/>Please contact admin.'; 
			}
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