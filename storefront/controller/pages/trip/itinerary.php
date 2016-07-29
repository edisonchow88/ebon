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
		//END
		
		//START: set data
		//END
		
		//START: set result
		//END
		
		//START: set modal
			$this->addChild('pages/trip/itinerary_guide', 'content_section_guide', 'pages/trip/itinerary_guide.tpl');
			$this->addChild('pages/trip/itinerary_table', 'content_section_table', 'pages/trip/itinerary_table.tpl');
			$this->addChild('pages/trip/itinerary_map', 'content_section_map', 'pages/trip/itinerary_map.tpl');
			$this->addChild('pages/trip/itinerary_footer', 'content_section_footer', 'pages/trip/itinerary_footer.tpl');
		//END
		
		//START: set link
		//END
		
		//START: set variable
			$this->view->batchAssign( $this->data);
		//END
		
		//START: set template 
			//$this->view->setTemplate('pages/trip/activity_list.tpl');
			$this->processTemplate('pages/trip/itinerary.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}