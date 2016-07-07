<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalDatabaseDeleteDatabase extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$modal_ajax['database/ajax_database'] = $this->html->getSecureURL('database/ajax_database');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		
		$this->processTemplate('modal/database/delete_database.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

