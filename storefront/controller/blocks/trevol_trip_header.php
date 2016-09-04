<?php 
//START: verify directory
	if (! defined ( 'DIR_CORE' )) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerBlocksTrevolTripHeader extends AController {
	//START: declare common variable
		public $data = array();
	//END
	
	public function main() {

        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: verify log in account
			$this->data['logged'] = $this->user->isLogged();
		//END
		
		//STARt: get trip_id
			$this->data['trip_id'] = $this->trip->getTripId();
		//END
		
		//START: set ajax
			$ajax_itinerary = $this->html->getSEOURL('trip/ajax_itinerary');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			$this->view->assign('ajax_itinerary',$ajax_itinerary);
		//END
		
		//START: set template
			$this->processTemplate();
		//END
		
        //START: init controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
  	}
}
?>