<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalGuideEditPoi extends AController {

  	public function main() {
        //START: Init Controller Data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: Set Input Box [ORDER IS IMPORTANT]
			/* REFERENCE
			[TEMPLATE FOR TAB]
				$modal_input[$i]['tab']['name'] = '';
				$modal_input[$i]['tab']['id'] = '';
				$modal_input[$i]['tab']['active'] = false;
			
			[TEMPLATE FOR SECTION]
				$i = '';
				$modal_input[$i]['section'] = '';
			
			[TEMPLATE FOR INPUT]
				$i ='';
				$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$modal_input[$i]['id'] = str_replace("_","-",$i);
				$modal_input[$i]['name'] = $i;
				$modal_input[$i]['required'] = false;
			
			[TEXT]
				$modal_input[$i]['type'] = 'text';
			
			[TEXTAREA]
				$modal_input[$i]['type'] = 'text';
				$modal_input[$i]['row'] = '5';
				
			[HIDDEN]
				$modal_input[$i]['type'] = 'hidden';
				$modal_input[$i]['json'] = $i;
			
			[SELECT]
				$modal_input[$i]['type'] = 'select';
				$modal_input[$i]['option'] = 'select';
			
			[DATE]
				$modal_input[$i]['type'] = 'date';
				$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
			*/
			
			$i = 'poi_id';
			$modal_input[$i]['label'] = 'Id';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['json'] = $i;
			
			$i = 'popularity';
				$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$modal_input[$i]['id'] = str_replace("_","-",$i);
				$modal_input[$i]['name'] = $i;
				$modal_input[$i]['required'] = false;
				
			$i = 'lat';
			$modal_input[$i]['label'] = 'Latitude';
			$modal_input[$i]['id'] = 'lat';
			$modal_input[$i]['name'] = 'lat';
			$modal_input[$i]['type'] = 'text';
			$modal_input[$i]['required'] = true;
			
			$i = 'lng';
			$modal_input[$i]['label'] = 'Longitude';
			$modal_input[$i]['id'] = 'lng';
			$modal_input[$i]['name'] = 'lng';
			$modal_input[$i]['type'] = 'text';
			$modal_input[$i]['required'] = true;
			
			$i = 'status';
			$modal_input[$i]['label'] = 'Status';
			$modal_input[$i]['id'] = 'status';
			$modal_input[$i]['name'] = 'status';
			$modal_input[$i]['type'] = 'select';
			$option = array();
				$option[0]['status'] = 0;
				$option[0]['name'] = 'OFF';
				$option[1]['status'] = 1;
				$option[1]['name'] = 'ON';
			$modal_input[$i]['option'] = $option;
			$modal_input[$i]['required'] = true;
			
			$i = 'date_added';
			$modal_input[$i]['label'] = 'Date Added';
			$modal_input[$i]['id'] = 'date-added';
			$modal_input[$i]['name'] = 'date_added';
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'date_modified';
			$modal_input[$i]['label'] = 'Date Modified';
			$modal_input[$i]['id'] = 'date-modified';
			$modal_input[$i]['name'] = 'date_modified';
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
		//END
		
		//START: Set Ajax	
			$modal_ajax['guide/ajax_poi'] = $this->html->getSecureURL('guide/ajax_poi');
		//END
		
		//START: Set Variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/guide/edit_poi.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

