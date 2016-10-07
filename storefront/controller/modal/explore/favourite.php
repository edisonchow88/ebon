<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalExploreFavourite extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set ajax
			$ajax['main/ajax_explore'] = $this->html->getSecureURL('main/ajax_explore');
			$ajax['main/ajax_favourite'] = $this->html->getSecureURL('main/ajax_favourite');
		//END
		
		//START: set link
			$link['home'] = $this->html->getSecureURL('main/home');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			if(count($result) > 0) { $this->view->assign('result', $result); }
			if(count($link) > 0) { $this->view->assign('link', $link); }
			if(count($ajax) > 0) { $this->view->assign('ajax', $ajax); }
		//END
		
		//START: set template
			$this->processTemplate('modal/explore/favourite.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

