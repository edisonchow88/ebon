<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalAccountSignup extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load component	
			$this->loadComponent('database/modal');
		//END
		
		//START: set form
			$id = 'modal-account-signup-form';
			$action = 'signup';
			$input = array();
			//START: set input [ORDER IS IMPORTANT]
				$i ='email';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = true;
				$input[$i]['value'] = '';
				
				$i ='password';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = true;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'password';
				
				$i ='confirm_password';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = true;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'password';
			//END
			$setting['autocomplete'] = false;
			$modal_component['form'] = $this->component_database_modal->writeForm($id,$action,$input,$setting);
		//END
		
		//START: set ajax
			$modal_ajax = $this->html->getSecureURL('account/ajax_user');
		//END
		
		//START: set variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/account/signup.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

