<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalGuideViewPoiSummary extends AController {

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
			
			$i = 'section_table';
			$modal_input[$i]['section'] = 'Number of Row';
			
			$i = 'alias';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'description';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'destination';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'google';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'wikipedia';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
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
			$this->processTemplate('modal/guide/view_poi_summary.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

