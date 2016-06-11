<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL 2016/01/08
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ADraft {
	protected $registry;
	protected $customer_id;
	protected $view;
	protected $draft_id;
	protected $day_id;
	protected $customer;
	protected $draft_data;
	
  	public function __construct($registry, $draft_id = '') {
  		$this->registry = $registry;
  		
		$this->load->model('draft/draft', 'storefront');
		$this->load->model('draft/day', 'storefront');
		$this->load->model('draft/activity', 'storefront');
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
		
		//START - get $draft_id
		$expiry = time() + (60*60*24*3);
		if(isset($_REQUEST['itinerary_code'])) {
			$this->draft_id = $this->model_draft_draft->getDraftIdbyItineraryCode($_REQUEST['itinerary_code']);
			$cookie = base64_encode($this->draft_id);
			setcookie('draft',$cookie,$expiry);
			$_COOKIE['draft'] = $cookie;
		}
		
		if(isset($_COOKIE['draft'])) {
			$cookie = $_COOKIE['draft'];
			$this->draft_id = base64_decode($cookie);
			setcookie('draft',$cookie,$expiry); //renew the cookie if logged in
			if(!isset($this->session->data['day_id'])) {
				$this->day_id = $this->session->data['day_id'] = $this->model_draft_day->getFirstDayId($this->draft_id);
			}
			else {
				$this->day_id = $this->session->data['day_id'];
			}
		}
		//END
		
		$this->itinerary_code = $this->model_draft_draft->getItineraryCode($this->draft_id);
	}

	public function __get($key) {
		return $this->registry->get($key);
	}
	
	public function __set($key, $value) {
		$this->registry->set($key, $value);
	}
	
	public function loadDraftData( $draft_id ) {
		if ( $draft_id ) {
			$this->draft_id = $draft_id;
		}
		$this->draft_data = $this->model_draft_draft->getDraft($this->draft_id);
		return $this->draft_data;
	}	
	
	public function setView($view) {
		$this->view = $this->session->data['view'] = $view;
		return true;
	}
	
	public function setTemplate($template_code) {
		$template_id = $this->model_draft_draft->getDraftIdbyItineraryCode($template_code);
		$this->model_draft_draft->setTemplate($this->draft_id, $template_id);
		$this->day_id = $this->model_draft_day->getFirstDayId($this->draft_id);
		$this->model_draft_day->resetDraftDayDate($this->draft_id); 
		return $this->day_id;
	}
	
	public function setTemplateCode($template_code) {
		$this->itinerary_code = $template_code;
		$this->draft_id = $this->model_draft_draft->getDraftIdbyItineraryCode($template_code);
		$this->day_id = $this->model_draft_day->getFirstDayId($this->draft_id);
		return true;
	}
	
	public function setDraftId($draft_id) {
		$this->draft_id = $this->session->data['draft_id'] = (int)$draft_id;
		return true;
	}
	
	public function setDayId($day_id) {
		$this->day_id = $this->session->data['day_id'] = (int)$day_id;
		return true;
	}
	
	public function saveDraft($customer_id) {
		return $this->model_draft_draft->saveDraft($this->draft_id, $customer_id);
	}
	
	public function editDraft($draft_name, $draft_date) {
		$data['draft_name'] = $draft_name;
		$data['draft_date'] = $draft_date;
		$this->model_draft_draft->editDraft($this->draft_id, $data);
		$this->model_draft_day->resetDraftDayDate($this->draft_id); 
		return true;
	}
	
	public function getView() {
		return $this->view;
	}
	
	public function getItineraryCode() {
		return $this->itinerary_code;
	}
	
	public function getDraftId() {
		return $this->draft_id;
	}
   	  	
	public function getDraftData(){
		return $this->draft_data;
	}
	
	public function getDraftbyItineraryCode($itinerary_code) {
		$draft_id = $this->model_draft_draft->getDraftIdbyItineraryCode($itinerary_code);
		$draft = $this->model_draft_draft->getDraft($draft_id);
		$draft['itinerary_code'] = $itinerary_code;
		$draft['day_id'] = $this->model_draft_day->getFirstDayId($draft_id);
		return $draft;
	}
	
	public function getDraft() {
		$draft = $this->model_draft_draft->getDraft($this->draft_id);
		return $draft;
	}
	
	public function getDrafts() {
		$drafts = $this->model_draft_draft->getDrafts();
		return $drafts;
	}
	
	public function getDays() {
		$days = $this->model_draft_draft->getDays($this->draft_id);
		foreach($days as $day) {
			$days[$day['day_id']]['total_activities'] = $this->model_draft_activity->getTotalDayActivities($day['day_id']);
		}
		return $days;
	}
	
	public function getDaysCount() {
		$count = count($this->getDays());
		return $count;
	}
	
	public function getDay() {
		$day = $this->model_draft_draft->getDay($this->day_id);
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
		$day_activities = $this->model_draft_activity->getDraftActivitiesByDay($this->day_id);
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
						'draft_activity_id' => $activity['draft_activity_id'],
						'sortable' => $activity['sortable'],
						'date' => $activity['date'],
						'time' => $activity['time'],
						'comment' => $activity['comment'],
						'thumbnail' => $thumbnail,
						'name' => $product['name'],
						'link' =>  $this->html->getSEOURL('product/product', $url . '&product_id=' . $activity['activity_id'], '&encode'),
			);
		}
		return $activities;
	}
	
	public function getPrevDayId() {
		$days = $this->getDays($this->draft_id);
		if(isset($days[$this->day_id]['prev_day_id'])) {
			$day_id = $days[$this->day_id]['prev_day_id'];
			return $day_id;
		}
		else {
			return false;
		}
	}
	
	public function getNextDayId() {
		$days = $this->getDays($this->draft_id);
		if(isset($days[$this->day_id]['next_day_id'])) {
			$day_id = $days[$this->day_id]['next_day_id'];
			return $day_id;
		}
		else {
			return false;
		}
	}
	
	public function addDraft() {
		$this->draft = $this->model_draft_draft->addDraft();
		$this->draft_id = $this->draft['draft_id'];
		$this->day_id = $this->draft['day_id'];
		$cookie = base64_encode($this->draft_id);
		setcookie('draft',$cookie,$expiry);
		return $this->draft;
	}
	
	public function addDay() {
		 $result = $this->model_draft_day->addDay($this->draft_id);
		 return $result;
	}
	
	public function deleteDay() {
		 $result = $this->model_draft_day->deleteDay($this->draft_id, $this->day_id);
		 return $result;
	}
	
	public function addDraftActivity($draft_id, $day_id, $activity_id) {
		$draft_activity_id = $this->model_draft_activity->addActivity($draft_id, $day_id, $activity_id);
		return $draft_activity_id;
	}
	
	public function deleteDraftActivity($draft_activity_id) {
		$result = $this->model_draft_activity->deleteDraftActivity($draft_activity_id);
		return $result;
	}
	
	public function sortDraftDay($sequence) {
		$result = $this->model_draft_day->sortDraftDay($this->draft_id, $sequence);
		return $result;
	}
	
	public function sortDraftActivity($sequence) {
		$result = $this->model_draft_activity->sortDraftActivity($sequence);
		return $result;
	}
	
	public function verifyDraftIdbyItineraryCode($itinerary_code) {
		$result = $this->model_draft_draft->verifyDraftIdbyItineraryCode($itinerary_code);
		return $result;
	}
}
