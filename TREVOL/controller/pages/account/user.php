<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesAccountUser extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "User";
			$this->document->setTitle($title);
		//END
		
		//START: set alert
			$this->view->assign('error_warning', $this->session->data['warning']);
			if (isset($this->session->data['warning'])) {
				unset($this->session->data['warning']);
			}
			$this->view->assign('success', $this->session->data['success']);
			if (isset($this->session->data['success'])) {
				unset($this->session->data['success']);
			}
		//END
		
		//START: set model
			$this->loadModel('account/user');
		//END
		
		//START: set data
			$data = $this->model_account_user->getUser();
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$user_id = $row['user_id'];
					
					//NOTE: sequence is important
					$result[$user_id]['user_id'] = $row['user_id'];
					$user_group = $this->model_account_user->getUserGroup($row['user_group_id']);
					$result[$user_id]['user_group'] = $user_group['name'];
					$result[$user_id]['email'] = $row['email'];
					$result[$user_id]['fullname'] = $row['fullname'];
					$result[$user_id]['last_login'] = $row['last_login'];
					$result[$user_id]['date_added'] = $row['date_added'];
					$result[$user_id]['date_modified'] = $row['date_modified'];
				}
			}
		//END
		
		//START: set column
			/* [Template]
			$i = '';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			*/
			
			$i = 'user_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '80px';
			$column[$i]['order'] = '';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'user_group';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'email';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'fullname';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'last_login';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'date_added';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'date_modified';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			
			$i = 'commands';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = 'right';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
		//END
		
		//START: set modal
			$this->addChild('modal/account/add_user', 'modal_add_user', 'modal/account/add_user.tpl');
			$this->addChild('modal/account/edit_user', 'modal_edit_user', 'modal/account/edit_user.tpl');
			$this->addChild('modal/account/delete_user', 'modal_delete_user', 'modal/account/delete_user.tpl');
		//END
		
		//START: set link
			$link['account/user_group'] = $this->html->getSecureURL('account/user_group');
		//END
		
		//START: set variable
			if(count($column) > 0) { $this->view->assign('column', $column); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
		//END
		
		//START: set template
			$this->processTemplate('pages/account/user.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>