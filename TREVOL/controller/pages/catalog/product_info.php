<?php
/*------------------------------------------------------------------------------
CREATED by TREVOL, 2016/01/25
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}
class ControllerPagesCatalogProductInfo extends AController {
	private $error = array(); 
	public $data = array();
	private $hour_fields = array('status','general', 'date_from', 'date_to', 'month_from', 'month_to', 'month_eml_from', 'month_eml_to', 'day_mon', 'day_tue', 'day_wed', 'day_thu', 'day_fri', 'day_sat', 'day_sun', 'day_holiday', 'time_from', 'time_to', 'description');
	private $price_fields = array('name', 'amount');
     
  	public function main() {

          //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$this->loadLanguage('catalog/product');
    	$this->document->setTitle( $this->language->get('heading_title') );
		
		$this->loadModel('catalog/product');
		$this->loadModel('catalog/product_hour');
		$this->loadModel('catalog/product_price');
		
		$product_id = $this->request->get['product_id'];
		
		/*
        if ($this->request->is_POST()) {
            $this->model_catalog_product_hour->addProductHour($this->request->get['product_id'], $this->request->post);
            $this->session->data['success'] = $this->language->get('text_success');
            $this->redirect($this->html->getSecureURL('catalog/product_hours', '&product_id=' . $this->request->get['product_id'] ));
        }
		*/
		
		//load tabs controller
		$this->data['active'] = 'info';
		$tabs_obj = $this->dispatch('pages/catalog/product_tabs', array( $this->data ) );
		$this->data['product_tabs'] = $tabs_obj->dispatchGetOutput();
		unset($tabs_obj);
			
        $product_info = $this->model_catalog_product->getProduct($this->request->get['product_id']);
		
        if ( !$product_info ) {
            $this->session->data['warning'] = $this->language->get('error_product_not_found');
            $this->redirect($this->html->getSecureURL('catalog/product'));
        }
		
		//load operating hours data
		$hours = $this->model_catalog_product_hour->getProductHoursDetail($this->request->get['product_id']);
		foreach ($hours as $hour) {
			$this->data['edit_hour'][$hour['product_hour_id']] =  $this->html->getSecureURL('catalog/product_info/editHour','&product_id='.$product_id.'&product_hour_id='.$hour['product_hour_id']);
			$this->data['delete_hour'][$hour['product_hour_id']] =  $this->html->getSecureURL('catalog/product_info/deleteHour','&product_id='.$product_id.'&product_hour_id='.$hour['product_hour_id']);
		}
		$this->data['hours'] = $hours;
		$this->data['add_hour'] =  $this->html->getSecureURL('catalog/product_info/addHour','&product_id='.$product_id);
		
		//load prices data
		$prices = $this->model_catalog_product_price->getProductPricesDetail($this->request->get['product_id']);
		foreach ($prices as $price) {
			$this->data['edit_price'][$price['product_price_id']] =  $this->html->getSecureURL('catalog/product_info/editPrice','&product_id='.$product_id.'&product_price_id='.$price['product_price_id']);
			$this->data['delete_price'][$price['product_price_id']] =  $this->html->getSecureURL('catalog/product_info/deletePrice','&product_id='.$product_id.'&product_price_id='.$price['product_price_id']);
		}
		$this->data['prices'] = $prices;
		$this->data['add_price'] =  $this->html->getSecureURL('catalog/product_info/addPrice','&product_id='.$product_id);
		
		//assign success text	
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
        $this->view->batchAssign( $this->data );
		$this->processTemplate('pages/catalog/product_info.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
	
	public function addHour() {

        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

		$this->loadLanguage('catalog/product');
    	$this->document->setTitle( $this->language->get('heading_title') );
		$this->loadModel('catalog/product');
		$this->loadModel('catalog/product_hour');
		
		$product_id = $this->request->get['product_id'];

		if ( $this->request->is_POST() && $this->_validateHourForm() ) {
			$product_hour_id = $this->model_catalog_product_hour->addProductHour($product_id, $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_add_hour');
			$this->redirect($this->html->getSecureURL('catalog/product_info', '&product_id='.$product_id ));
		}
		$this->_getHourForm();

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
	
	public function editHour() {

        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

		$this->loadLanguage('catalog/product');
    	$this->document->setTitle( $this->language->get('heading_title') );
		
		$this->loadModel('catalog/product');
		$this->loadModel('catalog/product_hour');
		
		$product_id = $this->request->get['product_id'];
		$product_hour_id = $this->request->get['product_hour_id'];

		if ( $this->request->is_POST() && $this->_validateHourForm() ) {
			$hour_data = $this->model_catalog_product_hour->updateProductHour($product_hour_id, $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_edit_hour');
			$this->redirect( $this->html->getSecureURL('catalog/product_info', '&product_id=' . $product_id ));
		}
		$this->_getHourForm();

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
	
	public function deleteHour() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->loadModel('catalog/product');
		$this->loadModel('catalog/product_hour');

		if (isset($this->request->get['product_hour_id'])) {
			$this->model_catalog_product_hour->deleteProductHour($this->request->get['product_hour_id']);

			$this->session->data['success'] = $this->language->get('text_success_delete_hour');
			unset($this->session->data['product_hour_id']);
		}

		$this->main();

		//init controller data
		$this->extensions->hk_UpdateData($this, __FUNCTION__);
	}
	
	private function _getHourForm() {
		$this->data = array();
		$product_id = $this->request->get['product_id'];
		
		$this->data['error'] = $this->error;
		$this->data['cancel'] = $this->html->getSecureURL('catalog/product_info', '&product_id=' . $product_id );

		if (isset($this->request->get['product_hour_id']) && $this->request->is_GET() ) {
			$hour_data = $this->model_catalog_product_hour->getProductHour($this->request->get['product_hour_id']);
		}
		
		//set default value
		foreach ( $this->hour_fields as $f ) {
			$hour_data_default[$f] = '';
			if($f=='status') { $hour_data_default['status'] = 1; }
			if($f=='date_from') { 
				$hour_data_default['date_from'] = date("Y-m-d"); 
			}
			if($f=='date_to') { $hour_data_default['date_to'] = date("Y-m-d"); }
			if($f=='day_mon') { $hour_data_default['day_mon'] = 1; }
			if($f=='day_tue') { $hour_data_default['day_tue'] = 1; }
			if($f=='day_wed') { $hour_data_default['day_wed'] = 1; }
			if($f=='day_thu') { $hour_data_default['day_thu'] = 1; }
			if($f=='day_fri') { $hour_data_default['day_fri'] = 1; }
			if($f=='day_sat') { $hour_data_default['day_sat'] = 1; }
			if($f=='day_sun') { $hour_data_default['day_sun'] = 1; }
			if($f=='day_holiday') { $hour_data_default['day_holiday'] = 1; }
			if($f=='time_from') { $hour_data_default['time_from'] = '00:00:00'; }
			if($f=='time_to') { $hour_data_default['time_to'] = '00:00:00'; }
		}
		
		//set display value
		foreach ( $this->hour_fields as $f ) {
			if (isset ( $this->request->post [$f] )) {
				$this->data['form']['fields'][$f]['value'] = $this->request->post[$f];
			} 
			else if (isset($hour_data)) {
				$this->data['form']['fields'][$f]['value'] = $hour_data[$f];
			} 
			else {
				$this->data['form']['fields'][$f]['value'] = $hour_data_default[$f];
				
			}
		}
		
		//set time condition
		if($this->data['form']['fields']['time_from']['value'] == '00:00:00' && $this->data['form']['fields']['time_to']['value'] == '00:00:00') {
			$this->data['form']['fields']['time']['value'] = 0;
		}
		else {
			$this->data['form']['fields']['time']['value'] = 1;
		}
		
		//identify scenario: ADD or EDIT
		if (!isset($this->request->get['product_hour_id'])) {
			$this->data['action'] = $this->html->getSecureURL('catalog/product_info/addHour','&product_id='.$product_id);
			$this->data['heading_title'] = $this->language->get('text_add') .' '. $this->language->get('text_hour');
		} else {
			$this->data['action'] = $this->html->getSecureURL('catalog/product_info/editHour', '&product_id='.$product_id.'&product_hour_id='.$this->request->get['product_hour_id'] );
			$this->data['heading_title'] = $this->language->get('text_edit') .' '. $this->language->get('text_hour');
		}
		
		$this->view->batchAssign( $this->data );
        $this->processTemplate('pages/catalog/product_hour_form.tpl' );
	}
	
	private function _validateHourForm() {

		$this->extensions->hk_ValidateData($this);

		if (!$this->error) { 
			return TRUE;
		} else {
			return FALSE;
		}
	}
	
	public function addPrice() {

        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

		$this->loadLanguage('catalog/product');
    	$this->document->setTitle( $this->language->get('heading_title') );
		$this->loadModel('catalog/product');
		$this->loadModel('catalog/product_hour');
		$this->loadModel('catalog/product_price');
		
		$product_id = $this->request->get['product_id'];

		if ( $this->request->is_POST() && $this->_validatePriceForm() ) {
			$product_price_id = $this->model_catalog_product_price->addProductPrice($product_id, $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_add_price');
			$this->redirect($this->html->getSecureURL('catalog/product_info', '&product_id='.$product_id ));
		}
		$this->_getPriceForm();

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
	
	public function editPrice() {

        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

		$this->loadLanguage('catalog/product');
    	$this->document->setTitle( $this->language->get('heading_title') );
		
		$this->loadModel('catalog/product');
		$this->loadModel('catalog/product_hour');
		$this->loadModel('catalog/product_price');
		
		$product_id = $this->request->get['product_id'];
		$product_price_id = $this->request->get['product_price_id'];

		if ( $this->request->is_POST() && $this->_validatePriceForm() ) {
			$price_data = $this->model_catalog_product_price->updateProductPrice($product_price_id, $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_edit_price');
			$this->redirect( $this->html->getSecureURL('catalog/product_info', '&product_id=' . $product_id ));
		}
		$this->_getPriceForm();

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
	
	public function deletePrice() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->loadModel('catalog/product');
		$this->loadModel('catalog/product_price');

		if (isset($this->request->get['product_price_id'])) {
			$this->model_catalog_product_price->deleteProductPrice($this->request->get['product_price_id']);

			$this->session->data['success'] = $this->language->get('text_success_delete_price');
			unset($this->session->data['product_price_id']);
		}

		$this->main();

		//init controller data
		$this->extensions->hk_UpdateData($this, __FUNCTION__);
	}
	
	private function _getPriceForm() {
		$this->data = array();
		$product_id = $this->request->get['product_id'];
		
		$this->data['error'] = $this->error;
		$this->data['cancel'] = $this->html->getSecureURL('catalog/product_info', '&product_id=' . $product_id );

		if (isset($this->request->get['product_price_id']) && $this->request->is_GET() ) {
			$price_data = $this->model_catalog_product_price->getProductPrice($this->request->get['product_price_id']);
		}
		
		$fields = $this->model_catalog_product_price->getFields();
		$defaults = $this->model_catalog_product_price->getDefaults();
		
		//set display value
		foreach ( $fields as $f ) {
			if (isset ( $this->request->post [$f] )) {
				$this->data['form']['fields'][$f]['value'] = $this->request->post[$f];
			} 
			else if (isset($price_data)) {
				$this->data['form']['fields'][$f]['value'] = $price_data[$f];
			} 
			else {
				$this->data['form']['fields'][$f]['value'] = $defaults[$f];
				
			}
		}
		$options = $this->model_catalog_product_hour->getProductHoursShort($product_id);
		$this->data['time_options'] = $this->model_catalog_product_price->setTimeOptions($this->data['form']['fields']['product_hour_id']['value'],$options);
		$this->data['gender_options'] = $this->model_catalog_product_price->setGenderOptions($this->data['form']['fields']['gender']['value']);
		$this->data['age_options'] = $this->model_catalog_product_price->setAgeOptions($this->data['form']['fields']['age']['value']);
		$this->data['pax_options'] = $this->model_catalog_product_price->setPaxOptions($this->data['form']['fields']['pax']['value']);
		$this->data['currency_options'] = $this->model_catalog_product_price->setCurrencyOptions($this->data['form']['fields']['currency_code']['value']);
		$this->data['unit_options'] = $this->model_catalog_product_price->setUnitOptions($this->data['form']['fields']['unit']['value']);
		$this->data['duration_unit_options'] = $this->model_catalog_product_price->setDurationUnitOptions($this->data['form']['fields']['duration_unit']['value']);
		
		//identify scenario: ADD or EDIT
		if (!isset($this->request->get['product_price_id'])) {
			$this->data['action'] = $this->html->getSecureURL('catalog/product_info/addPrice','&product_id='.$product_id);
			$this->data['heading_title'] = $this->language->get('text_add') .' '. $this->language->get('text_price');
		} else {
			$this->data['action'] = $this->html->getSecureURL('catalog/product_info/editPrice', '&product_id='.$product_id.'&product_price_id='.$this->request->get['product_price_id'] );
			$this->data['heading_title'] = $this->language->get('text_edit') .' '. $this->language->get('text_price');
		}
		
		$this->view->batchAssign( $this->data );
        $this->processTemplate('pages/catalog/product_price_form.tpl' );
	}
	
	private function _validatePriceForm() {

		$this->extensions->hk_ValidateData($this);

		if (!$this->error) { 
			return TRUE;
		} else {
			return FALSE;
		}
	}

}