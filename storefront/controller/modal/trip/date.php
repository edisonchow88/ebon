<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTripDate extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load component	
			$this->loadComponent('database/mobile_modal');
		//END
		
		//START: set form
			$id = 'plan-date-form';
			$action = 'set_date';
			$input = array();
			//START: set input [ORDER IS IMPORTANT]
				$i ='start_date';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['placeholder'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = 'travel_date';
				$input[$i]['required'] = false;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'date';
				
				$i ='end_date';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['placeholder'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = 'last_date';
				$input[$i]['required'] = false;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'disabled';
				
				$i ='number_of_days';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['placeholder'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = 'num_of_day';
				$input[$i]['required'] = false;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'disabled';
			//END
			$setting['autocomplete'] = false;
			$component['form'] = $this->component_database_mobile_modal->writeForm($id,$action,$input,$setting);
		//END
		
		//START: set form
			$id = 'plan-date-form-hidden';
			$action = 'set_date';
			$setting['autocomplete'] = false;
			foreach($input as $key => $value) {
				$input[$key]['type'] = 'hidden';
			}
			$component['form_hidden'] = $this->component_database_mobile_modal->writeForm($id,$action,$input,$setting);
		//END
		
		//START: set ajax
			$ajax['trip/ajax_itinerary'] = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set link
			$link['home'] = $this->html->getSecureURL('main/home');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
			$this->view->assign('component', $component);
		//END
		
		//START: set template
			$this->processTemplate('modal/trip/date.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

