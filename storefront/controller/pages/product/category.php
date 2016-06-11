<?php 
/*------------------------------------------------------------------------------
  $Id$

  AbanteCart, Ideal OpenSource Ecommerce Solution
  http://www.AbanteCart.com

  Copyright © 2011-2015 Belavier Commerce LLC

  This source file is subject to Open Software License (OSL 3.0)
  License details is bundled with this package in the file LICENSE.txt.
  It is also available at this URL:
  <http://www.opensource.org/licenses/OSL-3.0>

 UPGRADE NOTE:
   Do not edit or add to this file if you wish to upgrade AbanteCart to newer
   versions in the future. If you wish to customize AbanteCart for your
   needs please refer to http://www.AbanteCart.com for more information.
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerPagesProductCategory extends AController {
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

		$this->loadLanguage('product/category');

		$this->document->resetBreadcrumbs();

   		$this->document->addBreadcrumb( array ( 
      		'href'      => $this->html->getURL('index/home'),
       		'text'      => $this->language->get('text_home'),
       		'separator' => FALSE
   		 ));	

		$this->loadModel('catalog/category');
		$this->loadModel('tool/seo_url');  
		
		if(!isset($this->request->get['path']) && isset($this->request->get['category_id']) ){
			$this->request->get['path'] = $this->request->get['category_id'];
		}


		if (isset($this->request->get['path'])) {
			$path = '';
		
			$parts = explode('_', $this->request->get['path']);
			if ( count($parts) == 1 ) {
				//see if this is a category ID to sub category, need to build full path
				$parts = explode('_', $this->model_catalog_category->buildPath($this->request->get['path']));
			}		
			foreach ($parts as $path_id) {
				$category_info = $this->model_catalog_category->getCategory($path_id);
				
				if ($category_info) {
					if (!$path) {
						$path = $path_id;
					} else {
						$path .= '_' . $path_id;
					}

	       			$this->document->addBreadcrumb( array ( 
   	    				'href'      => $this->html->getSEOURL('product/category','&path=' . $path, '&encode'),
    	   				'text'      => $category_info['name'],
        				'separator' => $this->language->get('text_separator')
        			 ));
				}
			}		
		
			$category_id = array_pop($parts);
		} else {
			$category_id = 0;
		}

		$category_info = array();

		if($category_id){
			$category_info = $this->model_catalog_category->getCategory($category_id);
		} elseif($this->config->get('embed_mode') == true){
			$category_info['name'] = $this->language->get('text_top_category');
		}
	
		if ($category_info) {
	  		$this->document->setTitle( $category_info['name'] );
			$this->document->setKeywords( $category_info['meta_keywords'] );
			$this->document->setDescription( $category_info['meta_description'] );
			
            $this->view->assign('heading_title', $category_info['name'] );
			$this->view->assign('description', html_entity_decode($category_info['description'], ENT_QUOTES, 'UTF-8') );
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
				$limit = $this->config->get('config_catalog_limit');
			}

			if (isset($this->request->get['sort'])) {
				$sorting_href = $this->request->get['sort'];
			} else {
				$sorting_href = $this->config->get('config_product_default_sort_order');
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

			$this->loadModel('catalog/product');
	 
			$category_total = $this->model_catalog_category->getTotalCategoriesByCategoryId($category_id);
			$product_total = $this->model_catalog_product->getTotalProductsByCategoryId($category_id);

			if ($category_total || $product_total) {
        		$categories = array();
        		
				$results = $this->model_catalog_category->getCategories($category_id);
				$resource = new AResource('image');

        		foreach ($results as $result) {
			        $thumbnail = $resource->getMainThumb('categories',
			                                     $result['category_id'],
			                                     (int)$this->config->get('config_image_category_width'),
			                                     (int)$this->config->get('config_image_category_height'),true);

						$categories[] = array(
            			'name'  => $result['name'],
            			'href'  => $this->html->getSEOURL('product/category', '&path=' . $this->request->get['path'] . '_' . $result['category_id'] . $url, '&encode'),
            			'thumb' => $thumbnail);
        		}
                $this->view->assign('categories', $categories );
		
				$this->loadModel('catalog/review');
				
				$this->view->assign('button_add_to_cart', $this->language->get('button_add_to_cart'));
				
				$product_ids = $products = array();

				$products_result = $this->model_catalog_product->getProductsByCategoryId($category_id,
				                                                                 $sort,
				                                                                 $order,
				                                                                 ($page - 1) * $limit,
				                                                                 $limit);
				foreach($products_result as $p){
					$product_ids[] = (int)$p['product_id'];
				}
				$products_info = $this->model_catalog_product->getProductsAllInfo($product_ids);

        		foreach ($products_result as $result) {

			        $thumbnail = $resource->getMainThumb('products',
			                                     $result['product_id'],
			                                     (int)$this->config->get('config_image_product_width'),
			                                     (int)$this->config->get('config_image_product_height'),true);
					
					$rating = $products_info[$result['product_id']]['rating'];
					$special = FALSE;
					$this->view->assign('image_product_width', (int)$this->config->get('config_image_product_width').'px' );
					
					$discount = $products_info[$result['product_id']]['discount'];
 					
					if ($discount) {
						$price = $this->currency->format($this->tax->calculate($discount, $result['tax_class_id'], $this->config->get('config_tax')));
					} else {
						$price = $this->currency->format($this->tax->calculate($result['price'], $result['tax_class_id'], $this->config->get('config_tax')));
					
						$special = $products_info[$result['product_id']]['special'];
					
						if ($special) {
							$special = $this->currency->format($this->tax->calculate($special, $result['tax_class_id'], $this->config->get('config_tax')));
						}					
					}
			
					$options = $products_info[$result['product_id']]['options'];
					
					if ($options) {
						$add = $this->html->getSEOURL('product/product','&product_id=' . $result['product_id'], '&encode');
					} else {
                        if($this->config->get('config_cart_ajax')){
                            $add = '#';
                        }else{
	                        $add = $this->html->getSecureURL($cart_rt, '&product_id=' . $result['product_id'], '&encode');
                        }
					}
					
					//check for stock status, availability and config
					$track_stock = false;
					$in_stock = false;
					$no_stock_text = $result['stock'];
					$total_quantity = 0;
					if ( $this->model_catalog_product->isStockTrackable($result['product_id']) ) {
						$track_stock = true;
		    			$total_quantity = $this->model_catalog_product->hasAnyStock($result['product_id']);
		    			//we have stock or out of stock checkout is allowed
		    			if ($total_quantity > 0 || $this->config->get('config_stock_checkout')) {
			    			$in_stock = true;
		    			}
					}
					
					$products[] = array(
            			'product_id' 	=> $result['product_id'],
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
						'href'    	 	=> $this->html->getSEOURL('product/product','&path=' . $this->request->get['path'] . '&product_id=' . $result['product_id'], '&encode'),
						'add'	  	 	=> $add,
						'description'	=> html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'),
						'track_stock' => $track_stock,
						'in_stock'		=> $in_stock,
						'no_stock_text' => $no_stock_text,
						'total_quantity'=> $total_quantity,
          			);
        		}
            	$this->data['products'] = $products;

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
					'href'  => $this->html->getSEOURL('product/category', $url . '&path=' . $this->request->get['path'] . '&sort=p.sort_order&order=ASC', '&encode')
				);
				
				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_name_asc'),
					'value' => 'pd.name-ASC',
					'href'  => $this->html->getSEOURL('product/category', $url . '&path=' . $this->request->get['path'] . '&sort=pd.name&order=ASC', '&encode')
				);
 
				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_name_desc'),
					'value' => 'pd.name-DESC',
					'href'  => $this->html->getSEOURL('product/category', $url . '&path=' . $this->request->get['path'] . '&sort=pd.name&order=DESC', '&encode')
				);  

				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_price_asc'),
					'value' => 'p.price-ASC',
					'href'  => $this->html->getSEOURL('product/category', $url . '&path=' . $this->request->get['path'] . '&sort=p.price&order=ASC', '&encode')
				); 

				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_price_desc'),
					'value' => 'p.price-DESC',
					'href'  => $this->html->getSEOURL('product/category', $url . '&path=' . $this->request->get['path'] . '&sort=p.price&order=DESC', '&encode')
				); 
				
				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_rating_desc'),
					'value' => 'rating-DESC',
					'href'  => $this->html->getSEOURL('product/category', $url . '&path=' . $this->request->get['path'] . '&sort=rating&order=DESC', '&encode')
				); 
				
				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_rating_asc'),
					'value' => 'rating-ASC',
					'href'  => $this->html->getSEOURL('product/category', $url . '&path=' . $this->request->get['path'] . '&sort=rating&order=ASC', '&encode')
				);

				/* DISABLED by TREVOL, 2016/01/25
				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_date_desc'),
					'value' => 'date_modified-DESC',
					'href'  => $this->html->getSEOURL('product/category', $url . '&path=' . $this->request->get['path'] . '&sort=date_modified&order=DESC', '&encode')
				);

				$sorts[] = array(
					'text'  => $this->language->get('text_sorting_date_asc'),
					'value' => 'date_modified-ASC',
					'href'  => $this->html->getSEOURL('product/category', $url . '&path=' . $this->request->get['path'] . '&sort=date_modified&order=ASC', '&encode')
				);
				*/

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
				$this->view->assign( 'url', $this->html->getSEOURL('product/category','&path=' . $this->request->get['path']));

				$pagination_url = $this->html->getSEOURL('product/category','&path=' . $this->request->get['path'] . '&sort=' . $sorting_href . '&page={page}' . '&limit=' . $limit, '&encode');

				$this->view->assign('pagination_bootstrap', $this->html->buildElement( array (
											'type' => 'Pagination',
											'name' => 'pagination',
											'text'=> $this->language->get('text_pagination'),
											'text_limit' => $this->language->get('text_per_page'),
											'total'	=> $product_total,
											'page'	=> $page,
											'limit'	=> $limit,
											'url' => $pagination_url,
											'style' => 'pagination')) 
									);
			
                $this->view->assign('sort', $sort );
                $this->view->assign('order', $order );

				$this->view->setTemplate( 'pages/product/category.tpl' );
      		} else {

        		$this->document->setTitle( $category_info['name'] );
				$this->document->setDescription( $category_info['meta_description'] );
        		$this->view->assign('heading_title', $category_info['name']);
        		$this->view->assign('text_error', $this->language->get('text_empty'));
        		$this->view->assign('button_continue', $this->language->get('button_continue'));
        		$this->view->assign('continue', $this->html->getURL('index/home'));
                $this->view->assign('categories', array());
				$this->data['products'] = array();
				$this->view->setTemplate( 'pages/product/category.tpl' );
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
   	    			'href'      => $this->html->getSEOURL('product/category','&path=' . $this->request->get['path'] . $url, '&encode'),
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
		
		//set redirect url
		$redirect = $this->html->getSEOURL('product/category','&path=' . $this->request->get['path'] . $url, '&encode');
		$this->session->data['redirect'] = $redirect;
		
		$trip = new ATrip($this->registry);
		//START - get $trip_id and $day_id
		$trip_id = $trip->getTripId();
		$day_id = $trip->getDayId();
		//END
		
		//set button action
		$url = $this->html->getURL('product/product');
		$this->view->assign( 'add', $url.'/add&trip_id='.$trip_id.'&day_id='.$day_id.'&activity_id=');

        $this->processTemplate();

        //init controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
  	}
}