<?php 
/*------------------------------------------------------------------------------
CREATED BY TREVOL, 2016/01/15
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerPagesAttractionDestination extends AController {
	public $data = array();
	
	public function main() {

		//is this an embed mode
		if($this->config->get('embed_mode') == true){
			$cart_rt = 'r/checkout/cart/embed';
		} else{
			$cart_rt = 'checkout/cart';
		}

        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);

		$this->loadLanguage('attraction/destination');

		$this->document->resetBreadcrumbs();

   		$this->document->addBreadcrumb( array ( 
      		'href'      => $this->html->getURL('index/home'),
       		'text'      => $this->language->get('text_home'),
       		'separator' => FALSE
   		 ));	

		$this->loadModel('brochure/destination');
		$this->loadModel('tool/seo_url');  
		
		if(!isset($this->request->get['path']) && isset($this->request->get['destination_id']) ){
			$this->request->get['path'] = $this->request->get['destination_id'];
		}


		if (isset($this->request->get['path'])) {
			$path = '';
		
			$parts = explode('_', $this->request->get['path']);
			if ( count($parts) == 1 ) {
				//see if this is a destination ID to sub destination, need to build full path
				$parts = explode('_', $this->model_brochure_destination->buildPath($this->request->get['path']));
			}		
			foreach ($parts as $path_id) {
				$destination_info = $this->model_brochure_destination->getDestination($path_id);
				
				if ($destination_info) {
					if (!$path) {
						$path = $path_id;
					} else {
						$path .= '_' . $path_id;
					}

	       			$this->document->addBreadcrumb( array ( 
   	    				'href'      => $this->html->getSEOURL('attraction/destination','&path=' . $path, '&encode'),
    	   				'text'      => $destination_info['name'],
        				'separator' => $this->language->get('text_separator')
        			 ));
				}
			}		
		
			$destination_id = array_pop($parts);
		} else {
			$destination_id = 0;
		}

		$destination_info = array();

		if($destination_id){
			$destination_info = $this->model_brochure_destination->getDestination($destination_id);
		} elseif($this->config->get('embed_mode') == true){
			$destination_info['name'] = $this->language->get('text_top_destination');
		}
	
		if ($destination_info) {
	  		$this->document->setTitle( $destination_info['name'] );
			$this->document->setKeywords( $destination_info['meta_keywords'] );
			$this->document->setDescription( $destination_info['meta_description'] );
			
            $this->view->assign('heading_title', $destination_info['name'] );
			$this->view->assign('description', html_entity_decode($destination_info['description'], ENT_QUOTES, 'UTF-8') );
			$this->view->assign('text_sort', $this->language->get('text_sort'));
			
			if (isset($this->request->get['page'])) {
				$page = $this->request->get['page'];
			} else { 
				$page = 1;
			}	
			if (isset($this->request->get['limit'])) {
				$limit = (int)$this->request->get['limit'];
				$limit = $limit>50 ? 50 : $limit;
			} else {
				$limit = $this->config->get('config_brochure_limit');
			}

			if (isset($this->request->get['sort'])) {
				$sorting_href = $this->request->get['sort'];
			} else {
				$sorting_href = $this->config->get('config_attraction_default_sort_order');
			}

			list($sort,$order) = explode("-",$sorting_href);

			if($sort=='name'){
				$sort = 'pd.'.$sort;
			}elseif(in_array($sort,array('sort_order','price'))){
				$sort = 'p.'.$sort;
			}

			$url = '&sort=' . $sort."-".$order;

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			$this->loadModel('brochure/attraction');
	 
			$destination_total = $this->model_brochure_destination->getTotalDestinationsByDestinationId($destination_id);
			$attraction_total = $this->model_brochure_attraction->getTotalAttractionsByDestinationId($destination_id);

			if ($destination_total || $attraction_total) {
        		$destinations = array();
        		
				$results = $this->model_brochure_destination->getDestinations($destination_id);
				$resource = new AResource('image');

        		foreach ($results as $result) {
			        $thumbnail = $resource->getMainThumb('destinations',
			                                     $result['destination_id'],
			                                     (int)$this->config->get('config_image_destination_width'),
			                                     (int)$this->config->get('config_image_destination_height'),true);

						$destinations[] = array(
            			'name'  => $result['name'],
            			'href'  => $this->html->getSEOURL('attraction/destination', '&path=' . $this->request->get['path'] . '_' . $result['destination_id'] . $url, '&encode'),
            			'thumb' => $thumbnail);
        		}
                $this->view->assign('destinations', $destinations );
		
				$this->loadModel('brochure/review');
				
				$this->view->assign('button_add_to_cart', $this->language->get('button_add_to_cart'));
				
				$attraction_ids = $attractions = array();

				$attractions_result = $this->model_brochure_attraction->getAttractionsByDestinationId($destination_id,
				                                                                 $sort,
				                                                                 $order,
				                                                                 ($page - 1) * $limit,
				                                                                 $limit);
				foreach($attractions_result as $p){
					$attraction_ids[] = (int)$p['attraction_id'];
				}
				$attractions_info = $this->model_brochure_attraction->getAttractionsAllInfo($attraction_ids);

        		foreach ($attractions_result as $result) {

			        $thumbnail = $resource->getMainThumb('attractions',
			                                     $result['attraction_id'],
			                                     (int)$this->config->get('config_image_attraction_width'),
			                                     (int)$this->config->get('config_image_attraction_height'),true);
					
					$rating = $attractions_info[$result['attraction_id']]['rating'];
					$special = FALSE;
					
					$discount = $attractions_info[$result['attraction_id']]['discount'];
 					
					if ($discount) {
						$price = $this->currency->format($this->tax->calculate($discount, $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					
						$special = $attractions_info[$result['attraction_id']]['special'];
					
						if ($special) {
							$special = $this->currency->format($this->tax->calculate($special, $result['tax_class_id'], $this->config->get('config_tax')));
						}					
					}
			
					$options = $attractions_info[$result['attraction_id']]['options'];
					
					if ($options) {
						$add = $this->html->getSEOURL('attraction/attraction','&attraction_id=' . $result['attraction_id'], '&encode');
					} else {
                        if($this->config->get('config_cart_ajax')){
                            $add = '#';
                        }else{
	                        $add = $this->html->getSecureURL($cart_rt, '&attraction_id=' . $result['attraction_id'], '&encode');
                        }
					}
					
					//check for stock status, availability and config
					$track_stock = false;
					$in_stock = false;
					$no_stock_text = $result['stock'];
					$total_quantity = 0;
					if ( $this->model_brochure_attraction->isStockTrackable($result['attraction_id']) ) {
						$track_stock = true;
		    			$total_quantity = $this->model_brochure_attraction->hasAnyStock($result['attraction_id']);
		    			//we have stock or out of stock checkout is allowed
		    			if ($total_quantity > 0 || $this->config->get('config_stock_checkout')) {
			    			$in_stock = true;
		    			}
					}
					
					$attractions[] = array(
            			'attraction_id' 	=> $result['attraction_id'],
						'name'    	 	=> $result['name'],
						'blurb' => $result['blurb'],
						'model'   	 	=> $result['model'],
            			'rating'  	 	=> $rating,
						'stars'   	 	=> sprintf($this->language->get('text_stars'), $rating),
						'thumb'   	 	=> $thumbnail,
            			'price'   	 	=> $price,
            			'call_to_order'=> $result['call_to_order'],
            			'options' 	 	=> $options,
						'special' 	 	=> $special,
						'href'    	 	=> $this->html->getSEOURL('attraction/attraction','&path=' . $this->request->get['path'] . '&attraction_id=' . $result['attraction_id'], '&encode'),
						'add'	  	 	=> $add,
						'description'	=> html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'),
						'track_stock' => $track_stock,
						'in_stock'		=> $in_stock,
						'no_stock_text' => $no_stock_text,
						'total_quantity'=> $total_quantity,
          			);
        		}
            	$this->data['attractions'] = $attractions;

				if ($this->config->get('config_customer_price')) {
					$display_price = TRUE;
				} elseif ($this->customer->isLogged()) {
					$display_price = TRUE;
				} else {
					$display_price = FALSE;
				}
                $this->view->assign('display_price', $display_price );
		
				$url = '';
		
				if (isset($this->request->get['page'])) {
					$url .= '&page=' . $this->request->get['page'];
				}
                if (isset($this->request->get['limit'])) {
                    $url .= '&limit=' . $this->request->get['limit'];
                }
		
				$sorts = array();
				$sorts[] = array(
					'text'  => $this->language->get('text_default'),
					'value' => 'p.sort_order-ASC',
					'href'  => $this->html->getSEOURL('attraction/destination', $url . '&path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC', '&encode')
				);
				
				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_name_asc'),
					'value' => 'pd.name-ASC',
					'href'  => $this->html->getSEOURL('attraction/destination', $url . '&path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC', '&encode')
				);
 
				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_name_desc'),
					'value' => 'pd.name-DESC',
					'href'  => $this->html->getSEOURL('attraction/destination', $url . '&path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC', '&encode')
				);  

				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_price_asc'),
					'value' => 'p.price-ASC',
					'href'  => $this->html->getSEOURL('attraction/destination', $url . '&path=' . $this->request->get['path'] . '&sort=p.price&order=ASC', '&encode')
				); 

				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_price_desc'),
					'value' => 'p.price-DESC',
					'href'  => $this->html->getSEOURL('attraction/destination', $url . '&path=' . $this->request->get['path'] . '&sort=p.price&order=DESC', '&encode')
				); 
				
				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->html->getSEOURL('attraction/destination', $url . '&path=' . $this->request->get['path'] . '&sort=rating&order=DESC', '&encode')
				); 
				
				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->html->getSEOURL('attraction/destination', $url . '&path=' . $this->request->get['path'] . '&sort=rating&order=ASC', '&encode')
				);

				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_date_desc'),
					'value' => 'date_modified-DESC',
					'href'  => $this->html->getSEOURL('attraction/destination', $url . '&path=' . $this->request->get['path'] . '&sort=date_modified&order=DESC', '&encode')
				);

				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_date_asc'),
					'value' => 'date_modified-ASC',
					'href'  => $this->html->getSEOURL('attraction/destination', $url . '&path=' . $this->request->get['path'] . '&sort=date_modified&order=ASC', '&encode')
				);

                $options = array();
				foreach($sorts as $item){
					$options[$item['value']] = $item['text'];
				}
				$sorting = $this->html->buildSelectbox( array (
													 'name' => 'sort',
													 'options'=> $options,
													 'value'=> $sort.'-'.$order
													 ) );
				$this->view->assign( 'sorting', $sorting );
				$this->view->assign( 'url', $this->html->getSEOURL('attraction/destination','&path=' . $this->request->get['path']));

				$pagination_url = $this->html->getSEOURL('attraction/destination','&path=' . $this->request->get['path'] . '&sort=' . $sorting_href . '&page={page}' . '&limit=' . $limit, '&encode');

				$this->view->assign('pagination_bootstrap', $this->html->buildElement( array (
											'type' => 'Pagination',
											'name' => 'pagination',
											'text'=> $this->language->get('text_pagination'),
											'text_limit' => $this->language->get('text_per_page'),
											'total'	=> $attraction_total,
											'page'	=> $page,
											'limit'	=> $limit,
											'url' => $pagination_url,
											'style' => 'pagination')) 
									);
			
                $this->view->assign('sort', $sort );
                $this->view->assign('order', $order );

				$this->view->setTemplate( 'pages/attraction/destination.tpl' );
      		} else {

        		$this->document->setTitle( $destination_info['name'] );
				$this->document->setDescription( $destination_info['meta_description'] );
        		$this->view->assign('heading_title', $destination_info['name']);
        		$this->view->assign('text_error', $this->language->get('text_empty'));
        		$this->view->assign('button_continue', $this->language->get('button_continue'));
        		$this->view->assign('continue', $this->html->getURL('index/home'));
                $this->view->assign('destinations', array());
				$this->data['attractions'] = array();
				$this->view->setTemplate( 'pages/attraction/destination.tpl' );
      		}

			$this->data['review_status'] = $this->config->get('enable_reviews');
			
			$this->view->batchAssign( $this->data );
			
    	} else {
			$url = '';
			
			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}	

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}
				
			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}	
			
			if (isset($this->request->get['path'])) {	
	       		$this->document->addBreadcrumb( array ( 
   	    			'href'      => $this->html->getSEOURL('attraction/destination','&path=' . $this->request->get['path'] . $url, '&encode'),
    	   			'text'      => $this->language->get('text_error'),
        			'separator' => $this->language->get('text_separator')
        		 ));
			}
				
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

        $this->processTemplate();

        //init controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
  	}
}