<?php 
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerPagesTripItineraryTable extends AController {
	//START: set common variable
		public $data = array();
	//END
	
	public function main() {
		//START: init controller data
			$this->extensions->hk_InitData($this, __FUNCTION__);
		//END
		
		
		//START: set modal
		//END
		
		//START: set data
		//END
		
		//START: set result
		//END
		
		//START: set column
			$i = 'day_id';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'line_id';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'sort_order';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'day';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '40px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'datetime';
			$column[$i]['title'] = 'Date / Time';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$j = 'date';
			$column[$i]['dayName'] = $j;
			$column[$i]['dayId'] = str_replace("_","-",$j);
			$column[$i]['dayClass'] = 'plan-col-'.str_replace("_","-",$j);
			$j = 'time';
			$column[$i]['lineName'] = $j;
			$column[$i]['lineId'] = str_replace("_","-",$j);
			$column[$i]['lineClass'] = 'plan-col-'.str_replace("_","-",$j);
			$column[$i]['width'] = '80px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'duration';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['headerStyle'] = 'margin-right:10px;';
			$column[$i]['dayStyle'] = 'margin-right:10px;';
			$column[$i]['lineStyle'] = 'margin-right:10px;';
			$column[$i]['width'] = '55px';
			$column[$i]['align'] = 'right';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			$column[$i]['type'] = 'progress';
			
			$i = 'activity';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '80px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'place';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '200px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'lat';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'lng';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'false';
			
			$i = 'fee';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = ucwords(str_replace("_"," ",$i));
			$column[$i]['width'] = '50px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'currency';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '40px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'note';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '30px';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'left';
			$column[$i]['visible'] = 'true';
			
			$i = 'command';
			$column[$i]['name'] = $i;
			$column[$i]['id'] = str_replace("_","-",$i);
			$column[$i]['class'] = 'plan-col-'.str_replace("_","-",$i);
			$column[$i]['title'] = '';
			$column[$i]['width'] = '';
			$column[$i]['align'] = '';
			$column[$i]['headerAlign'] = '';
			$column[$i]['thAlign'] = 'right';
			$column[$i]['visible'] = 'true';
		//END
		
		//START: set modal
		//END
		
		//START: set link
		//END
		
		//START: set ajax
			$ajax_itinerary = $this->html->getSEOURL('trip/ajax_itinerary');
		//END
		
		//START: set variable
			$this->view->batchAssign($this->data);
			$this->view->assign('column',$column);
			$this->view->assign('column_json',json_encode(array_values($column)));
			$this->view->assign('ajax_itinerary',$ajax_itinerary);
		//END
		
		//START: set template 
			$this->processTemplate('pages/trip/itinerary_table.tpl');
		//END
		
		//START: init controller data
			$this->extensions->hk_UpdateData($this, __FUNCTION__);
		//END
	}
}