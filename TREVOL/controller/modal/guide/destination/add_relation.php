<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalGuideDestinationAddRelation extends AController {

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
			
			$i ='destination_id';
			$modal_input[$i]['label'] = 'Destination';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			if(isset($_GET['destination_id'])) { 
				$destination = $this->model_guide_destination->getDestination($_GET['destination_id']);
				$modal_input[$i]['value'] = $destination['destination_id'];
				$modal_input[$i]['type'] = 'hidden';
				$modal_input[$i]['text'] = $destination['name'].' (#'.$destination['destination_id'].')'; 
			}
			else {
				$destination = $this->model_guide_destination->getDestination();
				$modal_input[$i]['type'] = 'select';
				$modal_input[$i]['option'] = $destination;
			}
			
			$i ='target_id';
			$modal_input[$i]['label'] = 'Target';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['type'] = 'search';
			
			$i = 'relation';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '';
			$modal_input[$i]['type'] = 'select';
			$option = array();
				$option[0]['relation'] = 'parent';
				$option[0]['name'] = 'Parent';
				$option[1]['relation'] = 'child';
				$option[1]['name'] = 'Child';
			$modal_input[$i]['option'] = $option;
		//END
		
		//START: Set Ajax	
			$modal_ajax['guide/ajax_destination_relation'] = $this->html->getSecureURL('guide/ajax_destination_relation');
		//END
		
		//START: Set Variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/guide/destination/add_relation.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

