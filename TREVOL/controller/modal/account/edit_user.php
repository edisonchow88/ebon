<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalAccountEditUser extends AController {

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
			
			$i ='user_id';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i ='user_group_id';
			$modal_input[$i]['label'] = 'User Group';
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['required'] = true;
			$modal_input[$i]['type'] = 'select';
			$modal_input[$i]['option'] = $this->model_account_user->getUserGroup(); 
			
			$i ='email';
			$modal_input[$i]['label'] = ucwords(str_replace("_"," ",$i));
			$modal_input[$i]['id'] = str_replace("_","-",$i);
			$modal_input[$i]['name'] = $i;
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'date_added';
			$modal_input[$i]['label'] = 'Date Added';
			$modal_input[$i]['id'] = 'date-added';
			$modal_input[$i]['name'] = 'date_added';
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
			
			$i = 'date_modified';
			$modal_input[$i]['label'] = 'Date Modified';
			$modal_input[$i]['id'] = 'date-modified';
			$modal_input[$i]['name'] = 'date_modified';
			$modal_input[$i]['type'] = 'hidden';
			$modal_input[$i]['required'] = false;
			$modal_input[$i]['json'] = $i;
		//END
		
		//START: Set Ajax	
			$modal_ajax['account/ajax_user'] = $this->html->getSecureURL('account/ajax_user');
		//END
		
		//START: Set Component	
			$this->loadModel('component/form');
			
			$id = 'modal-edit-user-form';
			$action = 'edit';
			$input = $modal_input;
			$modal_component[$id] = $this->model_component_form->getForm($id,$action,$input);
			
			//START: set get form
				$form = array();
				$form['id'] = 'modal-get-user-form';
				$form['action'] = 'get';
				
				$i ='user_id';
				$form['input'][$i]['label'] = '';
				$form['input'][$i]['id'] = str_replace("_","-",$i);
				$form['input'][$i]['name'] = $i;
				$form['input'][$i]['type'] = 'hidden';
				
				$modal_component[$form['id']] = $this->model_component_form->getForm($form['id'],$form['action'],$form['input']);
			//END
		//END
		
		//START: Set Variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_component', $modal_component);
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/account/edit_user.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

