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
class ModelCatalogProductHour extends Model{
	
	/**
	 * @param int $product_id
	 * @return int
	 */
	public function addProductHour($product_id, $data){
		
		if($data['general']==1) {
			$data['date_from'] = NULL;
			$data['date_to'] = NULL;
			$data['month_from'] = NULL;
			$data['month_to'] = NULL;
			$data['month_eml_from'] = NULL;
			$data['month_eml_to'] = NULL;
		}
		else if($data['general']==2) {
			$data['date_from'] = NULL;
			$data['date_to'] = NULL;
		}
		else {
			$data['month_from'] = NULL;
			$data['month_to'] = NULL;
			$data['month_eml_from'] = NULL;
			$data['month_eml_to'] = NULL;
		}
		
		//for checkbox input
		if(!isset($data['day_mon'])) { $data['day_mon'] =  0; }
		if(!isset($data['day_tue'])) { $data['day_tue'] =  0; }
		if(!isset($data['day_wed'])) { $data['day_wed'] =  0; }
		if(!isset($data['day_thu'])) { $data['day_thu'] =  0; }
		if(!isset($data['day_fri'])) { $data['day_fri'] =  0; }
		if(!isset($data['day_sat'])) { $data['day_sat'] =  0; }
		if(!isset($data['day_sun'])) { $data['day_sun'] =  0; }
		if(!isset($data['day_holiday'])) { $data['day_holiday'] =  0; }
		
		$keys = array();
		$values = array();
		$keys[] = "product_id";
		$values[] = $product_id;
		foreach($data as $key => $value) {
			$keys[] = $key;
			$values[] = "'".$value."'";
		}
		$field_keys = implode(", ", $keys);
		$field_values = implode(", ", $values);
		
		$this->db->query(
				"INSERT INTO `" . $this->db->table("product_hours") . "`
							(".$field_keys.")
						VALUES (".$field_values.")");
		$product_hour_id = $this->db->getLastId();
		$this->cache->delete('product');
		return $product_hour_id;
	}
	
	/**
	 * @param int $product_hour_id
	 * @return bool
	 */
	public function deleteProductHour($product_hour_id){
		
		$sql = "DELETE FROM " . $this->db->table("product_hours") . " WHERE product_hour_id = '" . (int)$product_hour_id . "'";
		$this->db->query($sql);

		$this->cache->delete('product');
		return true;
	}
	
	/**
	 * @param int $product_id
	 * @param int $product_hour_id
	 * @return bool
	 */
	public function deleteProductHours($product_id){
		
		$sql = "DELETE FROM " . $this->db->table("product_hours") . " WHERE product_id = '" . (int)$product_id . "'";
		$query = $this->db->query($sql);

		$this->cache->delete('product');
		return true;
	}
	
	/**
	 * @param int $product_hour_id
	 * @param array $data
	 */
	public function updateProductHour($product_hour_id, $data){
		
		$fields = array(
			"product_id",
			"general",
			"date_from",
			"date_to",
			"month_from",
			"month_to",
			"month_eml_from",
			"month_eml_to",
			"day_mon",
			"day_tue",
			"day_wed",
			"day_thu",
			"day_fri",
			"day_sat",
			"day_sun",
			"day_holiday",
			"time_from",
			"time_to",
			"description",
			"status",
		   );
		
		$update = array();
		foreach($fields as $f){
			if(isset($data[$f]))
				$update[] = $f . " = '" . $this->db->escape($data[$f]) . "'";
		}
		
		
		//for checkbox input
		$day_mon = isset($data['day_mon']) ? $data['day_mon'] : 0;
		$update[] = "day_mon = '". $day_mon . "'";
		$day_tue = isset($data['day_tue']) ? $data['day_tue'] : 0;
		$update[] = "day_tue = '". $day_tue . "'";
		$day_wed = isset($data['day_wed']) ? $data['day_wed'] : 0;
		$update[] = "day_wed = '". $day_wed . "'";
		$day_thu = isset($data['day_thu']) ? $data['day_thu'] : 0;
		$update[] = "day_thu = '". $day_thu . "'";
		$day_fri = isset($data['day_fri']) ? $data['day_fri'] : 0;
		$update[] = "day_fri = '". $day_fri . "'";
		$day_sat = isset($data['day_sat']) ? $data['day_sat'] : 0;
		$update[] = "day_sat = '". $day_sat . "'";
		$day_sun = isset($data['day_sun']) ? $data['day_sun'] : 0;
		$update[] = "day_sun = '". $day_sun . "'";
		$day_holiday = isset($data['day_holiday']) ? $data['day_holiday'] : 0;
		$update[] = "day_holiday = '". $day_holiday . "'";
		
		if(!empty($update)){
			$this->db->query("UPDATE " . $this->db->table("product_hours") . " 
								SET " . implode(',', $update) . "
								WHERE product_hour_id = '" . (int)$product_hour_id . "'");
		}
		
		$this->cache->delete('product');
		return true;
	}
	
	/**
	 * @param int $product_hour_id
	 * @return array
	 */
	public function getProductHour($product_hour_id){
		
		$sql = "SELECT * FROM " . $this->db->table("product_hours") . " WHERE product_hour_id = '" . (int)$product_hour_id . "'";
		$query = $this->db->query($sql);
		
		return $query->row;
	}

	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductHours($product_id){
		$product_hours = array();
		
		$sql = "SELECT * FROM " . $this->db->table("product_hours") . " WHERE product_id = '" . (int)$product_id . "' ORDER BY general ASC, date_from ASC, month_from ASC, day_mon DESC, time_from ASC";
		$query = $this->db->query($sql);

		foreach($query->rows as $result){
			$product_hours[$result['product_hour_id']] = $result;
		}
		return $product_hours;
	}
	
	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductHoursDetail($product_id){
		$product_hours = $this->getProductHours($product_id);
		
		$hours = array();
		foreach ($product_hours as $hour) {
			$hours[$hour['product_hour_id']]['product_hour_id'] = $hour['product_hour_id'];
			
			//START - set Status
			switch ($hour['status']){
				case 0:
					$status = "Closed";
					break;
				case 1:
					$status = "Open";
					break;
				case 2:
					$status = "Temporary Closed";
					break;
			}
			$hours[$hour['product_hour_id']]['status'] = $status;
			//END
			
			//START - set Condition
			if($hour['general'] == 3) { //condition: specific date
				$hours[$hour['product_hour_id']]['date'] = $hour['date_from']." - ".$hour['date_to'];
			}
			else if($hour['general'] == 2) { //condition:specific month
				switch ($hour['month_from']){
					case 1:
						$month = "JAN";
						break;
					case 2:
						$month = "FEB";
						break;
					case 3:
						$month = "MAR";
						break;
					case 4:
						$month = "APR";
						break;
					case 5:
						$month = "MAY";
						break;
					case 6:
						$month = "JUN";
						break;
					case 7:
						$month = "JUL";
						break;
					case 8:
						$month = "AUG";
						break;
					case 9:
						$month = "SEP";
						break;
					case 10:
						$month = "OCT";
						break;
					case 11:
						$month = "NOV";
						break;
					case 12:
						$month = "DEC";
						break;
				}
				$month_from = $month;
				
				switch ($hour['month_to']){
					case 1:
						$month = "JAN";
						break;
					case 2:
						$month = "FEB";
						break;
					case 3:
						$month = "MAR";
						break;
					case 4:
						$month = "APR";
						break;
					case 5:
						$month = "MAY";
						break;
					case 6:
						$month = "JUN";
						break;
					case 7:
						$month = "JUL";
						break;
					case 8:
						$month = "AUG";
						break;
					case 9:
						$month = "SEP";
						break;
					case 10:
						$month = "OCT";
						break;
					case 11:
						$month = "NOV";
						break;
					case 12:
						$month = "DEC";
						break;
				}
				$month_to = $month;
				
				$month_eml_from = $hour['month_eml_from'];
				if($month_eml_from != '') { $month_eml_from .= " "; }
				
				$month_eml_to = $hour['month_eml_to'];
				if($month_eml_to != '') { $month_eml_to .= " "; }
				
				$hours[$hour['product_hour_id']]['date'] = $month_eml_from.$month_from." - ".$month_eml_to.$month_to;
			}
			else { //condition: none
				$hours[$hour['product_hour_id']]['date'] = "Normal";
			}
			//END
			
			//START - set Day
			$hours[$hour['product_hour_id']]['day'] = '';
			
			$count = 0;
			$cont = 0;
			if($hour['day_mon']==true) {
				if($hour['day_tue']==true) { //head of string
					$hours[$hour['product_hour_id']]['day'] .= 'Mon';
					$cont = 0;
				}
				else if($hour['day_tue']==false) { //Standalone
					$hours[$hour['product_hour_id']]['day'] .= 'Mon';
				}
				$count += 1;
			}
			if($hour['day_tue']==true) {
				$day_before = $hour['day_mon'];
				$day_after = $hour['day_wed'];
				$weekday = 'Tue';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_wed']==true) {
				$day_before = $hour['day_tue'];
				$day_after = $hour['day_thu'];
				$weekday = 'Wed';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_thu']==true) {
				$day_before = $hour['day_wed'];
				$day_after = $hour['day_fri'];
				$weekday = 'Thu';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_fri']==true) {
				$day_before = $hour['day_thu'];
				$day_after = $hour['day_sat'];
				$weekday = 'Fri';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_sat']==true) {
				$day_before = $hour['day_fri'];
				$day_after = $hour['day_sun'];
				$weekday = 'Sat';
				if($day_before==false && $day_after==true) { //head of string
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
					$cont = 0;
				}
				else if($day_before==true && $day_after==true) { //body of string
					$cont += 1;
				}
				else if($day_before==true && $day_after==false) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false && $day_after==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_sun']==true) {
				$day_before = $hour['day_sat'];
				$weekday = 'Sun';
				if($day_before==true) { //tail of string
					if($cont == 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					else { $hours[$hour['product_hour_id']]['day'] .= ' - '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				else if($day_before==false) { //Standalone
					if($count > 0) { $hours[$hour['product_hour_id']]['day'] .= ', '; }
					$hours[$hour['product_hour_id']]['day'] .= $weekday;
				}
				$count += 1;
			}
			if($hour['day_holiday']==true) {
				$hours[$hour['product_hour_id']]['day'] .= ' &#38; Holiday';
			}
			
			if($hour['day_mon']==true && $hour['day_tue']==true && $hour['day_wed']==true && $hour['day_thu']==true && $hour['day_fri']==true && $hour['day_sat']==true && $hour['day_sun']==true && $hour['day_holiday']==true) { 
				$hours[$hour['product_hour_id']]['day'] = 'Everyday';
			}
			else if($hour['day_mon']==true && $hour['day_tue']==true && $hour['day_wed']==true && $hour['day_thu']==true && $hour['day_fri']==true && $hour['day_sat']==true && $hour['day_sun']==true && $hour['day_holiday']==false) { 
				$hours[$hour['product_hour_id']]['day'] = 'Everyday except Holiday';
			}
			else if($hour['day_mon']==true && $hour['day_tue']==true && $hour['day_wed']==true && $hour['day_thu']==true && $hour['day_fri']==true && $hour['day_sat']==false && $hour['day_sun']==false) { 
				$hours[$hour['product_hour_id']]['day'] = 'Weekday'; 
				if($hour['day_holiday']==true) { $hours[$hour['product_hour_id']]['day'] .= ' &#38; Holiday'; }
			}
			else if($hour['day_mon']==false && $hour['day_tue']==false && $hour['day_wed']==false && $hour['day_thu']==false && $hour['day_fri']==false && $hour['day_sat']==true && $hour['day_sun']==true) {
				$hours[$hour['product_hour_id']]['day'] = 'Sat, Sun';
				if($hour['day_holiday']==true) { $hours[$hour['product_hour_id']]['day'] .= ' &#38; Holiday'; }
			}
			//END
			
			//START - set Time
			$time_from = date('H:i',strtotime($hour['time_from']));
			$time_to = date('H:i',strtotime($hour['time_to']));
			$hours[$hour['product_hour_id']]['time'] = $time_from." - ".$time_to;
			if($hour['time_from'] =='00:00:00' && $hour['time_to'] == '00:00:00') { $hours[$hour['product_hour_id']]['time'] = '24 hours';}
			//END
			
			//START - set Description
			if($hour['description']) { $hours[$hour['product_hour_id']]['description'] = "( ".$hour['description']." )";
			}
			//END
		}
		
		return $hours;
	}
	
	/**
	 * @param int $product_id
	 * @return array
	 */
	public function getProductHoursShort($product_id){
		$product_hours = $this->getProductHours($product_id);
		
		$hours = array();
		foreach ($product_hours as $hour) {
			$hours[$hour['product_hour_id']]['product_hour_id'] = $hour['product_hour_id'];
			if($hour['status'] != 1) { break; }
			
			//START - set Condition
			if($hour['general'] == 3) { //condition: specific date
				$hours[$hour['product_hour_id']]['date'] = $hour['date_from']." - ".$hour['date_to'];
			}
			else if($hour['general'] == 2) { //condition:specific month
				switch ($hour['month_from']){
					case 1:
						$month = "JAN";
						break;
					case 2:
						$month = "FEB";
						break;
					case 3:
						$month = "MAR";
						break;
					case 4:
						$month = "APR";
						break;
					case 5:
						$month = "MAY";
						break;
					case 6:
						$month = "JUN";
						break;
					case 7:
						$month = "JUL";
						break;
					case 8:
						$month = "AUG";
						break;
					case 9:
						$month = "SEP";
						break;
					case 10:
						$month = "OCT";
						break;
					case 11:
						$month = "NOV";
						break;
					case 12:
						$month = "DEC";
						break;
				}
				$month_from = $month;
				
				switch ($hour['month_to']){
					case 1:
						$month = "JAN";
						break;
					case 2:
						$month = "FEB";
						break;
					case 3:
						$month = "MAR";
						break;
					case 4:
						$month = "APR";
						break;
					case 5:
						$month = "MAY";
						break;
					case 6:
						$month = "JUN";
						break;
					case 7:
						$month = "JUL";
						break;
					case 8:
						$month = "AUG";
						break;
					case 9:
						$month = "SEP";
						break;
					case 10:
						$month = "OCT";
						break;
					case 11:
						$month = "NOV";
						break;
					case 12:
						$month = "DEC";
						break;
				}
				$month_to = $month;
				
				$month_eml_from = $hour['month_eml_from'];
				if($month_eml_from != '') { $month_eml_from .= " "; }
				
				$month_eml_to = $hour['month_eml_to'];
				if($month_eml_to != '') { $month_eml_to .= " "; }
				
				$hours[$hour['product_hour_id']]['date'] = $month_eml_from.$month_from." - ".$month_eml_to.$month_to;
			}
			else { //condition: none
			}
			//END
			
			//START - set Day
			$hours[$hour['product_hour_id']]['day'] = '';
			
			if($hour['day_mon']==true) { $hours[$hour['product_hour_id']]['day'] .= 'M'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_tue']==true) { $hours[$hour['product_hour_id']]['day'] .= 'T'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_wed']==true) { $hours[$hour['product_hour_id']]['day'] .= 'W'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_thu']==true) { $hours[$hour['product_hour_id']]['day'] .= 'T'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_fri']==true) { $hours[$hour['product_hour_id']]['day'] .= 'F'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_sat']==true) { $hours[$hour['product_hour_id']]['day'] .= 'S'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_sun']==true) { $hours[$hour['product_hour_id']]['day'] .= 'S'; } else { $hours[$hour['product_hour_id']]['day'] .= '-'; }
			if($hour['day_holiday']==true) { $hours[$hour['product_hour_id']]['day'] .= '*'; }
			//END
			
			//START - set Time
			$time_from = date('H:i',strtotime($hour['time_from']));
			$time_to = date('H:i',strtotime($hour['time_to']));
			$hours[$hour['product_hour_id']]['time'] = $time_from." - ".$time_to;
			if($hour['time_from'] =='00:00:00' && $hour['time_to'] == '00:00:00') { $hours[$hour['product_hour_id']]['time'] = '24 hours';}
			//END
			
			//START - set Description
			if($hour['description']) { $hours[$hour['product_hour_id']]['description'] = $hour['description'];
			}
			//END
			if($hours[$hour['product_hour_id']]['description']!=''){ $strings[$hour['product_hour_id']] .= $hours[$hour['product_hour_id']]['description']."&nbsp;&nbsp;&nbsp;";}
			if($hours[$hour['product_hour_id']]['date']!=''){ $strings[$hour['product_hour_id']] .= $hours[$hour['product_hour_id']]['date']."&nbsp;&nbsp;&nbsp;";}
			if($hours[$hour['product_hour_id']]['day']!=''){ $strings[$hour['product_hour_id']] .= $hours[$hour['product_hour_id']]['day']."&nbsp;&nbsp;&nbsp;";}
			if($hours[$hour['product_hour_id']]['time']!=''){ $strings[$hour['product_hour_id']] .= $hours[$hour['product_hour_id']]['time']."&nbsp;&nbsp;&nbsp;";}
		}
		
		return $strings;
	}

}
