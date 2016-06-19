<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceImageForm extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		if(!isset($this->request->get['image_id'])) {
			$title = 'Add Image';
			$form['action'] = 'add';
		}
		else {
			$title = 'Edit Image';
			$form['action'] = 'edit';
			$image_id = $this->request->get['image_id'];
			
			$this->loadModel("guide/destination");
			$this->loadModel("resource/tag");
			$this->loadModel("resource/image");
			
			$data = $this->model_resource_image->getImage($image_id, "300px");
			foreach($data as $k => $v) { $form[$k] = $v; } //auto generate input data
			
			$tag_time = $this->model_resource_tag->getTagByImageId($image_id);
				if($tag_time != '') { $json = json_encode(array_values($tag_time)); } else { $json = ''; }
			$form['tag_time'] = $json;
			
			$image_destination = $this->model_guide_destination->getDestinationByImageId($image_id);
				if($image_destination != '') { $json = json_encode(array_values($image_destination)); } else { $json = ''; }
			$form['image_destination'] = $json;
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
		
		$this->loadModel('resource/image_license');
		$this->loadModel('resource/image_source');
		
		$link['resource/image_list'] = $this->html->getSecureURL('resource/image_list');
		$link['resource/image_form'] = $this->html->getSecureURL('resource/image_form');
		$link['resource/image_post'] = $this->html->getSecureURL('resource/image_post');
		
		$option['license'] = $this->model_resource_image_license->getImageLicense();
		$option['source'] = $this->model_resource_image_source->getImageSource();
		
		$reference['license'] = "https://en.wikipedia.org/wiki/Creative_Commons_license#Seven_regularly_used_licenses";
		
		//include modal
		$this->addChild('modal/resource/tag_time', 'modal_tag_time', 'modal/resource/tag_time.tpl');
		$this->addChild('modal/resource/image_destination', 'modal_image_destination', 'modal/resource/image_destination.tpl');
		$this->addChild('modal/resource/replace_image', 'modal_replace_image', 'modal/resource/replace_image.tpl');
		
		$this->view->assign('title', $title);
		$this->view->assign('link', $link);
		$this->view->assign('form', $form);
		$this->view->assign('option', $option);
		$this->view->assign('reference', $reference);
		
		$this->processTemplate('pages/resource/image_form.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

