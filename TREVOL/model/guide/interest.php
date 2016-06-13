<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelGuideInterest extends Model{
	
	private $table = "interest";
	private $table_description = "interest_description";
	private $table_relation = "interest_relation";
	private $table_tag = "interest_tag";
	
	private $type_color = "#5cb85c";
	
	public function getFields() {
		$sql = "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$this->db->table($this->table)."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$output[] = $result['COLUMN_NAME'];
		}
		return $output;
	}
	
	public function getDefaults() {
		$sql = "SELECT * FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$this->db->table($this->table)."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$output[$result['COLUMN_NAME']] = $result['COLUMN_DEFAULT'];
		}
		return $output;
	}
	
	public function getInterest($interest_id='') {
		$interest = array();
		
		if($interest_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.interest_id = t2.interest_id 
				ORDER BY t1.interest_id ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.interest_id = t2.interest_id 
				WHERE t1.interest_id = '" . (int)$interest_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($interest_id == '') {
			foreach($query->rows as $result){
				$output[$result['interest_id']] = $result;
				$output[$result['interest_id']]['name'] = ucwords($result['name']);
				$output[$result['interest_id']]['type_color'] = $this->type_color;
			}
		}
		else {
			$output = $query->row;
			$output['name'] = ucwords($output['name']);
			$output['type_color'] = $this->type_color;
		}
		
		return $output;
	}
	
	public function getInterestRelation($x,$y) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE x = '" . (int)$x . "' AND y = '" . (int)$y . "'";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			if($result['relation'] == 'parent') { $result['relation'] = 'child'; }
			$output = $result['relation'];
		}
		
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE x = '" . (int)$y . "' AND y = '" . (int)$x . "'";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output = $result['relation'];
		}
		return $output;
	}
	
	public function getInterestAllRelation($interest_id) {
		$interest = array();
		
		$sql = "
			SELECT * 
			FROM " . $this->db->table($this->table) . " t1 
			LEFT JOIN ".$this->db->table($this->table_description)." t2 
			ON t1.interest_id = t2.interest_id 
			WHERE t1.interest_id <> '" . (int)$interest_id . "' 
		";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['interest_id']] = $result;
			$output[$result['interest_id']]['name'] = ucwords($result['name']);
			$output[$result['interest_id']]['type_color'] = $this->type_color;
			$output[$result['interest_id']]['relation'] = $this->getInterestRelation($interest_id,$result['interest_id']);
		}
		
		return $output;
	}
	
	public function getInterestParent($interest_id) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE y = '" . (int)$interest_id . "' AND relation = 'parent' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['x']] = $this->getInterest($result['x']);
		}
		
		return $output;
	}
	
	public function getInterestChild($interest_id) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE x = '" . (int)$interest_id . "' AND relation = 'parent' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['y']] = $this->getInterest($result['y']);
		}
		
		return $output;
	}
	
	public function getInterestSimilar($interest_id) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE y = '" . (int)$interest_id . "' AND relation = 'similar' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['x']] = $this->getInterest($result['x']);
		}
		
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE x = '" . (int)$interest_id . "' AND relation = 'similar' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['y']] = $this->getInterest($result['y']);
		}
		
		return $output;
	}
	
	public function addInterest($data) {
		//add id
		$sql = "
				INSERT INTO " . $this->db->table($this->table) . " 
				SET 
					interest_tag_id = '" . $this->db->escape($data['interest_tag_id']) . "', 
					icon = '" . $this->db->escape($data['icon']) . "'
			";
		$query = $this->db->query($sql);
		
		$interest_id = $this->db->getLastId();
		
		//add description
		$sql = "
				INSERT INTO " . $this->db->table($this->table_description) . " 
				SET 
					interest_id = '" . $interest_id . "', 
					language_id = '" . $this->db->escape($data['language_id']) . "', 
					name = '" . $this->db->escape($data['name']) . "',
					description = '" . $this->db->escape($data['description']) . "'
			";
		$query = $this->db->query($sql);
		
		//add parent
		if($data['parent'] != '') {
			foreach($data['parent'] as $parent) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_relation) . " 
						SET 
							y = '" . $interest_id . "', 
							x = '" . $parent['interest_id'] . "', 
							relation = 'parent'
					";
				$query = $this->db->query($sql);
			}
		}
		
		//add child
		if($data['child'] != '') {
			foreach($data['child'] as $child) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_relation) . " 
						SET 
							x = '" . $interest_id . "', 
							y = '" . $child['interest_id'] . "', 
							relation = 'parent'
					";
				$query = $this->db->query($sql);
			}
		}
		
		//add similar
		if($data['similar'] != '') {
			foreach($data['similar'] as $similar) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_relation) . " 
						SET 
							x = '" . $interest_id . "', 
							y = '" . $similar['interest_id'] . "', 
							relation = 'similar'
					";
				$query = $this->db->query($sql);
			}
		}
		
		$this->cache->delete('interest');
		
		return $interest_id;
	}
	
	public function editInterest($interest_id, $data) {
		//edit general
		$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET 
					interest_tag_id = '" . $data['interest_tag_id'] . "', 
					icon = '" . $data['icon'] . "', 
					date_modified = NOW() 
				WHERE interest_id = '" . (int)$data['interest_id'] . "'
			";
		$query = $this->db->query($sql);
		
		//edit description
		$sql = "
				UPDATE " . $this->db->table($this->table_description) . " 
				SET 
					language_id = '" . $data['language_id'] . "', 
					name = '" . $data['name'] . "', 
					description = '" . $data['description'] . "' 
				WHERE interest_id = '" . (int)$data['interest_id'] . "'
			";
		$query = $this->db->query($sql);
		
		//delete all interest relation
		$sql = "
				DELETE FROM " . $this->db->table($this->table_relation) . " 
				WHERE ( x = '" . (int)$interest_id . "' OR y = '" . (int)$interest_id . "' )
			";
		$query = $this->db->query($sql);
		
		//add parent
		if($data['parent'] != '') {
			foreach($data['parent'] as $parent) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_relation) . " 
						SET 
							y = '" . (int)$data['interest_id'] . "', 
							x = '" . $parent['interest_id'] . "', 
							relation = 'parent'
					";
				$query = $this->db->query($sql);
			}
		}
		
		//add child
		if($data['child'] != '') {
			foreach($data['child'] as $child) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_relation) . " 
						SET 
							x = '" . (int)$data['interest_id'] . "', 
							y = '" . $child['interest_id'] . "', 
							relation = 'parent'
					";
				$query = $this->db->query($sql);
			}
		}
		
		//add similar
		if($data['similar'] != '') {
			foreach($data['similar'] as $similar) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_relation) . " 
						SET 
							x = '" . (int)$data['interest_id'] . "', 
							y = '" . $similar['interest_id'] . "', 
							relation = 'similar'
					";
				$query = $this->db->query($sql);
			}
		}
		
		$this->cache->delete('interest');
	}
	
	public function deleteInterest($interest_id) {
		//delete id
		$sql = "
				DELETE FROM " . $this->db->table($this->table) . " 
				WHERE interest_id = '" . (int)$interest_id . "'
			";
		$query = $this->db->query($sql);
		
		//delete description
		$sql = "
				DELETE FROM " . $this->db->table($this->table_description) . " 
				WHERE interest_id = '" . (int)$interest_id . "'
			";
		$query = $this->db->query($sql);
		
		//delete relation
		$sql = "
				DELETE FROM " . $this->db->table($this->table_relation) . " 
				WHERE ( x = '" . (int)$interest_id . "' OR y = '" . (int)$interest_id . "' )
			";
		$query = $this->db->query($sql);
		
		$this->cache->delete('interest');
	}
	
}

?>