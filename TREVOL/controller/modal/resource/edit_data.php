<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalResourceEditData extends AController {

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
			
			$i = 'data_id';
			$modal_input[$i]['label'] = 'Id';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['json'] = $i;
			
			$i ='dataset_id';
			$modal_input[$i]['label'] = 'Dataset';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			if(isset($_GET['dataset_id'])) { 
				$dataset = $this->model_resource_data->getDataset($_GET['dataset_id']);
				$modal_input[$i]['type'] = 'hidden';
				$modal_input[$i]['text'] = $dataset['name'].' (#'.$dataset['dataset_id'].')';
			}
			else {
				$dataset = $this->model_resource_data->getDataset();
				$modal_input[$i]['type'] = 'select';
				$modal_input[$i]['option'] = $dataset;
			}
			
			$i = 'language';
			$language = $this->language->getCurrentLanguage();
			$modal_input[$i]['label'] = 'Language';
			$modal_input[$i]['id'] = 'language-id';
			$modal_input[$i]['name'] = 'language_id';
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['text'] = $language['name'];
			
			$i ='name';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			
			$i ='description';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			
			$i ='value';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			
			$i ='icon';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
		//END
		
		//START: Set Ajax	
			$modal_ajax['resource/ajax_data'] = $this->html->getSecureURL('resource/ajax_data');
		//END
		
		//START: Set Variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/resource/edit_data.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

