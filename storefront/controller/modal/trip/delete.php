<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTripDelete extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load component	
			$this->loadComponent('database/modal');
		//END
		
		//START: set form
			$id = 'modal-trip-delete-form';
			$action = 'delete_trip';
			$input = array();
			//START: set input [ORDER IS IMPORTANT]
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
			$this->processTemplate('modal/trip/delete.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

