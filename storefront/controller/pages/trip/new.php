<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripNew extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set model
			$this->loadModel('localisation/country');
			$this->loadModel('travel/trip');
		//END
		
		//START: set data
			$country = $this->model_localisation_country->getCountries();
			$country_available = array();
			foreach($country as $key => $value) {
				if($value['status'] != 0) {
					$country_available[] = $country[$key];
				}
			}
			$this->data['country'] = $country_available;
			
			$mode = $this->model_travel_trip->getMode();
			$mode_available = array();
			foreach($mode as $key => $value) {
				if($value['status'] != 0) {
					$mode_available[] = $mode[$key];
				}
			}
			$this->data['mode'] = $mode_available;
		//END
		
		//START: set link
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/new.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}