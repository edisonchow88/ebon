<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesMainAjaxFavourite extends AController {
	
	public $data = array();

	public function main() {
		
		//START: load model
			$this->loadModel('explore/favourite');
			
		foreach($_POST as $key => $value) {
			$this->data[$key] = $value;
		}	
		
		$action = $this->data['action'];
		unset($this->data['action']);
		
		if($action == 'get_favourite') { $this->getFavourite(); return; }
		else if($action == 'add_favourite') { $this->addFavourite(); return; }
		else if($action == 'delete_favourite') { $this->deleteFavourite(); return; }
		else { 
		//IMPORTANT: Return responseText in order for xmlhttp to function properly 
			$result['warning'][] = 'System Failure: Please contact Admin.'; 
			$response = json_encode($result);
			echo $response;	
		}
	}
	
	
	public function getFavourite() {
		//START: set variable
			$user_id = $this->data['user_id'];
		//END
		//START: set result
			$result = $this->model_explore_favourite->getFavouriteByUserId($user_id);
		//END
		//START: format result
			if($result == false) { $result = array(); }
		//END
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
	}
	
	public function addFavourite() {
		//START: set variable
			$data['place_id'] = $this->data['place_id'];
			$data['user_id'] = $this->data['user_id'];
		//END
		
		//START: set result
			$result = $this->model_explore_favourite->addFavourite($data);
		//END
		
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
		/*
		//START: verify place_id if exist
			$favourite_id = $this->model_explore_favourite->addFavourite($data);
		//END
		//START: format result
			if($favourite_id == false) { 
				$result = 'yest'; 
			} 
			else { 
				$result = 'ya'; 
			}
		//END
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
		*/
	}
	
	public function deleteFavourite() {
		//START: set variable
			$place = $this->data['place'];
			$user_id = $this->data['user_id'];
		//END
		
		//START: execute
			foreach($place as $place_id) {
				$result = $this->model_explore_favourite->deleteFavouriteByPlaceIdAndUserId($place_id,$user_id);
			}
		//END
		
		//START: set response
			$response = json_encode($result);
			echo $response;
		//END
	}
}