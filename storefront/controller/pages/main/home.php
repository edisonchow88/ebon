<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesMainHome extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set result
		//END
		
		//START: set modal
			$this->addChild('pages/main/explore', 'section_content_explore', 'pages/main/explore.tpl');
			$this->addChild('pages/main/trip', 'section_content_trip', 'pages/main/trip.tpl');
			$this->addChild('pages/main/account', 'section_content_account', 'pages/main/account.tpl');
		//END
		
		//START: set link
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
		//END
		
		//START: set template 
			$this->processTemplate('pages/main/home.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}