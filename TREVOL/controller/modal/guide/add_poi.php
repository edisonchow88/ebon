<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalGuideAddPoi extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
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
				$modal_input[$i]['label'] = '';
				$modal_input[$i]['id'] = '';
				$modal_input[$i]['name'] = '';
				$modal_input[$i]['type'] = 'hidden';
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
		$i = 'tab_main';
		$modal_input[$i]['tab']['name'] = 'Main';
		$modal_input[$i]['tab']['id'] = 'modal-add-poi-tab-main';
		$modal_input[$i]['tab']['active'] = true;
		
		$i = 'section_description';
		$modal_input[$i]['section'] = 'Description';
		
		$i = 'language';
		$language = $this->language->getCurrentLanguage();
		$modal_input[$i]['label'] = 'Language';
		$modal_input[$i]['id'] = 'language-id';
		$modal_input[$i]['name'] = 'language_id';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = $language['language_id'];
		$modal_input[$i]['text'] = $language['name'];
		
		$i = 'name';
		$modal_input[$i]['label'] = 'Name';
		$modal_input[$i]['id'] = 'name';
		$modal_input[$i]['name'] = 'name';
		$modal_input[$i]['type'] = 'text';
		$modal_input[$i]['required'] = true;
		
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
		
		$i = 'section_general';
		$modal_input[$i]['section'] = 'General';
		
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
		$modal_input[$i]['value'] = 1;
		
		$i = 'date_added';
		$modal_input[$i]['label'] = 'Date Added';
		$modal_input[$i]['id'] = 'date-added';
		$modal_input[$i]['name'] = 'date_added';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = gmdate('Y-m-d H:i:s');
		$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
		
		$i = 'date_modified';
		$modal_input[$i]['label'] = 'Date Modified';
		$modal_input[$i]['id'] = 'date-modified';
		$modal_input[$i]['name'] = 'date_modified';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = gmdate('Y-m-d H:i:s');
		$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
		
		$i = 'tab_google';
		$modal_input[$i]['tab']['name'] = 'Google';
		$modal_input[$i]['tab']['id'] = 'modal-add-poi-tab-google';
		$modal_input[$i]['tab']['active'] = false;
		
		$i = 'section_google';
		$modal_input[$i]['section'] = 'Google';
		
		$i = 'g_place_id';
		$modal_input[$i]['label'] = 'Place Id';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['text'] = 'Undefined';
		
		$i = 'g_name';
		$modal_input[$i]['label'] = 'Name';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['text'] = 'Undefined';
		
		$i = 'g_website';
		$modal_input[$i]['label'] = 'Website';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['text'] = 'Undefined';
		
		$i = 'g_vicinity';
		$modal_input[$i]['label'] = 'Vicinity';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['text'] = 'Undefined';
		
		$i = 'g_lat';
		$modal_input[$i]['label'] = 'Latitude';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['text'] = 'Undefined';
		
		$i = 'g_lng';
		$modal_input[$i]['label'] = 'Longitude';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['text'] = 'Undefined';
		
		$i = 'g_date_added';
		$modal_input[$i]['label'] = 'Date Added';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = gmdate('Y-m-d H:i:s');
		$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
		
		$i = 'g_date_modified';
		$modal_input[$i]['label'] = 'Date Modified';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = gmdate('Y-m-d H:i:s');
		$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
		
		$i = 'tab_wiki';
		$modal_input[$i]['tab']['name'] = 'Wiki';
		$modal_input[$i]['tab']['id'] = 'modal-add-poi-tab-wiki';
		$modal_input[$i]['tab']['active'] = false;
		
		$i = 'section_wiki';
		$modal_input[$i]['section'] = 'Wiki';
		
		$i = 'w_title';
		$modal_input[$i]['label'] = 'Title';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['text'] = 'Undefined';
		
		$i = 'w_blurb';
		$modal_input[$i]['label'] = 'Blurb';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['text'] = 'Undefined';
		
		$i = 'w_date_added';
		$modal_input[$i]['label'] = 'Date Added';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = gmdate('Y-m-d H:i:s');
		$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
		
		$i = 'w_date_modified';
		$modal_input[$i]['label'] = 'Date Modified';
		$modal_input[$i]['id'] = str_replace("_","-",$i);
		$modal_input[$i]['name'] = $i;
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['value'] = gmdate('Y-m-d H:i:s');
		$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
		//END: input
		
		$modal_ajax['guide/ajax_poi'] = $this->html->getSecureURL('guide/ajax_poi');
		//$modal_ajax['wikipedia'] = 'http://en.wikipedia.org/w/api.php?format=json&action=query&prop=revisions&rvprop=content&redirects=true&callback=?&titles=';
		$modal_ajax['wikipedia'] = 'http://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro=&explaintext=&callback=?&redirects=true&titles=';
		
		$modal_link['wikipedia'] = 'https://en.wikipedia.org/wiki/Main_Page';
		
		$this->view->assign('modal_ajax', $modal_ajax);
		$this->view->assign('modal_input', $modal_input);
		$this->view->assign('modal_link', $modal_link);
		
		$this->processTemplate('modal/guide/add_poi.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

