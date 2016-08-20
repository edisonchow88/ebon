<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalTravelModeReviewMode extends AController {

  	public function main() {
        //START: initiate controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set component
			$this->loadComponent('database/modal');
			
			//START: set modal
				$modal['object'] = 'mode';
				$modal['ajax'] = $this->html->getSecureURL('travel/ajax_mode');
				
				//START: set form
					$f = 'review';
					$form[$f]['action'] = $f;
					
					//START: set input [ORDER IS IMPORTANT]
						$input = array();
						
						$column = $this->model_travel_trip->getFields($this->db->table('trip_mode'));
						
						foreach($column as $c) {
							$i = $c;
							$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
							$input[$i]['id'] = str_replace("_","-",$i);
							$input[$i]['name'] = $i;
							$input[$i]['type'] = 'hidden';
							$input[$i]['required'] = false;
							$input[$i]['json'] = $i;
						}
						
						$column = $this->model_travel_trip->getFields($this->db->table('trip_mode_description'));
						
						foreach($column as $c) {
							$i = $c;
							$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
							$input[$i]['id'] = str_replace("_","-",$i);
							$input[$i]['name'] = $i;
							$input[$i]['type'] = 'hidden';
							$input[$i]['required'] = false;
							$input[$i]['json'] = $i;
						}
					//END
					
					$form[$f]['input'] = $input;
				//END
				
				$modal['form'] = $form;
			//END
			
			$modal_component['modal_form'] = $this->component_database_modal->review($modal['object'],$modal['ajax'],$modal['form']);
		//END
		
		//START: set variable
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/travel/mode/review_mode.tpl' );
		//END
		
		//START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

