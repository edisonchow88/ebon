<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTagTypeForm extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		if(!isset($this->request->get['tag_type_id'])) {
			$title = 'Add Tag Type';
			$form['action'] = 'add';
		}
		else {
			$title = 'Edit Tag Type';
			$form['action'] = 'edit';
			$tag_type_id = $this->request->get['tag_type_id'];
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
		
		$link['tag/type_list'] = $this->html->getSecureURL('tag/type_list');
		$link['tag/type_post'] = $this->html->getSecureURL('tag/type_post');
		
		$this->loadModel('tag/tag');
		$data = $this->model_tag_tag->getTagType($tag_type_id);
		
		$form['tag_type_id'] = $data['tag_type_id'];
		$form['type_name'] = $data['type_name'];
		$form['type_color'] = $data['type_color'];
		
		$this->view->assign('title', $title);
		$this->view->assign('link', $link);
		$this->view->assign('form', $form);
		
		$this->processTemplate('pages/tag/type_form.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

