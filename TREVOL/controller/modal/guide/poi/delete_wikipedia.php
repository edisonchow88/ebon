<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalGuidePoiDeleteWikipedia extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$modal_ajax['guide/ajax_poi_wikipedia'] = $this->html->getSecureURL('guide/ajax_poi_wikipedia');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		
		$this->processTemplate('modal/guide/poi/delete_wikipedia.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

