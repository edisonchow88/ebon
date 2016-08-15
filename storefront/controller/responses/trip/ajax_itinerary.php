<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerResponsesTripAjaxItinerary extends AController {
	
	public $data = array();
	
	public function main() {
		//START: testing script
			foreach($_POST as $key => $value) {
				$this->data[$key] = $value;
			}	
			
			if($this->data['action'] == 'refresh_plan') { $this->refresh_plan(); return; }
			else { 
				//IMPORTANT: Return responseText in order for xmlhttp to function properly 
				$result['warning'][] = 'System Failure: Please contact Admin.'; 
				$response = json_encode($result);
				echo $response;	
				return;
			}
			
		//END
	}
	
	public function refresh_plan() {
		$result['day'] = array();
		$line = array();
		$line[] = array('line_id' => 1, 'type' => 'poi', 'id' => 1, 'sort_order' => 1, 'title' => 'Kiyomizu Temple');
		$line[] = array('line_id' => 2, 'type' => 'poi', 'id' => 2, 'sort_order' => 2, 'title' => 'Tokyo Temple');
		$line[] = array('line_id' => 3, 'type' => 'poi', 'id' => 3, 'sort_order' => 3, 'title' => 'Osaka Temple');
		$result['day'][] = array('day_id' => 1, 'sort_order' => 1, 'duration' => '180', 'line' => $line);
		$line = array();
		$line[] = array('line_id' => 1, 'type' => 'poi', 'id' => 1, 'sort_order' => 1, 'title' => 'Kiyomizu Temple');
		$line[] = array('line_id' => 2, 'type' => 'poi', 'id' => 2, 'sort_order' => 2, 'title' => 'Tokyo Temple');
		$line[] = array('line_id' => 3, 'type' => 'poi', 'id' => 3, 'sort_order' => 3, 'title' => 'Osaka Temple');
		$result['day'][] = array('day_id' => 2, 'sort_order' => 2, 'duration' => '210', 'line' => $line);
		/*
		$this->loadModel('travel/trip');
		$result = $this->model_travel_trip->getPlanDetail($this->data['plan_id']);
		*/
		$response = json_encode($result);
		echo $response;
	}
	
	public function get_trip() {
		$text = html_entity_decode($this->data['send']);
		$json = json_decode($text,true);
		
		$this->loadModel('travel/trip');
		$this->loadModel('resource/tag');
		$this->loadModel('resource/image');
		
		$result['plan'] = $this->model_travel_trip->getAllLineByPlanId($json['plan_id']);
		$result['success'][] = '';
		
		$response = json_encode($result);
		echo $response;
	}
}

/*

 {"day" : 
[ 
		{
		"day_id": "1",
		"sort_order": "1",
        "percentage": "30",
		"line": [	
					{"line_id" : "1", "type" : "line", "id": "1", "content": {"name":"Kiyomizu Temple", "info": "DAY1POI1"}, "sort_order": "1"},
					{"line_id" : "2", "type" : "line", "id": "1", "content": {"name":"Kiyomizu Temple", "info": "DAY1POI1"}, "sort_order": "2"},
					{"line_id" : "3", "type" : "line", "id": "1", "content": {"name":"Kiyomizu Temple", "info": "DAY1POI1"}, "sort_order": "3"},
				]
		},
		{
		"day_id": "2",
		"sort_order": "2",
        "percentage": "50",
		"line": [	
					{"line_id" : "1", "type" : "line", "id": "1", "content": {"name":"Kiyomizu Temple", "info": "DAY1POI1"}, "sort_order": "1"},
					{"line_id" : "2", "type" : "line", "id": "1", "content": {"name":"Kiyomizu Temple", "info": "DAY1POI1"}, "sort_order": "2"},
					{"line_id" : "3", "type" : "line", "id": "1", "content": {"name":"Kiyomizu Temple", "info": "DAY1POI1"}, "sort_order": "3"},
				]
		},
]
 }
 */