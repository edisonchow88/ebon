<?php
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}

class ModelResourceTag extends Model{
	
	private $table = "tag";
	private $table_description = "tag_description";
	private $table_relation = "tag_relation";
	private $table_type = "tag_type";
	
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
	
	public function getTag($tag_id='',$tag_type_id='') {
		if($tag_id == '0') { return; } //avoid return an array
		
		$tag = array();
		
		if($tag_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.tag_id = t2.tag_id 
				LEFT JOIN ".$this->db->table($this->table_type)." t3 
				ON t1.tag_type_id = t3.tag_type_id 
			";
			if($tag_type_id != '') $sql .= "WHERE t1.tag_type_id = '" . (int)$this->db->escape($tag_type_id) . "' ";
			$sql .= "ORDER BY t3.type_name ASC, t1.tag_id ASC";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table) . " t1 
				LEFT JOIN ".$this->db->table($this->table_description)." t2 
				ON t1.tag_id = t2.tag_id 
				LEFT JOIN ".$this->db->table($this->table_type)." t3 
				ON t1.tag_type_id = t3.tag_type_id 
				WHERE t1.tag_id = '" . (int)$tag_id . "' 
			";
			if($tag_type_id != '') $sql .= "AND t1.tag_type_id = '" . $this->db->escape($tag_type_id) . "'";
		}
		$query = $this->db->query($sql);
		
		if($tag_id == '') {
			foreach($query->rows as $result){
				$output[$result['tag_id']] = $result;
				$output[$result['tag_id']]['name'] = ucwords($result['name']);
				$output[$result['tag_id']]['type_name'] = ucwords($result['type_name']);
			}
		}
		else {
			$output = $query->row;
			$output['name'] = ucwords($output['name']);
			$output['type_name'] = ucwords($output['type_name']);
		}
		
		return $output;
	}
	
	public function getTagByTypeName($type_name) {
		$sql = "
			SELECT * 
			FROM " . $this->db->table($this->table_type) . " 
			WHERE type_name = '" . $type_name . "' 
		";
		$query = $this->db->query($sql);
		$result = $query->row;
		$tag_type_id = $result['tag_type_id'];
		return $this->getTag('',$tag_type_id);
	}
	
	public function getTagRelation($x,$y) {
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
	
	public function getTagAllRelation($tag_id) {
		$tag = array();
		
		$sql = "
			SELECT * 
			FROM " . $this->db->table($this->table) . " t1 
			LEFT JOIN ".$this->db->table($this->table_description)." t2 
			ON t1.tag_id = t2.tag_id 
			LEFT JOIN ".$this->db->table($this->table_type)." t3 
			ON t1.tag_type_id = t3.tag_type_id 
			WHERE t1.tag_id <> '" . (int)$tag_id . "' 
		";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['tag_id']] = $result;
			$output[$result['tag_id']]['name'] = ucwords($result['name']);
			$output[$result['tag_id']]['type_name'] = ucwords($result['type_name']);
			$output[$result['tag_id']]['relation'] = $this->getTagRelation($tag_id,$result['tag_id']);
		}
		
		return $output;
	}
	
	public function getTagParent($tag_id) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE y = '" . (int)$tag_id . "' AND relation = 'parent' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['x']] = $this->getTag($result['x']);
		}
		
		return $output;
	}
	
	public function getTagChild($tag_id) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE x = '" . (int)$tag_id . "' AND relation = 'parent' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['y']] = $this->getTag($result['y']);
		}
		
		return $output;
	}
	
	public function getTagSimilar($tag_id) {
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE y = '" . (int)$tag_id . "' AND relation = 'similar' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['x']] = $this->getTag($result['x']);
		}
		
		$sql = "SELECT * FROM " . $this->db->table($this->table_relation) . " WHERE x = '" . (int)$tag_id . "' AND relation = 'similar' ";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['y']] = $this->getTag($result['y']);
		}
		
		return $output;
	}
	
	public function addTag($data) {
		//add id
		$sql = "
				INSERT INTO " . $this->db->table($this->table) . " 
				SET 
					tag_type_id = '" . $this->db->escape($data['tag_type_id']) . "', 
					icon = '" . $this->db->escape($data['icon']) . "'
			";
		$query = $this->db->query($sql);
		
		$tag_id = $this->db->getLastId();
		
		//add description
		$sql = "
				INSERT INTO " . $this->db->table($this->table_description) . " 
				SET 
					tag_id = '" . $tag_id . "', 
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
							y = '" . $tag_id . "', 
							x = '" . $parent['tag_id'] . "', 
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
							x = '" . $tag_id . "', 
							y = '" . $child['tag_id'] . "', 
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
							x = '" . $tag_id . "', 
							y = '" . $similar['tag_id'] . "', 
							relation = 'similar'
					";
				$query = $this->db->query($sql);
			}
		}
		
		$this->cache->delete('tag');
		
		return $tag_id;
	}
	
	public function editTag($tag_id, $data) {
		//edit general
		$sql = "
				UPDATE " . $this->db->table($this->table) . " 
				SET 
					tag_type_id = '" . $data['tag_type_id'] . "', 
					icon = '" . $data['icon'] . "', 
					date_modified = NOW() 
				WHERE tag_id = '" . (int)$data['tag_id'] . "'
			";
		$query = $this->db->query($sql);
		
		//edit description
		$sql = "
				UPDATE " . $this->db->table($this->table_description) . " 
				SET 
					language_id = '" . $data['language_id'] . "', 
					name = '" . $data['name'] . "', 
					description = '" . $data['description'] . "' 
				WHERE tag_id = '" . (int)$data['tag_id'] . "'
			";
		$query = $this->db->query($sql);
		
		//delete all tag relation
		$sql = "
				DELETE FROM " . $this->db->table($this->table_relation) . " 
				WHERE ( x = '" . (int)$tag_id . "' OR y = '" . (int)$tag_id . "' )
			";
		$query = $this->db->query($sql);
		
		//add parent
		if($data['parent'] != '') {
			foreach($data['parent'] as $parent) {
				$sql = "
						INSERT INTO " . $this->db->table($this->table_relation) . " 
						SET 
							y = '" . (int)$data['tag_id'] . "', 
							x = '" . $parent['tag_id'] . "', 
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
							x = '" . (int)$data['tag_id'] . "', 
							y = '" . $child['tag_id'] . "', 
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
							x = '" . (int)$data['tag_id'] . "', 
							y = '" . $similar['tag_id'] . "', 
							relation = 'similar'
					";
				$query = $this->db->query($sql);
			}
		}
		
		$this->cache->delete('tag');
	}
	
	public function deleteTag($tag_id) {
		//delete id
		$sql = "
				DELETE FROM " . $this->db->table($this->table) . " 
				WHERE tag_id = '" . (int)$tag_id . "'
			";
		$query = $this->db->query($sql);
		
		//delete description
		$sql = "
				DELETE FROM " . $this->db->table($this->table_description) . " 
				WHERE tag_id = '" . (int)$tag_id . "'
			";
		$query = $this->db->query($sql);
		
		//delete relation
		$sql = "
				DELETE FROM " . $this->db->table($this->table_relation) . " 
				WHERE ( x = '" . (int)$tag_id . "' OR y = '" . (int)$tag_id . "' )
			";
		$query = $this->db->query($sql);
		
		$this->cache->delete('tag');
	}
	
	//START: Tag Type
	public function getTagType($tag_type_id='') {
		$tag_type = array();
		
		if($tag_type_id == '') {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table_type) . " 
				ORDER BY type_name ASC
			";
		}
		else {
			$sql = "
				SELECT * 
				FROM " . $this->db->table($this->table_type) . " 
				WHERE tag_type_id = '" . (int)$tag_type_id . "' 
			";

		}
		$query = $this->db->query($sql);
		$this->cache->delete('tag_type');
		
		if($tag_type_id == '') {
			foreach($query->rows as $result){
				$output[$result['tag_type_id']] = $result;
				$output[$result['tag_type_id']]['type_name'] = ucwords($result['type_name']);
			}
		}
		else {
			$output = $query->row;
			$output['type_name'] = ucwords($output['type_name']);
		}
		
		return $output;
	}
	
	public function addTagType($data) {
		$sql = "
				INSERT INTO " . $this->db->table($this->table_type) . " 
				SET 
					type_name = '" . $this->db->escape($data['type_name']) . "', 
					type_color = '" . $this->db->escape($data['type_color']) . "'
			";
		$query = $this->db->query($sql);
		$this->cache->delete('tag_type');
		
		$tag_type_id = $this->db->getLastId();
		
		return $tag_type_id;
	}
	
	public function editTagType($tag_type_id, $data) {
		$update_data = array();
		foreach ( $data as $key => $value ) {
			$update_data[] = "`$key` = '" . $this->db->escape($value) . "' ";
		}
		
		$sql = "
				UPDATE " . $this->db->table($this->table_type) . " 
				SET ".implode(',', $update_data)." 
				WHERE tag_type_id = '" . (int)$tag_type_id . "'
			";
		$query = $this->db->query($sql);
		$this->cache->delete('tag_type');
	}
	
	public function deleteTagType($tag_type_id) {
		$sql = "
				DELETE FROM " . $this->db->table($this->table_type) . " 
				WHERE tag_type_id = '" . (int)$tag_type_id . "'
			";
		$query = $this->db->query($sql);
		$this->cache->delete('tag_type');
	}
	
	//image
	public function getTagByImageId($image_id) {
		$sql = "
				SELECT * 
				FROM " . $this->db->table('image_tag') . " 
				WHERE image_id = '" . (int)$image_id . "' 
			";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result['tag_id']] = $this->getTag($result['tag_id']);
		}
		
		return $output;
	}
	
	//destination
	public function getTagByDestinationId($destination_id) {
		$sql = "
				SELECT * 
				FROM " . $this->db->table('destination_tag') . " 
				WHERE destination_id = '" . (int)$destination_id . "' 
			";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result[$i]] = $this->getTag($result['tag_id']);
		}
		
		return $output;
	}
	
	//interest
	public function getTagByInterestId($interest_id) {
		$sql = "
				SELECT * 
				FROM " . $this->db->table('interest_tag') . " 
				WHERE interest_id = '" . (int)$interest_id . "' 
			";
		$query = $this->db->query($sql);
		
		foreach($query->rows as $result){
			$output[$result[$i]] = $this->getTag($result['tag_id']);
		}
		
		return $output;
	}
}

?>