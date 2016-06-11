<?php 
/*------------------------------------------------------------------------------
CREATED by TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesItineraryList extends AController {
	private $error = array();
	public $data = array();

	public function main() {

		//init controller data
		$this->extensions->hk_InitData($this, __FUNCTION__);

		$this->document->setTitle($this->language->get('heading_title'));
		
		$this->document->resetBreadcrumbs();

      	$this->document->addBreadcrumb( array ( 
        	'href'      => $this->html->getURL('index/home'),
        	'text'      => $this->language->get('text_home'),
        	'separator' => FALSE
      	 )); 

      	$this->document->addBreadcrumb( array ( 
        	'href'      => $this->html->getURL('itinerary/list'),
        	'text'      => 'Itineraries', //temporary solution
        	'separator' => $this->language->get('text_separator')
      	 ));
		
		$this->data['itinerary1'] = $this->html->getURL("itinerary/template&template_code=TEST0001");
		$this->data['itinerary2'] = $this->html->getURL("itinerary/template&template_code=TEST0002");
		$this->data['itinerary3'] = $this->html->getURL("itinerary/template&template_code=TEST0003");
		/*
		$this->loadModel('itinerary/template');
		$itineraries = $this->model_itinerary_template->getTemplates();
		*/
		$this->view->batchAssign( $this->data);
        $this->processTemplate();
		
		//init controller data
		$this->extensions->hk_UpdateData($this, __FUNCTION__);
	}
}