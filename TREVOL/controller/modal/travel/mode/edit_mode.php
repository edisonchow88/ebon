<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalTravelModeEditMode extends AController {

  	public function main() {
        //START: initiate controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set component
			$this->loadComponent('database/modal');
			
			//START: set modal
				$modal['object'] = 'mode';
				$modal['ajax'] = $this->html->getSecureURL('travel/ajax_mode');
				
				//START: set form
					$f = 'edit';
					$form[$f]['action'] = $f;
					
					//START: set input [ORDER IS IMPORTANT]
						$input = array();
						
						$i ='mode_id';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['type'] = 'hidden';
						$input[$i]['required'] = false;
						$input[$i]['json'] = $i;
						
						$i = 'section_general';
						$input[$i]['section'] = 'General';
						
						$i = 'icon';
						$input[$i]['label'] = 'Icon';
						$input[$i]['id'] = 'icon';
						$input[$i]['name'] = 'icon';
						$input[$i]['type'] = 'text';
						$input[$i]['required'] = true;
						$input[$i]['help'] = 'fa-awesome';
						$input[$i]['link'] = 'http://fontawesome.io/icons/';
						
						$i = 'section_description';
						$input[$i]['section'] = 'Description';
						
						$i = 'language';
						$language = $this->language->getCurrentLanguage();
						$input[$i]['label'] = 'Language';
						$input[$i]['id'] = 'language-id';
						$input[$i]['name'] = 'language_id';
						$input[$i]['type'] = 'hidden';
						$input[$i]['required'] = false;
						$input[$i]['json'] = 'language.name';
						
						$i = 'name';
						$input[$i]['label'] = 'Name';
						$input[$i]['id'] = 'name';
						$input[$i]['name'] = 'name';
						$input[$i]['type'] = 'text';
						$input[$i]['required'] = true;
					//END
					
					$form[$f]['input'] = $input;
				//END
				
				//START: set form
					$f = 'get';
					$form[$f]['action'] = $f;
					
					//START: set input [ORDER IS IMPORTANT]
						$input = array();
						
						$i ='mode_id';
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['type'] = 'hidden';
					//END
					
					$form[$f]['input'] = $input;
				//END
				
				$modal['form'] = $form;
			//END
			
			$modal_component['modal_form'] = $this->component_database_modal->edit($modal['object'],$modal['ajax'],$modal['form']);
		//END
		
		//START: set variable
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/travel/mode/edit_mode.tpl' );
		//END
		
		//START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
		
		
	}
}
?>

