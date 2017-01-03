<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesLandingHome extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set model
			$this->loadModel('localisation/country');
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
		//END
		
		//START: set menu
			$this->addChild('menu/mobile/main', 'menu_mobile_main', 'menu/mobile/main.tpl');
		//END
		
		//START: set modal
		//END
		
		//START: set link
			$link['wizard/new'] = $this->html->getSecureURL('wizard/new');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/landing/home.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}