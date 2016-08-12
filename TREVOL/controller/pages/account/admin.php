<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesAccountAdmin extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Admin";
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
			$this->loadModel('account/admin');
		//END
		
		//START: set data
			$data = $this->model_account_admin->getAdmin();
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$admin_id = $row['admin_id'];
					
					//NOTE: sequence is important
					$result[$admin_id]['admin_id'] = $row['admin_id'];
					$role = $this->model_account_admin->getRole($row['role_id']);
					$result[$admin_id]['role'] = $role['name'];
					$result[$admin_id]['email'] = $row['email'];
					$result[$admin_id]['last_login'] = $row['last_login'];
					$result[$admin_id]['date_added'] = $row['date_added'];
					$result[$admin_id]['date_modified'] = $row['date_modified'];
				}
			}
		//END
		
		//START: set column
			/* [SAMPLE]
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
			
			$i = 'admin_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '80px';
			$column[$i]['order'] = '';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'role';
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
		
		//START: set component
			$this->loadComponent('database/table');
			$object = 'admin';
			$table['column'] = $column;
			$table['row'] = $result;
			$action['add'] = true;
			$action['edit'] = true;
			$action['delete'] = true;
			$related = array();
			$related[0]['title'] = 'role';
			$related[0]['url'] = $this->html->getSecureURL('account/admin_role');
			$grid['setting']['caseSensitive'] = 'false';
			$grid['setting']['rowCount'] = -1;
			$grid['setting']['columnSelection'] = 'false';
			$grid['setting']['multiSort'] = 'false';
			$component['table'] = $this->component_database_table->writeTable($object,$table,$action,$related,$grid);
		//END
		
		//START: set modal
			$this->addChild('modal/account/admin/add_admin', 'modal_add_admin', 'modal/account/admin/add_admin.tpl');
			$this->addChild('modal/account/admin/edit_admin', 'modal_edit_admin', 'modal/account/admin/edit_admin.tpl');
			$this->addChild('modal/account/admin/delete_admin', 'modal_delete_admin', 'modal/account/admin/delete_admin.tpl');
		//END
		
		//START: set variable
			$this->view->assign('component', $component);
		//END
		
		//START: set template
			$this->processTemplate('pages/account/admin.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>