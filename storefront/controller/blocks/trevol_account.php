<?php  
/*------------------------------------------------------------------------------
CREATED BY TREVOL, 2016/01/18
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerBlocksTrevolAccount extends AController {
	public $data;
	public function main() {

        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

		$this->loadLanguage('account/account');
		$this->loadLanguage('common/header');

		if ($this->customer->isLogged() || $this->customer->isUnauthCustomer()) {
			$this->data['active'] = true;
			if($this->customer->isLogged()) {
				$this->data['name'] = $this->customer->getFirstName();
				
			} else {
				$this->data['name'] = $this->customer->getUnauthName();			
				$this->data['login'] = $this->html->getSecureURL('account/login');
			}
			
			$this->data['account'] = $this->html->getSecureURL('account/account');
			$this->data['logout'] = $this->html->getSecureURL('account/logout');
			$this->data['information'] = $this->html->getSecureURL('account/edit');
			$this->data['password'] = $this->html->getSecureURL('account/password');
			$this->data['address'] = $this->html->getSecureURL('account/address');
			$this->data['history'] = $this->html->getSecureURL('account/history');
			$this->data['transactions'] = $this->html->getSecureURL('account/transactions');
			$this->data['download'] = $this->html->getSecureURL('account/download');
			$this->data['newsletter'] = $this->html->getSecureURL('account/newsletter');
			$this->data['wishlist'] = $this->html->getSecureURL('account/wishlist');
			$this->data['current'] = $this->html->getSecureURL($this->request->get['rt']);

		} else {
			$this->data['login'] = $this->html->getSecureURL('account/login');
			$this->data['register'] = $this->html->getSecureURL('account/create');		
		} 

		$this->view->batchAssign($this->data);
		$this->processTemplate();

        //init controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);

	}
}
