<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerModalHomeSplash extends AController {

	public function main() {

		//START: init controller data
			$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set template
			$this->processTemplate('modal/home/splash.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
