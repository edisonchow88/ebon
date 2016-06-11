<?php  
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
$trip = new ATrip($this->registry);

//GET request data
$action = $_REQUEST['action'];

//set variables
$view = $trip->setView($_REQUEST['view']);
$trip_id = $trip->setTripId($_REQUEST['trip']);
$day_id = $trip->setDayId($_REQUEST['day']);

$result = '';
//identify action
if($action == "save_trip") {
	$result = $trip->saveTrip($_REQUEST['trip_name'], $_REQUEST['travel_date']);
}
else if($action == "save_trip_name") {
	$trip_name = $_REQUEST['trip_name'];
	$trip_date = $_REQUEST['travel_date'];
	$trip->saveTrip($trip_name, $trip_date);
}
else if($action == "save_travel_date") {
	$trip_name = $_REQUEST['trip_name'];
	$trip_date = $_REQUEST['travel_date'];
	$trip->saveTrip($trip_name, $trip_date);
}
else if($action == "refresh_day_list") {
	$days = $trip->getDays();
	
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
		$result .= '"sortable":"'.$day["sortable"].'"';
		$result .= ',';
		$result .= '"total_activities":"'.$day["total_activities"].'"';
		$result .= '}';
		if($i != $n) { $result .= ','; }
	}
	$result .= ']';
}
else if($action == "refresh_activity_list") {
	$day = $trip->getDay();
	$activities = $trip->getDayActivities();
	$prev_day_id = $trip->getPrevDayId();
	$next_day_id = $trip->getNextDayId();
	
	$result .= '{';
		$result .= '"day_selected":';
			$result .= '{';
			$result .= '"day_id":"'.$day["day_id"].'"';
			$result .= ',';
			$result .= '"date":"'.date( "M d", strtotime($day["date"])).'"';
			$result .= ',';
			$result .= '"day":"'.date( "D", strtotime($day["date"])).'"';
			$result .= ',';
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
					$result .= '"trip_activity_id":"'.$activity["trip_activity_id"].'"';
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
else if($action == "add_day") {
	$result = $trip->addDay();
}
else if($action == "delete_day") {
	$prev_day_id = $trip->getPrevDayId();
	$next_day_id = $trip->getNextDayId();
	if($prev_day_id != '') { 
		$new_day_id = $prev_day_id; 
	}
	else if($next_day_id != '') { 
		$new_day_id = $next_day_id; 
	}
	$execute = $trip->deleteDay($trip_id, $day_id);
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
	$result = $trip->addTripActivity($trip_id, $day_id, $activity_id);
}
else if($action == "delete_activity") {
	$result = $trip->deleteTripActivity($_REQUEST['trip_activity_id']);
}
else if($action == "sort_day") {
	foreach($_REQUEST['sort_day_id'] as $trip_day_id) {
		$sequence[] = $trip_day_id;
	}
	$result = $trip->sortTripDay($sequence);
	echo $sequence;
}
else if($action == "sort_activity") {
	foreach($_REQUEST['sort_activity_id'] as $trip_activity_id) {
		$sequence[] = $trip_activity_id;
	}
	$result = $trip->sortTripActivity($sequence);
	echo $sequence;
}

echo $result;

?>
