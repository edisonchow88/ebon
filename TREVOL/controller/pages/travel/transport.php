<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelTransport extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Transport";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$this->loadModel('travel/transport');
		
		$data = $this->model_travel_transport->getTransport();
		
		foreach($data as $row) {
			$transport_id = $row['transport_id'];
			
			//following sequence is important
			$result[$transport_id]['transport_id'] = $row['transport_id'];
			$result[$transport_id]['icon'] = $row['icon'];
			$result[$transport_id]['name'] = $row['name'];
		}
		
		//include modal
		$this->addChild('modal/travel/add_transport', 'modal_add_transport', 'modal/travel/add_transport.tpl');
		$this->addChild('modal/travel/edit_transport', 'modal_edit_transport', 'modal/travel/edit_transport.tpl');
		$this->addChild('modal/travel/delete_transport', 'modal_delete_transport', 'modal/travel/delete_transport.tpl');
		
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/travel/transport.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

