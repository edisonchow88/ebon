<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerMenuMobileMain extends AController {
	//START: set common variable
		public $data = array();
	//END
	
  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set popover hint
			if($this->session->data['account_action'] != '') {
				if($this->session->data['account_action'] == 'login') {
					$this->data['last_action'] = 'Log In';
				}
				else if($this->session->data['account_action'] == 'signup') {
					$this->data['last_action'] = 'Sign Up';
				}
				else if($this->session->data['account_action'] == 'logout') {
					$this->data['last_action'] = 'Log Out';
				}
				unset($this->session->data['account_action']);
			}
		//END
		
		//START: set modal
			$this->addChild('modal/account/signup', 'modal_account_signup', 'modal/account/signup.tpl');
			$this->addChild('modal/account/login', 'modal_account_login', 'modal/account/login.tpl');
			$this->addChild('modal/account/logout', 'modal_account_logout', 'modal/account/logout.tpl');
			$this->addChild('modal/account/detail', 'modal_account_detail', 'modal/account/detail.tpl');
		//END
		
		//START: set link
			$link['landing/home'] = $this->html->getSecureURL('landing/home');
			$link['list/trip/upcoming'] = $this->html->getSecureURL('list/trip/upcoming');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template
			$this->processTemplate('menu/mobile/main.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

