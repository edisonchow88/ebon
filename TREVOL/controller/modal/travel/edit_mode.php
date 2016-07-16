<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTravelEditMode extends AController {

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
		$modal_input[$i]['json'] = 'language.name';
		
		$i = 'name';
		$modal_input[$i]['label'] = 'Name';
		$modal_input[$i]['id'] = 'name';
		$modal_input[$i]['name'] = 'name';
		$modal_input[$i]['type'] = 'text';
		$modal_input[$i]['required'] = true;
		
		$i = 'section_general';
		$modal_input[$i]['section'] = 'General';
		
		$i = 'icon';
		$modal_input[$i]['label'] = 'Icon';
		$modal_input[$i]['id'] = 'icon';
		$modal_input[$i]['name'] = 'icon';
		$modal_input[$i]['type'] = 'text';
		$modal_input[$i]['required'] = true;
		$modal_input[$i]['help'] = 'fa-awesome';
		$modal_input[$i]['link'] = 'http://fontawesome.io/icons/';
		
		$i = 'id';
		$modal_input[$i]['label'] = 'Id';
		$modal_input[$i]['id'] = 'mode-id';
		$modal_input[$i]['name'] = 'mode_id';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['json'] = 'mode_id';
		//END: input
		
		$modal_ajax['travel/ajax_mode'] = $this->html->getSecureURL('travel/ajax_mode');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		$this->view->assign('modal_input', $modal_input);
		
		$this->processTemplate('modal/travel/edit_mode.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

