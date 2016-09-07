<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTripQuota extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set ajax
		//END
		
		//START: set variable
			$this->view->assign('modal_ajax', $modal_ajax);
		//END
		
		//START: set template
			$this->processTemplate('modal/trip/quota.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

