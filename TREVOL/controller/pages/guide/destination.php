<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerPagesGuideDestination extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END

    	//START: set title
			$title = "Destination";
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
			$this->loadModel('guide/destination');
			$this->loadModel('resource/tag');
			$this->loadModel('resource/image');
		//END
		
		//START: set data
			$data = $this->model_guide_destination->getDestination();
		//END
		
		//START: set result
			foreach($data as $row) {
				$destination_id = $row['destination_id'];
				
				//NOTE: sequence is important
				$result[$destination_id]['destination_id'] = $row['destination_id'];
				$result[$destination_id]['image'] = json_encode($row['image']);
				$result[$destination_id]['name'] = $row['name'];
				$result[$destination_id]['tag'] = json_encode($row['tag']);
				$result[$destination_id]['blurb'] = $row['blurb'];
				$result[$destination_id]['description'] = $row['description'];
				$result[$destination_id]['lat'] = $row['lat'];
				$result[$destination_id]['lng'] = $row['lng'];
				$result[$destination_id]['status'] = $row['status'];
				$result[$destination_id]['date_added'] = $row['date_added'];
				$result[$destination_id]['date_modified'] = $row['date_modified'];
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
			
			//NOTE: sequence is important
			
			$i = 'destination_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '';
			$column[$i]['order'] = 'desc';
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
			
			$i = 'name';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Name';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '200px';
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
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'blurb';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Blurb';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
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
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'lat';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Lat';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'lng';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Lng';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'row_status';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Status';
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
			$column[$i]['title'] = 'Added';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'date_modified';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Modified';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'commands';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = '';
			$column[$i]['width'] = '730px';
			$column[$i]['align'] = 'right';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
		//END
		
		//START: set modal
			$this->addChild('modal/guide/add_destination', 'modal_add_destination', 'modal/guide/add_destination.tpl');
			$this->addChild('modal/guide/edit_destination', 'modal_edit_destination', 'modal/guide/edit_destination.tpl');
			$this->addChild('modal/guide/delete_destination', 'modal_delete_destination', 'modal/guide/delete_destination.tpl');
			$this->addChild('modal/guide/toggle_destination_status', 'modal_toggle_destination_status', 'modal/guide/toggle_destination_status.tpl');
			//$this->addChild('modal/guide/view_destination_summary', 'modal_view_destination_summary', 'modal/guide/view_destination_summary.tpl');
		//END
		
		//START: set link
			$link['guide/destination_subset/alias'] = $this->html->getSecureURL('guide/destination_subset/alias');
			$link['guide/destination_subset/description'] = $this->html->getSecureURL('guide/destination_subset/description');
			$link['guide/destination_subset/image'] = $this->html->getSecureURL('guide/destination_subset/image');
			$link['guide/destination_subset/tag'] = $this->html->getSecureURL('guide/destination_subset/tag');
			$link['guide/destination_subset/relation'] = $this->html->getSecureURL('guide/destination_subset/relation');
			$link['guide/destination_subset/google'] = $this->html->getSecureURL('guide/destination_subset/google');
			$link['guide/destination_subset/wikipedia'] = $this->html->getSecureURL('guide/destination_subset/wikipedia');
		//END
		
		//START: set variable
			$this->view->assign('column', $column);
			$this->view->assign('link', $link);
			$this->view->assign('result', $result);
		//END
		
		//START: set template
			$this->processTemplate('pages/guide/destination.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

