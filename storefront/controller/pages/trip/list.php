<?php 
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripList extends AController {
	private $error = array();
	public $data = array();
	private $fields = array('trip_name','date_start');

	public function main() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);
		
		$this->document->setTitle($this->language->get('heading_title'));
		 
		$this->getList();
		
		//init controller data
		$this->extensions->hk_UpdateData($this, __FUNCTION__);
		unset($this->session->data['success']);
		unset($this->session->data['error']);

  	}
	
	public function getList() {
		$this->document->resetBreadcrumbs();

      	$this->document->addBreadcrumb( array ( 
        	'href'      => $this->html->getURL('index/home'),
        	'text'      => $this->language->get('text_home'),
        	'separator' => FALSE
      	 )); 

      	$this->document->addBreadcrumb( array ( 
        	'href'      => $this->html->getURL('trip/list'),
        	'text'      => $this->language->get('heading_title'),
        	'separator' => $this->language->get('text_separator')
      	 ));
		 
		$this->load->model('trip/trip', 'storefront');
		
		$trips = $this->model_trip_trip->getTrips();
		$this->data['trips'] = $trips;
			
		$total_trips = $this->model_trip_trip->getTotalTrips();
			
    	if ( $total_trips ) {
			$this->data['total_trips'] = $total_trips;
    	} else {            
            $this->data['heading_title'] = $this->language->get('heading_title');
            $this->data['text_error'] = $this->language->get('text_empty_list');
            $this->view->setTemplate( 'pages/error/not_found.tpl' );
    	}
		
		$this->view->assign('error_warning', $this->error['warning']);
		$this->view->assign('success', $this->session->data['success']);

		$this->view->batchAssign( $this->data);
		$this->view->assign( 'add', $this->html->getURL('trip/list/add') );
		$this->view->assign( 'view', $this->html->getURL('trip/itinerary&trip_id=') );
		$this->view->assign( 'edit', $this->html->getURL('trip/list/edit&trip_id=') );
		$this->view->assign( 'delete', $this->html->getURL('trip/list/delete&trip_id=') );
        $this->processTemplate('pages/trip/trip_list.tpl' );
	}
	
	public function add() {

        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

		$this->document->setTitle( $this->language->get('heading_title') );
		
		$this->load->model('trip/trip', 'storefront');

		if ( $this->request->is_POST() && $this->_validateForm() ) {
			$trip_data = $this->model_trip_trip->addTrip($this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_add');
			$this->session->data['trip_id'] = $trip_data['trip_id'];
			$this->session->data['day_id'] = $trip_data['day_id'];
			
			//redirect
			if ( $this->session->data['redirect'] ) {
				$redirect_url = $this->session->data['redirect'];
				unset($this->session->data['redirect']);
				$this->redirect($redirect_url);
			}
			else {
				$this->redirect( $this->html->getSecureURL('trip/list' ) );
			}
		}
		$this->_getForm();

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
	
	public function edit() {
		
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}

		$this->document->setTitle( $this->language->get('heading_title') );
		
		$this->load->model('trip/trip', 'storefront');

		if ( $this->request->is_POST() && $this->_validateForm() ) {
			$this->model_trip_trip->editTrip($this->request->get['trip_id'], $this->request->post);
			$this->session->data['success'] = $this->language->get('text_success_edit');
			$this->redirect( $this->html->getSecureURL('trip/list/edit', '&trip_id=' . $this->request->get['trip_id'] ) );
		}
		$this->_getForm();

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
	
	private function _getForm() {
		
		$this->data = array();
		$this->data['error'] = $this->error;
		$this->data['cancel'] = $this->html->getSecureURL('trip/list');

  		$this->document->initBreadcrumb( array (
       		'href'      => $this->html->getSecureURL('index/home'),
       		'text'      => $this->language->get('text_home'),
      		'separator' => FALSE
   		 ));
   		$this->document->addBreadcrumb( array ( 
       		'href'      => $this->html->getSecureURL('trip/list'),
       		'text'      => $this->language->get('heading_title'),
      		'separator' => ' :: '
   		 ));
		 
		$this->load->model('trip/trip', 'storefront');

		if (isset($this->request->get['trip_id']) && $this->request->is_GET() ) {
			$trip_info = $this->model_trip_trip->getTrip($this->request->get['trip_id']);
		}
		
		foreach ( $this->fields as $f ) {
			if (isset ( $this->request->post [$f] )) {
				$this->data [$f] = $this->request->post [$f];
			} elseif (isset($trip_info)) {
				$this->data[$f] = $trip_info[$f];
			} else {
				$this->data[$f] = '';
			}
		}

		if (!isset($this->request->get['trip_id'])) {
			$this->data['action'] = $this->html->getSecureURL('trip/list/add');
			$this->data['heading_title'] = $this->language->get('text_add') .' '. $this->language->get('text_trip');
			$this->data['edit'] = '';
			$form = new AForm();
			$input_form_value = date("Y-m-d");
		} else {
			$this->data['action'] = $this->html->getSecureURL('trip/list/edit', '&trip_id=' . $this->request->get['trip_id'] );
			$this->data['heading_title'] = $this->language->get('text_edit') .' '. $this->language->get('text_trip') . ' : ' . $this->data['trip_name'];
			$this->data['edit'] = $this->html->getSecureURL('listing_grid/trip/update_field','&id='.$this->request->get['trip_id']);
			$form = new AForm();
			$input_form_value = $this->data['date_start'];
		}
		
		$this->document->addBreadcrumb( array (
       		'href'      => $this->data['action'],
       		'text'      => $this->data['heading_title'],
      		'separator' => ' :: ',
			'current'	=> true
   		 ));

		$form->setForm(array(
		    'form_name' => 'cgFrm',
			'update' => $this->data['edit'],
	    ));

        $this->data['form']['id'] = 'cgFrm';
        $this->data['form']['form_open'] = $form->getFieldHtml(array(
		    'type' => 'form',
		    'name' => 'cgFrm',
		    'action' => $this->data['action'],
			'attr' => 'data-confirm-exit="true" class="aform form-horizontal"'
	    ));
        $this->data['form']['submit'] = $form->getFieldHtml(array(
		    'type' => 'button',
		    'name' => 'submit',
		    'text' => $this->language->get('button_add'),
		    'style' => 'button1',
	    ));
		$this->data['form']['cancel'] = $form->getFieldHtml(array(
		    'type' => 'button',
		    'name' => 'cancel',
		    'text' => $this->language->get('button_cancel'),
		    'style' => 'button2',
	    ));
		
		$this->data['form']['fields']['date_start'] = $form->getFieldHtml(array(
				    'type' => 'date',
				    'name' => 'date_start',
					'value' => $input_form_value,
			    ));
				
		//set default value
		if($this->data['trip_name']=='') { $this->data['trip_name'] = "Trip 1"; }
		
		foreach ( $this->fields as $f ) {
			if ( $f == 'date_start' ) break;
			$this->data['form']['fields'][$f] = $form->getFieldHtml(array(
				'type' => 'input',
				'name' => $f,
				'value' => $this->data[$f],
				'required' => ( !in_array($f, array('trip_name')) ? false: true),
			));
		}
		$this->view->batchAssign( $this->data );
        $this->processTemplate('pages/trip/trip_form.tpl' );
	}
	
	private function _validateForm() {

		$this->extensions->hk_ValidateData($this);

		if (!$this->error) { 
			return TRUE;
		} else {
			return FALSE;
		}
	}
	
	public function delete() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->load->model('trip/trip', 'storefront');

		if (isset($this->request->get['trip_id'])) {
			$this->model_trip_trip->deleteTrip($this->request->get['trip_id']);

			$this->session->data['success'] = $this->language->get('text_success_delete');
			unset($this->session->data['trip_id']);
			unset($this->session->data['day_id']);
			
			//redirect
			if ( $this->session->data['redirect'] ) {
				$redirect_url = $this->session->data['redirect'];
				unset($this->session->data['redirect']);
				$this->redirect($redirect_url);
			}
			else {
				$this->redirect($this->html->getSecureURL('trip/list'));
			}
		}

		$this->getList();

		//init controller data
		$this->extensions->hk_UpdateData($this, __FUNCTION__);
	}

}