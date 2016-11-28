<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelSample extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Sample";
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
					$row['url'] = $this->html->removeQueryVar($this->html->getURL('trip/view','&trip='.$row['code']), 's');
					$sample_exist = $this->model_travel_trip->getSampleExist($trip_id);
					//NOTE: sequence is important
					$result[$trip_id]['trip_id'] = $row['trip_id'];
					$result[$trip_id]['code'] = $row['code'];
					$result[$trip_id]['language'] = $row['language']['name'];
					$result[$trip_id]['name'] = $row['name'];
					$result[$trip_id]['description'] = $row['description'];
					$result[$trip_id]['url'] = $row['url'];
					if ($sample_exist) {
						$result[$trip_id]['sample'] = "1";
						$result[$trip_id]['id'] = $sample_exist['sample_id'];						
					}else {
						$result[$trip_id]['sample'] = "0";
						$result[$trip_id]['id'] = "-";
					}
					$result[$trip_id]['ranking'] = $sample_exist['ranking'];
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
			$column[$i]['name'] = 'trip_id';
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '80px';
			$column[$i]['order'] = '';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';

			$i = 'code';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'true';
		
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
						
			$i = 'View';
			$column[$i]['name'] = 'url';
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'sample';
			$column[$i]['name'] = 'exist';
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'sample_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'ranking';
			$column[$i]['name'] = 'sample_ranking';
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
						
			$i = 'sample_commands';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = '';
			$column[$i]['width'] = '200px';
			$column[$i]['align'] = 'right';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
		//END
		
		//START: set component
			$this->loadComponent('database/table');
			$object = 'sample';
			$table['column'] = $column;
			$table['row'] = $result;
			//START: [action]
				$action['review'] = true;
				$action['add'] = false;
				$action['edit'] = true;
				$action['delete'] = true;
				$action['custom_add'] = true;
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
				$this->addChild('modal/travel/sample/review_sample', 'modal_review_sample', 'modal/travel/sample/review_sample.tpl');
			}
			if($action['add'] == true) {
				$this->addChild('modal/travel/sample/add_sample', 'modal_add_sample', 'modal/travel/sample/add_sample.tpl');
			}
			if($action['edit'] == true) {
				$this->addChild('modal/travel/sample/edit_sample', 'modal_edit_sample', 'modal/travel/sample/edit_sample.tpl');
			}
			if($action['delete'] == true) {
				$this->addChild('modal/travel/sample/delete_sample', 'modal_delete_sample', 'modal/travel/sample/delete_sample.tpl');
			}
			if($action['custom_add'] == true) {
				$this->addChild('modal/travel/sample/add_sample', 'modal_add_sample', 'modal/travel/sample/add_sample.tpl');
			}
			
		//END
		
		//START: set variable
			$this->view->assign('component', $component);
		//END
		
		//START: set template
			$this->processTemplate('pages/travel/sample.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

