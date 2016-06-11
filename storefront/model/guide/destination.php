<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ModelGuideDestination extends Model{
	
	private $table = "destination";
	private $table_description = "destination_description";
	private $table_relation = "destination_relation";
	private $table_tag = "destination_tag";
	
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
	
	public function getDestination($destination_id='') {
		$destination = array();
		
		if($destination_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.destination_id = t2.destination_id 
				ORDER BY t1.destination_id ASC 
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.destination_id = t2.destination_id 
				WHERE t1.destination_id = '" . (int)$destination_id . "' 
			";

		}
		$query = $this->db->query($sql);
		
		if($destination_id == '') {
			foreach($query->rows as $result){
				$output[$result['destination_id']] = $result;
				$output[$result['destination_id']]['name'] = ucwords($result['name']);
				$output[$result['destination_id']]['type_color'] = $this->type_color;
			}
		}
		else {
			$output = $query->row;
			$output['name'] = ucwords($output['name']);
			$output['type_color'] = $this->type_color;
		}
		
		return $output;
	}
	
	public function getDestinationRelation($x,$y) {
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
	
	public function getDestinationAllRelation($destination_id) {
		$destination = array();
		
		$sql = "
			SELECT * 
			FROM " . $this->db->table($this->table) . " t1 
			LEFT JOIN ".$this->db->table($this->table_description)." t2 
			ON t1.destination_id = t2.destination_id 
			WHERE t1.destination_id <> '" . (int)$destination_id . "' 
		";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['destination_id']] = $result;
			$output[$result['destination_id']]['name'] = ucwords($result['name']);
			$output[$result['destination_id']]['type_color'] = $this->type_color;
			$output[$result['destination_id']]['relation'] = $this->getDestinationRelation($destination_id,$result['destination_id']);
		}
		
		return $output;
	}
	
	public function getDestinationParent($destination_id) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE y = '" . (int)$destination_id . "' AND relation = 'parent' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['x']] = $this->getDestination($result['x']);
		}
		
		return $output;
	}
	
	public function getDestinationChild($destination_id) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE x = '" . (int)$destination_id . "' AND relation = 'parent' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['y']] = $this->getDestination($result['y']);
		}
		
		return $output;
	}
	
	public function getDestinationSimilar($destination_id) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE y = '" . (int)$destination_id . "' AND relation = 'similar' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['x']] = $this->getDestination($result['x']);
		}
		
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE x = '" . (int)$destination_id . "' AND relation = 'similar' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['y']] = $this->getDestination($result['y']);
		}
		
		return $output;
	}
	
	public function addDestination($data) {
		//add id
		$sql = "
				INSERT INTO " . $this->db->table($this->table) . " 
				SET 
					destination_tag_id = '" . $this->db->escape($data['destination_tag_id']) . "', 
					icon = '" . $this->db->escape($data['icon']) . "'
			";
		$query = $this->db->query($sql);
		
		$destination_id = $this->db->getLastId();
		
		//add description
		$sql = "
				INSERT INTO " . $this->db->table($this->table_description) . " 
				SET 
					destination_id = '" . $destination_id . "', 
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
							y = '" . $destination_id . "', 
							x = '" . $parent['destination_id'] . "', 
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
							x = '" . $destination_id . "', 
							y = '" . $child['destination_id'] . "', 
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
							x = '" . $destination_id . "', 
							y = '" . $similar['destination_id'] . "', 
							relation = 'similar'
					";
				$query = $this->db->query($sql);
			}
		}
		
		$this->cache->delete('destination');
		
		return $destination_id;
	}
	
	public function editDestination($destination_id, $data) {
		//edit general
		$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET 
					destination_tag_id = '" . $data['destination_tag_id'] . "', 
					icon = '" . $data['icon'] . "', 
					date_modified = NOW() 
				WHERE destination_id = '" . (int)$data['destination_id'] . "'
			";
		$query = $this->db->query($sql);
		
		//edit description
		$sql = "
				UPDATE " . $this->db->table($this->table_description) . " 
				SET 
					language_id = '" . $data['language_id'] . "', 
					name = '" . $data['name'] . "', 
					description = '" . $data['description'] . "' 
				WHERE destination_id = '" . (int)$data['destination_id'] . "'
			";
		$query = $this->db->query($sql);
		
		//delete all destination relation
		$sql = "
				DELETE FROM " . $this->db->table($this->table_relation) . " 
				WHERE ( x = '" . (int)$destination_id . "' OR y = '" . (int)$destination_id . "' )
			";
		$query = $this->db->query($sql);
		
		//add parent
		if($data['parent'] != '') {
			foreach($data['parent'] as $parent) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_relation) . " 
						SET 
							y = '" . (int)$data['destination_id'] . "', 
							x = '" . $parent['destination_id'] . "', 
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
							x = '" . (int)$data['destination_id'] . "', 
							y = '" . $child['destination_id'] . "', 
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
							x = '" . (int)$data['destination_id'] . "', 
							y = '" . $similar['destination_id'] . "', 
							relation = 'similar'
					";
				$query = $this->db->query($sql);
			}
		}
		
		$this->cache->delete('destination');
	}
	
	public function deleteDestination($destination_id) {
		//delete id
		$sql = "
				DELETE FROM " . $this->db->table($this->table) . " 
				WHERE destination_id = '" . (int)$destination_id . "'
			";
		$query = $this->db->query($sql);
		
		//delete description
		$sql = "
				DELETE FROM " . $this->db->table($this->table_description) . " 
				WHERE destination_id = '" . (int)$destination_id . "'
			";
		$query = $this->db->query($sql);
		
		//delete relation
		$sql = "
				DELETE FROM " . $this->db->table($this->table_relation) . " 
				WHERE ( x = '" . (int)$destination_id . "' OR y = '" . (int)$destination_id . "' )
			";
		$query = $this->db->query($sql);
		
		$this->cache->delete('destination');
	}
	
}

?>