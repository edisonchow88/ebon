<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelActivity extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Trip Activity";
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
		$this->loadModel('travel/activity');
		$this->loadModel('user/user');
		$this->loadModel('resource/tag');
		$this->loadModel('resource/image');
		//END
		
		$data = $this->model_travel_activity->getActivity();
		
		//START: set result
		foreach($data as $row) {
			$activity_id = $row['activity_id'];
			
			//NOTE: sequence is important
			$result[$activity_id]['activity_id'] = $row['activity_id'];
			$result[$activity_id]['line'] = json_encode($row['line']);
			$result[$activity_id]['day'] = json_encode($row['day']);
			$result[$activity_id]['time'] = $row['time'];
			$result[$activity_id]['duration'] = $row['duration'];
			$result[$activity_id]['name'] = $row['name'];
			$result[$activity_id]['description'] = $row['description'];
			$result[$activity_id]['tag'] = json_encode($row['tag']);
			$result[$activity_id]['poi'] = json_encode($row['poi']);
			$result[$activity_id]['path'] = json_encode($row['path']);
			$result[$activity_id]['image'] = json_encode($row['image']);
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
		
		$i = 'activity_id';
		$column[$i]['name'] = 'id';
		$column[$i]['title'] = 'Id';
		$column[$i]['type'] = 'numeric';
		$column[$i]['width'] = '';
		$column[$i]['order'] = 'desc';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'line';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Line';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'day';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Day';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'time';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Time';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'duration';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Duration';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'name';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Name';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'description';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Description';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'tag';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Tag';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'poi';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Poi';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'path';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Path';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
		$column[$i]['sortable'] = 'true';
		$column[$i]['searchable'] = 'true';
		
		$i = 'image';
		$column[$i]['name'] = $i;
		$column[$i]['title'] = 'Image';
		$column[$i]['type'] = '';
		$column[$i]['width'] = '';
		$column[$i]['order'] = '';
		$column[$i]['align'] = '';
		$column[$i]['headerAlign'] = '';
		$column[$i]['visible'] = 'true';
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
		$this->addChild('modal/travel/add_activity', 'modal_add_activity', 'modal/travel/add_activity.tpl');
		$this->addChild('modal/travel/edit_activity', 'modal_edit_activity', 'modal/travel/edit_activity.tpl');
		$this->addChild('modal/travel/delete_activity', 'modal_delete_activity', 'modal/travel/delete_activity.tpl');
		//END
		
		$this->view->assign('column', $column);
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/travel/activity.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

