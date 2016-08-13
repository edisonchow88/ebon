<?php 
//START: verify directory
	if (! defined ( 'DIR_CORE' )) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerBlocksTrevolTripDebug extends AController {
	//START: declare common variable
		public $data = array();
	//END
	
	public function main() {

        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: load model	
			$this->loadModel('account/user');
		//END
		
		//START: get data
			$this->data['user_id'] = $this->user->getUserId();
			$this->data['role_id'] = $this->user->getRoleId();
			$role = $this->model_account_user->getRole($this->data['role_id']);
			$this->data['role'] = $role['name'];
		//END
		
		//START: load component	
			$this->loadComponent('database/modal');
		//END
		
		//START: set form
			$id = 'wrapper-debug-modal-form';
			$action = 'view';
			$input = array();
			//START: set input [ORDER IS IMPORTANT]
				$i ='action';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->data['action'];
				$input[$i]['type'] = 'disabled';
				
				$i ='user_id';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->data['user_id'];
				$input[$i]['type'] = 'disabled';
				
				$i ='role';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->data['role'];
				$input[$i]['type'] = 'disabled';
				
				$i ='trip_id';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->data['trip_id'];
				$input[$i]['type'] = 'disabled';
				
				$i ='day_id';
				$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
				$input[$i]['id'] = str_replace("_","-",$i);
				$input[$i]['name'] = $i;
				$input[$i]['required'] = false;
				$input[$i]['value'] = $this->data['day_id'];
				$input[$i]['type'] = 'disabled';
			//END
			$modal_component['form'] = $this->component_database_modal->writeForm($id,$action,$input);
		//END
		
		//START: set variable
			$this->view->assign('modal_component', $modal_component);
			$this->view->batchAssign($this->data);
		//END
		
		//START: set template
			$this->processTemplate();
		//END
		
        //START: init controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
  	}
}
?>