<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesAccountAjaxUserGroup extends AController {
	
	public $data = array();

	public function main() {
		$this->loadModel('account/user');
		
		foreach($_POST as $key => $value) {
			$this->data[$key] = $value;
		}
		
		$action = $this->data['action'];
		unset($this->data['action']);
		
		if($action == 'get') { $this->get(); }
		else if($action == 'add') { $this->add(); }
		else if($action == 'edit') { $this->edit(); }
		else if($action == 'delete') { $this->delete(); }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'No action has been sent via POST'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	public function get() {
		$user_group_id = $this->data['user_group_id']; 
		$result = $this->model_account_user->getUserGroup($user_group_id);
		$response = json_encode($result);
		echo $response;
	}
	
	public function add() {
		if($this->verify() == 'failed') { return; }
		
		$user_group_id = $this->model_account_user->addUserGroup($this->data); 
		$this->session->data['success'] = 'Success: New <b>User Group #'.$user_group_id.'</b> has been added';
		
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
		$result['success'][] = true;
		$response = json_encode($result);
		echo $response;
	}
	
	public function edit() {
		if($this->verify() == 'failed') { return; }
		
		$user_group_id = $this->data['user_group_id']; 
		$execution = $this->model_account_user->editUserGroup($user_group_id, $this->data); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>User Group #".$user_group_id."</b> has been modified";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function delete() {
		$user_group_id = $this->data['user_group_id'];
		
		//START: verify
			$count = $this->model_account_user->countUserByUserGroupId($user_group_id);
			
			if($count > 0) {
				$result['warning'][] = 'Found <b>'.$count.'</b> Users. Please remove it before delete User Group';
			}
			
			if(count($result['warning']) > 0) { 
				$response = json_encode($result);
				echo $response;	
				return 'failed';
			}
		//END
		
		$execution = $this->model_account_user->deleteUserGroup($user_group_id); 
		if($execution == true) { 
			$this->session->data['success'] = "Success: <b>User Group #".$user_group_id."</b> has been deleted";
			
			//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['success'][] = true;
			$response = json_encode($result);
			echo $response;
		}
	}
	
	public function verify() {
		if($this->data['name'] == '') {
			$result['warning'][] = 'Please input <b>Name</b>';
		}
		
		if(count($result['warning']) > 0) { 
			$response = json_encode($result);
			echo $response;	
			return 'failed';
		}
	}
}