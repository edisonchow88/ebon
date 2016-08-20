<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelMode extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Mode";
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
			$this->loadModel('travel/trip');		//END
		
		//START: set data
			$data = $this->model_travel_trip->getMode();
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$mode_id = $row['mode_id'];
			
					//following sequence is important
					$result[$mode_id]['mode_id'] = $row['mode_id'];
					$result[$mode_id]['icon'] = $row['icon'];
					$result[$mode_id]['name'] = $row['name'];
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
			
			$i = 'mode_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '80px';
			$column[$i]['order'] = '';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'icon';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
			
			$i = 'name';
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
			$object = 'mode';
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
				$i = '';
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
			$component['table'] = $this->component_database_table->writeTable($object,$table,$action,$related,$grid);
		//END
		
		//START: set modal
			if($action['review'] == true) {
				$this->addChild('modal/travel/mode/review_mode', 'modal_review_mode', 'modal/travel/mode/review_mode.tpl');
			}
			if($action['add'] == true) {
				$this->addChild('modal/travel/mode/add_mode', 'modal_add_mode', 'modal/travel/mode/add_mode.tpl');
			}
			if($action['edit'] == true) {
				$this->addChild('modal/travel/mode/edit_mode', 'modal_edit_mode', 'modal/travel/mode/edit_mode.tpl');
			}
			if($action['delete'] == true) {
				$this->addChild('modal/travel/mode/delete_mode', 'modal_delete_mode', 'modal/travel/mode/delete_mode.tpl');
			}
		//END
		
		//START: set variable
			$this->view->assign('component', $component);
		//END
		
		//START: set template
			$this->processTemplate('pages/travel/mode.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>





