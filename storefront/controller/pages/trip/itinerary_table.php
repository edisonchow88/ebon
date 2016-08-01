<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripItineraryTable extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		
		//START: set modal
		//END
		
		//START: set data
		//END
		
		//START: set result
		//END
		
		//START: set modal
		//END
		
		//START: set link
		//END
		
		//START: set ajax
			$ajax_itinerary = $this->html->getSEOURL('trip/ajax_itinerary');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			$this->view->assign('ajax_itinerary',$ajax_itinerary);
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/itinerary_table.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}