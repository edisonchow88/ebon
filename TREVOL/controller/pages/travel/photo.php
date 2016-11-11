<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTravelPhoto extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Photo";
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
		
		//START: set data
			$data = $this->model_travel_trip->getTripPhoto();
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$trip_photo_id = $row['trip_photo_id'];
			
					//following sequence is important
					$result[$trip_photo_id]['trip_photo_id'] = $row['trip_photo_id'];
					$result[$trip_photo_id]['trip_id'] = $row['trip_id'];
					$result[$trip_photo_id]['photo_id'] = $row['photo_id'];
					$result[$trip_photo_id]['sort_order'] = $row['sort_order'];
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
			
			$i = 'trip_photo_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '80px';
			$column[$i]['order'] = '';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'trip_id';
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
			
			$i = 'photo_id';
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
			$object = 'photo';
			$table['column'] = $column;
			$table['row'] = $result;
			//START: [action]
				$action['review'] = false;
				$action['add'] = false;
				$action['edit'] = false;
				$action['delete'] = false;
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
			$component['table'] = $this->component_database_table->writeTable($object,$table,$action,$related,$grid);
		//END
		
		//START: set modal
			if($action['review'] == true) {
				$this->addChild('modal/travel/photo/review_photo', 'modal_review_photo', 'modal/travel/photo/review_photo.tpl');
			}
			if($action['add'] == true) {
				$this->addChild('modal/travel/photo/add_photo', 'modal_add_photo', 'modal/travel/photo/add_photo.tpl');
			}
			if($action['edit'] == true) {
				$this->addChild('modal/travel/photo/edit_photo', 'modal_edit_photo', 'modal/travel/photo/edit_photo.tpl');
			}
			if($action['delete'] == true) {
				$this->addChild('modal/travel/photo/delete_photo', 'modal_delete_photo', 'modal/travel/photo/delete_photo.tpl');
			}
		//END
		
		//START: set variable
			$this->view->assign('component', $component);
		//END
		
		//START: set template
			$this->processTemplate('pages/travel/photo.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>



