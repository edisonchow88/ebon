<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripItinerary extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		
		//START: set modal
			$this->loadModel('travel/trip');
		//END
		
		//START: set data
			$this->data['trip_id'] = $this->trip->getTripId();
			$this->data['plan_id'] = $this->trip->getPlanId();
		//END
		
		//START: verify
			if($this->trip->hasCode()) {
				if($this->trip->hasTrip()) {
					$this->data['trip'] = $this->model_travel_trip->getTrip($this->data['trip_id']);
					$this->data['plan'] = $this->model_travel_trip->getPlan($this->data['plan_id']);
					if($this->trip->isRemoved()) {
						$this->session->data['error'] = 'trip_removed';
						$this->redirect($this->html->getSecureURL('error/trip'));
					}
				}
				else {
					$this->session->data['error'] = 'trip_not_found';
					$this->redirect($this->html->getSecureURL('error/trip'));
				}
			}
		//END
		
		//START: set mode
			if($this->trip->hasTrip()) {
				if($this->user->getUserId() == $this->trip->getOwnerId()) {
					$this->session->data['mode'] = 'edit';
					$this->session->data['memory'] = 'server';
				}
				else if($this->user->getUserId() != $this->trip->getOwnerId()) {
					$this->session->data['mode'] = 'view';
					$this->session->data['memory'] = 'server';
				}
			}
			else {
				$this->session->data['mode'] = 'edit';
				$this->session->data['memory'] = 'cookie';
			}
		//END
		
		//START: set result
		//END
		
		//START: set modal
			$this->addChild('modal/home/splash', 'modal_home_splash', 'modal/home/splash.tpl');
			$this->addChild('pages/trip/itinerary_guide', 'section_content_guide', 'pages/trip/itinerary_guide.tpl');
			$this->addChild('pages/trip/itinerary_plan', 'section_content_plan', 'pages/trip/itinerary_plan.tpl');
			$this->addChild('pages/trip/itinerary_map', 'section_content_map', 'pages/trip/itinerary_map.tpl');
			$this->addChild('pages/trip/itinerary_footer', 'section_content_footer', 'pages/trip/itinerary_footer.tpl');
		//END
		
		//START: set link
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/itinerary.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}