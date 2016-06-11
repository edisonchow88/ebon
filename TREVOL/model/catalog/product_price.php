<?php
/*------------------------------------------------------------------------------
CREATED by TREVOL, 2016/01/25
------------------------------------------------------------------------------*/
if(!defined('DIR_CORE') || !IS_ADMIN){
	header('Location: static_pages/');
}
/**
 * @property ModelCatalogDownload $model_catalog_download
 */
class ModelCatalogProductPrice extends Model{
	
	private $table = "product_prices";
	
	public function getFields() {
		$sql = "SELECT `COLUMN_NAME` FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$this->db->table($this->table)."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$fields[] = $result['COLUMN_NAME'];
		}
		return $fields;
	}
	
	public function getDefaults() {
		$sql = "SELECT * FROM `INFORMATION_SCHEMA`.`COLUMNS` WHERE `TABLE_NAME`='".$this->db->table($this->table)."'";
		$query = $this->db->query($sql);
		foreach($query->rows as $result){
			$defaults[$result['COLUMN_NAME']] = $result['COLUMN_DEFAULT'];
		}
		return $defaults;
	}
	
	public function setTimeOptions($selected,$options) {
		$string = "<option value='' selected='selected'>-- Non Specific --</option>";
		foreach($options as $key => $value) {
			if($key == $selected) {
				$string .= "<option value=".$key." selected='selected'>".$value."</option>";
			}
			else {
				$string .= "<option value=".$key.">".$value."</option>";
			}
		}
		return $string;
	}
	
	public function setGenderOptions($selected) {
		$options = array(
			"-- Non Specific --",
			"Male",
			"Female"
		);
		$values = array(
			"''",
			"M",
			"F",
		);
		foreach($options as $key => $value) {
			if($values[$key] == $selected) {
				$string .= "<option value=".$values[$key]." selected='selected'>".$value."</option>";
			}
			else {
				$string .= "<option value=".$values[$key].">".$value."</option>";
			}
		}
		return $string;
	}
	
	public function setAgeOptions($selected) {
		$options = array(
			"-- Non Specific --",
			"Less than or equal to",
			"Greater than or equal to",
			"Between",
		);
		$values = array(
			"''",
			"1",
			"2",
			"3",
		);
		foreach($options as $key => $value) {
			if($values[$key] == $selected) {
				$string .= "<option value=".$values[$key]." selected='selected'>".$value."</option>";
			}
			else {
				$string .= "<option value=".$values[$key].">".$value."</option>";
			}
		}
		return $string;
	}
	
	public function setPaxOptions($selected) {
		$options = array(
			"-- Non Specific --",
			"Less than or equal to",
			"Greater than or equal to",
			"Between",
		);
		$values = array(
			"''",
			"1",
			"2",
			"3",
		);
		foreach($options as $key => $value) {
			if($values[$key] == $selected) {
				$string .= "<option value=".$values[$key]." selected='selected'>".$value."</option>";
			}
			else {
				$string .= "<option value=".$values[$key].">".$value."</option>";
			}
		}
		return $string;
	}
	
	public function setCurrencyOptions($selected) {
		$currencies = $this->currency->getCurrencies();
		foreach($currencies as $currency) {
			$options[] = $currency['code'];
			$values[] = $currency['code'];
		}
		
		foreach($options as $key => $value) {
			if($values[$key] == $selected) {
				$string .= "<option value=".$values[$key]." selected='selected'>".$value."</option>";
			}
			else {
				$string .= "<option value=".$values[$key].">".$value."</option>";
			}
		}
		return $string;
	}
	
	public function setUnitOptions($selected) {
		$options = array(
			"per Person",
			"per Group"
		);
		$values = array(
			"person",
			"group",
		);
		foreach($options as $key => $value) {
			if($values[$key] == $selected) {
				$string .= "<option value=".$values[$key]." selected='selected'>".$value."</option>";
			}
			else {
				$string .= "<option value=".$values[$key].">".$value."</option>";
			}
		}
		return $string;
	}
	
	public function setDurationUnitOptions($selected) {
		$options = array(
			"hour",
			"day",
			"week",
		);
		$values = array(
			"hour",
			"day",
			"week",
		);
		foreach($options as $key => $value) {
			if($values[$key] == $selected) {
				$string .= "<option value=".$values[$key]." selected='selected'>".$value."</option>";
			}
			else {
				$string .= "<option value=".$values[$key].">".$value."</option>";
			}
		}
		return $string;
	}
	
	/**
	 * @param int $product_id
	 * @return int
	 */
	public function addProductPrice($parent_id, $data){
		
		$keys = array();
		$values = array();
		$keys[] = "product_id";
		$values[] = $parent_id;
		foreach($data as $key => $value) {
			$keys[] = $key;
			$values[] = "'".$value."'";
		}
		$field_keys = implode(", ", $keys);
		$field_values = implode(", ", $values);
		
		$this->db->query(
				"INSERT INTO `" . $this->db->table($this->table) . "`
							(".$field_keys.")
						VALUES (".$field_values.")");
		$id = $this->db->getLastId();
		$this->cache->delete('product');
		return $id;
	}
	
	/**
	 * @param int $product_price_id
	 * @return bool
	 */
	public function deleteProductPrice($product_price_id){
		
		$sql = "DELETE FROM " . $this->db->table("product_prices") . " WHERE product_price_id = '" . (int)$product_price_id . "'";
		$this->db->query($sql);

		$this->cache->delete('product');
		return true;
	}
	
	/**
	 * @param int $product_id
	 * @param int $product_price_id
	 * @return bool
	 */
	public function deleteProductPrices($product_id){
		
		$sql = "DELETE FROM " . $this->db->table("product_prices") . " WHERE product_id = '" . (int)$product_id . "'";
		$query = $this->db->query($sql);

		$this->cache->delete('product');
		return true;
	}
	
	/**
	 * @param int $product_price_id
	 * @param array $data
	 */
	public function updateProductPrice($product_price_id, $data){
		
		$fields = $this->getFields();
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape($data[$f]) . "'";
		}
		
		if(!empty($update)){
			$this->db->query("UPDATE " . $this->db->table($this->table) . " 
								SET " . implode(',', $update) . "
								WHERE product_price_id = '" . (int)$product_price_id . "'");
		}
		
		$this->cache->delete('product');
		return true;
	}
	
	/**
	 * @param int $product_price_id
	 * @return array
	 */
	public function getProductPrice($product_price_id){
		
		$sql = "SELECT * FROM " . $this->db->table("product_prices") . " WHERE product_price_id = '" . (int)$product_price_id . "'";
		$query = $this->db->query($sql);
		
		return $query->row;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductPrices($product_id){
		$product_prices = array();
		
		$sql = "SELECT * FROM " . $this->db->table("product_prices") . " WHERE product_id = '" . (int)$product_id . "' ORDER BY amount DESC";
		$query = $this->db->query($sql);

		foreach($query->rows as $result){
			$product_prices[$result['product_price_id']] = $result;
		}
		return $product_prices;
	}
	
	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductPricesDetail($product_id){
		$product_prices = $this->getProductPrices($product_id);
		
		$prices = array();
		foreach ($product_prices as $price) {
			$prices[$price['product_price_id']]['product_price_id'] = $price['product_price_id'];
			$prices[$price['product_price_id']]['name'] = $price['name'];
			
			if($price['amount'] > 0 ) {
				$prices[$price['product_price_id']]['amount'] = $this->currency->format($price['amount'],$price['currency_code'])."&nbsp;per&nbsp;".$price['unit'];
			}
			else {
				$prices[$price['product_price_id']]['amount'] = "Free";
			}
			
			$count = 0;
			//START - set Condition
			if($price['product_hour_id'] != 0) {
				if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
				$prices[$price['product_price_id']]['condition'] .= "<i class='fa fa-clock-o'></i>";
				$count += 1;
			}
			
			switch ($price['gender']){
				case 'M':
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "<i class='fa fa-mars' title='Male'></i>";
					$count += 1;
					break;
				case 'F':
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "<i class='fa fa-venus' title='Female'></i>";
					$count += 1;
					break;
			}
			
			switch ($price['age']){
				case 1:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "&#8805;".$price['min_age']." age";
					$count += 1;
					break;
				case 2:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "&#8804;".$price['max_age']." age";
					$count += 1;
					break;
				case 3:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= $price['min_age']." ~ ".$price['max_age']." age";
					$count += 1;
					break;
			}
			
			switch ($price['pax']){
				case 1:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "&#8805;".$price['min_pax']." pax";
					$count += 1;
					break;
				case 2:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= "&#8804;".$price['max_pax']." pax";
					$count += 1;
					break;
				case 3:
					if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
					$prices[$price['product_price_id']]['condition'] .= $price['min_pax']." ~ ".$price['max_pax']." pax";
					$count += 1;
					break;
			}
			
			if($price['duration'] != 0) {
				if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
				$prices[$price['product_price_id']]['condition'] .= $price['duration']."&nbsp;".$price['duration_unit'];
				$count += 1;
			}
			
			if($price['early_booking'] != 0) {
				if($count > 0) { $prices[$price['product_price_id']]['condition'] .= ", "; }
				$prices[$price['product_price_id']]['condition'] .= $price['early_booking']." days before visit";
				$count += 1;
			}
			//END
		}
		
		return $prices;
	}

}
