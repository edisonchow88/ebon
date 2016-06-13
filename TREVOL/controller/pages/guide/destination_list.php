<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuideDestinationList extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Destination List";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$this->loadModel('resource/tag');
		$this->loadModel('resource/image');
		$this->loadModel('guide/destination');
		$data = $this->model_guide_destination->getDestination();
		
		foreach($data as $row) {
			
			$destination_id = $row['destination_id'];
			$name = $row['name'];
			$status= $row['status'];
			
			$image = $this->model_resource_image->getImageByDestinationId($destination_id,'50px');
				//json_encode will only treat sequential array as object hence need to use array_values 
				if(count($image) > 0) { $json_image = json_encode(array_values($image)); }
			
			$tag = $this->model_resource_tag->getTagByDestinationId($destination_id);
				if(count($tag) > 0) { $json_tag = json_encode(array_values($tag)); }
				
			$parent = $this->model_guide_destination->getDestinationParent($destination_id);
				if(count($parent) > 0) { $json_parent = json_encode(array_values($parent)); }
				
			$child = $this->model_guide_destination->getDestinationChild($destination_id);
			
			//following sequence is important
			$result[$destination_id]['image'] = $json_image;
			$result[$destination_id]['destination_id'] = $destination_id;
			$result[$destination_id]['name'] = $name;
			$result[$destination_id]['tag'] = $json_tag;
			$result[$destination_id]['parent'] = $json_parent;
			$result[$destination_id]['child'] = count($child);
			$result[$destination_id]['descendant'] = count($descendant);
			$result[$destination_id]['similar'] = $json_similar;
			$result[$destination_id]['status'] = $status;
		}
		
		$link['guide/destination_list'] = $this->html->getSecureURL('guide/destination_list');
		$link['guide/destination_form'] = $this->html->getSecureURL('guide/destination_form');
		$link['guide/destination_post'] = $this->html->getSecureURL('guide/destination_post');
		
		$this->view->assign('link', $link); 
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/guide/destination_list.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

