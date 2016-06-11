<?php  
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerBlocksTrip extends AController {
	private $error = array();
	public $data = array();
	
	public function main() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);
		
		
		$this->document->addStyle(array(
			'href' => $this->view->templateResource('/stylesheet/jquery.smoothness.css'),
			'rel' => 'stylesheet',
			'media' => 'screen',
		));
		$this->document->addStyle(array(
			'href' => $this->view->templateResource('/stylesheet/trip.css'),
			'rel' => 'stylesheet',
			'media' => 'screen',
		));
		$this->document->addScript($this->view->templateResource('/javascript/jquery-1.10.2.js'));
		$this->document->addScript($this->view->templateResource('/javascript/jquery-ui.js'));
		
		$trip = new ATrip($this->registry);
		unset($this->session->data['submitted_once']);
		
		$trip_id = $this->data['trip_id'] = $trip->getTripId();
		$day_id = $this->data['day_id'] = $trip->getDayId();
		$this->data['customer_id'] = $this->customer->getId();
		
		if($this->data['customer_id'] == '') {
			$this->data['url_log_in'] = $this->html->getURL("account/login");
			$this->data['url_register'] = $this->html->getURL("account/create");
		}
		
		$this->data['activity_id'] = $this->request->get['product_id'];
		$this->data['view'] = $trip->getView();
		
		//START - setup trip or draft data
		if($trip_id != 0) {
			$this->data['drafting'] = false;
			$this->data['itinerary_code'] = $trip->getItineraryCode();
			$this->data['itinerary_link'] = $this->html->getURL("trip/itinerary&itinerary_code=".$this->data['itinerary_code']);
			$this->data['trip'] = $trip->getTrip();
			$this->data['trip_date'] = $trip->getTripDate();
			$this->data['travel_date'] = $trip->getTripDate();
			$this->data['trips'] = $trip->getTrips();
			$this->data['block_title'] = $this->data['trip']['trip_name'];
			$this->data['days_count'] = $trip->getDaysCount();
			$this->data['days'] = $trip->getDays();
			$this->data['prev_day_id'] = $trip->getPrevDayId();
			$this->data['next_day_id'] = $trip->getNextDayId();
			$this->data['ajax_url'] = $this->html->getURL('ajax/trip');
			//START - define $trip_activities array
			$this->load->model('trip/activity', 'storefront');
			$this->load->model('catalog/product', 'storefront');
			$trip_activities = $this->model_trip_activity->getTripActivitiesByDay($day_id);
			$resource = new AResource('image');
			$url = $this->model_catalog_product->_build_url_params();
			foreach ($trip_activities as $activity) {
				
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
			if(!empty($activities)) {
				$this->data['activities'] = $activities;
			}
			else {
				$this->data['activities'] = array();
			}
			//END
		}
		else {
			$draft = new ADraft($this->registry);
			$draft_id = $this->data['draft_id'] = $draft->getDraftId();
			$this->data['ajax_url'] = $this->html->getURL('ajax/draft');
			if($draft_id != 0) {
				$this->data['drafting'] = true;
				$day_id = $this->data['day_id'] = $draft->getDayId();
				$this->data['itinerary_code'] = $draft->getItineraryCode();
				$this->data['itinerary_link'] = $this->html->getURL("trip/itinerary&itinerary_code=".$this->data['itinerary_code']);
				$this->data['trip'] = $draft->getDraft();
				$this->data['trip']['trip_name'] = $this->data['trip']['draft_name'];
				$this->data['travel_date'] = $this->data['trip']['draft_date'];
				$this->data['block_title'] = $this->data['trip']['draft_name'];
				$this->data['days_count'] = $draft->getDaysCount();
				$this->data['days'] = $draft->getDays();
				$this->data['prev_day_id'] = $draft->getPrevDayId();
				$this->data['next_day_id'] = $draft->getNextDayId();
				//START - define $trip_activities array
				$this->load->model('draft/activity', 'storefront');
				$this->load->model('catalog/product', 'storefront');
				$draft_activities = $this->model_draft_activity->getDraftActivitiesByDay($day_id);
				$resource = new AResource('image');
				$url = $this->model_catalog_product->_build_url_params();
				foreach ($draft_activities as $activity) {
					
					$product = $this->model_catalog_product->getProduct($activity['activity_id']);
			
					$thumbnail = $resource->getMainThumb('products',
								$activity['activity_id'],
								'32px',
								'32px',
								false);
								
					$activities[] = array (
								'trip_activity_id' => $activity['draft_activity_id'],
								'sortable' => $activity['sortable'],
								'date' => $activity['date'],
								'time' => $activity['time'],
								'comment' => $activity['comment'],
								'thumbnail' => $thumbnail,
								'name' => $product['name'],
								'link' =>  $this->html->getSEOURL('product/product', $url . '&product_id=' . $activity['activity_id'], '&encode'),
					);
				}
				if(!empty($activities)) {
					$this->data['activities'] = $activities;
				}
				else {
					$this->data['activities'] = array();
				}
				//END
			}
			else {
				$this->data['drafting'] = false;
			}
		}
		//END
		
		$this->data['anchor_top'] = $this->html->currentURL().'#top';
		$this->data['itinerary_url'] = $this->html->getURL("trip/itinerary&itinerary_code=");
		
		$this->view->setTemplate('blocks/trip.tpl');

		$this->view->batchAssign( $this->data);
        $this->processTemplate();

		//init controller data
		$this->extensions->hk_UpdateData($this, __FUNCTION__);
	}
}
