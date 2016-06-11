<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ModelDraftDay extends Model {
	//CREATED on 2016/03/21 to replace addDraftDay after all its related function is replaced
	public function addDay($draft_id) {
		$reset = $this->resetDraftDaySortable($draft_id);
		$last = $this->getTotalDraftDays($draft_id);
		$last = $last + 1;
		$lastday = $this->getLastDayDate($draft_id);
		$lastday = date('Y-m-d H:i:s', strtotime($lastday . ' +1 day'));
		
		$sql = "INSERT INTO " .$this->db->table("draft_days")." 
		                    (`draft_id`,
		                     `date`,
							 `sortable`
							 )
						  VALUES ('" . $draft_id . "',
						          '" . $lastday . "',
								  '" . $last . "'
								  )";
		$this->db->query($sql);
		$day_id = $this->db->getLastId();
		
		$update = $this->updateLastModifiedDraft($draft_id);
		return $day_id;
	}
	
	//CREATED on 2016/03/21 to replace deleteDraftDay after all its related function is replaced
	public function deleteDay($draft_id, $day_id) {
		$days = $this->getTotalDraftDays($draft_id);
		
		if($days > 1) {		
			$sql = "DELETE FROM " . $this->db->table("draft_days") . " WHERE day_id = '" . (int)$day_id . "'";
			$this->db->query($sql);
			
			//delete all activities
			$sql = "DELETE FROM " . $this->db->table("draft_activities") . " WHERE day_id = '" . (int)$day_id . "'";
			$this->db->query($sql);
			
			//reset the orders of days
			$reset_date = $this->resetDraftDayDate($draft_id);
			$reset_sortable = $this->resetDraftDaySortable($draft_id);
			
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
	public function addDraftDay($data) {
		$draft_id = $data['draft_id'];
		
		$reset = $this->resetDraftDaySortable($draft_id);
		$last = $this->getTotalDraftDays($draft_id);
		$last = $last + 1;
		$lastday = $this->getLastDayDate($draft_id);
		$lastday = date('Y-m-d H:i:s', strtotime($lastday . ' +1 day'));
		
		$sql = "INSERT INTO " .$this->db->table("draft_days")." 
		                    (`draft_id`,
		                     `date`,
							 `sortable`
							 )
						  VALUES ('" . $data['draft_id'] . "',
						          '" . $lastday . "',
								  '" . $last . "'
								  )";
		$this->db->query($sql);
		$day_id = $this->db->getLastId();
		
		$update = $this->updateLastModifiedDraft($draft_id);
		return $day_id;
	}
	
	/**
	 * @param int $day_id
	 * @return bool
	 */
	public function deleteDraftDay($draft_id, $day_id) {
		$days = $this->getTotalDraftDays($draft_id);
		
		if($days > 1) {		
			$sql = "DELETE FROM " . $this->db->table("draft_days") . " WHERE day_id = '" . (int)$day_id . "'";
			$this->db->query($sql);
			
			//delete all activities
			$sql = "DELETE FROM " . $this->db->table("draft_activities") . " WHERE day_id = '" . (int)$day_id . "'";
			$this->db->query($sql);
			
			//reset the orders of days
			$reset_date = $this->resetDraftDayDate($draft_id);
			$reset_sortable = $this->resetDraftDaySortable($draft_id);
			
			return true;
		}
		else {
			return false;
		}
	}
	
	public function getDraftDays($draft_id) {
		$sql = "SELECT * FROM " . $this->db->table("draft_days") . " ";
		$sql .= " WHERE draft_id = '" . (int)$draft_id . "'";
		$sql .= " ORDER BY sortable ASC";
		
		$query = $this->db->query($sql);

		return $query->rows;
	}
	
	public function getTotalDraftDays($draft_id){
		$query = $this->db->query("SELECT COUNT(*) AS total
      								FROM `" . $this->db->table("draft_days") . "`
      								WHERE draft_id = '" . (int)$draft_id . "'");
		return (int)$query->row['total'];
	}
	
	public function resetDraftDaySortable($draft_id){
		$draft_days_data = $this->getDraftDays($draft_id);
		
		$i = 1;
		foreach($draft_days_data as $day) {	
			$sql = "UPDATE " . $this->db->table("draft_days") . " 
							  SET sortable = '" . $i . "'
							  WHERE day_id = '" . (int)$day['day_id'] . "'";
			$this->db->query($sql);
			$i++;
		}
		
		return true;
	}
	
	public function resetDraftDayDate($draft_id){
		$draft_days_data = $this->getDraftDays($draft_id);
		
		$date = $this->getFirstDayDate($draft_id);
		foreach($draft_days_data as $day) {	
			$sql = "UPDATE " . $this->db->table("draft_days") . " 
							  SET date = '" . $date . "'
							  WHERE day_id = '" . (int)$day['day_id'] . "'";
			$this->db->query($sql);
			$date = date('Y-m-d H:i:s', strtotime($date . ' +1 day'));;
		}
		
		return true;
	}
	
	public function updateLastModifiedDraft($draft_id){
		$sql = "UPDATE " . $this->db->table("drafts") . " 
							  SET date_modified = NOW()
							  WHERE draft_id = '" . (int)$draft_id . "'";
		$this->db->query($sql);
	}
	
	public function getFirstDayId($draft_id) {
		$days_data = $this->getDraftDays($draft_id);
		reset($days_data);
		$key = key($days_data);
		$first_day_id = $days_data[$key]['day_id'];
    	return $first_day_id;
  	}
	
	public function getFirstDayDate($draft_id) {
		$query = $this->db->query("SELECT * FROM " . $this->db->table("drafts") . " WHERE draft_id = '" . (int)$draft_id . "'");
		return $query->row['draft_date'];
  	}
	
	public function getLastDayId($draft_id) {
		$days_data = $this->getDraftDays($draft_id);
		end($days_data);
		$key = key($days_data);
		$last_day_id = $days_data[$key]['day_id'];
    	return $last_day_id;
  	}
	
	public function getLastDayDate($draft_id) {
		$days_data = $this->getDraftDays($draft_id);
		end($days_data);
		$key = key($days_data);
		$last_day_date = $days_data[$key]['date'];
    	return $last_day_date;
  	}
	
	public function verifyDayId($day_id) {
		$sql = "SELECT COUNT(*) AS total FROM `" . $this->db->table("draft_days") . "` WHERE day_id = '" . (int)$day_id . "' LIMIT 1";
		$query = $this->db->query($sql);
		
		if ((int)$query->row['total'] > 0) {
			 return true;
		} else {
			 return false;
		}
	}
	
	public function sortDraftDay($draft_id, $sequence) {
		$date = $this->getFirstDayDate($draft_id);
		$i = 1;
		foreach($sequence as $day_id) {
			$sql = "UPDATE " . $this->db->table("draft_days") . " 
							  SET sortable='".$i."', date='".$date."' WHERE day_id = '" . $day_id . "'";
			$this->db->query($sql);
			if($date != '0000-00-00') { $date = date("Y-m-d", strtotime("+1 day", strtotime($date)));}
			$i++;
		}
		return true;
	}	

}
