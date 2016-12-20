<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesListTripPast extends AController {
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
			$this->addChild('script/list/trip', 'script_list_trip', 'script/list/trip.tpl');
		//END 
		
		//START: set menu
			$this->addChild('menu/list/trip', 'menu_list_trip', 'menu/list/trip.tpl');
		//END 
		
		//START: set modal
			$this->addChild('modal/home/menu', 'modal_home_menu', 'modal/home/menu.tpl');
			$this->addChild('modal/list/trip/search', 'modal_trip_search', 'modal/list/trip/search.tpl');
			$this->addChild('modal/list/trip/sort', 'modal_trip_sort', 'modal/list/trip/sort.tpl');
			$this->addChild('modal/list/trip/action', 'modal_trip_action', 'modal/list/trip/action.tpl');
		//END
		
		//START: set link
			$link['trip/new'] = $this->html->getSecureURL('trip/new');
			$link['trip/itinerary'] = $this->html->getSecureURL('trip/itinerary');
			$link['main/home'] = $this->html->getSecureURL('main/home');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/list/trip/past.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}