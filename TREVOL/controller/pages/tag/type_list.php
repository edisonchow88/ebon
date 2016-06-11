<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTagTypeList extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$title = "Tag Type List";
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
		$data = $this->model_tag_tag->getTagType();
		
		foreach($data as $row) {
			$tag_type_id = $row['tag_type_id'];
			$type_name = $row['type_name'];
			$type_color = $row['type_color'];
			
			$result[$tag_type_id]['tag_type_id'] = $tag_type_id;
			$result[$tag_type_id]['type_name'] = $row['type_name'];
			$result[$tag_type_id]['type_color'] = $row['type_color'];
		}
		
		$link['tag/tag_list'] = $this->html->getSecureURL('tag/tag_list');
		$link['tag/type_form'] = $this->html->getSecureURL('tag/type_form');
		$link['submit'] = $this->html->getSecureURL('tag/type_post');
		
		$this->view->assign('link', $link); 
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/tag/type_list.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

