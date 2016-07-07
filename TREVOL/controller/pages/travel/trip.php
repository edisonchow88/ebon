<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelTrip extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Trip";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$this->loadModel('travel/trip');
		$this->loadModel('user/user'); //IMPORTANT: ModelTravelTrip unable to load other, hence need to load this model at controller
		
		$data = $this->model_travel_trip->getTrip();
		
		foreach($data as $row) {
			$trip_id = $row['trip_id'];
			
			//following sequence is important
			$result[$trip_id]['trip_id'] = $row['trip_id'];
			$result[$trip_id]['user_id'] = $row['user']['username'];
			$result[$trip_id]['status_id'] = $row['status_id'];
			$result[$trip_id]['name'] = $row['name'];
			$result[$trip_id]['description'] = $row['description'];
			$result[$trip_id]['transport_id'] = $row['transport_id'];
			$result[$trip_id]['travel_date'] = $row['travel_date'];
			$result[$trip_id]['date_added'] = $row['date_added'];
			$result[$trip_id]['date_modified'] = $row['date_modified'];
		}
		
		//include modal
		$this->addChild('modal/travel/add_trip', 'modal_add_trip', 'modal/travel/add_trip.tpl');
		$this->addChild('modal/travel/edit_trip', 'modal_edit_trip', 'modal/travel/edit_trip.tpl');
		$this->addChild('modal/travel/delete_trip', 'modal_delete_trip', 'modal/travel/delete_trip.tpl');
		
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/travel/trip.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

