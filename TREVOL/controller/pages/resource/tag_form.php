<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesResourceTagForm extends AController {
	/**
	private $error = array();
	public $data = array();
	**/

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		if(!isset($this->request->get['tag_id'])) {
			$title = 'Add Tag';
			$form['action'] = 'add';
		}
		else {
			$title = 'Edit Tag';
			$form['action'] = 'edit';
			$tag_id = $this->request->get['tag_id'];
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
		
		$link['resource/tag_list'] = $this->html->getSecureURL('resource/tag_list');
		$link['resource/tag_form'] = $this->html->getSecureURL('resource/tag_form');
		$link['resource/tag_post'] = $this->html->getSecureURL('resource/tag_post');
		$link['fa_awesome'] = "http://fontawesome.io/icons/";
		
		$language = $this->language->getAvailableLanguages();
		foreach ($language as $lang) {
			$language_option[$lang['language_id']] = $lang['name'];
		}
		
		$this->loadModel('resource/tag');
		
		//for modal-add-parent
		$relation_data = $this->model_resource_tag->getTagAllRelation($tag_id);
		foreach($relation_data as $row) {
			$relation_tag_id = $row['tag_id'];
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
			
			$result[$relation_tag_id]['tag_id'] = $relation_tag_id;
			$result[$relation_tag_id]['name'] = $json_name;
			$result[$relation_tag_id]['relation'] = $relation;
		}
		
		//for form
		$data = $this->model_resource_tag->getTag($tag_id);
		$type_option = $this->model_resource_tag->getTagType();
		$parent = $this->model_resource_tag->getTagParent($tag_id);
			$n = count($parent);
			$i = 0;
			$json_parent = '[';
			foreach($parent as $tag) {
				$i += 1;
				$json_parent .= '{';
				$json_parent .= '"tag_id":';
				$json_parent .= '"'.$tag['tag_id'].'"';
				$json_parent .= ',';
				$json_parent .= '"name":';
				$json_parent .= '"'.$tag['name'].'"';
				$json_parent .= ',';
				$json_parent .= '"color":';
				$json_parent .= '"'.$tag['type_color'].'"';
				$json_parent .= '}';
				if($i < $n) { $json_parent .= ','; }
			}
			$json_parent .= ']';
		$child = $this->model_resource_tag->getTagChild($tag_id);
			$n = count($child);
			$i = 0;
			$json_child = '[';
			foreach($child as $tag) {
				$i += 1;
				$json_child .= '{';
				$json_child .= '"tag_id":';
				$json_child .= '"'.$tag['tag_id'].'"';
				$json_child .= ',';
				$json_child .= '"name":';
				$json_child .= '"'.$tag['name'].'"';
				$json_child .= ',';
				$json_child .= '"color":';
				$json_child .= '"'.$tag['type_color'].'"';
				$json_child .= '}';
				if($i < $n) { $json_child .= ','; }
			}
			$json_child .= ']';
		$similar = $this->model_resource_tag->getTagSimilar($tag_id);
			$n = count($similar);
			$i = 0;
			$json_similar = '[';
			foreach($similar as $tag) {
				$i += 1;
				$json_similar .= '{';
				$json_similar .= '"tag_id":';
				$json_similar .= '"'.$tag['tag_id'].'"';
				$json_similar .= ',';
				$json_similar .= '"name":';
				$json_similar .= '"'.$tag['name'].'"';
				$json_similar .= ',';
				$json_similar .= '"color":';
				$json_similar .= '"'.$tag['type_color'].'"';
				$json_similar .= '}';
				if($i < $n) { $json_similar .= ','; }
			}
			$json_similar .= ']';
		
		//for javascript usage
		$i = 0;
		$json_type = '[';
		foreach($type_option as $type) {
			$i += 1;
			$json_type .= '{';
			$json_type .= '"tag_type_id":';
			$json_type .= '"'.$type['tag_type_id'].'"';
			$json_type .= ',';
			$json_type .= '"type_name":';
			$json_type .= '"'.$type['type_name'].'"';
			$json_type .= ',';
			$json_type .= '"type_color":';
			$json_type .= '"'.$type['type_color'].'"';
			$json_type .= '}';
			if($i < count($type_option)) { $json_type .= ','; }
		}
		$json_type .= ']';
		
		$form['tag_id'] = $tag_id;
		$form['tag_type_id'] = $data['tag_type_id'];
		$form['type_color'] = $data['type_color'];
		$form['icon'] = $data['icon'];
		$form['name'] = $data['name'];
		$form['description'] = $data['description'];
		$form['parent'] = $parent;
		$form['child'] = $child;
		
		$this->view->assign('title', $title);
		$this->view->assign('link', $link);
		$this->view->assign('language', $language_option);
		$this->view->assign('form', $form);
		$this->view->assign('result', $result);
		$this->view->assign('type_option', $type_option);
		$this->view->assign('json_type', $json_type);
		$this->view->assign('json_parent', $json_parent);
		$this->view->assign('json_child', $json_child);
		$this->view->assign('json_similar', $json_similar);
		
		$this->processTemplate('pages/resource/tag_form.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

