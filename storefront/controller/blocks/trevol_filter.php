<?php  
/*------------------------------------------------------------------------------
CREATED by TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerBlocksTrevolFilter extends AController {
	public $data=array();
	public function main() {
		//init controller data
		$this->extensions->hk_InitData($this,__FUNCTION__);
		
		$this->data['anchor_map'] = $this->html->currentURL().'#map';
		$this->data['anchor_destination'] = $this->html->currentURL().'#destination';
		
		$this->data['link_itinerary'] = $this->html->getURL('itinerary/list');

		$this->view->batchAssign($this->data);
		$this->processTemplate();
		$this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
