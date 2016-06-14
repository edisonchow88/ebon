<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceImageTypeForm extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		if(!isset($this->request->get['image_type_id'])) {
			$title = 'Add Image Type';
			$form['action'] = 'add';
		}
		else {
			$title = 'Edit Image Type';
			$form['action'] = 'edit';
			$image_type_id = $this->request->get['image_type_id'];
			
			$this->loadModel("resource/image_type");
			$data = $this->model_resource_image_type->getImageType($image_type_id);
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
		
		$link['resource/image_type_list'] = $this->html->getSecureURL('resource/image_type_list');
		$link['resource/image_type_form'] = $this->html->getSecureURL('resource/image_type_form');
		$link['resource/image_type_post'] = $this->html->getSecureURL('resource/image_type_post');
		
		$this->view->assign('title', $title);
		$this->view->assign('link', $link);
		$this->view->assign('form', $form);
		
		$this->processTemplate('pages/resource/image_type_form.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

