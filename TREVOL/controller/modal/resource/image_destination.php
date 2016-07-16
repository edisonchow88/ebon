<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalResourceImageDestination extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$this->loadModel('guide/destination');
		$data = $this->model_guide_destination->getDestination();
		
		$i = 0;
		foreach($data as $row) {
			$json['name'] = '{';
			$json['name'] .= '"name":';
			$json['name'] .= '"'.$row['name'].'"';
			$json['name'] .= ',';
			$json['name'] .= '"type_color":';
			$json['name'] .= '"'.$row['type_color'].'"';
			$json['name'] .= '}';
			
			$result_modal_image_destination[$i]['id'] = $row['destination_id'];
			$result_modal_image_destination[$i]['name'] = $json['name'];
			
			$i++;
		}
		
		$this->view->assign('result_modal_image_destination', $result_modal_image_destination);
		
		$this->processTemplate('modal/resource/image_destination.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

