<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripItinerary extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
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
			
			$i = 'datetime';
			$column[$i]['title'] = 'Date / Time';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$j = 'date';
			$column[$i]['dayName'] = $j;
			$column[$i]['dayId'] = str_replace("_","-",$j);
			$column[$i]['dayClass'] = 'plan-col-'.str_replace("_","-",$j);
			$j = 'time';
			$column[$i]['lineName'] = $j;
			$column[$i]['lineId'] = str_replace("_","-",$j);
			$column[$i]['lineClass'] = 'plan-col-'.str_replace("_","-",$j);
			$column[$i]['width'] = '90px';
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
			
			$i = 'description';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '30px';
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
			$this->addChild('modal/trip/splash', 'modal_trip_splash', 'modal/trip/splash.tpl');
			$this->addChild('modal/trip/day', 'modal_trip_day', 'modal/trip/day.tpl');
			$this->addChild('modal/trip/date', 'modal_trip_date', 'modal/trip/date.tpl');
			$this->addChild('modal/trip/map', 'modal_trip_map', 'modal/trip/map.tpl');
			$this->addChild('pages/trip/itinerary_guide', 'section_content_guide', 'pages/trip/itinerary_guide.tpl');
			$this->addChild('pages/trip/itinerary_plan', 'section_content_plan', 'pages/trip/itinerary_plan.tpl');
			$this->addChild('pages/trip/itinerary_map', 'section_content_map', 'pages/trip/itinerary_map.tpl');
			$this->addChild('pages/trip/itinerary_footer', 'section_content_footer', 'pages/trip/itinerary_footer.tpl');
		//END
		
		//START: set ajax
			$ajax['trip/ajax_itinerary'] = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set link
			$link['main/home'] = $this->html->getSecureURL('main/home','#tab=trip');
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
			$this->processTemplate('pages/trip/itinerary.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}