<?php 
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesItineraryTemplate extends AController {
	private $error = array();
	public $data = array();
	
	public function main() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);
		
		$this->document->resetBreadcrumbs();

		$this->document->addBreadcrumb( array ( 
		  'href'      => $this->html->getURL('index/home'),
		  'text'      => $this->language->get('text_home'),
		  'separator' => FALSE
		)); 
		
		//temporary solution
		if($_REQUEST['template_code'] == 'TEST0001') {
			$template_name = "White Hokkaido Love Story";
		}
		else if($_REQUEST['template_code'] == 'TEST0002') {
			$template_name = "Hokkaido Pink Moss";
		}
		else if($_REQUEST['template_code'] == 'TEST0003') {
			$template_name = "Hokkaido Purple Romance";
		}
		else {
			$template_name = "Template";
		}
		
		$this->document->setTitle($template_name);
		
		$this->document->addBreadcrumb( array ( 
		  'href'      => $this->html->getURL('itinerary/list'),
		  'text'      => 'Itineraries',
		  'separator' => $this->language->get('text_separator')
		));
		 
		$this->document->addBreadcrumb( array ( 
		  'href'      => substr($this->html->currentURL(),0,-1),
		  'text'      => $template_name,
		  'separator' => $this->language->get('text_separator')
		));
		
		$draft = new ADraft($this->registry);
		unset($this->session->data['submitted_once']);
		
		$template_code = $_REQUEST['template_code'];
		
		$draft->setTemplateCode($template_code);
		$this->data['itinerary_code'] = $template_code;
		
		$draft_id = $this->data['draft_id'] = $draft->getDraftId();
		$this->data['trip'] = $draft->getDraft();
		$this->data['template_name'] = $this->data['trip']['draft_name'];
		$this->data['days_count'] = $draft->getDaysCount();
		$this->data['days'] = $draft->getDays();
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
		
		$this->view->batchAssign( $this->data);
        $this->processTemplate();

		//init controller data
		$this->extensions->hk_UpdateData($this, __FUNCTION__);
		unset($this->session->data['success']);
	}
}