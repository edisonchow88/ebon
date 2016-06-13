<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuideInterestList extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Interest List";
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
		$this->loadModel('guide/interest');
		$data = $this->model_guide_interest->getInterest();
		
		foreach($data as $row) {
			
			$interest_id = $row['interest_id'];
			$name = $row['name'];
			$status= $row['status'];
			
			$image = $this->model_resource_image->getImageByInterestId($interest_id,'50px');
				//json_encode will only treat sequential array as object hence need to use array_values 
				if(count($image) > 0) { $json_image = json_encode(array_values($image)); }
			
			$tag = $this->model_resource_tag->getTagByInterestId($interest_id);
				if(count($tag) > 0) { $json_tag = json_encode(array_values($tag)); }
				
			$parent = $this->model_guide_interest->getInterestParent($interest_id);
				if(count($parent) > 0) { $json_parent = json_encode(array_values($parent)); }
				
			$child = $this->model_guide_interest->getInterestChild($interest_id);
			
			//following sequence is important
			$result[$interest_id]['image'] = $json_image;
			$result[$interest_id]['interest_id'] = $interest_id;
			$result[$interest_id]['name'] = $name;
			$result[$interest_id]['tag'] = $json_tag;
			$result[$interest_id]['parent'] = $json_parent;
			$result[$interest_id]['child'] = count($child);
			$result[$interest_id]['similar'] = $json_similar;
			$result[$interest_id]['status'] = $status;
		}
		
		$link['guide/interest_list'] = $this->html->getSecureURL('guide/interest_list');
		$link['guide/interest_form'] = $this->html->getSecureURL('guide/interest_form');
		$link['guide/interest_post'] = $this->html->getSecureURL('guide/interest_post');
		
		$this->view->assign('link', $link); 
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/guide/interest_list.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

