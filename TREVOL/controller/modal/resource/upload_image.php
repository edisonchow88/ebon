<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalResourceUploadImage extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$this->loadModel('resource/image_license');
		$this->loadModel('resource/image_source');
		
		$modal_ajax['resource/upload_image'] = $this->html->getSecureURL('resource/upload_image');
		
		$modal_link['resource/image_post'] = $this->html->getSecureURL('resource/image_post');
		
		$modal_option['license'] = $this->model_resource_image_license->getImageLicense();
		$modal_option['source'] = $this->model_resource_image_source->getImageSource();
		
		$this->view->assign('modal_ajax', $modal_ajax);
		$this->view->assign('modal_link', $modal_link);
		$this->view->assign('modal_option', $modal_option);
		
		$this->processTemplate('modal/resource/upload_image.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

