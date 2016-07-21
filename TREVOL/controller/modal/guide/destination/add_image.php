<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalGuideDestinationAddImage extends AController {

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
			
			$i = 'tab_upload_image';
			$modal_input[$i]['tab']['name'] = 'Upload Image';
			$modal_input[$i]['tab']['id'] = str_replace("_","-",$i);
			$modal_input[$i]['tab']['active'] = true;
		
			$i = 'section_upload_image';
			$modal_input[$i]['section'] = 'Upload Image';
			
			$i ='image';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['value'] = '';
			$modal_input[$i]['type'] = 'upload_image';
		
			$i = 'section_general';
			$modal_input[$i]['section'] = 'General';
			
			$i ='destination_id';
			$modal_input[$i]['label'] = 'Destination';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			if(isset($_GET['destination_id'])) { 
				$destination = $this->model_guide_destination->getDestination($_GET['destination_id']);
				$modal_input[$i]['type'] = 'hidden';
				$modal_input[$i]['text'] = $destination['name'].' (#'.$destination['destination_id'].')';
				$modal_input[$i]['value'] = $destination['destination_id'];
			}
			else {
				$destination = $this->model_guide_destination->getDestination();
				$modal_input[$i]['type'] = 'select';
				$modal_input[$i]['option'] = $destination;
			}
			
			$i = 'sort_order';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['type'] = 'text';
			$modal_input[$i]['value'] = '0';
			
			$i = 'section_description';
			$modal_input[$i]['section'] = 'Description';
			
			$i = 'name';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '';
			$modal_input[$i]['type'] = 'text';
			
			$i = 'section_source';
			$modal_input[$i]['section'] = 'Source';
			
			$i = 'photographer';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['value'] = '';
			$modal_input[$i]['type'] = 'text';
			
			$i = 'link';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['value'] = '';
			$modal_input[$i]['type'] = 'text';
			
			$i = 'image_source_id';
			$modal_input[$i]['label'] = 'Source';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '0';
			$modal_input[$i]['type'] = 'select';
			$modal_input[$i]['option'] = $this->model_resource_image_source->getImageSource();
			
			$i = 'image_license_id';
			$modal_input[$i]['label'] = 'License';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '0';
			$modal_input[$i]['type'] = 'select';
			$modal_input[$i]['option'] = $this->model_resource_image_license->getImageLicense();
			$modal_input[$i]['help'] = 'Creative Common License';
			$modal_input[$i]['link'] = 'https://en.wikipedia.org/wiki/Creative_Commons_license#Seven_regularly_used_licenses';
			
			$i = 'tab_select_image';
			$modal_input[$i]['tab']['name'] = 'Select Image';
			$modal_input[$i]['tab']['id'] = str_replace("_","-",$i);
			$modal_input[$i]['tab']['active'] = false;
			
			$i = 'section_select_image';
			$modal_input[$i]['section'] = 'Select Image';
			
			$i ='image_id';
			$modal_input[$i]['label'] = 'Image';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['type'] = 'search';
		//END
		
		//START: Set Ajax	
			$modal_ajax['guide/ajax_destination_image'] = $this->html->getSecureURL('guide/ajax_destination_image');
			$modal_ajax['resource/upload_image'] = $this->html->getSecureURL('resource/upload_image');
		//END
		
		//START: Set Variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/guide/destination/add_image.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

