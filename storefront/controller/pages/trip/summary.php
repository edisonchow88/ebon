<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripSummary extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set ajax
			$ajax['trip/ajax_itinerary'] = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set script
			$this->addChild('script/trip/frame', 'script_trip_frame', 'script/trip/frame.tpl');
		//END
		
		//START: set modal
			$this->addChild('modal/itinerary/trip/gallery', 'modal_trip_gallery', 'modal/itinerary/trip/gallery.tpl');
			$this->addChild('modal/itinerary/trip/photo', 'modal_trip_photo', 'modal/itinerary/trip/photo.tpl');
		//END
		
		//START: set link
			$link['list/trip/upcoming'] = $this->html->getSecureURL('list/trip/upcoming');
			$link['trip/itinerary/view'] = $this->html->getSecureURL('trip/itinerary/view');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/summary.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}