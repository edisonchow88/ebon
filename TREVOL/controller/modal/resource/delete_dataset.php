<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalResourceDeleteDataset extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$modal_ajax['resource/ajax_dataset'] = $this->html->getSecureURL('resource/ajax_dataset');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		
		$this->processTemplate('modal/resource/delete_dataset.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

