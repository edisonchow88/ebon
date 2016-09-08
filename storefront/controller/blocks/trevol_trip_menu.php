<?php 
//START: verify directory
	if (! defined ( 'DIR_CORE' )) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerBlocksTrevolTripMenu extends AController {
	//START: declare common variable
		public $data = array();
	//END
	
	public function main() {

        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
		//END
		
		//START: set modal
			$this->addChild('modal/trip/new', 'modal_trip_new', 'modal/trip/new.tpl');
			$this->addChild('modal/trip/load', 'modal_trip_load', 'modal/trip/load.tpl');
			$this->addChild('modal/trip/save', 'modal_trip_save', 'modal/trip/save.tpl');
			$this->addChild('modal/trip/delete', 'modal_trip_delete', 'modal/trip/delete.tpl');
			$this->addChild('modal/trip/remove', 'modal_trip_remove', 'modal/trip/remove.tpl');
			$this->addChild('modal/trip/share', 'modal_trip_share', 'modal/trip/share.tpl');
			$this->addChild('modal/trip/quota', 'modal_trip_quota', 'modal/trip/quota.tpl');
		//END
		
		//START: set template
			$this->processTemplate();
		//END
		
        //START: init controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
  	}
}
?>