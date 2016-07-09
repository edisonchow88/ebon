<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTravelAddDay extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		//START: input [ORDER IS IMPORTANT]
		$i = 'section_relation';
		$modal_input[$i]['section'] = 'Relation';
		
		$i = 'line';
		$modal_input[$i]['label'] = 'Line';
		$modal_input[$i]['id'] = 'line-id';
		$modal_input[$i]['name'] = 'line_id';
		$modal_input[$i]['type'] = 'select';
		$modal_input[$i]['required'] = true;
		$modal_input[$i]['option'] = $this->model_travel_line->getLine();
		
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
		$modal_input[$i]['required'] = false;
		
		$i = 'section_general';
		$modal_input[$i]['section'] = 'General';
		
		$i = 'date';
		$modal_input[$i]['label'] = 'Date';
		$modal_input[$i]['id'] = 'date';
		$modal_input[$i]['name'] = 'date';
		$modal_input[$i]['type'] = 'date';
		$modal_input[$i]['required'] = true;
		//END: input
		
		$modal_ajax['travel/ajax_day'] = $this->html->getSecureURL('travel/ajax_day');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		$this->view->assign('modal_input', $modal_input);
		
		$this->processTemplate('modal/travel/add_day.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

