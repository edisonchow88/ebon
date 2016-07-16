<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTravelDeleteDay extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$modal_ajax['travel/ajax_day'] = $this->html->getSecureURL('travel/ajax_day');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		
		$this->processTemplate('modal/travel/delete_day.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

