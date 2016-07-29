<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripItineraryGuide extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set model
			$this->loadModel('guide/destination');
			$this->loadModel('resource/tag');
			$this->loadModel('resource/image');
		//END
		
		//START: set id
			if(isset($_GET['destination_id'])) {
				$destination_id = $_GET['destination_id'];
			}
			else {
				$destination_id = 1;
			}
		//END
		
		//START: set data
			$data = $this->model_guide_destination->getDestination($destination_id);
		//END
		
		//START: set result
			if(count($data) > 0) {
				$result['current']['destination_id'] = $data['destination_id'];
				$result['current']['image'] = $data['image']['image'];
				$result['current']['name'] = $data['name'];
				$result['current']['tag'] = $data['tag'];
				$result['current']['parent'] = json_encode($data['parent']);
				$result['current']['blurb'] = $data['blurb'];
				$result['current']['description'] = $data['description'];
				$result['current']['lat'] = $data['lat'];
				$result['current']['lng'] = $data['lng'];
				$result['current']['status'] = $data['status'];
				$result['current']['date_added'] = $data['date_added'];
				$result['current']['date_modified'] = $data['date_modified'];
			}
		//END
		
		//START: set result
		//END
		
		//START: set modal
		//END
		
		//START: set link
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($result) > 0) { $this->view->assign('result', $result); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/itinerary_guide.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}