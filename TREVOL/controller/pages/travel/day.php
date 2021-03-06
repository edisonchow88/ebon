<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelDay extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Day";
			$this->document->setTitle($title);
		//END
		
		//START: set alert
			$this->view->assign('error_warning', $this->session->data['warning']);
			if (isset($this->session->data['warning'])) {
				unset($this->session->data['warning']);
			}
			$this->view->assign('success', $this->session->data['success']);
			if (isset($this->session->data['success'])) {
				unset($this->session->data['success']);
			}
		//END
		
		//START: set model
			$this->loadModel('travel/trip');
		//END
		
		//START: set parent id
			if(isset($_GET['plan_id'])) { $plan_id = $_GET['plan_id']; }
		//END
		
		//START: set data
			$data = $this->model_travel_trip->getDay('',$plan_id);
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$day_id = $row['day_id'];
			
					//following sequence is important
					$result[$day_id]['day_id'] = $row['day_id'];
					$plan = $this->model_travel_trip->getPlan($row['plan_id']);
					$result[$day_id]['plan'] = $plan['name'];
					$result[$day_id]['sort_order'] = $row['sort_order'];
					$line = $this->model_travel_trip->getLineByDayId($day_id);
					$result[$day_id]['line'] = count($line);
				}
			}
		//END
		
		//START: set column
			/* [SAMPLE]
			$i = '';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
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
			$column[$i]['width'] = '80px';
			$column[$i]['order'] = '';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'plan';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'sort_order';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'line';
			$column[$i]['name'] = 'child';
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'commands';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = 'right';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
		//END
		
		//START: set component
			$this->loadComponent('database/table');
			$object = 'day';
			$table['column'] = $column;
			$table['row'] = $result;
			//START: [action]
				$action['review'] = true;
				$action['add'] = true;
				$action['edit'] = true;
				$action['delete'] = true;
			//END
			//START: [related]
				$related = array();
				$i = 'trip';
				$related[$i]['title'] = $i;
				$related[$i]['url'] = $this->html->getSecureURL('travel/'.$i);
				$i = 'plan';
				$related[$i]['title'] = $i;
				$related[$i]['url'] = $this->html->getSecureURL('travel/'.$i);
				$i = 'day';
				$related[$i]['title'] = $i;
				$related[$i]['url'] = $this->html->getSecureURL('travel/'.$i);
				$i = 'line';
				$related[$i]['title'] = $i;
				$related[$i]['url'] = $this->html->getSecureURL('travel/'.$i);
				$i = '1';
				$related[$i]['divider'] = $i;
				$i = 'photo';
				$related[$i]['title'] = $i;
				$related[$i]['url'] = $this->html->getSecureURL('travel/'.$i);
				$i = '2';
				$related[$i]['divider'] = $i;
				$i = 'status';
				$related[$i]['title'] = $i;
				$related[$i]['url'] = $this->html->getSecureURL('travel/'.$i);
				$i = 'mode';
				$related[$i]['title'] = $i;
				$related[$i]['url'] = $this->html->getSecureURL('travel/'.$i);
			//END
			//START: [setting]
				$grid['setting']['caseSensitive'] = 'false';
				$grid['setting']['rowCount'] = -1;
				$grid['setting']['columnSelection'] = 'false';
				$grid['setting']['multiSort'] = 'false';
			//END
			//START: [link]
				$link['child'] = $this->html->getSecureURL('travel/line');
			//END
			$component['table'] = $this->component_database_table->writeTable($object,$table,$action,$related,$grid,$link);
		//END
		
		//START: set modal
			if($action['review'] == true) {
				$this->addChild('modal/travel/day/review_day', 'modal_review_day', 'modal/travel/day/review_day.tpl');
			}
			if($action['add'] == true) {
				$this->addChild('modal/travel/day/add_day', 'modal_add_day', 'modal/travel/day/add_day.tpl');
			}
			if($action['edit'] == true) {
				$this->addChild('modal/travel/day/edit_day', 'modal_edit_day', 'modal/travel/day/edit_day.tpl');
			}
			if($action['delete'] == true) {
				$this->addChild('modal/travel/day/delete_day', 'modal_delete_day', 'modal/travel/day/delete_day.tpl');
			}
		//END
		
		//START: set variable
			$this->view->assign('component', $component);
		//END
		
		//START: set template
			$this->processTemplate('pages/travel/day.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>





