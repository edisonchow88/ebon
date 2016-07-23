<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalResourceDataDeleteAlias extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$modal_ajax['resource/ajax_data_alias'] = $this->html->getSecureURL('resource/ajax_data_alias');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		
		$this->processTemplate('modal/resource/data/delete_alias.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

