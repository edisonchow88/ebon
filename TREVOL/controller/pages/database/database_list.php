<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesDatabaseDatabaseList extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

    	$title = "Database List";
    	$this->document->setTitle($title);

		$this->view->assign('error_warning', $this->session->data['warning']);
		if (isset($this->session->data['warning'])) {
			unset($this->session->data['warning']);
		}
		$this->view->assign('success', $this->session->data['success']);
		if (isset($this->session->data['success'])) {
			unset($this->session->data['success']);
		}
		
		$this->loadModel('database/database');
		$data = $this->model_database_database->getDatabase();
		
		foreach($data as $row) {
			$database_id = $row['database_id'];
			
			//following sequence is important
			$result[$database_id]['database_id'] = $row['database_id'];
			$result[$database_id]['name'] = $row['name'];
			$result[$database_id]['folder'] = $row['folder'];
			$result[$database_id]['filename'] = $row['filename'];
			$result[$database_id]['sort_order'] = $row['sort_order'];
			$result[$database_id]['link'] = $this->html->getSecureURL(strtolower($row['folder'].'/'.$row['filename']));
		}
		
		$link['database/database_list'] = $this->html->getSecureURL('database/database_list');
		$link['database/database_form'] = $this->html->getSecureURL('database/database_form');
		$link['database/database_post'] = $this->html->getSecureURL('database/database_post');
		
		//include modal
		$this->addChild('modal/database/add_database', 'modal_add_database', 'modal/database/add_database.tpl');
		$this->addChild('modal/database/edit_database', 'modal_edit_database', 'modal/database/edit_database.tpl');
		$this->addChild('modal/database/delete_database', 'modal_delete_database', 'modal/database/delete_database.tpl');
		
		$this->view->assign('link', $link); 
		$this->view->assign('result', $result);
		
		$this->processTemplate('pages/database/database_list.tpl' );

        //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

