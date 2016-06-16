<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalResourceTagTime extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		$this->loadModel('resource/tag');
		$data = $this->model_resource_tag->getTag('',19);
		
		$i = 0;
		foreach($data as $row) {
			$json['name'] = '{';
			$json['name'] .= '"name":';
			$json['name'] .= '"'.$row['name'].'"';
			$json['name'] .= ',';
			$json['name'] .= '"type_color":';
			$json['name'] .= '"'.$row['type_color'].'"';
			$json['name'] .= '}';
			
			$result_modal_tag_time[$i]['id'] = $row['tag_id'];
			$result_modal_tag_time[$i]['name'] = $json['name'];
			
			$i++;
		}
		
		$this->view->assign('result_modal_tag_time', $result_modal_tag_time);
		
		$this->processTemplate('modal/resource/tag_time.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

