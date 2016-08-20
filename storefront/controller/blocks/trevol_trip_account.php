<?php 
//START: verify directory
	if (! defined ( 'DIR_CORE' )) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerBlocksTrevolTripAccount extends AController {
	//START: declare common variable
		public $data = array();
	//END
	
	public function main() {

        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: verify log in account
			$this->data['logged'] = $this->user->isLogged();
		//END
		
		//START: set modal
			$this->addChild('modal/account/login', 'modal_account_login', 'modal/account/login.tpl');
			$this->addChild('modal/account/logout', 'modal_account_logout', 'modal/account/logout.tpl');
			$this->addChild('modal/account/detail', 'modal_account_detail', 'modal/account/detail.tpl');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
		//END
		
		//START: set template
			$this->processTemplate();
		//END
		
        //START: init controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
  	}
}
?>