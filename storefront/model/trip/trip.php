<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ModelTripTrip extends Model {
	/**
	 * @param array $trip_data
	 * @return array $new_data
	 */
	public function addTrip($trip_data) {
		$sql = "INSERT INTO " .$this->db->table("trips")." 
		                    (`date_start`,
		                     `trip_name`,
		                     `customer_id`,
		                     `date_added`,
		                     `date_modified`,
							 `trip_status_id`)
						  VALUES ('" . $this->db->escape($trip_data[ 'date_start' ]) . "',
						          '" . $this->db->escape($trip_data[ 'trip_name' ]) . "',
						          '" . (int)$this->customer->getId() . "',
								  NOW(),
						          NOW(),
								  '0')";
		$this->db->query($sql);
		$new_data['trip_id'] = $this->db->getLastId();
		
		//assign itinerary_code
		$sql = "INSERT INTO " .$this->db->table("itineraries")." 
		                    (`code`,
		                     `type`,
		                     `id`)
						  VALUES ('',
						          'trip',
						          '" . $new_data['trip_id'] . "')";
		$this->db->query($sql);
		$new_data['itinerary_id'] = $this->db->getLastId();
		
		$year_code = date('y');
		$month_code = chr(date('m')+64);
		if(date('d')<=26) { $day_code = chr(date('d')+64); } else { $day_code = chr(date('d')+70); }
		$num_code = substr(sprintf('%04u',$new_data['itinerary_id']),-4);
		$itinerary_code = $year_code.$month_code.$day_code.$num_code;
		
		$sql = "UPDATE " . $this->db->table("itineraries") . " 
							  SET code = '" . $itinerary_code . "' 
							  WHERE itinerary_id = '" . $new_data['itinerary_id'] . "'";
		$this->db->query($sql);
		
		//add first day
		$sql = "INSERT INTO " .$this->db->table("trip_days")." 
		                    (`trip_id`,
		                     `date`,
		                     `sortable`)
						  VALUES ('" . $new_data['trip_id'] . "',
						          '" . $this->db->escape($trip_data[ 'date_start' ]) . "',
						          '" . 1 . "')";
		$this->db->query($sql);
		$new_data['day_id'] = $this->db->getLastId();
		
		return $new_data;
	}
	
	/**
	 * @param int $trip_id
	 * @param $data
	 * @return bool
	 */
	public function editTrip($trip_id, $data) {
		// prevent disabling the only enabled trip in cart
		if (isset($data[ 'status' ]) && !$data[ 'status' ]) {
			$enabled = array();
			$all = $this->getTrips();
			foreach ($all as $c) {
				if ($c[ 'status' ] && $c[ 'trip_id' ] != $trip_id) {
					$enabled[ ] = $c;
				}
			}
			if (!$enabled) {
				return false;
			}
		}

		$fields = array( 'date_start', 'trip_name', );
		$update = array( 'date_modified = NOW()' );
		foreach ($fields as $f) {
			if (isset($data[ $f ]))
				$update[ ] = $f." = '" . $this->db->escape($data[ $f ]) . "'";
		}
		if (!empty($update)) {
			$this->db->query("UPDATE " . $this->db->table("trips") . " 
							  SET " . implode(',', $update) . "
							  WHERE trip_id = '" . (int)$trip_id . "'");
			$this->cache->delete('trip');
		}
		return true;
	}
	
	/**
	 * @param int $trip_id
	 * @return bool
	 */
	public function deleteTrip($trip_id) {
		$this->db->query("DELETE FROM " . $this->db->table("trips") . " 
						  WHERE trip_id = '" . (int)$trip_id . "'");
		
		//delete all days
		$sql = "DELETE FROM " . $this->db->table("trip_days") . " WHERE trip_id = '" . (int)$trip_id . "'";
		$this->db->query($sql);
		
		//delete all activities
		$sql = "DELETE FROM " . $this->db->table("trip_activities") . " WHERE trip_id = '" . (int)$trip_id . "'";
		$this->db->query($sql);
		
		$this->cache->delete('trip');
		return true;
	}
	
	/**
	 * @param int $trip_id
	 * @return array
	 */
	public function getTrip($trip_id) {
		$query = $this->db->query("SELECT * FROM " . $this->db->table("trips") . " WHERE trip_id = '" . (int)$trip_id . "'");
		return $query->row;
	}

	/**
	 * @param array $data
	 * @return array $trip_data
	 */
	public function getTrips($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . $this->db->table("trips") . " ";
			$sql .= " ORDER BY date_start DESC, trip_name ASC";
			
			$query = $this->db->query($sql);

			return $query->rows;
		} else {
			
			$query = $this->db->query("SELECT *
										FROM " . $this->db->table("trips") . "
										WHERE customer_id = '" . (int)$this->customer->getId() . "'  
										ORDER BY date_start DESC, trip_name ASC " );
			return $query->rows;
		}
	}

	/**
	 * @return int
	 */
	public function getTotalTrips() {
      	$query = $this->db->query("SELECT COUNT(*) AS total
      								FROM `" . $this->db->table("trips") . "`
      								WHERE customer_id = '" . (int)$this->customer->getId() . "'");
		return (int)$query->row['total'];
	}
	
	public function getLastTripId() {
		$trips = $this->getTrips();
		$mostRecent= 0;
		foreach($trips as $trip){
		  $curDate = strtotime($trip['date_start']);
		  if ($curDate > $mostRecent) {
			 $mostRecent = $curDate;
			 $last_modified_trip_id = $trip['trip_id'];
		  }
		}
    	return $last_modified_trip_id;
  	}
	
	/**
	 * @param int $trip_id
	 * @return array $days_data
	 */
	public function getDays($trip_id) {
		$sql = "SELECT * FROM " . $this->db->table("trip_days") . " ";
		$sql .= " WHERE trip_id = '" . (int)$trip_id . "'";
		$sql .= " ORDER BY sortable ASC";
		
		$query = $this->db->query($sql);
		
		$result = array();
		$i = 0;
		$n = count($query->rows)-1;
		foreach ($query->rows as $row) {
			$result[$row['day_id']] = $row;
			if($i != 0 ) { $result[$row['day_id']]['prev_day_id'] = $query->rows[$i-1]['day_id'];}
			if($i != $n ) { $result[$row['day_id']]['next_day_id'] = $query->rows[$i+1]['day_id'];}
			$i += 1;
		}

		return $result;
	}
	
	//
	public function getDay($day_id) {
		$query = $this->db->query("SELECT * FROM " . $this->db->table("trip_days") . " WHERE day_id = '" . (int)$day_id . "'");
		return $query->row;
	}
	
	/*
	public function getFirstDayId($trip_id) {
		$days_data = $this->getDays($trip_id);
		reset($days_data);
		$key = key($days_data);
		$first_day_id = $days_data[$key]['day_id'];
    	return $first_day_id;
  	}
	*/
	
	public function verifyTripId($trip_id) {
		$sql = "SELECT EXISTS(SELECT 1 FROM `" . $this->db->table("trips") . "` WHERE trip_id = '" . (int)$trip_id . "' LIMIT 1)";
		$query = $this->db->query($sql);
		
		if (@mysql_num_rows(mysql_query($query))!=1) {
			 return false;
		} else {
			 return true;
		}
	}
	
	
	public function getItineraryCode($trip_id) {
		$query = $this->db->query("SELECT code FROM " . $this->db->table("itineraries") . " WHERE type = 'trip' AND id = '" . (int)$trip_id . "'");
		return $query->row['code'];
	}
}
