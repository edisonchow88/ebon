<?php  
/*------------------------------------------------------------------------------
CREATED BY TREVOL, 2016/04/21
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerBlocksTrevolGuide extends AController {
	public $data = array();

	public function main() {

        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$destination_id = $this->request->get['id'];
		$this->loadModel('guide/map');
		
		if($destination_id) {
			$destinations = array();
			$results = $this->model_guide_destination->getDestinations($destination_id);
			$resource = new AResource('image');
			foreach ($results as $result) {
				$thumbnail = $resource->getMainThumb('destinations',
											 $result['destination_id'],
											 '200px',
											 '200px',true);
											 
				$map = $this->model_guide_map->getMapMarkers("destination", $result['destination_id']);		
							 
				$destinations[] = array(
					'id' => $result['destination_id'],
					'name'  => $result['name'],
					'url'  => $this->html->getSEOURL('guide/destination', '&id=' . $result['destination_id']),
					'thumb' => $thumbnail,
					'lat' => $map['lat'],
					'lng' => $map['lng'],
					);
				
			}
			$this->view->assign('destinations', $destinations );
		}

		$this->view->batchAssign($this->data);
		
		$this->processTemplate();

        //init controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
  	}
}
