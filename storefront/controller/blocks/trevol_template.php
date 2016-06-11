<?php  
/*------------------------------------------------------------------------------
CREATED BY TREVOL, 2016/01/18
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerBlocksTrevolTemplate extends AController {
	public $data = array();
	protected $category_id = 0;
	protected $path = array();
	protected $selected_root_id = array();

	public function main() {

        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$this->data['itineraries'] = $this->html->getURL("itinerary/list");
		$this->data['itinerary1'] = $this->html->getURL("itinerary/template&template_code=TEST0001");
		$this->data['itinerary2'] = $this->html->getURL("itinerary/template&template_code=TEST0002");
		$this->data['itinerary3'] = $this->html->getURL("itinerary/template&template_code=TEST0003");

		$this->view->batchAssign($this->data);
		
		$this->processTemplate();

        //init controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
  	}
}
