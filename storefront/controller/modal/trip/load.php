<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTripLoad extends AController {
	//START: set common variable
		public $data = array();
	//END
	
  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load model
			$this->loadModel('account/user');
			$this->loadModel('travel/trip');
		//END
		
		//START: set data
			$this->data['trip'] = $this->model_travel_trip->getTripByUserId($this->user->getUserId());
			$this->data['max_active_trip'] = $this->user->getMaxActiveTrip();
			if($this->data['trip'] != false) {
				$this->data['num_of_active_trip'] = count($this->data['trip']);
			}
			else {
				$this->data['num_of_active_trip'] = 0;
			}
			$this->data['usage'] = $this->data['num_of_active_trip'] / $this->data['max_active_trip'] * 100;
		//END
		
		//START: set result & process data
			if($this->data['trip'] != false) {
				foreach($this->data['trip'] as $trip_id => $trip) {
					$this->data['result'][$trip_id] = $trip;
					$user = $this->model_account_user->getUser($trip['user_id']);
					$username = substr($user['email'], 0, strpos($user['email'], "@"));
					$this->data['result'][$trip_id]['username'] = $username;
					$this->data['result'][$trip_id]['url'] = $this->html->getSecureURL('trip/itinerary','&trip='.$trip['code']);
				}
			}
		//END
		
		//START: set ajax
			$modal_ajax = $this->html->getSecureURL('account/ajax_user');
		//END
		
		//START: set variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->batchAssign($this->data);
		//END
		
		//START: set template
			$this->processTemplate('modal/trip/load.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

