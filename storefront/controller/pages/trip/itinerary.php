<?php 
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripItinerary extends AController {
	private $error = array();
	public $data = array();
	
	public function main() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);
		
		$trip = new ATrip($this->registry);
		unset($this->session->data['submitted_once']);
		
		if($_REQUEST['trip_id']) { $trip->setTripid($_REQUEST['trip_id']); }
		if($_REQUEST['template_id']) { $trip->setTripid($_REQUEST['template_id']); }
		$trip_id = $this->data['trip_id'] = $trip->getTripId();
		$day_id = $this->data['day_id'] = $trip->getDayId();
		$this->data['customer_id'] = $this->customer->getId();
		$this->data['activity_id'] = $this->request->get['product_id'];
		
		//START - setup trip or draft data
		if($trip_id != 0) {
			$this->data['drafting'] = false;
			$this->data['itinerary_code'] = $trip->getItineraryCode();
			$this->data['trip'] = $trip->getTrip();
			$this->data['trip_date'] = $trip->getTripDate();
			$this->data['trips'] = $trip->getTrips();
			$this->data['block_title'] = $this->data['trip']['trip_name'];
			$this->data['days_count'] = $trip->getDaysCount();
			$this->data['days'] = $trip->getDays();
			$this->data['prev_day_id'] = $trip->getPrevDayId();
			$this->data['next_day_id'] = $trip->getNextDayId();
			$this->data['ajax_url'] = $this->html->getURL('ajax/trip');
			//START - setup activity data
			$this->load->model('trip/activity', 'storefront');
			$this->load->model('catalog/product', 'storefront');
			$resource = new AResource('image');
			$url = $this->model_catalog_product->_build_url_params();
			foreach($this->data['days'] as $day) {
				$trip_activities = $this->model_trip_activity->getTripActivitiesByDay($day['day_id']);
				foreach ($trip_activities as $activity) {
					
					$product = $this->model_catalog_product->getProduct($activity['activity_id']);
			
					$thumbnail = $resource->getMainThumb('products',
								$activity['activity_id'],
								'100px',
								'100px',
								false);
								
					$activities[$day['day_id']][] = array (
								'trip_activity_id' => $activity['trip_activity_id'],
								'sortable' => $activity['sortable'],
								'date' => $activity['date'],
								'time' => $activity['time'],
								'comment' => $activity['comment'],
								'thumbnail' => $thumbnail,
								'name' => $product['name'], 
								'blurb' => $product['blurb'], 
								'link' =>  $this->html->getSEOURL('product/product', $url . '&product_id=' . $activity['activity_id'], '&encode'),
					);
				}
				if(!empty($activities[$day['day_id']])) {
					$this->data['activities'][$day['day_id']] = $activities[$day['day_id']];
				}
				else {
					$this->data['activities'][$day['day_id']] = array();
				}
			}
		}
		else {
			$this->data['drafting'] = true;
			$draft = new ADraft($this->registry);
			$this->data['itinerary_code'] = $draft->getItineraryCode();
			$draft_id = $this->data['draft_id'] = $draft->getDraftId();
			$day_id = $this->data['day_id'] = $draft->getDayId();
			$this->data['trip'] = $draft->getDraft();
			$this->data['trips'] = $draft->getDrafts();
			$this->data['trip']['trip_name'] = $this->data['trip']['draft_name'];
			$this->data['block_title'] = $this->data['trip']['draft_name'];
			$this->data['days_count'] = $draft->getDaysCount();
			$this->data['days'] = $draft->getDays();
			$this->data['prev_day_id'] = $draft->getPrevDayId();
			$this->data['next_day_id'] = $draft->getNextDayId();
			$this->data['ajax_url'] = $this->html->getURL('ajax/draft');
			//START - define $trip_activities array
			$this->load->model('draft/activity', 'storefront');
			$this->load->model('catalog/product', 'storefront');
			$resource = new AResource('image');
			$url = $this->model_catalog_product->_build_url_params();
			foreach($this->data['days'] as $day) {
				$draft_activities = $this->model_draft_activity->getDraftActivitiesByDay($day['day_id']);
				foreach ($draft_activities as $activity) {
					
					$product = $this->model_catalog_product->getProduct($activity['activity_id']);
			
					$thumbnail = $resource->getMainThumb('products',
								$activity['activity_id'],
								'100px',
								'100px',
								false);
								
					$activities[$day['day_id']][] = array (
								'trip_activity_id' => $activity['draft_activity_id'],
								'sortable' => $activity['sortable'],
								'date' => $activity['date'],
								'time' => $activity['time'],
								'comment' => $activity['comment'],
								'thumbnail' => $thumbnail,
								'name' => $product['name'],
								'blurb' => $product['blurb'], 
								'link' =>  $this->html->getSEOURL('product/product', $url . '&product_id=' . $activity['activity_id'], '&encode'),
								'hours' => $this->model_catalog_product->getProductHoursDetail($activity['activity_id']),
								'prices' => $this->model_catalog_product->getProductPricesDetail($activity['activity_id']), 
					);
				}
				if(!empty($activities[$day['day_id']])) {
					$this->data['activities'][$day['day_id']] = $activities[$day['day_id']];
				}
				else {
					$this->data['activities'][$day['day_id']] = array();
				}
			}
			//END
		}
		//END
		
		
		
		$this->view->setTemplate('pages/trip/activity_list.tpl');
		
		//START - set button action
		$this->view->assign( 'addTrip', $this->html->getSecureURL('trip/list/add'));
		$this->view->assign( 'deleteTrip', $this->html->getSecureURL('trip/list/delete&trip_id='.$trip_id));
		$this->view->assign( 'addDay', $this->html->getSecureURL('trip/itinerary/addDay'));
		$this->view->assign( 'deleteDay', $this->html->getSecureURL('trip/itinerary/deleteDay&trip_id='.$trip_id.'&day_id='.$day_id));
		$this->view->assign( 'deleteActivity', $this->html->getURL('trip/itinerary/delete&trip_id='.$trip_id.'&trip_activity_id=') );
		//END

		$this->view->batchAssign( $this->data);
        $this->processTemplate();

		//init controller data
		$this->extensions->hk_UpdateData($this, __FUNCTION__);
		unset($this->session->data['success']);
	}
}