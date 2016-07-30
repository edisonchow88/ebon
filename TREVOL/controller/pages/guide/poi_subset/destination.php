<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuidePoiSubsetDestination extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Poi Destination";
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
			$this->loadModel('guide/poi');
			$this->loadModel('guide/destination');
			$this->loadModel('resource/tag');
			$this->loadModel('resource/image');
		//END
		
		//START: set id
			$poi_id = $_GET['poi_id'];
		//END
		
		//START: set data
			$data = $this->model_guide_poi->getPoiDestinationByPoiId($poi_id);
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$relation_id = $row['relation_id'];
					
					//NOTE: sequence is important
					$result[$relation_id]['relation_id'] = $row['relation_id'];
					$poi = $this->model_guide_poi->getPoi($row['poi_id']);
					$result[$relation_id]['poi'] = $poi['name'];
					$destination = $this->model_guide_destination->getDestinationSpecialTagByDestinationId($row['destination_id']);
					$result[$relation_id]['destination'] = json_encode($destination);
					$result[$relation_id]['sort_order'] = $row['sort_order'];
				}
			}
		//END
		
		//START: set column
			/* [Template]
			$i = '';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",str_replace("g_","",$i)));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			*/
			
			$i = 'relation_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '80px';
			$column[$i]['order'] = '';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'poi';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",str_replace("g_","",$i)));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = 'asc';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'destination';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",str_replace("g_","",$i)));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'sort_order';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Sort';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = 'desc';
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
		
		//START: set modal
			$this->addChild('modal/guide/poi/add_destination', 'modal_add_destination', 'modal/guide/poi/add_destination.tpl');
			$this->addChild('modal/guide/poi/edit_destination', 'modal_edit_destination', 'modal/guide/poi/edit_destination.tpl');
			$this->addChild('modal/guide/poi/delete_destination', 'modal_delete_destination', 'modal/guide/poi/delete_destination.tpl');
		//END
		
		//START: set link
			$link['guide/poi'] = $this->html->getSecureURL('guide/poi');
		//END
		
		//START: set variable
			if(count($column) > 0) { $this->view->assign('column', $column); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
		//END
		
		//START: set template
			$this->processTemplate('pages/guide/poi_subset/destination.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>