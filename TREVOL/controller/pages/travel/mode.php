<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelMode extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Mode";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$this->loadModel('travel/mode');
		
		$data = $this->model_travel_mode->getMode();
		
		foreach($data as $row) {
			$mode_id = $row['mode_id'];
			
			//following sequence is important
			$result[$mode_id]['mode_id'] = $row['mode_id'];
			$result[$mode_id]['icon'] = $row['icon'];
			$result[$mode_id]['name'] = $row['name'];
		}
		
		//include modal
		$this->addChild('modal/travel/add_mode', 'modal_add_mode', 'modal/travel/add_mode.tpl');
		$this->addChild('modal/travel/edit_mode', 'modal_edit_mode', 'modal/travel/edit_mode.tpl');
		$this->addChild('modal/travel/delete_mode', 'modal_delete_mode', 'modal/travel/delete_mode.tpl');
		
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/travel/mode.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

