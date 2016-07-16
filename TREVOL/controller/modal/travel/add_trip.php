<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTravelAddTrip extends AController {

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
		
		$i = 'description';
		$modal_input[$i]['label'] = 'Description';
		$modal_input[$i]['id'] = 'description';
		$modal_input[$i]['name'] = 'description';
		$modal_input[$i]['type'] = 'textarea';
		$modal_input[$i]['required'] = false;
		
		$i = 'section_general';
		$modal_input[$i]['section'] = 'General';
		
		$i = 'admin';
		$modal_input[$i]['label'] = 'Admin';
		$modal_input[$i]['id'] = 'user-id';
		$modal_input[$i]['name'] = 'user_id';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = $this->user->getId();
		$modal_input[$i]['text'] = $this->user->getUserName();
		
		$i = 'status';
		$modal_input[$i]['label'] = 'Status';
		$modal_input[$i]['id'] = 'status-id';
		$modal_input[$i]['name'] = 'status_id';
		$modal_input[$i]['type'] = 'select';
		$modal_input[$i]['option'] = $this->model_travel_status->getStatus();
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = 1;
		
		$i = 'travel_date';
		$modal_input[$i]['label'] = 'Travel Date';
		$modal_input[$i]['id'] = 'travel-date';
		$modal_input[$i]['name'] = 'travel_date';
		$modal_input[$i]['type'] = 'date';
		$modal_input[$i]['required'] = false;
		
		$i = 'date_added';
		$modal_input[$i]['label'] = 'Date Added';
		$modal_input[$i]['id'] = 'date-added';
		$modal_input[$i]['name'] = 'date_added';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = gmdate('Y-m-d H:i:s');
		$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
		
		$i = 'date_modified';
		$modal_input[$i]['label'] = 'Date Modified';
		$modal_input[$i]['id'] = 'date-modified';
		$modal_input[$i]['name'] = 'date_modified';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = gmdate('Y-m-d H:i:s');
		$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
		//END: input
		
		$modal_ajax['travel/ajax_trip'] = $this->html->getSecureURL('travel/ajax_trip');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		$this->view->assign('modal_input', $modal_input);
		
		$this->processTemplate('modal/travel/add_trip.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

