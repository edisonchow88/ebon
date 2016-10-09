<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalAccountDetail extends AController {
	//START: declare common variable
		public $data = array();
	//END
	
  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: get data
			$this->data['plan'] = $this->user->getRole();
			$this->data['email'] = $this->user->getEmail();
		//END
		
		//START: load component	
			$this->loadComponent('database/mobile_modal');
		//END
		
		//START: set form
			$id = 'modal-account-detail-form';
			$action = 'edit';
			$input = array();
			//START: set input [ORDER IS IMPORTANT]
				$i ='plan';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->data['plan'];
				$input[$i]['type'] = 'hidden';
				$input[$i]['text'] = $this->data['plan'];
				
				$i ='email';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->data['email'];
				$input[$i]['type'] = 'hidden';
				$input[$i]['text'] = $this->data['email'];
			//END
			$modal_component['form'] = $this->component_database_mobile_modal->writeForm($id,$action,$input);
		//END
		
		//START: set ajax
			$modal_ajax = $this->html->getSecureURL('account/ajax_user');
		//END
		
		//START: set variable
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_component', $modal_component);
			$this->view->batchAssign($this->data);
		//END
		
		//START: set template
			$this->processTemplate('modal/account/detail.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

