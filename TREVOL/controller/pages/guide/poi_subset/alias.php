<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuidePoiSubsetAlias extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Poi Alias";
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
			$this->loadModel('resource/tag');
			$this->loadModel('resource/image');
		//END
		
		//START: set id
			$poi_id = $_GET['poi_id'];
		//END
		
		//START: set data
			$data = $this->model_guide_poi->getPoiAliasByPoiId($poi_id);
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$alias_id = $row['alias_id'];
					
					//NOTE: sequence is important
					$result[$alias_id]['alias_id'] = $row['alias_id'];
                    $result[$alias_id]['poi_id'] = $row['poi_id'];
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
            
            $i = 'poi_id';
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
			$this->addChild('modal/guide/poi/add_alias', 'modal_add_alias', 'modal/guide/poi/add_alias.tpl');
			$this->addChild('modal/guide/poi/edit_alias', 'modal_edit_alias', 'modal/guide/poi/edit_alias.tpl');
			$this->addChild('modal/guide/poi/delete_alias', 'modal_delete_alias', 'modal/guide/poi/delete_alias.tpl');
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
			$this->processTemplate('pages/guide/poi_subset/alias.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>