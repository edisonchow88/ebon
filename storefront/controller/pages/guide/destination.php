<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerPagesGuideDestination extends AController {
	public $data = array();
	
	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

		$this->loadLanguage('attraction/destination');

		$this->document->resetBreadcrumbs();	

		$this->loadModel('guide/destination');
		
		$destination_id = $this->request->get['id'];

		$destination_info = array();
		$destination_info = $this->model_guide_destination->getDestination($destination_id);
		
		//SET parent breadcrumbs
		$parent_id = $destination_info['parent_id'];
		if($parent_id != 0) {
			$parent_info = $this->model_guide_destination->getDestination($parent_id);
			$this->document->addBreadcrumb( array ( 
				'href'      => $this->html->getSEOURL('guide/destination', '&id=' . $parent_id),
				'text'      => $parent_info['name'],
				'separator' => FALSE
			));	
		}
		else {
			$this->document->addBreadcrumb( array ( 
				'href'      => $this->html->getURL('index/home'),
				'text'      => $this->language->get('text_home'),
				'separator' => FALSE
			));
		}
		
		if ($destination_info) {
	  		$this->document->setTitle( $destination_info['name'] );
			$this->document->setKeywords( $destination_info['meta_keywords'] );
			$this->document->setDescription( $destination_info['meta_description'] );
			
            $this->view->assign('heading_title', $destination_info['name'] );
			$this->view->assign('description', html_entity_decode($destination_info['description'], ENT_QUOTES, 'UTF-8') );
			$this->view->assign('text_sort', $this->language->get('text_sort'));
			
			
			$destination_total = $this->model_guide_destination->getTotalDestinationsByDestinationId($destination_id);
			if ($destination_total) {
        		$destinations = array();
				$results = $this->model_guide_destination->getDestinations($destination_id);
				$resource = new AResource('image');
        		foreach ($results as $result) {
			        $thumbnail = $resource->getMainThumb('destinations',
			                                     $result['destination_id'],
			                                     (int)$this->config->get('config_image_destination_width'),
			                                     (int)$this->config->get('config_image_destination_height'),true);

						$destinations[] = array(
            			'name'  => $result['name'],
            			'href'  => $this->html->getSEOURL('guide/destination', '&id=' . $result['destination_id']),
            			'thumb' => $thumbnail);
        		}
                $this->view->assign('destinations', $destinations );
			}
			
			$this->view->setTemplate( 'pages/guide/destination.tpl' );
			$this->view->batchAssign( $this->data );
    	} else {
				
			$this->document->setTitle( $this->language->get('text_error') );

      		$this->view->assign('heading_title', $this->language->get('text_error') );
            $this->view->assign('text_error', $this->language->get('text_error') );
			$this->view->assign('button_continue', $this->html->buildElement( array ('type' => 'button',
		                                               'name' => 'continue_button',
			                                           'text'=> $this->language->get('button_continue'),
			                                           'style' => 'button')));

      		$this->view->assign('continue',  $this->html->getURL('index/home') );

            $this->view->setTemplate( 'pages/error/not_found.tpl' );
		}
		
		//SET map
		$this->loadModel('guide/map');
		$map = $this->model_guide_map->getMap("destination", $destination_id);
		$this->view->assign('map_zoom', $map['zoom'] );
		$this->view->assign('map_lat', $map['lat'] );
		$this->view->assign('map_lng', $map['lng'] );
		
		//set redirect url
		$redirect = $this->html->getSEOURL('guide/destination','&id=' . $destination_id , '&encode');
		$this->session->data['redirect'] = $redirect;
		
		$trip = new ATrip($this->registry);
		//START - get $trip_id and $day_id
		$trip_id = $trip->getTripId();
		$day_id = $trip->getDayId();
		//END
		
		//set button action
		$url = $this->html->getURL('attraction/attraction');
		$this->view->assign( 'add', $url.'/add&trip_id='.$trip_id.'&day_id='.$day_id.'&activity_id=');

        $this->processTemplate();

        //init controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
  	}
}