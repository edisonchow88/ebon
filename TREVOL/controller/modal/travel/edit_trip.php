<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTravelEditTrip extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		//START: input [ORDER IS IMPORTANT]
		$i = 'id';
		$modal_input[$i]['label'] = 'Id';
		$modal_input[$i]['id'] = 'trip-id';
		$modal_input[$i]['name'] = 'trip_id';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['json'] = 'trip_id';
		
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
		$modal_input[$i]['json'] = 'user.username';
		
		$i = 'status';
		$modal_input[$i]['label'] = 'Status';
		$modal_input[$i]['id'] = 'status-id';
		$modal_input[$i]['name'] = 'status_id';
		$modal_input[$i]['type'] = 'text';
		$modal_input[$i]['required'] = false;
		
		$i = 'transport';
		$modal_input[$i]['label'] = 'Transport';
		$modal_input[$i]['id'] = 'transport-id';
		$modal_input[$i]['name'] = 'transport_id';
		$modal_input[$i]['type'] = 'text';
		$modal_input[$i]['required'] = false;
		
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
		$modal_input[$i]['json'] = 'date_added';
		
		$i = 'date_modified';
		$modal_input[$i]['label'] = 'Date Modified';
		$modal_input[$i]['id'] = 'date-modified';
		$modal_input[$i]['name'] = 'date_modified';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['json'] = 'date_modified';
		//END: input
		
		$modal_ajax['travel/ajax_trip'] = $this->html->getSecureURL('travel/ajax_trip');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		$this->view->assign('modal_input', $modal_input);
		
		$this->processTemplate('modal/travel/edit_trip.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

