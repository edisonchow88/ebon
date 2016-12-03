<?php
//START: verify admin
	if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
		header ( 'Location: static_pages/' );
	}
//END

class ControllerModalTravelSampleEditSample extends AController {

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
					$f = 'edit';
					$form[$f]['action'] = $f;
					
					//START: set input [ORDER IS IMPORTANT]
						$input = array();
						
						$i ='general';
						$input['section'.$i]['section'] = ucwords(str_replace("_"," ",$i));
						
						$i ='trip_id';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['type'] = 'hidden';
						$input[$i]['required'] = false;
						$input[$i]['json'] = $i;
						
						$i ='sample_id';
						$input[$i]['label'] = ucwords(str_replace("_"," ",$i));
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['type'] = 'hidden';
						$input[$i]['required'] = false;
						$input[$i]['json'] = $i;
						
						$i = 'ranking';
						$input[$i]['label'] = 'Ranking (Numbers)';
						$input[$i]['id'] = 'ranking';
						$input[$i]['name'] = 'ranking';
						$input[$i]['type'] = 'text';
						$input[$i]['required'] = true;
					//END
					
					$form[$f]['input'] = $input;
				//END
				
				//START: set form
					$f = 'get';
					$form[$f]['action'] = $f;
					
					//START: set input [ORDER IS IMPORTANT]
						$input = array();
						
						$i ='sample_id';
						$input[$i]['id'] = str_replace("_","-",$i);
						$input[$i]['name'] = $i;
						$input[$i]['type'] = 'hidden';
					//END
					
					$form[$f]['input'] = $input;
				//END
				
				$modal['form'] = $form;
			//END
			
			$modal_component['modal_form'] = $this->component_database_modal->edit($modal['object'],$modal['ajax'],$modal['form']);
		//END
		
		//START: set variable
			$this->view->assign('modal_component', $modal_component);
		//END
		
		//START: set template
			$this->processTemplate('modal/travel/sample/edit_sample.tpl' );
		//END
		
		//START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
		
		
	}
}
?>

