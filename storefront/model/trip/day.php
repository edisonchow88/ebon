<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ModelTripDay extends Model {
	//CREATED on 2016/03/21 to replace addTripDay after all its related function is replaced
	public function addDay($trip_id) {
		$reset = $this->resetTripDaySortable($trip_id);
		$last = $this->getTotalTripDays($trip_id);
		$last = $last + 1;
		$lastday = $this->getLastDayDate($trip_id);
		$lastday = date('Y-m-d H:i:s', strtotime($lastday . ' +1 day'));
		
		$sql = "INSERT INTO " .$this->db->table("trip_days")." 
		                    (`trip_id`,
		                     `date`,
							 `sortable`
							 )
						  VALUES ('" . $trip_id . "',
						          '" . $lastday . "',
								  '" . $last . "'
								  )";
		$this->db->query($sql);
		$day_id = $this->db->getLastId();
		
		$update = $this->updateLastModifiedTrip($trip_id);
		return $day_id;
	}
	
	//CREATED on 2016/03/21 to replace deleteTripDay after all its related function is replaced
	public function deleteDay($trip_id, $day_id) {
		$days = $this->getTotalTripDays($trip_id);
		
		if($days > 1) {		
			$sql = "DELETE FROM " . $this->db->table("trip_days") . " WHERE day_id = '" . (int)$day_id . "'";
			$this->db->query($sql);
			
			//delete all activities
			$sql = "DELETE FROM " . $this->db->table("trip_activities") . " WHERE day_id = '" . (int)$day_id . "'";
			$this->db->query($sql);
			
			//reset the orders of days
			$reset_date = $this->resetTripDayDate($trip_id);
			$reset_sortable = $this->resetTripDaySortable($trip_id);
			
			return true;
		}
		else {
			return false;
		}
	}
	
	/**
	 * @param array $data
	 * @return int
	 */
	public function addTripDay($data) {
		$trip_id = $data['trip_id'];
		
		$reset = $this->resetTripDaySortable($trip_id);
		$last = $this->getTotalTripDays($trip_id);
		$last = $last + 1;
		$lastday = $this->getLastDayDate($trip_id);
		$lastday = date('Y-m-d H:i:s', strtotime($lastday . ' +1 day'));
		
		$sql = "INSERT INTO " .$this->db->table("trip_days")." 
		                    (`trip_id`,
		                     `date`,
							 `sortable`
							 )
						  VALUES ('" . $data['trip_id'] . "',
						          '" . $lastday . "',
								  '" . $last . "'
								  )";
		$this->db->query($sql);
		$day_id = $this->db->getLastId();
		
		$update = $this->updateLastModifiedTrip($trip_id);
		return $day_id;
	}
	
	/**
	 * @param int $day_id
	 * @return bool
	 */
	public function deleteTripDay($trip_id, $day_id) {
		$days = $this->getTotalTripDays($trip_id);
		
		if($days > 1) {		
			$sql = "DELETE FROM " . $this->db->table("trip_days") . " WHERE day_id = '" . (int)$day_id . "'";
			$this->db->query($sql);
			
			//delete all activities
			$sql = "DELETE FROM " . $this->db->table("trip_activities") . " WHERE day_id = '" . (int)$day_id . "'";
			$this->db->query($sql);
			
			//reset the orders of days
			$reset_date = $this->resetTripDayDate($trip_id);
			$reset_sortable = $this->resetTripDaySortable($trip_id);
			
			return true;
		}
		else {
			return false;
		}
	}
	
	public function getTripDays($trip_id) {
		$sql = "SELECT * FROM " . $this->db->table("trip_days") . " ";
		$sql .= " WHERE trip_id = '" . (int)$trip_id . "'";
		$sql .= " ORDER BY sortable ASC";
		
		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	public function getTotalTripDays($trip_id){
		$query = $this->db->query("SELECT COUNT(*) AS total
      								FROM `" . $this->db->table("trip_days") . "`
      								WHERE trip_id = '" . (int)$trip_id . "'");
		return (int)$query->row['total'];
	}
	
	public function resetTripDaySortable($trip_id){
		$trip_days_data = $this->getTripDays($trip_id);
		
		$i = 1;
		foreach($trip_days_data as $day) {	
			$sql = "UPDATE " . $this->db->table("trip_days") . " 
							  SET sortable = '" . $i . "'
							  WHERE day_id = '" . (int)$day['day_id'] . "'";
			$this->db->query($sql);
			$i++;
		}
		
		return true;
	}
	
	public function resetTripDayDate($trip_id){
		$trip_days_data = $this->getTripDays($trip_id);
		
		$date = $this->getFirstDayDate($trip_id);
		foreach($trip_days_data as $day) {	
			$sql = "UPDATE " . $this->db->table("trip_days") . " 
							  SET date = '" . $date . "'
							  WHERE day_id = '" . (int)$day['day_id'] . "'";
			$this->db->query($sql);
			$date = date('Y-m-d H:i:s', strtotime($date . ' +1 day'));;
		}
		
		return true;
	}
	
	public function updateLastModifiedTrip($trip_id){
		$sql = "UPDATE " . $this->db->table("trips") . " 
							  SET date_modified = NOW()
							  WHERE trip_id = '" . (int)$trip_id . "'";
		$this->db->query($sql);
	}
	
	public function getFirstDayId($trip_id) {
		$days_data = $this->getTripDays($trip_id);
		reset($days_data);
		$key = key($days_data);
		$first_day_id = $days_data[$key]['day_id'];
    	return $first_day_id;
  	}
	
	public function getFirstDayDate($trip_id) {
		$query = $this->db->query("SELECT * FROM " . $this->db->table("trips") . " WHERE trip_id = '" . (int)$trip_id . "'");
		return $query->row['date_start'];
  	}
	
	public function getLastDayId($trip_id) {
		$days_data = $this->getTripDays($trip_id);
		end($days_data);
		$key = key($days_data);
		$last_day_id = $days_data[$key]['day_id'];
    	return $last_day_id;
  	}
	
	public function getLastDayDate($trip_id) {
		$days_data = $this->getTripDays($trip_id);
		end($days_data);
		$key = key($days_data);
		$last_day_date = $days_data[$key]['date'];
    	return $last_day_date;
  	}
	
	public function verifyDayId($day_id) {
		$sql = "SELECT COUNT(*) AS total FROM `" . $this->db->table("trip_days") . "` WHERE day_id = '" . (int)$day_id . "' LIMIT 1";
		$query = $this->db->query($sql);
		
		if ((int)$query->row['total'] > 0) {
			 return true;
		} else {
			 return false;
		}
	}
	
	public function sortTripDay($trip_id, $sequence) {
		$date = $this->getFirstDayDate($trip_id);
		$i = 1;
		foreach($sequence as $day_id) {
			$sql = "UPDATE " . $this->db->table("trip_days") . " 
							  SET sortable='".$i."', date='".$date."' WHERE day_id = '" . $day_id . "'";
			$this->db->query($sql);
			if($date != '0000-00-00') { $date = date("Y-m-d", strtotime("+1 day", strtotime($date)));}
			$i++;
		}
		return true;
	}	
}
