<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalAccountLogin extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load component	
			$this->loadComponent('form');
		//END
		
		//START: set form
			$id = 'modal-login-form';
			$action = 'log_in';
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
			//END
			$modal_component[$id] = $this->component_form->getForm($id,$action,$input);
		//END
		
		//START: set variable
			//$this->view->assign('modal_ajax', $modal_ajax);
			if(isset($modal_component)) { $this->view->assign('modal_component', $modal_component); }
		//END
		
		//START: set template
			$this->processTemplate('modal/account/login.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

