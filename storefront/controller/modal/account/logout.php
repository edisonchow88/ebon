<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalAccountLogout extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load component	
			$this->loadComponent('database/modal');
		//END
		
		//START: set form
			$id = 'modal-logout-form';
			$action = 'logout';
			$input = array();
			$modal_component[$id] = $this->component_database_modal->writeForm($id,$action,$input);
		//END
		
		//START: set ajax
			$modal_ajax = $this->html->getSecureURL('account/ajax_user');
		//END
		
		//START: set variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/account/logout.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

