<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesAccountUserRole extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set title
			$title = "Role";
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
			$data = $this->model_account_user->getRole();
		//END
		
		//START: process data and set result
			if(count($data) > 0 ) {
				foreach($data as $row) {
					$role_id = $row['role_id'];
					
					//NOTE: sequence is important
					$result[$role_id]['role_id'] = $row['role_id'];
					$result[$role_id]['name'] = $row['name'];
					$result[$role_id]['description'] = $row['description'];
					$result[$role_id]['max_active_trip'] = $row['max_active_trip'];
					$count = $this->model_account_user->countUserByRoleId($row['role_id']);
					$result[$role_id]['count'] = $count;
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
			
			$i = 'role_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '80px';
			$column[$i]['order'] = '';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'name';
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
			
			$i = 'description';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
			
			$i = 'max_active_trip';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
			
			$i = 'count';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['type'] = '';
			$column[$i]['width'] = '100px';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'false';
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
			$object = 'role';
			$table['column'] = $column;
			$table['row'] = $result;
			$action['add'] = true;
			$action['edit'] = true;
			$action['delete'] = true;
			$related = array();
			$related[0]['title'] = 'user';
			$related[0]['url'] = $this->html->getSecureURL('account/user');
			$grid['setting']['caseSensitive'] = 'false';
			$grid['setting']['rowCount'] = -1;
			$grid['setting']['columnSelection'] = 'false';
			$grid['setting']['multiSort'] = 'false';
			$component['table'] = $this->component_database_table->writeTable($object,$table,$action,$related,$grid);
		//END
		
		//START: set modal
			$this->addChild('modal/account/user/role/add_role', 'modal_add_role', 'modal/account/user/role/add_role.tpl');
			$this->addChild('modal/account/user/role/edit_role', 'modal_edit_role', 'modal/account/user/role/edit_role.tpl');
			$this->addChild('modal/account/user/role/delete_role', 'modal_delete_role', 'modal/account/user/role/delete_role.tpl');
		//END
		
		//START: set variable
			$this->view->assign('component', $component);
		//END
		
		//START: set template
			$this->processTemplate('pages/account/user_role.tpl' );
		//END
		
        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>