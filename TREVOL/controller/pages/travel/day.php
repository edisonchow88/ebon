<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelDay extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Trip Day";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		//START: load model
		$this->loadModel('travel/trip');
		$this->loadModel('travel/status');
		$this->loadModel('travel/plan');
		$this->loadModel('travel/mode');
		$this->loadModel('travel/line');
		$this->loadModel('travel/day');
		$this->loadModel('account/user');
		$this->loadModel('resource/tag');
		//END
		
		$data = $this->model_travel_day->getDay();
		
		//START: set result
		foreach($data as $row) {
			$day_id = $row['day_id'];
			
			//NOTE: sequence is important
			$result[$day_id]['day_id'] = $row['day_id'];
			$result[$day_id]['line_id'] = $row['line_id'];
			$result[$day_id]['date'] = $row['date'];
			$result[$day_id]['name'] = $row['name'];
		}
		//END
		
		//START: set column
		
		/* [Template]
		$i = '';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = '';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		*/
		
		$i = 'day_id';
		$column[$i]['name'] = 'id';
		$column[$i]['title'] = 'Id';
		$column[$i]['type'] = 'numeric';
		$column[$i]['width'] = '';
		$column[$i]['order'] = 'desc';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'line_id';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Line';
		$column[$i]['type'] = 'numeric';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'date';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Date';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'name';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Name';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'commands';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = '';
		$column[$i]['align'] = 'right';
		$column[$i]['sortable'] = 'false';
		$column[$i]['searchable'] = 'false';
		//END
		
		//START: include modal
		$this->addChild('modal/travel/add_day', 'modal_add_day', 'modal/travel/add_day.tpl');
		$this->addChild('modal/travel/edit_day', 'modal_edit_day', 'modal/travel/edit_day.tpl');
		$this->addChild('modal/travel/delete_day', 'modal_delete_day', 'modal/travel/delete_day.tpl');
		//END
		
		$this->view->assign('column', $column);
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/travel/day.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

