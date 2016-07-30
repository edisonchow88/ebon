<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesGuidePoiSubsetRecognition extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Poi Recognition";
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
			$data = $this->model_guide_poi->getPoiRecognitionByPoiId($poi_id);
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$recognition_id = $row['recognition_id'];
					
					//NOTE: sequence is important
					$result[$recognition_id]['recognition_id'] = $row['recognition_id'];
					$poi = $this->model_guide_poi->getPoi($row['poi_id']);
                    $result[$recognition_id]['poi_id'] = $poi['name'];
					$recognition = $this->model_resource_data->getDataByDatasetName('recognition',$row['recognition']);
					$result[$recognition_id]['recognition'] = json_encode($recognition);
                    $language = $this->language->getLanguageDetailsByID($row['language_id']);
                    $result[$recognition_id]['language'] = $language['name'];
                    $result[$recognition_id]['title'] = $row['title'];
					$result[$recognition_id]['link'] = $row['link'];
                    $result[$recognition_id]['year_started'] = $row['year_started'];
					$result[$recognition_id]['year_ended'] = $row['year_ended'];
					$result[$recognition_id]['year'] = $row['year'];
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
			
			$i = 'recognition_id';
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
			
			$i = 'recognition';
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
            
            $i = 'title';
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
			
			$i = 'link';
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
			
			$i = 'year_started';
            $column[$i]['name'] = $i;
            $column[$i]['title'] = ucwords(str_replace("_"," ",$i));
            $column[$i]['type'] = '';
            $column[$i]['width'] = '';
            $column[$i]['order'] = 'asc';
            $column[$i]['align'] = '';
            $column[$i]['headerAlign'] = '';
            $column[$i]['visible'] = 'false';
            $column[$i]['sortable'] = 'false';
            $column[$i]['searchable'] = 'false';
			
			$i = 'year_ended';
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
			
			$i = 'year';
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
			$this->addChild('modal/guide/poi/add_recognition', 'modal_add_recognition', 'modal/guide/poi/add_recognition.tpl');
			$this->addChild('modal/guide/poi/edit_recognition', 'modal_edit_recognition', 'modal/guide/poi/edit_recognition.tpl');
			$this->addChild('modal/guide/poi/delete_recognition', 'modal_delete_recognition', 'modal/guide/poi/delete_recognition.tpl');
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
			$this->processTemplate('pages/guide/poi_subset/recognition.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>