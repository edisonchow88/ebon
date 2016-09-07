<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalAccountUpgrade extends AController {
	//START: declare common variable
		public $data = array();
	//END
	
  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: get data
			$this->data['role_id'] = $this->user->getRoleId();
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
		//END
		
		//START: set template
			$this->processTemplate('modal/account/upgrade.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

