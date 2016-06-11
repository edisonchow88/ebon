<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ModelTripActivity extends Model {
	//created to replace addTripActivity eventually, used in AJAX
	public function addActivity($trip_id, $day_id, $activity_id) {
		$reset = $this->resetSortableTripActivities($trip_id);
		$last = $this->getTotalTripActivities($trip_id);
		
		$sql = "INSERT INTO " .$this->db->table("trip_activities")." 
		                    (`trip_id`,
		                     `activity_id`,
							 `sortable`,
							 `day_id`
							 )
						  VALUES ('" . $trip_id . "',
						          '" . $activity_id . "',
								  '" . $last . "',
								  '" . $day_id . "'
								  )";
		$this->cache->delete('trip_activity');
		$this->db->query($sql);
		
		$update = $this->updateLastModifiedTrip($trip_id);
		return $this->db->getLastId();
	}
	
	/**
	 * @param array $data
	 * @return int
	 */
	public function addTripActivity($data) {
		$trip_id = $data['trip_id'];
		
		$reset = $this->resetSortableTripActivities($trip_id);
		$last = $this->getTotalTripActivities($trip_id);
		
		$sql = "INSERT INTO " .$this->db->table("trip_activities")." 
		                    (`trip_id`,
		                     `activity_id`,
							 `sortable`,
							 `day_id`
							 )
						  VALUES ('" . $data['trip_id'] . "',
						          '" . $data['activity_id'] . "',
								  '" . $last . "',
								  '" . $data['day_id'] . "'
								  )";
		$this->cache->delete('trip_activity');
		$this->db->query($sql);
		
		$update = $this->updateLastModifiedTrip($trip_id);
		return $this->db->getLastId();
	}
	
	/**
	 * @param int $trip_activity_id
	 * @param $data
	 * @return bool
	 */
	 
	public function editTripActivity($trip_activity_id, $data) {
		// prevent disabling the only enabled trip in cart
		if (isset($data[ 'status' ]) && !$data[ 'status' ]) {
			$enabled = array();
			$all = $this->getTripActivities();
			foreach ($all as $c) {
				if ($c[ 'status' ] && $c[ 'trip_activity_id' ] != $trip_activity_id) {
					$enabled[ ] = $c;
				}
			}
			if (!$enabled) {
				return false;
			}
		}

		$fields = array('time','comment');
		$update = array( 'date_modified = NOW()' );
		foreach ($fields as $f) {
			if (isset($data[ $f ]))
				$update[ ] = $f." = '" . $this->db->escape($data[ $f ]) . "'";
		}
		if (!empty($update)) {
			$this->db->query("UPDATE " . $this->db->table("trip_activities") . " 
							  SET " . implode(',', $update) . "
							  WHERE trip_activity_id = '" . (int)$trip_activity_id . "'");
			$this->cache->delete('trip_activity');
		}
		
		$update = $this->updateLastModifiedTrip($trip_id);
		return true;
	}
	
	/**
	 * @param int $trip_activity_id
	 * @return bool
	 */
	public function deleteTripActivity($trip_activity_id) {
		$this->db->query("DELETE FROM " . $this->db->table("trip_activities") . " 
						  WHERE trip_activity_id = '" . (int)$trip_activity_id . "'");
		$this->cache->delete('trip_activity');
		$update = $this->updateLastModifiedTrip($trip_id);
		return true;
	}
	
	/**
	 * @param int $trip_activity_id
	 * @return array
	 */
	public function getTripActivity($trip_activity_id) {
		$query = $this->db->query("SELECT DISTINCT *
								   FROM " . $this->db->table("trip_activities") . " 
								   WHERE trip_activity_id = '" . (int)$trip_activity_id . "'");

		return $query->row;
	}

	/**
	 * @param int $trip_id
	 * @return array $trip_activity_data
	 */
	public function getTripActivities($trip_id) {
			
		$sql = "SELECT * FROM ".$this->db->table("trip_activities") ;
		$sql .= " WHERE trip_id = '". (int)$trip_id."'";
		$sql .=	" ORDER BY sortable ASC, date ASC, time ASC ";
		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$trip_activity_data[ $result[ 'trip_activity_id' ] ] = array(
				'trip_activity_id' => $result[ 'trip_activity_id' ],
				'trip_id' => $result[ 'trip_id' ],
				'activity_id' => $result[ 'activity_id' ],
				'date' => $result[ 'date' ],
				'time' => $result[ 'time' ],
				'comment' => $result[ 'comment' ],
				'sortable' => $result[ 'sortable' ],
				'day_id' => $result[ 'day_id' ]
			);
		}
		
		if(!empty($trip_activity_data)) {
			return $trip_activity_data;
		}
		else {
			$trip_activity_data = array();
			return $trip_activity_data;
		}
	}
	
	/**
	 * @param int $trip_id
	 * @return array $trip_activity_data
	 */
	public function getTripActivitiesByDay($day_id) {
			
		$sql = "SELECT * FROM ".$this->db->table("trip_activities") ;
		$sql .= " WHERE day_id = '". (int)$day_id."'";
		$sql .=	" ORDER BY sortable ASC, date ASC, time ASC ";
		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$trip_activity_data[ $result[ 'trip_activity_id' ] ] = array(
				'trip_activity_id' => $result[ 'trip_activity_id' ],
				'trip_id' => $result[ 'trip_id' ],
				'activity_id' => $result[ 'activity_id' ],
				'date' => $result[ 'date' ],
				'time' => $result[ 'time' ],
				'comment' => $result[ 'comment' ],
				'sortable' => $result[ 'sortable' ]
			);
		}
		
		if(!empty($trip_activity_data)) {
			return $trip_activity_data;
		}
		else {
			$trip_activity_data = array();
			return $trip_activity_data;
		}
	}
	
	public function getTotalTripActivities($trip_id){
		$query = $this->db->query("SELECT COUNT(*) AS total
      								FROM `" . $this->db->table("trip_activities") . "`
      								WHERE trip_id = '" . (int)$trip_id . "'");
		return (int)$query->row['total'];
	}
	
	public function getTotalDayActivities($day_id){
		$query = $this->db->query("SELECT COUNT(*) AS total
      								FROM `" . $this->db->table("trip_activities") . "`
      								WHERE day_id = '" . (int)$day_id . "'");
		return (int)$query->row['total'];
	}
	
	public function resetSortableTripActivities($trip_id){
		$trip_activity_data = $this->getTripActivities($trip_id);
		
		$i = 0;
		foreach($trip_activity_data as $activity) {	
			$sql = "UPDATE " . $this->db->table("trip_activities") . " 
							  SET sortable = '" . $i . "'
							  WHERE trip_activity_id = '" . (int)$activity['trip_activity_id'] . "'";
			$this->db->query($sql);
			$i++;
		}
		
		return true;
	}
	
	public function updateLastModifiedTrip($trip_id){
		$sql = "UPDATE " . $this->db->table("trips") . " 
							  SET date_modified = NOW()
							  WHERE trip_id = '" . (int)$trip_id . "'";
		$this->db->query($sql);
	}
	
	public function sortTripActivity($sequence) {
		$i = 1;
		foreach($sequence as $trip_activity_id) {
			$sql = "UPDATE " . $this->db->table("trip_activities") . " 
							  SET sortable = '" . $i . "'
							  WHERE trip_activity_id = '" . $trip_activity_id . "'";
			$this->db->query($sql);
			$i++;
		}
		return true;
	}

}
