<?php  
/*------------------------------------------------------------------------------
CREATED by TREVOL 2016/03/29
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerBlocksTrevolMap extends AController {
	public $data=array();
	public function main() {
		//init controller data
		$this->extensions->hk_InitData($this,__FUNCTION__);
		$this->loadLanguage('blocks/trevol_map');
		
		$this->data['link']['hokkaido'] = $this->html->getURL('product/category', '&path=3_8');
		$this->data['link']['tohoku'] = $this->html->getURL('product/category', '&path=3_11');
		$this->data['link']['kanto'] = $this->html->getURL('product/category', '&path=3_9');
		$this->data['link']['chubu'] = $this->html->getURL('product/category', '&path=3_12');
		$this->data['link']['kansai'] = $this->html->getURL('product/category', '&path=3_6');
		$this->data['link']['chugoku'] = $this->html->getURL('product/category', '&path=3_13');
		$this->data['link']['shikoku'] = $this->html->getURL('product/category', '&path=3_14');
		$this->data['link']['kyushu'] = $this->html->getURL('product/category', '&path=3_15');
		$this->data['link']['okinawa'] = $this->html->getURL('product/category', '&path=3_16');
		
		$this->data['link']['sapporo'] = $this->html->getURL('product/category', '&path=3_8_22');
		$this->data['link']['hakodate'] = $this->html->getURL('product/category', '&path=3_8_23');
		$this->data['link']['sendai'] = $this->html->getURL('product/category', '&path=3_11_91_109');
		$this->data['link']['tokyo'] = $this->html->getURL('product/category', '&path=3_9_214_223');
		$this->data['link']['takayama'] = $this->html->getURL('product/category', '&path=3_12_124_163');
		$this->data['link']['nagoya'] = $this->html->getURL('product/category', '&path=3_12_122_161');
		$this->data['link']['kyoto'] = $this->html->getURL('product/category', '&path=3_6_7_207');
		$this->data['link']['osaka'] = $this->html->getURL('product/category', '&path=3_6_191_201');
		$this->data['link']['hiroshima'] = $this->html->getURL('product/category', '&path=3_13_169_188');
		//$this->data['link']['fukuoka'] = $this->html->getURL('product/category', '&path=');
		
		$this->data['link']['chitose_airport'] = $this->html->getURL('product/product', '&path=3_8_248&product_id=261');
		
		$this->view->batchAssign($this->data);
		$this->processTemplate();
		$this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
