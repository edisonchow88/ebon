<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceImageList extends AController {

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
		$this->loadModel('resource/image_license');
		$this->loadModel('resource/image_source');
		
		$data = $this->model_resource_image->getImage();
		
		foreach($data as $row) {
			//$linked = $this->model_resource_image->getImageLinked($image_id);
			$image_id = $row['image_id'];
			
			$json_image = '{';
				$json_image .= '"name":';
				$json_image .= '"'.$row['name'].'"';
				$json_image .= ',';
				$json_image .= '"path":';
				$json_image .= '"'.$row['path'].'"';
				$json_image .= ',';
				$json_image .= '"width":';
				$json_image .= '"100px"';
				$json_image .= '}';
			
			if($row['image_license_id'] > 0) {
				$json['image_license'] = json_encode($this->model_resource_image_license->getImageLicense($row['image_license_id']));
			}
			else {
				$json['image_license'] = '';
			}
			
			$result[$image_id]['image'] = $json_image;
			$result[$image_id]['image_id'] = $image_id;
			$result[$image_id]['name'] = $row['name'];
			$result[$image_id]['link'] = $row['link'];
			$result[$image_id]['license'] = $json['image_license'];
			$result[$image_id]['linked'] = count($linked);
		}
		
		$link['resource/image_list'] = $this->html->getSecureURL('resource/image_list');
		$link['resource/image_form'] = $this->html->getSecureURL('resource/image_form');
		$link['resource/image_post'] = $this->html->getSecureURL('resource/image_post');
		$link['resource/image_source_list'] = $this->html->getSecureURL('resource/image_source_list');
		$link['resource/image_license_list'] = $this->html->getSecureURL('resource/image_license_list');
		
		$reference['source'] = $this->model_resource_image_source->getImageSource();
		
		//include modal
		$this->addChild('modal/resource/upload_image', 'modal_upload_image', 'modal/resource/upload_image.tpl');
		
		$this->view->assign('link', $link); 
		$this->view->assign('result', $result);
		$this->view->assign('reference', $reference);
		
		$this->processTemplate('pages/resource/image_list.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

