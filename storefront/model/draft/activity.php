<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ModelDraftActivity extends Model {
	//created to replace addDraftActivity eventually, used in AJAX
	public function addActivity($draft_id, $day_id, $activity_id) {
		$reset = $this->resetSortableDraftActivities($draft_id);
		$last = $this->getTotalDraftActivities($draft_id);
		
		$sql = "INSERT INTO " .$this->db->table("draft_activities")." 
		                    (`draft_id`,
		                     `activity_id`,
							 `sortable`,
							 `day_id`
							 )
						  VALUES ('" . $draft_id . "',
						          '" . $activity_id . "',
								  '" . $last . "',
								  '" . $day_id . "'
								  )";
		$this->cache->delete('draft_activity');
		$this->db->query($sql);
		
		$update = $this->updateLastModifiedDraft($draft_id);
		return $this->db->getLastId();
	}
	
	/**
	 * @param array $data
	 * @return int
	 */
	public function addDraftActivity($data) {
		$draft_id = $data['draft_id'];
		
		$reset = $this->resetSortableDraftActivities($draft_id);
		$last = $this->getTotalDraftActivities($draft_id);
		
		$sql = "INSERT INTO " .$this->db->table("draft_activities")." 
		                    (`draft_id`,
		                     `activity_id`,
							 `sortable`,
							 `day_id`
							 )
						  VALUES ('" . $data['draft_id'] . "',
						          '" . $data['activity_id'] . "',
								  '" . $last . "',
								  '" . $data['day_id'] . "'
								  )";
		$this->cache->delete('draft_activity');
		$this->db->query($sql);
		
		$update = $this->updateLastModifiedDraft($draft_id);
		return $this->db->getLastId();
	}
	
	/**
	 * @param int $draft_activity_id
	 * @param $data
	 * @return bool
	 */
	 
	public function editDraftActivity($draft_activity_id, $data) {
		// prevent disabling the only enabled draft in cart
		if (isset($data[ 'status' ]) && !$data[ 'status' ]) {
			$enabled = array();
			$all = $this->getDraftActivities();
			foreach ($all as $c) {
				if ($c[ 'status' ] && $c[ 'draft_activity_id' ] != $draft_activity_id) {
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
			$this->db->query("UPDATE " . $this->db->table("draft_activities") . " 
							  SET " . implode(',', $update) . "
							  WHERE draft_activity_id = '" . (int)$draft_activity_id . "'");
			$this->cache->delete('draft_activity');
		}
		
		$update = $this->updateLastModifiedDraft($draft_id);
		return true;
	}
	
	/**
	 * @param int $draft_activity_id
	 * @return bool
	 */
	public function deleteDraftActivity($draft_activity_id) {
		$this->db->query("DELETE FROM " . $this->db->table("draft_activities") . " 
						  WHERE draft_activity_id = '" . (int)$draft_activity_id . "'");
		$this->cache->delete('draft_activity');
		
		$update = $this->updateLastModifiedDraft($draft_id);
		return true;
	}
	
	/**
	 * @param int $draft_activity_id
	 * @return array
	 */
	public function getDraftActivity($draft_activity_id) {
		$query = $this->db->query("SELECT DISTINCT *
								   FROM " . $this->db->table("draft_activities") . " 
								   WHERE draft_activity_id = '" . (int)$draft_activity_id . "'");

		return $query->row;
	}

	/**
	 * @param int $draft_id
	 * @return array $draft_activity_data
	 */
	public function getDraftActivities($draft_id) {
			
		$sql = "SELECT * FROM ".$this->db->table("draft_activities") ;
		$sql .= " WHERE draft_id = '". (int)$draft_id."'";
		$sql .=	" ORDER BY sortable ASC, date ASC, time ASC ";
		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$draft_activity_data[ $result[ 'draft_activity_id' ] ] = array(
				'draft_activity_id' => $result[ 'draft_activity_id' ],
				'draft_id' => $result[ 'draft_id' ],
				'activity_id' => $result[ 'activity_id' ],
				'date' => $result[ 'date' ],
				'time' => $result[ 'time' ],
				'comment' => $result[ 'comment' ],
				'sortable' => $result[ 'sortable' ],
				'day_id' => $result[ 'day_id' ]
			);
		}
		
		if(!empty($draft_activity_data)) {
			return $draft_activity_data;
		}
		else {
			$draft_activity_data = array();
			return $draft_activity_data;
		}
	}
	
	/**
	 * @param int $draft_id
	 * @return array $draft_activity_data
	 */
	public function getDraftActivitiesByDay($day_id) {
			
		$sql = "SELECT * FROM ".$this->db->table("draft_activities") ;
		$sql .= " WHERE day_id = '". (int)$day_id."'";
		$sql .=	" ORDER BY sortable ASC, date ASC, time ASC ";
		$query = $this->db->query($sql);

		foreach ($query->rows as $result) {
			$draft_activity_data[ $result[ 'draft_activity_id' ] ] = array(
				'draft_activity_id' => $result[ 'draft_activity_id' ],
				'draft_id' => $result[ 'draft_id' ],
				'activity_id' => $result[ 'activity_id' ],
				'date' => $result[ 'date' ],
				'time' => $result[ 'time' ],
				'comment' => $result[ 'comment' ],
				'sortable' => $result[ 'sortable' ]
			);
		}
		
		if(!empty($draft_activity_data)) {
			return $draft_activity_data;
		}
		else {
			$draft_activity_data = array();
			return $draft_activity_data;
		}
	}
	
	public function getTotalDraftActivities($draft_id){
		$query = $this->db->query("SELECT COUNT(*) AS total
      								FROM `" . $this->db->table("draft_activities") . "`
      								WHERE draft_id = '" . (int)$draft_id . "'");
		return (int)$query->row['total'];
	}
	
	public function getTotalDayActivities($day_id){
		$query = $this->db->query("SELECT COUNT(*) AS total
      								FROM `" . $this->db->table("draft_activities") . "`
      								WHERE day_id = '" . (int)$day_id . "'");
		return (int)$query->row['total'];
	}
	
	public function resetSortableDraftActivities($draft_id){
		$draft_activity_data = $this->getDraftActivities($draft_id);
		
		$i = 0;
		foreach($draft_activity_data as $activity) {	
			$sql = "UPDATE " . $this->db->table("draft_activities") . " 
							  SET sortable = '" . $i . "'
							  WHERE draft_activity_id = '" . (int)$activity['draft_activity_id'] . "'";
			$this->db->query($sql);
			$i++;
		}
		
		return true;
	}
	
	public function updateLastModifiedDraft($draft_id){
		$sql = "UPDATE " . $this->db->table("drafts") . " 
							  SET date_modified = NOW()
							  WHERE draft_id = '" . (int)$draft_id . "'";
		$this->db->query($sql);
	}
	
	public function sortDraftActivity($sequence) {
		$i = 1;
		foreach($sequence as $draft_activity_id) {
			$sql = "UPDATE " . $this->db->table("draft_activities") . " 
							  SET sortable = '" . $i . "'
							  WHERE draft_activity_id = '" . $draft_activity_id . "'";
			$this->db->query($sql);
			$i++;
		}
		return true;
	}

}
