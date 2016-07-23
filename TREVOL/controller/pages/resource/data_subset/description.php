<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerPagesResourceDataSubsetDescription extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
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
		
		//START: set id
			$dataset_id = $_GET['dataset_id'];
			$data_id = $_GET['data_id'];
		//END
		
		//START: set model
			$this->loadModel('resource/data');
		//END
		
		//START: set data
			$data = $this->model_resource_data->getDataDescription('',$data_id);
			$dataset = $this->model_resource_data->getDataset($dataset_id);
		//END
		
    	//START: set title
			$title = $dataset['name']." Description";
			$this->document->setTitle($title);
		//END
			
		//START: set result
			if(count($data) > 0) {
				foreach($data as $row) {
					$description_id = $row['description_id'];
					
					//NOTE: sequence is important
					$result[$description_id]['description_id'] = $row['description_id'];
					$result[$description_id]['data_id'] = $row['data_id'];
					$language = $this->language->getLanguageDetailsByID($row['language_id']);
                    $result[$description_id]['language'] = $language['name'];
					$result[$description_id]['description'] = $row['description'];
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
			
			//NOTE: sequence is important
			
			$i = 'description_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '60px';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'data_id';
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
			
			$i = 'language_id';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Language';
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
			$this->addChild('modal/resource/data/add_description', 'modal_add_description', 'modal/resource/data/add_description.tpl');
			$this->addChild('modal/resource/data/edit_description', 'modal_edit_description', 'modal/resource/data/edit_description.tpl');
			$this->addChild('modal/resource/data/delete_description', 'modal_delete_description', 'modal/resource/data/delete_description.tpl');
		//END
		
		//START: set link
			$link['resource/data'] = $this->html->getSecureURL('resource/data','&dataset_id='.$dataset_id);
		//END
		
		//START: set variable
			$this->view->assign('title', $title);
			if(count($column) > 0) { $this->view->assign('column', $column); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
		//END
		
		//START: set template
			$this->processTemplate('pages/resource/data_subset/description.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

