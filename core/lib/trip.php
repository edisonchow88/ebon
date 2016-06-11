<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL 2016/01/08
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ATrip {
	protected $registry;
	protected $customer_id;
	protected $view;
	protected $trip_id;
	protected $day_id;
	protected $customer;
	protected $trip_data;
	
  	public function __construct($registry, $trip_id = '') {
  		$this->registry = $registry;
		
		$this->load->model('trip/trip', 'storefront');
		$this->load->model('trip/day', 'storefront');
		$this->load->model('trip/activity', 'storefront');
		$this->load->model('catalog/product', 'storefront');
		
		//START - get $customer_id
    	if ( class_exists($this->registry->customer) ) {
			$this->customer_id = $this->registry->customer->getId();
    	} else {
   			$this->customer = new ACustomer($registry);
    	}
		//END
		
		//START - set $view
		if(isset($this->session->data['view'])) {
			$this->view = $this->session->data['view'];
		}
		else {
			$this->view = $this->session->data['view'] = 'day';
		}
		//END
		
		//START - get $trip_id and $day_id
		if(!empty($_POST) && !isset($this->session->data['submitted_once'])) {
			// SCENARIO 1 - change the trip
			if($_POST['trip_id'] != $this->session->data['trip_id']) {
				$this->trip_id = $this->session->data['trip_id'] = $_POST['trip_id'];
				$this->day_id = $this->session->data['day_id'] = $this->model_trip_day->getFirstDayId($this->trip_id);
				$this->session->data['submitted_once'] = true;
			}
			// SCENARIO 2 - change the day
			else if($_POST['day_id'] != $this->session->data['day_id']) {
				$this->trip_id = $this->session->data['trip_id'];
				$this->day_id = $this->session->data['day_id'] = $_POST['day_id'];
				$this->session->data['submitted_once'] = true;
			}
		}
		else {
			
			if(isset($this->session->data['trip_id'])) {
				$this->trip_id = $this->session->data['trip_id'];
			}
			else {
				$this->trip_id = $this->session->data['trip_id'] = $this->model_trip_trip->getLastTripId();
			}
			
			if(isset($this->session->data['day_id'])) {
				$this->day_id = $this->session->data['day_id'];
			}
			else {
				$this->day_id = $this->session->data['day_id'] = $this->model_trip_day->getFirstDayId($this->trip_id);
			}
			
		}
		//END
		
		//START - reset $trip_id if not logged in
		if($this->customer_id == '') {
			$this->trip_id = '';
		}
		//END
		
		$this->itinerary_code = $this->model_trip_trip->getItineraryCode($this->trip_id);
	}

	public function __get($key) {
		return $this->registry->get($key);
	}
	
	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
	
	public function loadTripData( $trip_id ) {
		if ( $trip_id ) {
			$this->trip_id = $trip_id;
		}
		//get trip details for specific status. NOTE: Customer ID need to be set in customer class
		$this->trip_data = $this->model_trip_trip->getTrip($this->trip_id);
		return $this->trip_data;
	}	
	
	public function setView($view) {
		$this->view = $this->session->data['view'] = $view;
		return true;
	}
	
	public function setTripId($trip_id) {
		$this->trip_id = $this->session->data['trip_id'] = (int)$trip_id;
		return true;
	}
	
	public function setDayId($day_id) {
		$this->day_id = $this->session->data['day_id'] = (int)$day_id;
		return true;
	}
	
	public function saveTrip ($trip_name, $travel_date) {
		$data['trip_name'] = $trip_name;
		$data['date_start'] = $travel_date;
		$trip = $this->model_trip_trip->editTrip($this->trip_id, $data);
		return true;
	}
	
	public function getView() {
		return $this->view;
	}
	
	public function getItineraryCode() {
    	return $this->itinerary_code;
  	}
	
  	public function getTripId() {
    	return $this->trip_id;
  	}
	
	public function getTripDate() {
		$trip = $this->model_trip_trip->getTrip($this->trip_id);
		$date = $trip['date_start'];
		return $date;
	}
   	  	
	public function getTripData(){
		return $this->trip_data;
	}
	
	public function getTrip() {
		$trip = $this->model_trip_trip->getTrip($this->trip_id);
		return $trip;
	}
	
	public function getTrips() {
		$trips = $this->model_trip_trip->getTrips();
		return $trips;
	}
	
	public function getDays() {
		$days = $this->model_trip_trip->getDays($this->trip_id);
		foreach($days as $day) {
			$days[$day['day_id']]['total_activities'] = $this->model_trip_activity->getTotalDayActivities($day['day_id']);
		}
		return $days;
	}
	
	public function getDaysCount() {
		$count = count($this->getDays());
		return $count;
	}
	
	public function getDay() {
		$day = $this->model_trip_trip->getDay($this->day_id);
		return $day;
	}
	
	public function getDayId() {
    	return $this->day_id;
  	}
	
	public function getDayActivitiesCount() {
		$count = count($this->getDayActivities());
		return $count;
	}
	
	public function getDayActivities() {
		$day_activities = $this->model_trip_activity->getTripActivitiesByDay($this->day_id);
		$resource = new AResource('image');
		$url = $this->model_catalog_product->_build_url_params();
		foreach ($day_activities as $activity) {
			$product = $this->model_catalog_product->getProduct($activity['activity_id']);
			$thumbnail = $resource->getMainThumb('products',
						$activity['activity_id'],
						'32px',
						'32px',
						false);
			$activities[] = array (
						'trip_activity_id' => $activity['trip_activity_id'],
						'sortable' => $activity['sortable'],
						'date' => $activity['date'],
						'time' => $activity['time'],
						'comment' => $activity['comment'],
						'thumbnail' => $thumbnail,
						'name' => $product['name'],
						'link' =>  $this->html->getSEOURL('product/product', $url . '&product_id=' . $activity['activity_id'], '&encode'),
			);
		}
		//$activities = array();
		//$activities[] = array('trip_activity_id'=>2,'sortable'=>1,'date'=>'','time'=>'','comment'=>'','thumbnail'=>array('thumb_html'=>'haha'),'name'=>count($trip_activities),'link'=>'');
		return $activities;
	}
	
	public function getPrevDayId() {
		$days = $this->getDays($this->trip_id);
		if(isset($days[$this->day_id]['prev_day_id'])) {
			$day_id = $days[$this->day_id]['prev_day_id'];
			return $day_id;
		}
		else {
			return false;
		}
	}
	
	public function getNextDayId() {
		$days = $this->getDays($this->trip_id);
		if(isset($days[$this->day_id]['next_day_id'])) {
			$day_id = $days[$this->day_id]['next_day_id'];
			return $day_id;
		}
		else {
			return false;
		}
	}
	
	public function addDay() {
		 $result = $this->model_trip_day->addDay($this->trip_id);
		 return $result;
	}
	
	public function deleteDay() {
		 $result = $this->model_trip_day->deleteDay($this->trip_id, $this->day_id);
		 return $result;
	}
	
	public function addTripActivity($trip_id, $day_id, $activity_id) {
		$trip_activity_id = $this->model_trip_activity->addActivity($trip_id, $day_id, $activity_id);
		return $trip_activity_id;
	}
	
	public function deleteTripActivity($trip_activity_id) {
		$result = $this->model_trip_activity->deleteTripActivity($trip_activity_id);
		return $result;
	}
	
	public function sortTripDay($sequence) {
		$result = $this->model_trip_day->sortTripDay($this->trip_id, $sequence);
		return $result;
	}
	
	public function sortTripActivity($sequence) {
		$result = $this->model_trip_activity->sortTripActivity($sequence);
		return $result;
	}
}
