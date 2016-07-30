<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerPagesResourceDataset extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END

    	//START: set title
			$title = "Dataset";
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
			$this->loadModel('resource/data');
		//END
		
		//START: set data
			$data = $this->model_resource_data->getDataset();
		//END
			
		//START: set result
			$link['resource/data'] = $this->html->getSecureURL('resource/data');
			
			if(count($data) > 0) {
				foreach($data as $row) {
					$dataset_id = $row['dataset_id'];
					
					//NOTE: sequence is important
					$result[$dataset_id]['dataset_id'] = $row['dataset_id'];
					$result[$dataset_id]['category'] = $row['category'];
					$result[$dataset_id]['name'] = $row['name'];
					$result[$dataset_id]['icon_color'] = $row['icon_color'];
					$result[$dataset_id]['label_color'] = $row['label_color'];
					$result[$dataset_id]['font_color'] = $row['font_color'];
					$result[$dataset_id]['link'] = $link['resource/data'].'&dataset_id='.$row['dataset_id'];
					$d = $this->model_resource_data->getData('',$row['dataset_id']);
					$result[$dataset_id]['count'] = count($d);
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
			
			$i = 'dataset_id';
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
			
			$i = 'category';
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
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'icon_color';
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
			
			$i = 'label_color';
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
			
			$i = 'font_color';
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
			
			$i = 'link';
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
			
			$i = 'count';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Count';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
			
			$i = 'sample';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = '';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'false';
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
			$this->addChild('modal/resource/add_dataset', 'modal_add_dataset', 'modal/resource/add_dataset.tpl');
			$this->addChild('modal/resource/edit_dataset', 'modal_edit_dataset', 'modal/resource/edit_dataset.tpl');
			$this->addChild('modal/resource/delete_dataset', 'modal_delete_dataset', 'modal/resource/delete_dataset.tpl');
		//END
		
		//START: set link
			$link['resource/data'] = $this->html->getSecureURL('resource/data');
		//END
		
		//START: set variable
			if(count($column) > 0) { $this->view->assign('column', $column); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
		//END
		
		//START: set template
			$this->processTemplate('pages/resource/dataset.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

