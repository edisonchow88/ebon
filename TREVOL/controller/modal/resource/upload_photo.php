<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalResourceUploadPhoto extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		//START: set ajax
			$ajax['resource/ajax_photo'] = $this->html->getSecureURL('resource/ajax_photo');
		//END
		
		//START: set variable
			$this->view->assign('ajax', $ajax);
		//END
		
		//START: set template
			$this->processTemplate('modal/resource/upload_photo.tpl' );
		//END

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

