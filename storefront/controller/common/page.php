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
class ControllerCommonPage extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {

		//init controller data
		$this->extensions->hk_InitData($this,__FUNCTION__);
		
		$this->view->assign('lang', $this->language->get('code'));
		$this->view->assign('direction', $this->language->get('direction'));
		
		//BOC - ADDED by TREVOL
		$this->view->assign('error', $this->error['warning']);
		$this->view->assign('success', $this->session->data['success']);
		$this->document->addScript($this->view->templateResource('/javascript/tooltip.js'));
		$this->document->addScript($this->view->templateResource('/javascript/fontawesome-markers.min.js'));
		$this->document->addScript($this->view->templateResource('/javascript/jquery-1.10.2.js'));
		$this->document->addScript($this->view->templateResource('/javascript/jquery-ui.js'));
		
		//START: set popover hint
			if($this->session->data['hint'] != '') {
				$this->data['hint'] = $this->session->data['hint'];
				unset($this->session->data['hint']);
			}
		//END
		//EOC

        $this->addChild('common/head', 'head', 'common/head.tpl');

		foreach ($this->children as $block) {
				if ( !empty($block['position']) ) {
					$this->view->assign($block['block_txt_id'], $block['block_txt_id'].'_'.$block['instance_id']);
				}
		}

		$this->processTemplate('common/page.tpl');
		
		$col_left = false;
		$col_right = false;
		foreach($this->layout->blocks as $block) {
			if($block['block_txt_id'] == 'column_left') {
				$col_left = true;
			} else if($block['block_txt_id'] == 'column_right') {
				$col_right = true;
			}
		}
		
		$layout_css_suffix = '';
		$comumns_count= 3;
		if($col_left && !$col_right) {
			$layout_css_suffix = '-right';
			$comumns_count = 2;
		} else if($col_right && !$col_left) {
			$layout_css_suffix = '-left';
			$comumns_count = 2;
		} else if(!$col_left && !$col_right) {
			$layout_css_suffix = '-long';
			$comumns_count = 1;
		}
		
		
		$this->view->batchAssign($this->data);
		$this->view->assign('layout_columns', $comumns_count);
		$this->view->assign('layout_css_suffix', $layout_css_suffix);
		$this->view->assign('layout_width', $this->config->get('storefront_width'));
		$this->view->assign('rnk_link',base64_decode('aHR0cDovL3d3dy5hYmFudGVjYXJ0LmNvbQ=='));
		$this->view->assign('rnk_text',base64_decode('UG93ZXJlZCBieSBBYmFudGVjYXJ0IGVDb21tZXJjZSBTb2x1dGlvbg=='));


		if($this->config->get('config_maintenance') && isset($this->session->data['merchant'])){
			$this->view->assign('maintenance_warning',$this->language->get('text_maintenance_notice'));
		}
        //init controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
