<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTripNew extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load component	
			$this->loadComponent('database/mobile_modal');
		//END
		
		//START: set form
			$id = 'modal-trip-new-form';
			$action = 'new_trip';
			$input = array();
			//START: set input [ORDER IS IMPORTANT]
				$i ='name';
				$input[$i]['label'] = 'Trip Name';
				$input[$i]['placeholder'] = 'Trip Name';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = true;
				$input[$i]['value'] = 'My Trip';
								
				$i ='num_of_day';
				$input[$i]['label'] = 'Number of Days';
				$input[$i]['placeholder'] = 'Number of Days';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = true;
				$input[$i]['value'] = '6';
				$input[$i]['type'] = 'number';
				$input[$i]['min'] = '1';
				$input[$i]['max'] = '30';
				$input[$i]['step'] = '1';
				$input[$i]['pattern'] = '[0-9]*';
				
				$i ='travel_date';
				$input[$i]['label'] = 'Date (From)';
				$input[$i]['placeholder'] = 'Date (From)';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'date';
								
				$i ='last_date';
				$input[$i]['label'] = 'Date (To)';
				$input[$i]['placeholder'] = 'Date (To)';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'date';
				
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
			//END
			$setting['autocomplete'] = true;
			$modal_component['form'] = $this->component_database_mobile_modal->writeForm($id,$action,$input,$setting);
		//END
		
		//START: set ajax
			$modal_ajax = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/trip/new.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

