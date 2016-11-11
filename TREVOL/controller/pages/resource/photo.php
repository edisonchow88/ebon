<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerPagesResourcePhoto extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END

    	//START: set title
			$title = "Photo";
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
			$this->loadModel('resource/photo');
			$this->loadModel('account/user');
		//END
		
		//START: set data
			$data = $this->model_resource_photo->getPhoto();
		//END
		
		//START: set result
			foreach($data as $row) {
				$photo_id = $row['photo_id'];
				$user = $this->model_account_user->getUser($row['user_id']);
				
				//NOTE: sequence is important
				$result[$photo_id]['photo'] = json_encode($row['photo']);
				$result[$photo_id]['photo_id'] = $row['photo_id'];
				$result[$photo_id]['user_id'] = $user['email'];
				$result[$photo_id]['filename'] = $row['filename'];
				$result[$photo_id]['size'] = $row['size'];
				$result[$photo_id]['caption'] = $row['caption'];
				$result[$photo_id]['date_added'] = $row['date_added'];
				$result[$photo_id]['date_modified'] = $row['date_modified'];
			}
		//END
		
		//START: set column
			
			/* [Template]
			$i = '';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = '';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			*/
			
			//NOTE: sequence is important
			
			$i = 'photo';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords($i);
			$column[$i]['type'] = '';
			$column[$i]['width'] = '100px';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
			
			$i = 'photo_id';
			$column[$i]['name'] = 'id';
			$column[$i]['title'] = 'Id';
			$column[$i]['type'] = 'numeric';
			$column[$i]['width'] = '60px';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'user';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords($i);
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'filename';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords($i);
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'size';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords($i);
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'false';
			
			$i = 'caption';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = ucwords($i);
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'true';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'date_added';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Added';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'date_modified';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = 'Modified';
			$column[$i]['type'] = '';
			$column[$i]['width'] = '';
			$column[$i]['order'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['visible'] = 'false';
			$column[$i]['sortable'] = 'true';
			$column[$i]['searchable'] = 'true';
			
			$i = 'commands';
			$column[$i]['name'] = $i;
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = 'right';
			$column[$i]['sortable'] = 'false';
			$column[$i]['searchable'] = 'false';
		//END
		
		//START: set modal
			$this->addChild('modal/resource/upload_photo', 'modal_upload_photo', 'modal/resource/upload_photo.tpl');
			//$this->addChild('modal/resource/edit_photo', 'modal_edit_photo', 'modal/resource/edit_photo.tpl');
			$this->addChild('modal/resource/delete_photo', 'modal_delete_photo', 'modal/resource/delete_photo.tpl');
		//END
		
		//START: set variable
			$this->view->assign('column', $column);
			$this->view->assign('result', $result);
			$this->view->assign('link', $link);
		//END
		
		//START: set template
			$this->processTemplate('pages/resource/photo.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

