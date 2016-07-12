<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuidePoi extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Poi";
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
		$this->loadModel('guide/poi');
		$this->loadModel('resource/tag');
		$this->loadModel('resource/image');
		//END
		
		$data = $this->model_guide_poi->getPoi();
		
		//START: set result
		foreach($data as $row) {
			$poi_id = $row['poi_id'];
			
			//NOTE: sequence is important
			$result[$poi_id]['poi_id'] = $row['poi_id'];
			$result[$poi_id]['image'] = json_encode($row['image']);
			$result[$poi_id]['name'] = $row['name'];
			$result[$poi_id]['tag'] = json_encode($row['tag']);
			$result[$poi_id]['blurb'] = $row['blurb'];
			$result[$poi_id]['description'] = $row['description'];
			$result[$poi_id]['lat'] = $row['lat'];
			$result[$poi_id]['lng'] = $row['lng'];
			$result[$poi_id]['status'] = $row['status'];
			$result[$poi_id]['date_added'] = $row['date_added'];
			$result[$poi_id]['date_modified'] = $row['date_modified'];
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
		
		$i = 'poi_id';
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
		$column[$i]['width'] = '720px';
		$column[$i]['align'] = 'right';
		$column[$i]['sortable'] = 'false';
		$column[$i]['searchable'] = 'false';
		//END
		
		//START: include modal
		$this->addChild('modal/guide/add_poi', 'modal_add_poi', 'modal/guide/add_poi.tpl');
		//$this->addChild('modal/guide/edit_poi', 'modal_edit_poi', 'modal/guide/edit_poi.tpl');
		//$this->addChild('modal/guide/delete_poi', 'modal_delete_poi', 'modal/guide/delete_poi.tpl');
		//$this->addChild('modal/guide/view_poi_summary', 'modal_view_poi_summary', 'modal/guide/view_poi_summary.tpl');
		//END
		
		$this->view->assign('column', $column);
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/guide/poi.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>
