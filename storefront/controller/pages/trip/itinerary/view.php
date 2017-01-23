<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripItineraryView extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START
			$this->document->setTitle('View Itinerary');
		//END
		
		//START: set model
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
		
		//START: set script
			$this->addChild('script/trip/plan', 'script_trip_plan', 'script/trip/plan.tpl');
		//END
		
		//START: set ajax
			$ajax['trip/ajax_itinerary'] = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set link
			$link['trip/summary'] = $this->html->getSecureURL('trip/summary').'&trip='.$this->request->get_or_post('trip');
			$link['trip/itinerary/edit'] = $this->html->getSecureURL('trip/itinerary/edit').'&trip='.$this->request->get_or_post('trip');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/itinerary/view.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}