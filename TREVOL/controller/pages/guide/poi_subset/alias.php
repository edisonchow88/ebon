<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuidePoiSubsetAlias extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Poi Alias";
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
		
		$poi_id = $_GET['poi_id'];
		
		$data = $this->model_guide_poi->getPoiAliasByPoiId($poi_id);
		
		//START: set result
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
		
		//START: include modal
		$this->addChild('modal/guide/poi/add_alias', 'modal_add_alias', 'modal/guide/poi/add_alias.tpl');
		$this->addChild('modal/guide/poi/edit_alias', 'modal_edit_alias', 'modal/guide/poi/edit_alias.tpl');
		$this->addChild('modal/guide/poi/delete_alias', 'modal_delete_alias', 'modal/guide/poi/delete_alias.tpl');
		//END
		
		//START: define link
		$link['guide/poi'] = $this->html->getSecureURL('guide/poi');
		//END
		
		$this->view->assign('column', $column);
		$this->view->assign('link', $link);
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/guide/poi_subset/alias.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

