<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTripRemove extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load component	
			$this->loadComponent('database/modal');
		//END
		
		//START: set form
			$id = 'modal-trip-remove-form';
			$action = 'remove_trip';
			$input = array();
			//START: set input [ORDER IS IMPORTANT]
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
				
				$i ='trip_id';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->trip->getTripId();
				$input[$i]['type'] = 'hidden';
				
				$i ='owner_id';
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->trip->getOwnerId();
				$input[$i]['type'] = 'hidden';
			//END
			$setting['autocomplete'] = false;
			$modal_component['form'] = $this->component_database_modal->writeForm($id,$action,$input,$setting);
		//END
		
		//START: set ajax
			$modal_ajax = $this->html->getSecureURL('trip/ajax_itinerary');
		//END
		
		//START: set variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/trip/remove.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

