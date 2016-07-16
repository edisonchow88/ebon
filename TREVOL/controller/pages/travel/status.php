<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelStatus extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Trip Status";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$this->loadModel('travel/status');
		
		$data = $this->model_travel_status->getStatus();
		
		foreach($data as $row) {
			$status_id = $row['status_id'];
			
			//following sequence is important
			$result[$status_id]['status_id'] = $row['status_id'];
			$result[$status_id]['color'] = $row['color'];
			$result[$status_id]['name'] = $row['name'];
			$result[$status_id]['sort_order'] = $row['sort_order'];
			$result[$status_id]['priority'] = $row['priority'];
		}
		
		//include modal
		$this->addChild('modal/travel/add_status', 'modal_add_status', 'modal/travel/add_status.tpl');
		$this->addChild('modal/travel/edit_status', 'modal_edit_status', 'modal/travel/edit_status.tpl');
		$this->addChild('modal/travel/delete_status', 'modal_delete_status', 'modal/travel/delete_status.tpl');
		
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/travel/status.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

