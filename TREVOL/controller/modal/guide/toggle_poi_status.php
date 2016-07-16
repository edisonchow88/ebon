<?php
//START: Verify Admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalGuideTogglePoiStatus extends AController {

  	public function main() {
       //START: Init Controller Data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: Set Input
		//END
		
		//START: Set Ajax	
			$modal_ajax['guide/ajax_poi'] = $this->html->getSecureURL('guide/ajax_poi');
		//END
		
		//START: Set Link
		//END
		
		//START: Set Variable
			$this->view->assign('modal_input', $modal_input);
			$this->view->assign('modal_ajax', $modal_ajax);
			$this->view->assign('modal_link', $modal_link);
		//END
		
		//START: Set Template
			$this->processTemplate('modal/guide/toggle_poi_status.tpl' );
		//END
		
		//START: Update Controller Data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

