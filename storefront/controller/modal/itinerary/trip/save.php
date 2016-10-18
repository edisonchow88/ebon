<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalItineraryTripSave extends AController {
	//START: set common variable
		public $data = array();
	//END
	
  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load component	
			$this->loadComponent('database/mobile_modal');
		//END
		
		//START: set form for save trip
			$id = 'modal-trip-save-form';
			$action = 'save_trip';
			$input = array();
			//START: set input [ORDER IS IMPORTANT]
				$i ='name';
				$input[$i]['label'] = 'Title';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = '';
				$input[$i]['placeholder'] = 'Title';
				$input[$i]['type'] = 'text';
				
				$i ='user_id';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->user->getUserId();
				$input[$i]['type'] = 'hidden';
				
				$i ='role_id';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->user->getRoleId();
				$input[$i]['type'] = 'hidden';
				
				$i ='language_id';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->language->getLanguageId();
				$input[$i]['type'] = 'hidden';
				
				$i ='plan';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'hidden';
			//END
			$setting['autocomplete'] = false;
			$component['form'] = $this->component_database_mobile_modal->writeForm($id,$action,$input,$setting);
		//END
		
		//START: set ajax
			$ajax['trip/ajax_itinerary'] = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($component) > 0) { $this->view->assign('component', $component); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template
			$this->processTemplate('modal/itinerary/trip/save.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

