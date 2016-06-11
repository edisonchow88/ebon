<?php
/*------------------------------------------------------------------------------
  $Id$

  AbanteCart, Ideal OpenSource Ecommerce Solution
  http://www.AbanteCart.com

  Copyright © 2011-2015 Belavier Commerce LLC

  This source file is subject to Open Software License (OSL 3.0)
  Lincence details is bundled with this package in the file LICENSE.txt.
  It is also available at this URL:
  <http://www.opensource.org/licenses/OSL-3.0>

 UPGRADE NOTE:
   Do not edit or add to this file if you wish to upgrade AbanteCart to newer
   versions in the future. If you wish to customize AbanteCart for your
   needs please refer to http://www.AbanteCart.com for more information.
------------------------------------------------------------------------------*/
if ( !defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ModelExtensionDefaultBanktransfer extends Model {
  	public function getMethod($address) {
		$this->load->language('default_banktransfer/default_banktransfer');
		
		if ($this->config->get('default_banktransfer_status')) {
      		$query = $this->db->query("SELECT * FROM " . $this->db->table("zones_to_locations") . " WHERE location_id = '" . (int)$this->config->get('default_banktransfer_location_id') . "' AND country_id = '" . (int)$address['country_id'] . "' AND (zone_id = '" . (int)$address['zone_id'] . "' OR zone_id = '0')");
			
			if (!$this->config->get('default_banktransfer_location_id')) {
        		$status = TRUE;
      		} elseif ($query->num_rows) {
      		  	$status = TRUE;
      		} else {
     	  		$status = FALSE;
			}	
      	} else {
			$status = FALSE;
		}
		
		$method_data = array();
	
		if ($status) {  
      		$method_data = array( 
        		'id'         => 'default_banktransfer',
        		'title'      => $this->language->get('text_title'),
				'sort_order' => $this->config->get('default_banktransfer_sort_order')
      		);
    	}
   
    	return $method_data;
  	}
}