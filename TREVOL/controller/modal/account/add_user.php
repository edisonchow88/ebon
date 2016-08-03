<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalAccountAddUser extends AController {

  	public function main() {
        //START: Init Controller Data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: Set Input Box [ORDER IS IMPORTANT]
			/* REFERENCE
			[TEMPLATE FOR TAB]
				$i = 'tab_';
				$modal_input[$i]['tab']['name'] = '';
				$modal_input[$i]['tab']['id'] = '';
				$modal_input[$i]['tab']['active'] = false;
			
			[TEMPLATE FOR SECTION]
				$i = 'section_';
				$modal_input[$i]['section'] = '';
			
			[TEMPLATE FOR INPUT]
				$i ='';
				$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$modal_input[$i]['id'] = str_replace("_","-",$i);
				$modal_input[$i]['name'] = $i;
				$modal_input[$i]['required'] = false;
				$modal_input[$i]['value'] = '';
			
			[PASSWORD]
				$modal_input[$i]['type'] = 'password';
				
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
				$modal_input[$i]['option'] = $this->model_xxx_xxx->get();
			
			[DATE]
				$modal_input[$i]['type'] = 'date';
				$modal_input[$i]['text'] = gmdate('Y-m-d H:i:s');
			*/
			
			$i ='user_group_id';
			$modal_input[$i]['label'] = 'User Group';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '';
			$modal_input[$i]['type'] = 'select';
			$modal_input[$i]['option'] = $this->model_account_user->getUserGroup(); 
			
			$i ='email';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '';
			
			$i ='password';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '';
			$modal_input[$i]['type'] = 'password';
			
			$i ='confirm_password';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['value'] = '';
			$modal_input[$i]['type'] = 'password';
		//END
		
		//START: Set Ajax	
			$modal_ajax['account/ajax_user'] = $this->html->getSecureURL('account/ajax_user');
		//END
		
		//START: Set Component	
			$this->loadModel('component/form');
			$id = 'modal-add-user-form';
			$action = 'add';
			$input = $modal_input;
			$modal_component[$id] = $this->model_component_form->getForm($id,$action,$input);
		//END
		
		//START: Set Variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_component', $modal_component);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/account/add_user.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

