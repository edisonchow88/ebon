<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalResourceImageBox extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$this->loadModel('resource/image');
		$this->loadModel('resource/image_license');
		$this->loadModel('resource/image_source');
		
		$option['license'] = $this->model_resource_image_license->getImageLicense();
		$option['source'] = $this->model_resource_image_source->getImageSource();
		
		$ajax['resource/image_upload'] = $this->html->getSecureURL('resource/image_upload');
		
		$reference['license'] = "https://en.wikipedia.org/wiki/Creative_Commons_license#Seven_regularly_used_licenses";
		
		$form['image_source_id'] = "";
		$form['image_license_id'] = "";
		
		$this->view->assign('ajax', $ajax);
		$this->view->assign('form', $form);
		$this->view->assign('option', $option);
		$this->view->assign('reference', $reference);
		
		$this->processTemplate('modal/resource/image_box.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

