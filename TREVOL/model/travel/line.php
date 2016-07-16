<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelTravelLine extends Model{
	
	private $table = "trip_line";
	
	public function getFields($table) {
		$sql = "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$table."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$output[] = $result['COLUMN_NAME'];
		}
		return $output;
	}
	
	public function getDefaults($table) {
		$sql = "SELECT * FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$table."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$output[$result['COLUMN_NAME']] = $result['COLUMN_DEFAULT'];
		}
		return $output;
	}
	
	public function getLine($line_id='',$plan_id='') {
		$line = array();
		
		if($line_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " 
			";
			if($plan_id != '') { 
				$sql .= " 
					WHERE plan_id = '" . (int)$this->db->escape($plan_id) . "' 
				"; 
			}
			$sql .= "
				ORDER BY sort_order ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " 
				WHERE line_id = '" . (int)$line_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($line_id == '') {
			foreach($query->rows as $result){
				$output[$result['line_id']] = $result;
				$output[$result['line_id']]['plan'] = $this->model_travel_plan->getPlan($result['plan_id']); //IMPORTANT: need to call model at controller
				$output[$result['line_id']]['tag'] = $this->model_resource_tag->getTag($result['tag_id']); //IMPORTANT: need to call model at controller
			}
		}
		else {
			$output = $result = $query->row;
			$output['plan'] = $this->model_travel_plan->getPlan($result['plan_id']); //IMPORTANT: need to call model at controller
			$output['tag'] = $this->model_resource_tag->getTag($result['tag_id']); //IMPORTANT: need to call model at controller
		}
		
		return $output;
	}
	
	public function getLineByPlanId($plan_id) {
		return $this->getLine('',$plan_id);
	}
	
	public function addLine($data) {
		//START: table
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		if(isset($update['date_added'])) { $update['date_added'] = "date_added = '" . gmdate('Y-m-d H:i:s') . "'"; }
		if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
		
		$sql = "
			INSERT INTO `" . $this->db->table($this->table) . "` 
			SET " . implode(',', $update) . "
		";
		$query = $this->db->query($sql);
		//END
		
		$line_id = $this->db->getLastId();
		
		$this->cache->delete('line');
		
		return $line_id;
	}
	
	public function editLine($line_id, $data) {
		//START: table
		$fields = $this->getFields($this->db->table($this->table));
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[$f] = $f . " = '" . $this->db->escape(strtolower($data[$f])) . "'";
		}
		if(isset($update['date_modified'])) { $update['date_modified'] = "date_modified = '" . gmdate('Y-m-d H:i:s') . "'"; }
		
		if(!empty($update)){
			$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET " . implode(',', $update) . "
				WHERE line_id = '" . (int)$line_id . "'
			";
			$query = $this->db->query($sql);
		}
		//END
		
		$this->cache->delete('line');
		return true;
	}
	
	public function deleteLine($line_id) {
		//START: table
		$sql = "
			DELETE FROM " . $this->db->table($this->table) . " 
			WHERE line_id = '" . (int)$line_id . "'
		";
		$query = $this->db->query($sql);
		//END
		
		$this->cache->delete('line');
		return true;
	}
}

?>