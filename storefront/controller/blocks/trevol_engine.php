<?php  
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerBlocksTrevolEngine extends AController {
	private $error = array();
	public $data = array();
	
	public function main() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);
		
		$trip = new ATrip($this->registry);
		unset($this->session->data['submitted_once']);
		
		$trip_id = $this->data['trip_id'] = $trip->getTripId();
		$day_id = $this->data['day_id'] = $trip->getDayId();
		$this->data['customer_id'] = $this->customer->getId();
		$this->data['activity_id'] = $this->request->get['product_id'];
		$this->data['view'] = $trip->getView();
		
		//START - setup trip or draft data
		if($trip_id != 0) {
			$this->data['drafting'] = false;
			$this->data['itinerary_code'] = $trip->getItineraryCode();
		}
		else {
			$this->data['drafting'] = true;
			$draft = new ADraft($this->registry);
			$draft_id = $this->data['draft_id'] = $draft->getDraftId();
			$day_id = $this->data['day_id'] = $draft->getDayId();
			$this->data['itinerary_code'] = $draft->getItineraryCode();
			if($this->data['customer_id'] != '') { $draft->saveDraft($this->data['customer_id']); }
		}
		//END
		
		$this->view->batchAssign($this->data);
		$this->processTemplate();
		$this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
