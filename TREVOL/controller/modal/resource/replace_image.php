<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalResourceReplaceImage extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$this->loadModel('resource/image');
		
		$ajax['resource/replace_image'] = $this->html->getSecureURL('resource/replace_image');
		
		$this->view->assign('ajax', $ajax);
		
		$this->processTemplate('modal/resource/replace_image.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

