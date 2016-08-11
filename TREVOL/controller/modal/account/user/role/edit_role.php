<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalAccountUserRoleEditRole extends AController {

  	public function main() {
        //START: initiate controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set component
			$this->loadComponent('modal_form');
			
			//START: set modal
				$modal['object'] = 'role';
				$modal['ajax'] = $this->html->getSecureURL('account/ajax_user_role');
				
				//START: set form
					$f = 'edit';
					$form[$f]['action'] = $f;
					
					//START: set input [ORDER IS IMPORTANT]
						$input = array();
						
						$i ='role_id';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['type'] = 'hidden';
						$input[$i]['required'] = false;
						$input[$i]['json'] = $i;
						
						$i ='name';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['required'] = false;
						
						$i ='description';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['required'] = false;
					//END
					
					$form[$f]['input'] = $input;
				//END
				
				//START: set form
					$f = 'get';
					$form[$f]['action'] = $f;
					
					//START: set input [ORDER IS IMPORTANT]
						$input = array();
						
						$i ='role_id';
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['type'] = 'hidden';
					//END
					
					$form[$f]['input'] = $input;
				//END
				
				$modal['form'] = $form;
			//END
			
			$modal_component['modal_form'] = $this->component_modal_form->edit($modal['object'],$modal['ajax'],$modal['form']);
		//END
		
		//START: set variable
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/account/user/role/edit_role.tpl' );
		//END
		
		//START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
		
		
	}
}
?>

