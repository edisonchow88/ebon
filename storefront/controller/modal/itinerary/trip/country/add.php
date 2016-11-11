<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalItineraryTripCountryAdd extends AController {
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
		
		//START: set link
			$country = $this->model_localisation_country->getCountries();
			$country_available = array();
			foreach($country as $key => $value) {
				if($value['status'] != 0) {
					$country_available[] = $country[$key];
				}
			}
			$this->data['country'] = $country_available;
		//END
		
		//START: set ajax
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($component) > 0) { $this->view->assign('component', $component); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template
			$this->processTemplate('modal/itinerary/trip/country/add.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

