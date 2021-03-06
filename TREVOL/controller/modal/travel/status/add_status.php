<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalTravelStatusAddStatus extends AController {

  	public function main() {
        //START: initiate controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set component
			$this->loadComponent('database/modal');
			
			//START: set modal
				$modal['object'] = 'status';
				$modal['ajax'] = $this->html->getSecureURL('travel/ajax_status');
				
				//START: set form
					$f = 'add';
					$form[$f]['action'] = $f;
					
					//START: set input [ORDER IS IMPORTANT]
						$input = array();
						
						$i ='language_id';
						$language = $this->language->getAvailableLanguages();
						$current_language = $this->language->getCurrentLanguage();
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['required'] = true;
						$input[$i]['type'] = 'select';
						$input[$i]['value'] = $current_language['language_id'];
						$input[$i]['option'] = $language;
						
						$i ='name';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['required'] = true;
						$input[$i]['value'] = '';
						$input[$i]['type'] = 'text';
						
						$i ='general';
						$input['section'.$i]['section'] = ucwords(str_replace("_"," ",$i));
						
						$i ='color';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['required'] = true;
						$input[$i]['value'] = '';
						$input[$i]['type'] = 'color';
						
						$i ='sort_order';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['required'] = false;
						$input[$i]['value'] = '';
						$input[$i]['type'] = 'text';
						
						$i ='priority';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['required'] = false;
						$input[$i]['value'] = '';
						$input[$i]['type'] = 'text';
					//END
					
					$form[$f]['input'] = $input;
				//END
				
				$modal['form'] = $form;
			//END
			
			$modal_component['modal_form'] = $this->component_database_modal->add($modal['object'],$modal['ajax'],$modal['form']);
		//END
		
		//START: set variable
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/travel/status/add_status.tpl' );
		//END
		
		//START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

