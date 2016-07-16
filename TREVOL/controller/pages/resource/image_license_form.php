<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceImageLicenseForm extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		if(!isset($this->request->get['image_license_id'])) {
			$title = 'Add Image License';
			$form['action'] = 'add';
		}
		else {
			$title = 'Edit Image License';
			$form['action'] = 'edit';
			$image_license_id = $this->request->get['image_license_id'];
			
			$this->loadModel("resource/image_license");
			$data = $this->model_resource_image_license->getImageLicense($image_license_id);
			foreach($data as $k => $v) { $form[$k] = $v; } //auto generate input data
		}
		
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$link['resource/image_license_list'] = $this->html->getSecureURL('resource/image_license_list');
		$link['resource/image_license_form'] = $this->html->getSecureURL('resource/image_license_form');
		$link['resource/image_license_post'] = $this->html->getSecureURL('resource/image_license_post');
		
		$this->view->assign('title', $title);
		$this->view->assign('link', $link);
		$this->view->assign('form', $form);
		
		$this->processTemplate('pages/resource/image_license_form.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

