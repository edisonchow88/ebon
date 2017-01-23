<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesWizardNew extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set model
			$this->loadModel('localisation/country');
			$this->loadModel('resource/data');
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
			
			$month = $this->model_resource_data->getDataByDatasetId(1);
			$this->data['month'] = $month;
			
			$mode = $this->model_travel_trip->getMode();
			$mode_available = array();
			foreach($mode as $key => $value) {
				if($value['status'] != 0) {
					$mode_available[] = $mode[$key];
				}
			}
			$this->data['mode'] = $mode_available;
		//END
		
		//START: set ajax
			$ajax['wizard/ajax_trip'] = $this->html->getSecureURL('wizard/ajax_trip');
			$ajax['trip/ajax_itinerary'] = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set script
			$this->addChild('script/trip/frame', 'script_trip_frame', 'script/trip/frame.tpl');
		//END
		
		//START: set link
			$link['landing/home'] = $this->html->getSecureURL('landing/home');
			$link['list/trip/upcoming'] = $this->html->getSecureURL('list/trip/upcoming');
			$link['list/trip/past'] = $this->html->getSecureURL('list/trip/past');
			$link['list/trip/invited'] = $this->html->getSecureURL('list/trip/invited');
			$link['list/trip/removed'] = $this->html->getSecureURL('list/trip/removed');
			
			$link['wizard/template'] = $this->html->getSecureURL('wizard/template');
			$link['trip/itinerary/edit'] = $this->html->getSecureURL('trip/itinerary/edit');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/wizard/new.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}