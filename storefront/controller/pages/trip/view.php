<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripView extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set popover hint
			if($this->session->data['account_action'] != '') {
				if($this->session->data['account_action'] == 'login') {
					$this->data['last_action'] = 'Log In';
				}
				else if($this->session->data['account_action'] == 'signup') {
					$this->data['last_action'] = 'Sign Up';
				}
				else if($this->session->data['account_action'] == 'logout') {
					$this->data['last_action'] = 'Log Out';
				}
				unset($this->session->data['account_action']);
			}
			if($this->session->data['trip_action'] != '') {
				if($this->session->data['trip_action'] == 'save_trip') {
					$this->data['last_action'] = 'Trip Saved';
				}
				unset($this->session->data['trip_action']);
			}
		//END
		
		//START: set modal
			$this->loadModel('travel/trip');
		//END
		
		//START: verify log in account
			$this->data['logged'] = $this->user->isLogged();
		//END
		
		//START: set data
			$this->data['trip_id'] = $this->trip->getTripId();
			$this->data['plan_id'] = $this->trip->getPlanId();
		//END
		
		//START: verify
			if($this->trip->hasCode()) {
				if($this->trip->hasTrip()) {
					$this->data['trip'] = $this->model_travel_trip->getTrip($this->data['trip_id']);
					$this->data['plan'] = $this->model_travel_trip->getPlan($this->data['plan_id']);
					if($this->trip->isRemoved()) {
						$this->session->data['error'] = 'trip_removed';
						$this->redirect($this->html->getSecureURL('error/trip'));
					}
				}
				else {
					$this->session->data['error'] = 'trip_not_found';
					$this->redirect($this->html->getSecureURL('error/trip'));
				}
			}
		//END
		
		//START: set mode
			if($this->trip->hasTrip()) {
				if($this->user->getUserId() == $this->trip->getOwnerId()) {
					$this->session->data['mode'] = 'edit';
					$this->session->data['memory'] = 'server';
				}
				else if($this->user->getUserId() != $this->trip->getOwnerId()) {
					$this->session->data['mode'] = 'view';
					$this->session->data['memory'] = 'server';
				}
			}
			else {
				$this->session->data['mode'] = 'edit';
				$this->session->data['memory'] = 'cookie';
			}
		//END
		
		//START: set column
			$i = 'day_id';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'line_id';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'type';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'type_id';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'sort_order';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'image_id';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'photo';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'day';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '40px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'title';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'description';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'time';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			$column[$i]['type'] = 'progress';
			
			$i = 'duration';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '60px';
			$column[$i]['align'] = 'right';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			$column[$i]['type'] = 'progress';
			
			$i = 'activity';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'place';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'place_id';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'lat';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'lng';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'fee';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '50px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'currency';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '40px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'company';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'address';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'phone';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'fax';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'website';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'note';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '30px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'command';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'right';
			$column[$i]['visible'] = 'true';
		//END
		
		//START: set result
		//END
		
		//START: set modal
			$this->addChild('modal/itinerary/splash', 'modal_itinerary_splash', 'modal/itinerary/splash.tpl');
			$this->addChild('modal/itinerary/menu', 'modal_itinerary_menu', 'modal/itinerary/menu.tpl');
			$this->addChild('modal/itinerary/view/map', 'modal_itinerary_map', 'modal/itinerary/view/map.tpl');
			$this->addChild('modal/itinerary/trip/share', 'modal_trip_share', 'modal/itinerary/trip/share.tpl');
			$this->addChild('modal/itinerary/member/list', 'modal_member_list', 'modal/itinerary/member/list.tpl');
			$this->addChild('modal/itinerary/member/view', 'modal_member_view', 'modal/itinerary/member/view.tpl');
		//END
		
		//START: set ajax
			$ajax['trip/ajax_itinerary'] = $this->html->getSecureURL('trip/ajax_itinerary');
			$ajax['main/ajax_explore'] = $this->html->getSecureURL('main/ajax_explore');
		//END
		
		//START: set redirect
			$this->data['redirect'] = $this->html->getSecureURL('trip/itinerary');
		//END
		
		//START: set link
			$link['main/home'] = $this->html->getSecureURL('main/home','#tab=trip');
			$link['main/home/addtrip'] = $this->html->getSEOURL('main/home','&m=new&c='.$this->request->get_or_post('c').'#tab=trip');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			$this->view->assign('column',$column);
			$this->view->assign('column_json',json_encode(array_values($column)));
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/view.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}