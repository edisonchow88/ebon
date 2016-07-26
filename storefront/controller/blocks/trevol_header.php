<?php
//START
	if (! defined ( 'DIR_CORE' )) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerBlocksTrevolHeader extends AController {
	public $data = array();

	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//ADDED by TREVOl, 2016/02/24
		$this->loadLanguage('account/account');
		$this->loadLanguage('common/header');

		if ($this->customer->isLogged()) {
			$this->data['active'] = true;
			if($this->customer->isLogged()) {
				$this->data['name'] = $this->customer->getFirstName();
				
			} else {
				$this->data['name'] = $this->customer->getUnauthName();			
				$this->data['login'] = $this->html->getSecureURL('account/login');
			}
			
			$this->data['account'] = ''; //$this->html->getSecureURL('account/account');
			$this->data['logout'] = $this->html->getSecureURL('account/logout');
			$this->data['information'] = $this->html->getSecureURL('account/edit');
			$this->data['password'] = $this->html->getSecureURL('account/password');
			$this->data['current'] = $this->html->getSecureURL($this->request->get['rt']);
			$this->data['welcome'] = "Hi, ".$this->data['name'];

		} else {
			$this->data['account'] = $this->html->getSecureURL('account/login');
			$this->data['welcome'] = "Account";
			$this->data['login'] = $this->html->getSecureURL('account/login');
			$this->data['register'] = $this->html->getSecureURL('account/create');		
		} 
		
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