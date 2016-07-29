<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesIndexHome extends AController {
	//START: set common variable
		public $data = array();
	//END

	public function main() {

		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set page
			$this->document->setTitle( $this->config->get('config_title') );
			$this->document->setDescription( $this->config->get('config_meta_description') );
			$this->document->setKeywords( $this->config->get('config_meta_keywords') );
		//END
		
		//START: set redirect
			$redirect = $this->html->getSEOURL('trip/itinerary');
		//END
		
		//START: set modal
			$this->addChild('modal/home/splash', 'modal_home_splash', 'modal/home/splash.tpl');
		//END
		
		//START: set variable
			$this->view->batchAssign( $this->data);
			if(isset($result)) { $this->view->assign('result', $result); }
			if(isset($redirect)) { $this->view->assign('redirect', $redirect); }
		//END
		
		//START: set template 
			$this->processTemplate();
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}
