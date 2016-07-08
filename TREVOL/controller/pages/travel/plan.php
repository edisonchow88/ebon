<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelPlan extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Trip Plan";
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
		$this->loadModel('travel/transport');
		$this->loadModel('travel/plan');
		$this->loadModel('user/user');
		
		$data = $this->model_travel_plan->getPlan();
		
		foreach($data as $row) {
			$plan_id = $row['plan_id'];
			
			//following sequence is important
			$result[$plan_id]['plan_id'] = $row['plan_id'];
			$result[$plan_id]['trip_id'] = $row['trip_id'];
			$result[$plan_id]['trip'] = $row['trip']['name'];
			$result[$plan_id]['name'] = $row['name'];
			$result[$plan_id]['transport'] = json_encode($row['transport']);
			$result[$plan_id]['sort_order'] = $row['sort_order'];
			$result[$plan_id]['travel_date'] = $row['travel_date'];
			$result[$plan_id]['date_added'] = $row['date_added'];
			$result[$plan_id]['date_modified'] = $row['date_modified'];
		}
		
		//include modal
		$this->addChild('modal/travel/add_plan', 'modal_add_plan', 'modal/travel/add_plan.tpl');
		$this->addChild('modal/travel/edit_plan', 'modal_edit_plan', 'modal/travel/edit_plan.tpl');
		$this->addChild('modal/travel/delete_plan', 'modal_delete_plan', 'modal/travel/delete_plan.tpl');
		
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/travel/plan.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

