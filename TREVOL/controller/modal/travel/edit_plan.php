<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTravelEditPlan extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		//START: input [ORDER IS IMPORTANT]
		
		$i = 'section_relation';
		$modal_input[$i]['section'] = 'Relation';
		
		$i = 'trip';
		$modal_input[$i]['label'] = 'Trip';
		$modal_input[$i]['id'] = 'trip-id';
		$modal_input[$i]['name'] = 'trip_id';
		$modal_input[$i]['type'] = 'select';
		$modal_input[$i]['required'] = true;
		$modal_input[$i]['option'] = $this->model_travel_trip->getTrip();
		
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
		
		$i = 'transport';
		$modal_input[$i]['label'] = 'Transport';
		$modal_input[$i]['id'] = 'transport-id';
		$modal_input[$i]['name'] = 'transport_id';
		$modal_input[$i]['type'] = 'select';
		$modal_input[$i]['option'] = $this->model_travel_transport->getTransport();
		$modal_input[$i]['required'] = false;
		
		$i = 'sort';
		$modal_input[$i]['label'] = 'Sort';
		$modal_input[$i]['id'] = 'sort-order';
		$modal_input[$i]['name'] = 'sort_order';
		$modal_input[$i]['type'] = 'text';
		
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
		
		$i = 'id';
		$modal_input[$i]['label'] = 'Id';
		$modal_input[$i]['id'] = 'plan-id';
		$modal_input[$i]['name'] = 'plan_id';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['json'] = 'plan_id';
		//END: input
		
		$modal_ajax['travel/ajax_plan'] = $this->html->getSecureURL('travel/ajax_plan');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		$this->view->assign('modal_input', $modal_input);
		
		$this->processTemplate('modal/travel/edit_plan.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

