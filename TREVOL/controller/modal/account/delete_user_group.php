<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalAccountDeleteUserGroup extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$modal_ajax['account/ajax_user_group'] = $this->html->getSecureURL('account/ajax_user_group');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		
		$this->processTemplate('modal/account/delete_user_group.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

