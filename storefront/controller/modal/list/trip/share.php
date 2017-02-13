<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalListTripShare extends AController {
	//START: set common variable
		public $data = array();
	//END
	
  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set model
			$this->loadModel('travel/trip');
		//END
		
		//START: set data
			$this->data['user_id']= $this->user->getUserId();
		//END
		
		//START: set link
			//$this->data['trip_id'] = $this->trip->getTripId();
			//code= $this->model_travel_trip->getTripCodeByTripId($trip_id);
			//$code = $this->trip->hasCode();
			//$link['preview'] = $this->html->getSEOURL('trip/preview','&trip='.$this->data['trip_id']);
		//END
		
		//START: set ajax
			$ajax['trip/ajax_itinerary'] = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($component) > 0) { $this->view->assign('component', $component); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template
			$this->processTemplate('modal/list/trip/share.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

