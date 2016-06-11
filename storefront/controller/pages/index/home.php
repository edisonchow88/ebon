<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerPagesIndexHome extends AController {

	public function main() {

		//init controller data
		$this->extensions->hk_InitData($this,__FUNCTION__);

		$this->document->setTitle( $this->config->get('config_title') );
		$this->document->setDescription( $this->config->get('config_meta_description') );
		$this->document->setKeywords( $this->config->get('config_meta_keywords') );

		$this->loadModel('resource/tag');
		$this->loadModel('resource/image');
		$this->loadModel('guide/destination');
		$data = $this->model_guide_destination->getDestination();
		
		foreach($data as $row) {
			
			$destination_id = $row['destination_id'];
			$name = $row['name'];
			$status= $row['status'];
			
			$image = $this->model_resource_image->getImageByDestinationId($destination_id,'100%');
				//json_encode will only treat sequential array as object hence need to use array_values 
				if(count($image) > 0) { $json_image = json_encode(array_values($image)); }
			
			$tag = $this->model_resource_tag->getTagByDestinationId($destination_id);
				if(count($tag) > 0) { $json_tag = json_encode(array_values($tag)); }
				
			$parent = $this->model_guide_destination->getDestinationParent($destination_id);
				if(count($parent) > 0) { $json_parent = json_encode(array_values($parent)); }
				
			$child = $this->model_guide_destination->getDestinationChild($destination_id);
			
			//following sequence is important
			$result[$destination_id]['image'] = $image[0]['image'];
			$result[$destination_id]['destination_id'] = $destination_id;
			$result[$destination_id]['name'] = $name;
			$result[$destination_id]['tag'] = $json_tag;
			$result[$destination_id]['parent'] = $json_parent;
			$result[$destination_id]['child'] = count($child);
			$result[$destination_id]['descendant'] = count($descendant);
			$result[$destination_id]['similar'] = $json_similar;
			$result[$destination_id]['status'] = $status;
		}
		
		$this->view->assign('result', $result);

		$this->processTemplate();

		//init controller data
		$this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
