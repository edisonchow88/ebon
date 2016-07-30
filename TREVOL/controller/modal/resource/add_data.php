<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalResourceAddData extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: input [ORDER IS IMPORTANT]
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
			$i ='dataset_id';
			$modal_input[$i]['label'] = 'Dataset';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			if(isset($_GET['dataset_id'])) { 
				$dataset = $this->model_resource_data->getDataset($_GET['dataset_id']);
				$modal_input[$i]['type'] = 'hidden';
				$modal_input[$i]['text'] = $dataset['name'].' (#'.$dataset['dataset_id'].')';
				$modal_input[$i]['value'] = $dataset['dataset_id'];
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
			$modal_input[$i]['value'] = $language['language_id'];
			$modal_input[$i]['text'] = $language['name'];
			
			$i ='name';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '';
			
			$i ='description';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['value'] = '';
			
			$i ='value';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '';
			
			$i ='icon';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['value'] = '';
			$modal_input[$i]['help'] = 'Font Awesome Icons';
			$modal_input[$i]['link'] = 'http://fontawesome.io/icons/';
			
			$i ='sort_order';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['value'] = '';
		//END
		
		//START: set ajax
			$modal_ajax['resource/ajax_data'] = $this->html->getSecureURL('resource/ajax_data');
		//END
		
		//START: set variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: set template
			$this->processTemplate('modal/resource/add_data.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

