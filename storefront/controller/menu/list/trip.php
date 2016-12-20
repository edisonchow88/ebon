<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerMenuListTrip extends AController {
	//START: set common variable
		public $data = array();
	//END
	
  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set link
			$link['list/trip/upcoming'] = $this->html->getSecureURL('list/trip/upcoming');
			$link['list/trip/past'] = $this->html->getSecureURL('list/trip/past');
			$link['list/trip/cancelled'] = $this->html->getSecureURL('list/trip/cancelled');
			$link['list/trip/removed'] = $this->html->getSecureURL('list/trip/removed');
			$link['list/trip/invited'] = $this->html->getSecureURL('list/trip/invited');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template
			$this->processTemplate('menu/list/trip.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

