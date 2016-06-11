<?php  
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerBlocksTrevolAlert extends AController {
	private $error = array();
	public $data = array();
	
	public function main() {
		$this->extensions->hk_InitData($this, __FUNCTION__);
		
		$this->data['success'] = '';
		if (isset($this->session->data['success'])) {
			$this->data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		}
		
		$this->data['error'] = '';
		if (isset($this->session->data['error'])) {
			$this->data['error'] = $this->session->data['error'];
			unset($this->session->data['error']);
		}
		
		$this->view->batchAssign($this->data);
		$this->processTemplate();
		$this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
