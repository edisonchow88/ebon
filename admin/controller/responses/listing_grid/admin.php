<?php
/*------------------------------------------------------------------------------
TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}
class ControllerResponsesListingGridAdmin extends AController {
	private $error = array();

    public function main() {

	    //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

        $this->loadLanguage('user/admin');
	    $this->loadModel('user/admin');
    	$roles = array('' => $this->language->get('text_select_group'),);
		$results = $this->model_user_admin->getRoles();
		foreach ($results as $r) {
			$roles[ $r['role_id'] ] = $r['name'];
		}

		//Prepare filter config
		$filter_params = array('status', 'role_id');
 		$grid_filter_params = array( 'username' );
 		//Build query string based on GET params first 
		$filter_form = new AFilter( array( 'method' => 'get', 'filter_params' => $filter_params ) );  
		//Build final filter
	    $filter_grid = new AFilter( array( 'method' => 'post', 
	    								   'grid_filter_params' => $grid_filter_params,
	    								   'additional_filter_string' => $filter_form->getFilterString()
	    								  ) );   	    
		$total = $this->model_user_admin->getTotalAdmins( $filter_grid->getFilterData() );
	    $response = new stdClass();
		$response->page = $filter_grid->getParam('page');
		$response->total = $filter_grid->calcTotalPages( $total );
		$response->records = $total;
	    $results = $this->model_user_admin->getAdmins( $filter_grid->getFilterData() );

	    $i = 0;
		foreach ($results as $result) {

            $response->rows[$i]['id'] = $result['admin_id'];
			$response->rows[$i]['cell'] = array(
				$result['username'],
				$roles[$result['role_id']],
				$this->html->buildCheckbox(array(
                    'name'  => 'status['.$result['admin_id'].']',
                    'value' => $result['status'],
                    'style'  => 'btn_switch',
                )),
				dateISO2Display($result['date_added'], $this->language->get('date_format_short'))
			);
			$i++;
		}

		//update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);

		$this->load->library('json');
		$this->response->setOutput(AJson::encode($response));
	}

	public function update() {

		//init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

		if (!$this->admin->canModify('listing_grid/admin')) {
			        $error = new AError('');
			        return $error->toJSONResponse('NO_PERMISSIONS_402',
			                                      array( 'error_text' => sprintf($this->language->get('error_permission_modify'), 'listing_grid/admin'),
			                                             'reset_value' => true
			                                           ) );
		}

		$this->loadModel('user/admin');
        $this->loadLanguage('user/admin');

		switch ($this->request->post['oper']) {
			case 'del':
				$ids = explode(',', $this->request->post['id']);
				if ( !empty($ids) )
				foreach( $ids as $id ) {
					if ($this->admin->getId() == $id) {
						$this->response->setOutput( $this->language->get('error_account'));
						return null;
					}
					$this->model_user_admin->deleteAdmin($id);
				}
				break;
			case 'save':
				$ids = explode(',', $this->request->post['id']);
				if ( !empty($ids) )
				foreach( $ids as $id ) {
					$this->model_user_admin->editAdmin($id, array('status' => isset($this->request->post['status'][$id]) ? $this->request->post['status'][$id] : 0 ) );
				}

				break;

			default:


		}

		//update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}

    /**
     * update only one field
     *
     * @return void
     */
    public function update_field() {

		//init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

	    if (!$this->admin->canModify('listing_grid/admin')) {
	  			        $error = new AError('');
	  			        return $error->toJSONResponse('NO_PERMISSIONS_402',
	  			                                      array( 'error_text' => sprintf($this->language->get('error_permission_modify'), 'listing_grid/admin'),
	  			                                             'reset_value' => true
	  			                                           ) );
	  	}

        $this->loadLanguage('user/admin');
        $this->loadModel('user/admin');
		if ( isset( $this->request->get['id'] ) ) {
		    //request sent from edit form. ID in url
		    foreach ($this->request->post as $key => $value ) {
				$data = array( $key => $value );
				$this->model_user_admin->editAdmin($this->request->get['id'], $data);
			}
		    return null;
	    }

	    //request sent from jGrid. ID is key of array
        foreach ($this->request->post as $field => $value ) {
            foreach ( $value as $k => $v ) {
				$this->model_user_admin->editAdmin($k, array($field => $v) );
            }
        }

		//update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}

}
