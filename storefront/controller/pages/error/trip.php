<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ControllerPagesErrorTrip extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START:
			$this->document->setTitle('Error');
		//END
		
		//START: set variable
			$this->data['website_name'] = 'Trevol';
			switch($this->session->data['error']) {
				case 'trip_not_found':
					$this->data['error_title'] = 'Trip cannot be found';
					$this->data['error_description'] = 'It may have been removed or deleted.';
					$this->data['error_icon'] = 'fa-exclamation-triangle';
					$this->data['error_button'][] = array(
						'title' => 'Back to Home', 
						'url' => $this->html->getSecureURL('index/home'),
						'class' => 'btn-default'
					);
					break;
				case 'trip_removed':
					$this->data['error_title'] = 'Trip cannot be accessed';
					$this->data['error_description'] = 'It has been moved to archive. You may access it only if the owner restores it.';
					$this->data['error_icon'] = 'fa-exclamation-triangle';
					$this->data['error_button'][] = array(
						'title' => 'Back to Home', 
						'url' => $this->html->getSecureURL('index/home'),
						'class' => 'btn-default'
					);
					break;
				case 'plan_not_found':
					$this->data['error_title'] = 'Plan cannot be found';
					$this->data['error_description'] = 'It may have been deleted.';
					$this->data['error_icon'] = 'fa-exclamation-triangle';
					$this->data['error_button'][] = array(
						'title' => 'Back to Home', 
						'url' => $this->html->getSecureURL('index/home'),
						'class' => 'btn-default'
					);
					break;
				case 'trip_and_plan_mismatch':
					$this->data['error_title'] = 'Trip and Plan do not match';
					$this->data['error_description'] = 'Please confirm the url with the owner.';
					$this->data['error_icon'] = 'fa-exclamation-triangle';
					$this->data['error_button'][] = array(
						'title' => 'Back to Home', 
						'url' => $this->html->getSecureURL('index/home'),
						'class' => 'btn-default'
					);
					break;
				case 'private_trip_require_sign_in':
					$this->data['error_title'] = 'You need permission';
					$this->data['error_description'] = 'Please sign in to view the trip.';
					$this->data['error_icon'] = 'fa-lock';
					$this->data['error_button'][] = array(
						'title' => 'Back to Home', 
						'url' => $this->html->getSecureURL('index/home'),
						'class' => 'btn-default'
					);
					break;
				case 'private_trip_no_access':
					$this->data['error_title'] = 'You need permission';
					$this->data['error_description'] = 'Ask the owner for access, or switch to an account with permission.<br/><br/>You are signed in as <b>'.$this->user->getEmail().'</b>';
					$this->data['error_icon'] = 'fa-lock';
					$this->data['error_button'][] = array(
						'title' => 'Back to Home', 
						'url' => $this->html->getSecureURL('index/home'),
						'class' => 'btn-default'
					);
					break;
				default:
					break;
			}
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
		//END
		
		//START: set template
			$this->processTemplate('pages/error/trip.tpl');
		//END

        //START: init controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
  	}
}
?>