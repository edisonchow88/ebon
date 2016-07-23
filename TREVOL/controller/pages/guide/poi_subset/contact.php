<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuidePoiSubsetContact extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Poi Contact";
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
			$this->loadModel('resource/data');
			$this->loadModel('resource/tag');
			$this->loadModel('resource/image');
		//END
		
		//START: set id
			$poi_id = $_GET['poi_id'];
		//END
		
		//START: set data
			$data = $this->model_guide_poi->getPoiContactByPoiId($poi_id);
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$contact_id = $row['contact_id'];
					
					//NOTE: sequence is important
					$result[$contact_id]['contact_id'] = $row['contact_id'];
					$poi = $this->model_guide_poi->getPoi($row['poi_id']);
                    $result[$contact_id]['poi_id'] = $poi['name'];
					$contact = $this->model_resource_data->getDataByDatasetName('contact',$row['contact']);
					$result[$contact_id]['contact'] = json_encode($contact);
                    $result[$contact_id]['info'] = $row['info'];
				}
			}
		//END
		
		//START: set column
			/* [Template]
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
			
			$i = 'contact_id';
            $column[$i]['name'] = 'id';
            $column[$i]['title'] = 'Id';
            $column[$i]['type'] = 'numeric';
            $column[$i]['width'] = '';
            $column[$i]['order'] = '';
            $column[$i]['sortable'] = 'true';
            $column[$i]['searchable'] = 'true';
            
            $i = 'poi';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = 'asc';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'contact';
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
            
            $i = 'info';
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
		
		//START: set modal
			$this->addChild('modal/guide/poi/add_contact', 'modal_add_contact', 'modal/guide/poi/add_contact.tpl');
			$this->addChild('modal/guide/poi/edit_contact', 'modal_edit_contact', 'modal/guide/poi/edit_contact.tpl');
			$this->addChild('modal/guide/poi/delete_contact', 'modal_delete_contact', 'modal/guide/poi/delete_contact.tpl');
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
			$this->processTemplate('pages/guide/poi_subset/contact.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>