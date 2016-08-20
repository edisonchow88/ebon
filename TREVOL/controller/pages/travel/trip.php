<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelTrip extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Trip";
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
			$this->loadModel('account/user');
		//END
		
		//START: set data
			$data = $this->model_travel_trip->getTrip();
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$trip_id = $row['trip_id'];
			
					$plan = $this->model_travel_trip->getPlanByTripId($trip_id);
					
					//NOTE: sequence is important
					$result[$trip_id]['trip_id'] = $row['trip_id'];
					$result[$trip_id]['user_id'] = $row['user_id'];
					$result[$trip_id]['status'] = json_encode($row['status']);
					$result[$trip_id]['language'] = $row['language']['name'];
					$result[$trip_id]['name'] = $row['name'];
					$result[$trip_id]['description'] = $row['description'];
					$result[$trip_id]['plan'] = count($plan);
					unset($travel_date);
					foreach($plan as $p) {
						if($p['selected'] == 1) {
							$travel_date = $p['travel_date'];
						}
					}
					$result[$trip_id]['travel_date'] = $travel_date;
					$result[$trip_id]['date_added'] = $row['date_added'];
					$result[$trip_id]['date_modified'] = $row['date_modified'];
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
			
			$i = 'trip_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '80px';
			$column[$i]['order'] = '';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'user_id';
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
			
			$i = 'status';
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
			
			$i = 'langauge';
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
			
			$i = 'description';
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
			
			$i = 'plan';
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
			
			$i = 'travel_date';
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
			
			$i = 'date_added';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'date_modified';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			
			$i = 'commands';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = '';
			$column[$i]['width'] = '180px';
			$column[$i]['align'] = 'right';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
		//END
		
		//START: set component
			$this->loadComponent('database/table');
			$object = 'trip';
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
			//START: [link]
				$link['child'] = $this->html->getSecureURL('travel/plan');
			//END
			$component['table'] = $this->component_database_table->writeTable($object,$table,$action,$related,$grid,$link);
		//END
		
		//START: set modal
			if($action['review'] == true) {
				$this->addChild('modal/travel/trip/review_trip', 'modal_review_trip', 'modal/travel/trip/review_trip.tpl');
			}
			if($action['add'] == true) {
				$this->addChild('modal/travel/trip/add_trip', 'modal_add_trip', 'modal/travel/trip/add_trip.tpl');
			}
			if($action['edit'] == true) {
				$this->addChild('modal/travel/trip/edit_trip', 'modal_edit_trip', 'modal/travel/trip/edit_trip.tpl');
			}
			if($action['delete'] == true) {
				$this->addChild('modal/travel/trip/delete_trip', 'modal_delete_trip', 'modal/travel/trip/delete_trip.tpl');
			}
		//END
		
		//START: set variable
			$this->view->assign('component', $component);
		//END
		
		//START: set template
			$this->processTemplate('pages/travel/trip.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

