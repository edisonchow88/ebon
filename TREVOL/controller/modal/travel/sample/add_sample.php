<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalTravelSampleAddSample extends AController {

  	public function main() {
        //START: initiate controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set component
			$this->loadComponent('database/modal');
			
			//START: set modal
				$modal['object'] = 'sample';
				$modal['ajax'] = $this->html->getSecureURL('travel/ajax_sample');
				
				//START: set form
					$f = 'add';
					$form[$f]['action'] = $f;
					
					
					//START: set input [ORDER IS IMPORTANT]
						$input = array();
										
						$i ='general';
						$input['section'.$i]['section'] = ucwords(str_replace("_"," ",$i));
						/**/
						$i ='trip_id';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['type'] = 'hidden';
						$input[$i]['required'] = false;
						//$input[$i]['text'] = ""
						
						/*
						$i = 'status';
						$input[$i]['label'] = 'Status';
						$input[$i]['id'] = 'status';
						$input[$i]['name'] = 'status';
						$input[$i]['type'] = 'select';
						$option = array();
							$option[0]['status'] = 0;
							$option[0]['name'] = 'OFF';
							$option[1]['status'] = 1;
							$option[1]['name'] = 'ON';
						$input[$i]['option'] = $option;
						$input[$i]['required'] = true;
						$input[$i]['value'] = 1;
						*/
						
						$i = 'ranking';
						$input[$i]['label'] = 'Ranking (Numbers)';
						$input[$i]['id'] = 'ranking';
						$input[$i]['name'] = 'ranking';
						$input[$i]['type'] = 'text';
						$input[$i]['required'] = true;
						$input[$i]['value'] = 0;
					//END
					
					$form[$f]['input'] = $input;
				//END
				
				$modal['form'] = $form;
			//END
			
			$modal_component['modal_form'] = $this->component_database_modal->add($modal['object'],$modal['ajax'],$modal['form']);
		//END
		
		//START: set variable
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/travel/sample/add_sample.tpl' );
		//END
		
		//START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

