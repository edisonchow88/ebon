<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalGuideDestinationDeleteRelation extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$modal_ajax['guide/ajax_destination_relation'] = $this->html->getSecureURL('guide/ajax_destination_relation');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		
		$this->processTemplate('modal/guide/destination/delete_relation.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

