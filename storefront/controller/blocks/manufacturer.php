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
class ControllerBlocksManufacturer extends AController {
	private $error = array();
	public $data = array();
	

	public function main() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);

		

		$this->getItinerary();

		//init controller data
		$this->extensions->hk_UpdateData($this, __FUNCTION__);
		unset($this->session->data['success']);
	}

	private function getItinerary() {
		$cart_rt = 'checkout/cart';
		//is this an embed mode	
		if($this->config->get('embed_mode') == true){
			$cart_rt = 'r/checkout/cart/embed';
		}

		$whishlist = $this->customer->getWishList();		
    	if ( $whishlist ) {

			$this->loadModel('tool/seo_url'); 
	 		$this->loadModel('catalog/product');
						
      		$products = array();
			$resource = new AResource('image');

      		foreach ($whishlist as $product_id => $timestamp) {
 
				$product_info = $this->model_catalog_product->getProduct($product_id);

 				$thumbnail = $resource->getMainThumb('products',
			                                     $product_id,
			                                     '30px',
			                                     '30px',true);

 		    	$options = $this->model_catalog_product->getProductOptions($product_id);
		    	if ($options) {
		    		$add = $this->html->getSEOURL('product/product','&product_id=' . $product_id, '&encode');
		    	} else {
                    $add = $this->html->getSecureURL($cart_rt, '&product_id=' . $product_id, '&encode');
		    	}

       			$products[] = array(
          			'product_id'      => $product_id,
          			'name'     => $product_info['name'],
          			'model'    => $product_info['model'],
          			'thumb'    => $thumbnail,
          			'added'	   => dateInt2Display($timestamp),
					'price'    => $this->currency->format($this->tax->calculate($product_info['price'], $product_info['tax_class_id'], $this->config->get('config_tax'))),
					'href'     => $this->html->getSEOURL('product/product', '&product_id=' . $product_id,true),
					'call_to_order' => $product_info['call_to_order'],
					'add' => $add
        		);
      		}
            $this->data['products'] =  $products;
			
			if (isset($this->session->data['redirect'])) {
				$this->data['continue'] = str_replace('&amp;','&',$this->session->data['redirect']);
				unset($this->session->data['redirect']);
			} else {
                $this->data['continue'] = $this->html->getURL('index/home');
			}
			
			$this->view->assign('error', '' );
		    if($this->session->data['error']){
		    	$this->view->assign('error', $this->session->data['error'] );
			    unset($this->session->data['error']);
		    }

			if ($this->config->get('config_customer_price')) {
			    $display_price = TRUE;
			} elseif ($this->customer->isLogged()) {
			    $display_price = TRUE;
			} else {
			    $display_price = FALSE;
			}
	        $this->data['display_price'] = $display_price;

			
			$this->view->setTemplate('blocks/itinerary.tpl');

    	} else {            
            
            $this->data['text_error'] = $this->language->get('text_empty_wishlist');

		    $this->data['button_continue'] = HtmlElementFactory::create( array('name' => 'continue',
																			   'type' => 'button',
																			   'text' =>  $this->language->get('button_continue'),
																			   'href' =>  $this->html->getURL('index/home'),
																			   'style' => 'button' ));

            $this->view->setTemplate( 'pages/error/not_found.tpl' );
    	}

		$this->data['cart'] = $this->html->getSecureURL($cart_rt);

		$this->view->batchAssign( $this->data);
        $this->processTemplate();

  	}

}
