<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTagTagList extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Tag List";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$this->loadModel('tag/tag');
		$data = $this->model_tag_tag->getTag();
		
		foreach($data as $row) {
			$icon = $row['icon'];
			$tag_id = $row['tag_id'];
			$type['tag_type_id'] = $row['tag_type_id'];
			$type['type_name'] = $row['type_name'];
			$type['type_color'] = $row['type_color'];
			$name = $row['name'];
				$json_name = '{';
				$json_name .= '"name":';
				$json_name .= '"'.$name.'"';
				$json_name .= ',';
				$json_name .= '"color":';
				$json_name .= '"'.$row['type_color'].'"';
				$json_name .= '}';
			$parent = $this->model_tag_tag->getTagParent($tag_id);
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
			$child = $this->model_tag_tag->getTagChild($tag_id);
			$similar = $this->model_tag_tag->getTagSimilar($tag_id);
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
			
			$result[$tag_id]['icon'] = $icon;
			$result[$tag_id]['tag_id'] = $tag_id;
			$result[$tag_id]['type_id'] = $type['type_name'];
			$result[$tag_id]['name'] = $json_name;
			$result[$tag_id]['parent'] = $json_parent;
			$result[$tag_id]['child'] = count($child);
			$result[$tag_id]['similar'] = $json_similar;
		}
		
		$link['tag/type_list'] = $this->html->getSecureURL('tag/type_list');
		$link['tag/tag_list'] = $this->html->getSecureURL('tag/tag_list');
		$link['tag/tag_form'] = $this->html->getSecureURL('tag/tag_form');
		$link['tag/tag_post'] = $this->html->getSecureURL('tag/tag_post');
		
		$this->view->assign('link', $link); 
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/tag/tag_list.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

