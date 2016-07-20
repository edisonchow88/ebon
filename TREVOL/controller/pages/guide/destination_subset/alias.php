<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuideDestinationSubsetAlias extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Destination Alias";
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
		
		//START: set id
			$destination_id = $_GET['destination_id'];
		//END
		
		//START: set data
			$data = $this->model_guide_destination->getDestinationAliasByDestinationId($destination_id);
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$alias_id = $row['alias_id'];
					
					//NOTE: sequence is important
					$result[$alias_id]['alias_id'] = $row['alias_id'];
                    $result[$alias_id]['destination_id'] = $row['destination_id'];
                    $language = $this->language->getLanguageDetailsByID($row['language_id']);
                    $result[$alias_id]['language'] = $language['name'];
                    $result[$alias_id]['name'] = $row['name'];
                    $result[$alias_id]['ranking'] = $row['ranking'];
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
			
			$i = 'alias_id';
            $column[$i]['name'] = 'id';
            $column[$i]['title'] = 'Id';
            $column[$i]['type'] = 'numeric';
            $column[$i]['width'] = '';
            $column[$i]['order'] = '';
            $column[$i]['sortable'] = 'true';
            $column[$i]['searchable'] = 'true';
            
            $i = 'destination_id';
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
            
            $i = 'language';
            $column[$i]['name'] = $i;
            $column[$i]['title'] = ucwords(str_replace("_"," ",$i));
            $column[$i]['type'] = '';
            $column[$i]['width'] = '';
            $column[$i]['order'] = 'asc';
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
            
            $i = 'ranking';
            $column[$i]['name'] = $i;
            $column[$i]['title'] = ucwords(str_replace("_"," ",$i));
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
			$this->addChild('modal/guide/destination/add_alias', 'modal_add_alias', 'modal/guide/destination/add_alias.tpl');
			$this->addChild('modal/guide/destination/edit_alias', 'modal_edit_alias', 'modal/guide/destination/edit_alias.tpl');
			$this->addChild('modal/guide/destination/delete_alias', 'modal_delete_alias', 'modal/guide/destination/delete_alias.tpl');
		//END
		
		//START: set link
			$link['guide/destination'] = $this->html->getSecureURL('guide/destination');
		//END
		
		//START: set variable
			if(count($column) > 0) { $this->view->assign('column', $column); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
		//END
		
		//START: set template
			$this->processTemplate('pages/guide/destination_subset/alias.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>