<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesMainTrip extends AController {
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
		
		//START: set result
		//END
		
		//START: set modal
			$this->addChild('modal/trip/archive', 'modal_trip_archive', 'modal/trip/archive.tpl');
			$this->addChild('modal/trip/load', 'modal_trip_load', 'modal/trip/load.tpl');
			$this->addChild('modal/trip/save', 'modal_trip_save', 'modal/trip/save.tpl');
			$this->addChild('modal/trip/delete', 'modal_trip_delete', 'modal/trip/delete.tpl');
			$this->addChild('modal/trip/remove', 'modal_trip_remove', 'modal/trip/remove.tpl');
			$this->addChild('modal/trip/share', 'modal_trip_share', 'modal/trip/share.tpl');
			$this->addChild('modal/trip/quota', 'modal_trip_quota', 'modal/trip/quota.tpl');
		//END
		
		//START: set link
			$link['trip/itinerary'] = $this->html->getSecureURL('trip/itinerary');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/main/trip.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}