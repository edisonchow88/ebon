<?php
if (! defined ( 'DIR_CORE' ) || !IS_ADMIN) {
	header ( 'Location: static_pages/' );
}

class ControllerModalTravelEditLine extends AController {

  	public function main() {
        //init controller data
        $this->extensions->hk_InitData($this,__FUNCTION__);
		
		//START: input [ORDER IS IMPORTANT]
		
		$i = 'section_relation';
		$modal_input[$i]['section'] = 'Relation';
		
		$i = 'plan';
		$modal_input[$i]['label'] = 'Plan';
		$modal_input[$i]['id'] = 'plan-id';
		$modal_input[$i]['name'] = 'plan_id';
		$modal_input[$i]['type'] = 'select';
		$modal_input[$i]['required'] = true;
		$modal_input[$i]['option'] = $this->model_travel_plan->getPlan();
		
		$i = 'section_general';
		$modal_input[$i]['section'] = 'General';
		
		$i = 'tag';
		$modal_input[$i]['label'] = 'Tag';
		$modal_input[$i]['id'] = 'tag-id';
		$modal_input[$i]['name'] = 'tag_id';
		$modal_input[$i]['type'] = 'select';
		$modal_input[$i]['required'] = true;
		$modal_input[$i]['option'] = $this->model_resource_tag->getTagByTypeName('line');
		
		$i = 'sort';
		$modal_input[$i]['label'] = 'Sort';
		$modal_input[$i]['id'] = 'sort-order';
		$modal_input[$i]['name'] = 'sort_order';
		$modal_input[$i]['type'] = 'text';
		
		$i = 'id';
		$modal_input[$i]['label'] = 'Id';
		$modal_input[$i]['id'] = 'line-id';
		$modal_input[$i]['name'] = 'line_id';
		$modal_input[$i]['type'] = 'hidden';
		$modal_input[$i]['required'] = false;
		$modal_input[$i]['json'] = 'line_id';
		//END: input
		
		$modal_ajax['travel/ajax_line'] = $this->html->getSecureURL('travel/ajax_line');
		
		$this->view->assign('modal_ajax', $modal_ajax);
		$this->view->assign('modal_input', $modal_input);
		
		$this->processTemplate('modal/travel/edit_line.tpl' );

          //update controller data
        $this->extensions->hk_UpdateData($this,__FUNCTION__);
	}
}
?>

