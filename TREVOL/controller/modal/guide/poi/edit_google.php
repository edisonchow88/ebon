<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalGuidePoiEditGoogle extends AController {

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
				$modal_input[$i]['type'] = 'textarea';
				$modal_input[$i]['row'] = '5';
				
			[HIDDEN]
				$modal_input[$i]['type'] = 'hidden';
				$modal_input[$i]['json'] = '';
			
			[SELECT]
				$modal_input[$i]['type'] = 'select';
				$modal_input[$i]['option'] = 'select';
			
			[DATE]
				$modal_input[$i]['type'] = 'date';
				$modal_input[$i]['json'] = gmdate('Y-m-d H:i:s');
			*/
			
			$i ='poi_id';
			$modal_input[$i]['label'] = 'Poi';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			if(isset($_GET['poi_id'])) { 
				$modal_input[$i]['type'] = 'hidden';
				$modal_input[$i]['text'] = $_GET['poi_id']; 
			}
			else {
				$poi = $this->model_guide_poi->getPoi();
				$modal_input[$i]['type'] = 'select';
				$modal_input[$i]['option'] = $poi;
			}
				
			$i = 'g_place_id';
			$modal_input[$i]['label'] = 'Place Id';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_name';
			$modal_input[$i]['label'] = 'Name';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_website';
			$modal_input[$i]['label'] = 'Website';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_vicinity';
			$modal_input[$i]['label'] = 'Vicinity';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_url';
			$modal_input[$i]['label'] = 'Url';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_type';
			$modal_input[$i]['label'] = 'Type';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_address_component';
			$modal_input[$i]['label'] = 'Component';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_address';
			$modal_input[$i]['label'] = 'Address';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_phone';
			$modal_input[$i]['label'] = 'Phone';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_lat';
			$modal_input[$i]['label'] = 'Latitude';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_lng';
			$modal_input[$i]['label'] = 'Longitude';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_hour';
			$modal_input[$i]['label'] = 'Hour';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_photo';
			$modal_input[$i]['label'] = 'Photo';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_rating';
			$modal_input[$i]['label'] = 'Rating';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_review';
			$modal_input[$i]['label'] = 'Review';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_utc_offset';
			$modal_input[$i]['label'] = 'UTC Offset';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_bankrupt';
			$modal_input[$i]['label'] = 'Bankrupt';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_date_added';
			$modal_input[$i]['label'] = 'Date Added';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'g_date_modified';
			$modal_input[$i]['label'] = 'Date Modified';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
		//END
		
		//START: Set Ajax	
			$modal_ajax['guide/ajax_poi_google'] = $this->html->getSecureURL('guide/ajax_poi_google');
		//END
		
		//START: Set Variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/guide/poi/edit_google.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

