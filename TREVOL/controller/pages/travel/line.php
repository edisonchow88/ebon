<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelLine extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Trip Line";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$this->loadModel('travel/trip');
		$this->loadModel('travel/status');
		$this->loadModel('travel/plan');
		$this->loadModel('travel/mode');
		$this->loadModel('travel/line');
		$this->loadModel('resource/tag');
		$this->loadModel('user/user');
		
		$data = $this->model_travel_line->getLine();
		
		foreach($data as $row) {
			$line_id = $row['line_id'];
			
			//following sequence is important
			$result[$line_id]['line_id'] = $row['line_id'];
			$result[$line_id]['plan_id'] = $row['plan_id'];
			$result[$line_id]['plan'] = json_encode($row['plan']);
			$result[$line_id]['tag'] = json_encode($row['tag']);
			$result[$line_id]['sort_order'] = $row['sort_order'];
		}
		
		//include modal
		$this->addChild('modal/travel/add_line', 'modal_add_line', 'modal/travel/add_line.tpl');
		$this->addChild('modal/travel/edit_line', 'modal_edit_line', 'modal/travel/edit_line.tpl');
		$this->addChild('modal/travel/delete_line', 'modal_delete_line', 'modal/travel/delete_line.tpl');
		
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/travel/line.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

