<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalItineraryAccountSignup extends AController {
	//START: set common variable
		public $data = array();
	//END
	
  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load component	
			$this->loadComponent('database/mobile_modal');
		//END
		
		//START: set form for signup
			$id = 'modal-account-signup-form';
			$action = 'signup';
			$input = array();
			//START: set input [ORDER IS IMPORTANT]
				$i ='email';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['placeholder'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = true;
				$input[$i]['value'] = '';
				
				$i ='password';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['placeholder'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = true;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'password';
				
				$i ='confirm_password';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['placeholder'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = true;
				$input[$i]['value'] = '';
				$input[$i]['type'] = 'password';
			//END
			$setting['autocomplete'] = false;
			$component['form'] = $this->component_database_mobile_modal->writeForm($id,$action,$input,$setting);
		//END
		
		//START: set ajax
			$ajax['account/ajax_user'] = $this->html->getSecureURL('account/ajax_user');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($component) > 0) { $this->view->assign('component', $component); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template
			$this->processTemplate('modal/itinerary/account/signup.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

