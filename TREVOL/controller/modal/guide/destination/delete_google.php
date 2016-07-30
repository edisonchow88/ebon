<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalGuideDestinationDeleteGoogle extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$modal_ajax['guide/ajax_destination_google'] = $this->html->getSecureURL('guide/ajax_destination_google');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		
		$this->processTemplate('modal/guide/destination/delete_google.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

