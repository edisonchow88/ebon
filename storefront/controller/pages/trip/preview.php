<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripPreview extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set model
			$this->loadModel('travel/trip');
		//END
		
		//START: set data
			$this->data['trip_id'] = $this->trip->getTripId();
			$this->data['plan_id'] = $this->trip->getPlanId();
		//END
		
		//START: set menu
			$this->addChild('menu/mobile/main', 'menu_mobile_main', 'menu/mobile/main.tpl');
		//END
		
		//START: set modal
			$this->addChild('modal/itinerary/account/login', 'modal_account_login', 'modal/itinerary/account/login.tpl');
			$this->addChild('modal/itinerary/account/signup', 'modal_account_signup', 'modal/itinerary/account/signup.tpl');
			$this->addChild('modal/itinerary/member/join', 'modal_member_join', 'modal/itinerary/member/join.tpl');		
		//END
		
		//START: set ajax
			$ajax['trip/ajax_itinerary'] = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set link
			$link['trip/itinerary/view'] = $this->html->getSecureURL('trip/itinerary/view');
		//END
		
		//START: set script
			$this->addChild('script/trip/plan', 'script_trip_plan', 'script/trip/plan.tpl');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/preview.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}