<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesMainExplore extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		//START: set result
		//END
		
		//START: set ajax
			$ajax['main/ajax_explore'] = $this->html->getSecureURL('main/ajax_explore');
			$ajax['main/ajax_favourite'] = $this->html->getSecureURL('main/ajax_favourite');
		//END
		
		//START: set modal
			$this->addChild('modal/explore/search', 'modal_explore_search', 'modal/explore/search.tpl');
			$this->addChild('modal/explore/map', 'modal_explore_map', 'modal/explore/map.tpl');
			$this->addChild('modal/explore/review', 'modal_explore_review', 'modal/explore/review.tpl');
			$this->addChild('modal/explore/favourite', 'modal_explore_favourite', 'modal/explore/favourite.tpl');
		//END
		
		//START: set link
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template 
			$this->processTemplate('pages/main/explore.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}