<?php  
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
$draft = new ADraft($this->registry);

//GET request data
$action = $_REQUEST['action'];

//set variables
$view = $draft->setView($_REQUEST['view']);
$draft_id = $draft->setDraftId($_REQUEST['draft']);
$day_id = $draft->setDayId($_REQUEST['day']);

$result = '';
//identify action
if($action == "save_draft") {
	$result = $draft->saveDraft($_REQUEST['draft_name'], $_REQUEST['travel_date']);
}
else if($action == "load_trip") {
	$result = $draft->verifyDraftIdbyItineraryCode($_REQUEST['itinerary_code']);
	if($result == false) { 
		return; 
	}
	else {
		$load = $draft->getDraftbyItineraryCode($_REQUEST['itinerary_code']);
		$result = '';
		$result .= '{';
			$result .= '"draft_name":"'.$load["draft_name"].'"';
			$result .= ',';
			$result .= '"draft_date":"'.$load["draft_date"].'"';
			$result .= ',';
			$result .= '"draft_id":"'.$load["draft_id"].'"';
			$result .= ',';
			$result .= '"day_id":"'.$load["day_id"].'"';
			$result .= ',';
			$result .= '"itinerary_code":"'.$load["itinerary_code"].'"';
		$result .= '}';
	}
}
else if($action == "set_template") {
	$day_id = $draft->setTemplate($_REQUEST['template_code']);
	$result = $day_id;
}
else if($action == "save_trip_name") {
	$draft_name = $_REQUEST['draft_name'];
	$draft_date = $_REQUEST['travel_date'];
	$draft->editDraft($draft_name, $draft_date);
}
else if($action == "save_travel_date") {
	$draft_name = $_REQUEST['draft_name'];
	$draft_date = $_REQUEST['travel_date'];
	$draft->editDraft($draft_name, $draft_date);
}
else if($action == "refresh_day_list") {
	$days = $draft->getDays();
	
	$result .= '[';
	$i = 0;
	$n = count($days);
	foreach($days as $day) {
		$i += 1;
		$result .= '{';
		$result .= '"day_id":"'.$day["day_id"].'"';
		$result .= ',';
		if($day["date"] != '0000-00-00') {
			$result .= '"date":"'.date( "M d", strtotime($day["date"])).'"';
			$result .= ',';
			$result .= '"day":"'.date( "D", strtotime($day["date"])).'"';
			$result .= ',';
		}
		else {
			$result .= '"date":"'.$day["date"].'"';
			$result .= ',';
		}
		$result .= '"sortable":"'.$day["sortable"].'"';
		$result .= ',';
		$result .= '"total_activities":"'.$day["total_activities"].'"';
		$result .= '}';
		if($i != $n) { $result .= ','; }
	}
	$result .= ']';
}
else if($action == "refresh_activity_list") {
	$day = $draft->getDay();
	$activities = $draft->getDayActivities();
	$prev_day_id = $draft->getPrevDayId();
	$next_day_id = $draft->getNextDayId();
	
	$result .= '{';
		$result .= '"day_selected":';
			$result .= '{';
			$result .= '"day_id":"'.$day["day_id"].'"';
			$result .= ',';
			if($day["date"] != '0000-00-00') {
				$result .= '"date":"'.date( "M d", strtotime($day["date"])).'"';
				$result .= ',';
				$result .= '"day":"'.date( "D", strtotime($day["date"])).'"';
				$result .= ',';
			}
			else {
				$result .= '"date":"'.$day["date"].'"';
				$result .= ',';
			}
			$result .= '"sortable":"'.$day["sortable"].'"';
			$result .= ',';
			$result .= '"total_activities":"'.$day["total_activities"].'"';
			$result .= ',';
			$result .= '"prev_day_id":"'.$prev_day_id.'"';
			$result .= ',';
			$result .= '"next_day_id":"'.$next_day_id.'"';
			$result .= '}';
		$result .= ',';
		$result .= '"activity":';
		
			$n = count($activities);
			if($n > 0) {
				$result .= '[';
				$i = 0;
				foreach($activities as $activity) {
					$i += 1;
					$result .= '{';
					$result .= '"draft_activity_id":"'.$activity["draft_activity_id"].'"';
					$result .= ',';
					$result .= '"sortable":"'.$activity["sortable"].'"';
					$result .= ',';
					$result .= '"date":"'.$activity["date"].'"';
					$result .= ',';
					$result .= '"time":"'.$activity["time"].'"';
					$result .= ',';
					$result .= '"comment":"'.$activity["comment"].'"';
					$result .= ',';
					$result .= '"thumb_url":"'.$activity["thumbnail"]["thumb_url"].'"';
					$result .= ',';
					$result .= '"name":"'.$activity["name"].'"';
					$result .= ',';
					$result .= '"link":"'.$activity["link"].'"';
					$result .= '}';
					if($i != $n) { $result .= ','; }
				}
				$result .= ']';
			}
			else {
				$result .= '"empty"';
			}
	$result .= '}';
}
else if($action == "add_trip") {
	$new = $draft->addDraft();
	$result .= '{';
		$result .= '"draft_name":"'.$new["draft_name"].'"';
		$result .= ',';
		$result .= '"draft_date":"'.$new["draft_date"].'"';
		$result .= ',';
		$result .= '"draft_id":"'.$new["draft_id"].'"';
		$result .= ',';
		$result .= '"day_id":"'.$new["day_id"].'"';
		$result .= ',';
		$result .= '"itinerary_code":"'.$new["itinerary_code"].'"';
	$result .= '}';
}
else if($action == "add_day") {
	$result = $draft->addDay();
}
else if($action == "delete_day") {
	$prev_day_id = $draft->getPrevDayId();
	$next_day_id = $draft->getNextDayId();
	if($prev_day_id != '') { 
		$new_day_id = $prev_day_id; 
	}
	else if($next_day_id != '') { 
		$new_day_id = $next_day_id; 
	}
	$execute = $draft->deleteDay($draft_id, $day_id);
	if($execute == true) {
		$result = $new_day_id;
	}
	else {
		$result = $_REQUEST['day'];
	}
}
else if($action == "add_activity") {
	$day_id = $_REQUEST['day'];
	$activity_id = $_REQUEST['activity_id'];
	$result = $draft->addDraftActivity($draft_id, $day_id, $activity_id);
}
else if($action == "delete_activity") {
	$result = $draft->deleteDraftActivity($_REQUEST['draft_activity_id']);
}
else if($action == "sort_day") {
	foreach($_REQUEST['sort_day_id'] as $draft_day_id) {
		$sequence[] = $draft_day_id;
	}
	$result = $draft->sortDraftDay($sequence);
	echo $sequence;
}
else if($action == "sort_activity") {
	foreach($_REQUEST['sort_activity_id'] as $draft_activity_id) {
		$sequence[] = $draft_activity_id;
	}
	$result = $draft->sortDraftActivity($sequence);
	echo $sequence;
}

echo $result;

?>
