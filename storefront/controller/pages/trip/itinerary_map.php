<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripItineraryMap extends AController {
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
		
		//START: set api key
			$key = 'AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0';
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			$this->view->assign('key', $key);
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/itinerary_map.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}