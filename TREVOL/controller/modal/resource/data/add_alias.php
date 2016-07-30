<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalResourceDataAddAlias extends AController {

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
			
			$i ='data_id';
				$modal_input[$i]['label'] = 'Data';
				$modal_input[$i]['id'] = str_replace("_","-",$i);
				$modal_input[$i]['name'] = $i;
				$modal_input[$i]['required'] = true;
				if(isset($_GET['data_id'])) { 
					$modal_input[$i]['value'] = $_GET['data_id'];
					$modal_input[$i]['type'] = 'hidden';
					$modal_input[$i]['text'] = $_GET['data_id']; 
				}
				else {
					$data = $this->model_resource_data->getData();
					$modal_input[$i]['type'] = 'select';
					$modal_input[$i]['option'] = $data;
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
		
			$i = 'name';
				$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$modal_input[$i]['id'] = str_replace("_","-",$i);
				$modal_input[$i]['name'] = $i;
				$modal_input[$i]['type'] = 'text';
				$modal_input[$i]['required'] = true;
				
			$i = 'ranking';
				$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$modal_input[$i]['id'] = str_replace("_","-",$i);
				$modal_input[$i]['name'] = $i;
				$modal_input[$i]['type'] = 'text';
				$modal_input[$i]['required'] = false;
				$modal_input[$i]['value'] = 0;
		//END
		
		//START: Set Ajax	
			$modal_ajax['resource/ajax_data_alias'] = $this->html->getSecureURL('resource/ajax_data_alias');
		//END
		
		//START: Set Variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/resource/data/add_alias.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

