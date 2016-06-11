<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuideDestinationForm extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		if(!isset($this->request->get['destination_id'])) {
			$title = 'Add Destination';
			$form['action'] = 'add';
		}
		else {
			$title = 'Edit Destination';
			$form['action'] = 'edit';
			$destination_id = $this->request->get['destination_id'];
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
		
		$link['guide/destination_list'] = $this->html->getSecureURL('guide/destination_list');
		$link['guide/destination_form'] = $this->html->getSecureURL('guide/destination_form');
		$link['guide/destination_post'] = $this->html->getSecureURL('guide/destination_post');
		
		$language = $this->language->getAvailableLanguages();
		foreach ($language as $lang) {
			$language_option[$lang['language_id']] = $lang['name'];
		}
		
		$this->loadModel('guide/destination');
		$this->loadModel('tag/tag');
		$this->loadModel('resource/image');
		
		//for modal-add-parent
		$relation_data = $this->model_guide_destination->getDestinationAllRelation($destination_id);
		foreach($relation_data as $row) {
			$relation_destination_id = $row['destination_id'];
			$type_color = $row['type_color'];
			$name = $row['name'];
			$relation= $row['relation'];
			
			$json_name = '{';
			$json_name .= '"name":';
			$json_name .= '"'.$name.'"';
			$json_name .= ',';
			$json_name .= '"color":';
			$json_name .= '"'.$type_color.'"';
			$json_name .= '}';
			
			$result[$relation_destination_id]['destination_id'] = $relation_destination_id;
			$result[$relation_destination_id]['name'] = $json_name;
			$result[$relation_destination_id]['relation'] = $relation;
		}
		
		//for form
		$data = $this->model_guide_destination->getDestination($destination_id);
		foreach($data as $k => $v) { $form[$k] = $v; } //auto generate input data
		
		$tag = $this->model_tag_tag->getTagByDestinationId($destination_id);
		$tag = array_values($tag); 
		
		$image = $this->model_resource_image->getImageByDestinationId($destination_id,'100%');
		$parent = $this->model_guide_destination->getDestinationParent($destination_id);
			$n = count($parent);
			$i = 0;
			$json_parent = '[';
			foreach($parent as $destination) {
				$i += 1;
				$json_parent .= '{';
				$json_parent .= '"destination_id":';
				$json_parent .= '"'.$destination['destination_id'].'"';
				$json_parent .= ',';
				$json_parent .= '"name":';
				$json_parent .= '"'.$destination['name'].'"';
				$json_parent .= ',';
				$json_parent .= '"color":';
				$json_parent .= '"'.$destination['type_color'].'"';
				$json_parent .= '}';
				if($i < $n) { $json_parent .= ','; }
			}
			$json_parent .= ']';
		$child = $this->model_guide_destination->getDestinationChild($destination_id);
			$n = count($child);
			$i = 0;
			$json_child = '[';
			foreach($child as $destination) {
				$i += 1;
				$json_child .= '{';
				$json_child .= '"destination_id":';
				$json_child .= '"'.$destination['destination_id'].'"';
				$json_child .= ',';
				$json_child .= '"name":';
				$json_child .= '"'.$destination['name'].'"';
				$json_child .= ',';
				$json_child .= '"color":';
				$json_child .= '"'.$destination['type_color'].'"';
				$json_child .= '}';
				if($i < $n) { $json_child .= ','; }
			}
			$json_child .= ']';
		$similar = $this->model_guide_destination->getDestinationSimilar($destination_id);
			$n = count($similar);
			$i = 0;
			$json_similar = '[';
			foreach($similar as $destination) {
				$i += 1;
				$json_similar .= '{';
				$json_similar .= '"destination_id":';
				$json_similar .= '"'.$destination['destination_id'].'"';
				$json_similar .= ',';
				$json_similar .= '"name":';
				$json_similar .= '"'.$destination['name'].'"';
				$json_similar .= ',';
				$json_similar .= '"color":';
				$json_similar .= '"'.$destination['type_color'].'"';
				$json_similar .= '}';
				if($i < $n) { $json_similar .= ','; }
			}
			$json_similar .= ']';
		
		//for javascript usage
		$tag_option = $this->model_tag_tag->getTagChild(1);
		if(count($tag_option) > 0) { $json_tag_option = json_encode(array_values($tag_option)); }
		
		$form['destination_id'] = $destination_id;
		$form['destination_type_id'] = $data['destination_type_id'];
		$form['type_color'] = $data['type_color'];
		$form['icon'] = $data['icon'];
		$form['name'] = $data['name'];
		$form['description'] = $data['description'];
		$form['parent'] = $parent;
		$form['child'] = $child;
		$form['tag_id'] = $tag[0]['tag_id']; //get the first tag id
		$form['image'] = $image; 
		$form['main_image'] = $image[0]['image']; //get the first image
		
		$this->view->assign('title', $title);
		$this->view->assign('link', $link);
		$this->view->assign('language', $language_option);
		$this->view->assign('form', $form);
		$this->view->assign('result', $result);
		$this->view->assign('tag_option', $tag_option);
		$this->view->assign('json_tag_option', $json_tag_option);
		$this->view->assign('json_parent', $json_parent);
		$this->view->assign('json_child', $json_child);
		$this->view->assign('json_similar', $json_similar);
		
		$this->processTemplate('pages/guide/destination_form.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

