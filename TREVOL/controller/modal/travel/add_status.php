<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTravelAddStatus extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		//START: input [ORDER IS IMPORTANT]
		$i = 'section_description';
		$modal_input[$i]['section'] = 'Description';
		
		$i = 'language';
		$language = $this->language->getCurrentLanguage();
		$modal_input[$i]['label'] = 'Language';
		$modal_input[$i]['id'] = 'language-id';
		$modal_input[$i]['name'] = 'language_id';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = $language['language_id'];
		$modal_input[$i]['text'] = $language['name'];
		
		$i = 'name';
		$modal_input[$i]['label'] = 'Name';
		$modal_input[$i]['id'] = 'name';
		$modal_input[$i]['name'] = 'name';
		$modal_input[$i]['type'] = 'text';
		$modal_input[$i]['required'] = true;
		
		$i = 'section_general';
		$modal_input[$i]['section'] = 'General';
		
		$i = 'color';
		$modal_input[$i]['label'] = 'Color';
		$modal_input[$i]['id'] = 'color';
		$modal_input[$i]['name'] = 'color';
		$modal_input[$i]['type'] = 'color';
		$modal_input[$i]['required'] = true;
		
		$i = 'sort';
		$modal_input[$i]['label'] = 'Sort';
		$modal_input[$i]['id'] = 'sort-order';
		$modal_input[$i]['name'] = 'sort_order';
		$modal_input[$i]['type'] = 'text';
		//END: input
		
		$modal_ajax['travel/ajax_status'] = $this->html->getSecureURL('travel/ajax_status');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		$this->view->assign('modal_input', $modal_input);
		
		$this->processTemplate('modal/travel/add_status.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

