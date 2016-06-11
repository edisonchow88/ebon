<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalResourceImageBox extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$link['resource/image_list'] = $this->html->getSecureURL('resource/image_list');
		$link['resource/image_form'] = $this->html->getSecureURL('resource/image_form');
		$link['resource/image_post'] = $this->html->getSecureURL('resource/image_post');
		
		$this->view->assign('link', $link);
		$this->view->assign('form', $form);
		
		$this->processTemplate('modal/resource/image_box.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

