<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalItineraryLineFilter extends AController {
	//START: set common variable
		public $data = array();
	//END
	
  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set modal
			$this->loadModel('localisation/country');
		//END
		
		//START: set data
			$this->data['country'] = $this->model_localisation_country->getCountries();
		//END
		
		//START: set ajax
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template
			$this->processTemplate('modal/itinerary/line/filter.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

