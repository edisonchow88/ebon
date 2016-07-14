<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalGuidePoiAddDescription extends AController {

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
				$modal_input[$i]['value'] = '';
			
			[TEXT]
				$modal_input[$i]['type'] = 'text';
			
			[TEXTAREA]
				$modal_input[$i]['type'] = 'text';
				$modal_input[$i]['row'] = '5';
				
			[HIDDEN]
				$modal_input[$i]['type'] = 'hidden';
				$modal_input[$i]['text'] = '';
			
			[SELECT]
				$modal_input[$i]['type'] = 'select';
				$modal_input[$i]['option'] = 'select';
			
			[DATE]
				$modal_input[$i]['type'] = 'date';
				$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
			*/
			
			$i ='poi_id';
			$modal_input[$i]['label'] = 'Poi';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			if(isset($_GET['poi_id'])) { 
				$modal_input[$i]['value'] = $_GET['poi_id'];
				$modal_input[$i]['type'] = 'hidden';
				$modal_input[$i]['text'] = $_GET['poi_id']; 
			}
			else {
				$poi = $this->model_guide_poi->getPoi();
				$modal_input[$i]['type'] = 'select';
				$modal_input[$i]['option'] = $poi;
			}
				
			$i = 'language_id';
			$language = $this->language->getAvailableLanguages();
			$current_language = $this->language->getCurrentLanguage();
			$modal_input[$i]['label'] = 'Language';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = $current_language['language_id'];
			$modal_input[$i]['type'] = 'select';
			$modal_input[$i]['option'] = $language;
		
			$i = 'blurb';
			$modal_input[$i]['label'] = 'Blurb';
			$modal_input[$i]['id'] = 'blurb';
			$modal_input[$i]['name'] = 'blurb';
			$modal_input[$i]['type'] = 'textarea';
			$modal_input[$i]['required'] = true;
			
			$i = 'description';
			$modal_input[$i]['label'] = 'Description';
			$modal_input[$i]['id'] = 'description';
			$modal_input[$i]['name'] = 'description';
			$modal_input[$i]['type'] = 'textarea';
			$modal_input[$i]['row'] = 10;
			$modal_input[$i]['required'] = false;
		//END
		
		//START: Set Ajax	
			$modal_ajax['guide/ajax_poi_description'] = $this->html->getSecureURL('guide/ajax_poi_description');
		//END
		
		//START: Set Variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/guide/poi/add_description.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

