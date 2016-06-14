<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceImageSourceList extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Image List";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$this->loadModel('resource/image');
		$data = $this->model_resource_image->getImageSource();
		
		foreach($data as $key => $value) {
			$result[$key] = $value;
		}
		
		$link['resource/image_list'] = $this->html->getSecureURL('resource/image_list');
		$link['resource/image_source_list'] = $this->html->getSecureURL('resource/image_source_list');
		$link['resource/image_source_form'] = $this->html->getSecureURL('resource/image_source_form');
		$link['resource/image_source_post'] = $this->html->getSecureURL('resource/image_source_post');
		
		$this->view->assign('link', $link); 
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/resource/image_source_list.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

