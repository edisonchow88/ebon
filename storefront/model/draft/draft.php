<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ModelDraftDraft extends Model {
	
	public function setTemplate($draft_id, $template_id) {
		//delete all days
		$sql = "DELETE FROM " . $this->db->table("draft_days") . " WHERE draft_id = '" . (int)$draft_id . "'";
		$this->db->query($sql);
		
		//delete all activities
		$sql = "DELETE FROM " . $this->db->table("draft_activities") . " WHERE draft_id = '" . (int)$draft_id . "'";
		$this->db->query($sql);
		
		//insert new days
		$sql = "INSERT INTO " .$this->db->table("draft_days")." 
					(`draft_id`,
					`date`,
					`sortable`)
				SELECT 
					'" . $draft_id . "', 
					`date`, 
					`sortable`  
				FROM " .$this->db->table("draft_days")." 
				WHERE draft_id = '" . $template_id . "'";
		$this->db->query($sql);
		
		//get days_id
		$draft_days = $this->getDays($draft_id);
		$template_days = $this->getDays($template_id);
		
		$i = 0;
		foreach($draft_days as $day) {
			$draft_d[$i] = $day;
			$i++;
		}
		
		$i = 0;
		foreach($template_days as $day) {
			$template_d[$i] = $day;
			$i++;
		}
		
		//insert new day activities
		$i = 0;
		foreach($draft_d as $day) {
			$sql = "INSERT INTO ".$this->db->table("draft_activities")." 
					(`draft_id`,
					`activity_id`,
					`sortable`, 
					`day_id`)
				SELECT 
					'" . $draft_id . "', 
					`activity_id`, 
					`sortable`, 
					'" . $day['day_id'] . "' 
				FROM ".$this->db->table("draft_activities")." 
				WHERE day_id = '" . $template_d[$i]['day_id'] . "'";
			$this->db->query($sql);
			$i++;
		}
	}
	
	public function addDraft() {
		$draft_name = $draft['draft_name'] = "My Trip";
		$draft_date = $draft['draft_date'] = "0000-00-00";
		$customer_id = (int)$this->customer->getId();
		$db_drafts = $this->db->table("drafts");
		$db_draft_days = $this->db->table("draft_days");
		
		$sql = "INSERT INTO " .$db_drafts." 
		                    (`draft_name`,
		                     `draft_date`,
		                     `customer_id`,
		                     `date_added`,
		                     `date_modified`,
							 `draft_status_id`)
						  VALUES ('" . $draft_name . "',
						          '" . $draft_date . "',
						          '" . $customer_id . "',
								  NOW(),
						          NOW(),
								  '1')";
		$this->db->query($sql);
		$draft['draft_id'] = $this->db->getLastId();
		
		//assign itinerary_code
		$sql = "INSERT INTO " .$this->db->table("itineraries")." 
		                    (`code`,
		                     `type`,
		                     `id`)
						  VALUES ('',
						          'draft',
						          '" . $draft['draft_id'] . "')";
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
		$draft['itinerary_code'] = $itinerary_code;
		
		//add first day
		$sql = "INSERT INTO " .$db_draft_days." 
		                    (`draft_id`,
		                     `date`,
		                     `sortable`)
						  VALUES ('" . $draft['draft_id'] . "',
						          '" . $draft_date . "',
						          '" . 1 . "')";
		$this->db->query($sql);
		$draft['day_id'] = $this->db->getLastId();
		
		return $draft;
	}
	
	public function saveDraft($draft_id, $customer_id) {
		$draft = $this->getDraft($draft_id);
		if($draft['customer_id'] == 0) {
			$this->db->query("UPDATE " . $this->db->table("drafts") . " 
							  SET customer_id = '" . $customer_id . "' 
							  WHERE draft_id = '" . (int)$draft_id . "'");
			$this->cache->delete('draft');
			return true;
		}
		else {
			return false;
		}
	}
	
	/**
	 * @param int $draft_id
	 * @param $data
	 * @return bool
	 */
	public function editDraft($draft_id, $data) {
		// prevent disabling the only enabled draft in cart
		if (isset($data[ 'status' ]) && !$data[ 'status' ]) {
			$enabled = array();
			$all = $this->getDrafts();
			foreach ($all as $c) {
				if ($c[ 'status' ] && $c[ 'draft_id' ] != $draft_id) {
					$enabled[ ] = $c;
				}
			}
			if (!$enabled) {
				return false;
			}
		}

		$fields = array( 'draft_date', 'draft_name', );
		$update = array( 'date_modified = NOW()' );
		foreach ($fields as $f) {
			if (isset($data[ $f ]))
				$update[ ] = $f." = '" . $this->db->escape($data[ $f ]) . "'";
		}
		if (!empty($update)) {
			$this->db->query("UPDATE " . $this->db->table("drafts") . " 
							  SET " . implode(',', $update) . "
							  WHERE draft_id = '" . (int)$draft_id . "'");
			$this->cache->delete('draft');
		}
		return true;
	}
	
	/**
	 * @param int $draft_id
	 * @return bool
	 */
	public function deleteDraft($draft_id) {
		$this->db->query("DELETE FROM " . $this->db->table("drafts") . " 
						  WHERE draft_id = '" . (int)$draft_id . "'");
		
		//delete all days
		$sql = "DELETE FROM " . $this->db->table("draft_days") . " WHERE draft_id = '" . (int)$draft_id . "'";
		$this->db->query($sql);
		
		//delete all activities
		$sql = "DELETE FROM " . $this->db->table("draft_activities") . " WHERE draft_id = '" . (int)$draft_id . "'";
		$this->db->query($sql);
		
		$this->cache->delete('draft');
		return true;
	}
	
	/**
	 * @param int $draft_id
	 * @return array
	 */
	public function getDraft($draft_id) {
		$query = $this->db->query("SELECT * FROM " . $this->db->table("drafts") . " WHERE draft_id = '" . (int)$draft_id . "'");
		return $query->row;
	}
	
	public function getDraftIdbyItineraryCode($itinerary_code) {
		$query = $this->db->query("SELECT * FROM " . $this->db->table("itineraries") . " WHERE code = '" . $itinerary_code . "'");
		return $query->row['id'];
	}
	
	public function verifyDraftIdbyItineraryCode($itinerary_code) {
		$query = $this->db->query("SELECT COUNT(*) AS total
      								FROM `" . $this->db->table("itineraries") . "`
      								WHERE code = '" . $itinerary_code . "'");
		if($query->row['total'] != 0) {
			return true;
		}
		else {
			return false;
		}
	}

	/**
	 * @param array $data
	 * @return array $draft_data
	 */
	public function getDrafts($data = array()) {
		if ($data) {
			$sql = "SELECT * FROM " . $this->db->table("drafts") . " ";
			$sql .= " ORDER BY draft_date DESC, draft_name ASC";
			
			$query = $this->db->query($sql);

			return $query->rows;
		} else {
			
			$query = $this->db->query("SELECT *
										FROM " . $this->db->table("drafts") . "
										WHERE customer_id = '" . (int)$this->customer->getId() . "'  
										ORDER BY draft_date DESC, draft_name ASC " );
			return $query->rows;
		}
	}

	/**
	 * @return int
	 */
	public function getTotalDrafts() {
      	$query = $this->db->query("SELECT COUNT(*) AS total
      								FROM `" . $this->db->table("drafts") . "`
      								WHERE customer_id = '" . (int)$this->customer->getId() . "'");
		return (int)$query->row['total'];
	}
	
	public function getLastDraftId() {
		$drafts = $this->getDrafts();
		$mostRecent= 0;
		foreach($drafts as $draft){
		  $curDate = strtotime($draft['draft_date']);
		  if ($curDate > $mostRecent) {
			 $mostRecent = $curDate;
			 $last_modified_draft_id = $draft['draft_id'];
		  }
		}
    	return $last_modified_draft_id;
  	}
	
	/**
	 * @param int $draft_id
	 * @return array $days_data
	 */
	public function getDays($draft_id) {
		$sql = "SELECT * FROM " . $this->db->table("draft_days") . " ";
		$sql .= " WHERE draft_id = '" . (int)$draft_id . "'";
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
		$query = $this->db->query("SELECT * FROM " . $this->db->table("draft_days") . " WHERE day_id = '" . (int)$day_id . "'");
		return $query->row;
	}
	
	/*
	public function getFirstDayId($draft_id) {
		$days_data = $this->getDays($draft_id);
		reset($days_data);
		$key = key($days_data);
		$first_day_id = $days_data[$key]['day_id'];
    	return $first_day_id;
  	}
	*/
	
	public function verifyDraftId($draft_id) {
		$sql = "SELECT EXISTS(SELECT 1 FROM `" . $this->db->table("drafts") . "` WHERE draft_id = '" . (int)$draft_id . "' LIMIT 1)";
		$query = $this->db->query($sql);
		
		if (@mysql_num_rows(mysql_query($query))!=1) {
			 return false;
		} else {
			 return true;
		}
	}
	
	public function getItineraryCode($draft_id) {
		$query = $this->db->query("SELECT code FROM " . $this->db->table("itineraries") . " WHERE type = 'draft' AND id = '" . (int)$draft_id . "'");
		return $query->row['code'];
	}
}
