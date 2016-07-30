<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerPagesResourceData extends AController {

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
		//END
		
		//START: set model
			$this->loadModel('resource/data');
		//END
		
		//START: set dataset
			$dataset = $this->model_resource_data->getDataset($dataset_id);
		//END

    	//START: set title
			$title = $dataset['name'];
			$this->document->setTitle($title);
		//END
		
		//START: set data
			$data = $this->model_resource_data->getDataByDatasetId($dataset_id);
		//END
			
		//START: set result
			if(count($data) > 0) {
				foreach($data as $row) {
					$data_id = $row['data_id'];
					
					//NOTE: sequence is important
					$result[$data_id]['data_id'] = $row['data_id'];
					$result[$data_id]['dataset_id'] = $row['dataset_id'];
					$result[$data_id]['icon'] = $row['icon'];
					$result[$data_id]['label'] = json_encode($row['label']);
					$result[$data_id]['value'] = $row['value'];
					$result[$data_id]['name'] = $row['name'];
					$result[$data_id]['description'] = $row['description'];
					$result[$data_id]['sort_order'] = $row['sort_order'];
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
			
			$i = 'data_id';
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
			
			$i = 'dataset_id';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
			
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
			
			$i = 'label';
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
			
			$i = 'value';
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
			
			$i = 'name';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
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
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'true';
			
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
			$this->addChild('modal/resource/add_data', 'modal_add_data', 'modal/resource/add_data.tpl');
			$this->addChild('modal/resource/edit_data', 'modal_edit_data', 'modal/resource/edit_data.tpl');
			$this->addChild('modal/resource/delete_data', 'modal_delete_data', 'modal/resource/delete_data.tpl');
		//END
		
		//START: set link
			$link['resource/dataset'] = $this->html->getSecureURL('resource/dataset');
			$link['resource/data_subset/alias'] = $this->html->getSecureURL('resource/data_subset/alias');
			$link['resource/data_subset/description'] = $this->html->getSecureURL('resource/data_subset/description');
		//END
		
		//START: set variable
			$this->view->assign('title', $title);
			if(count($column) > 0) { $this->view->assign('column', $column); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
		//END
		
		//START: set template
			$this->processTemplate('pages/resource/data.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

