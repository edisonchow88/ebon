<?php
/*------------------------------------------------------------------------------
CREATED BY TREVOL, 2016/01/15
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ModelBrochureReview extends Model {		
	public function addReview($attraction_id, $data) {
		$this->db->query("INSERT INTO " . $this->db->table("reviews") . " 
						  SET author = '" . $this->db->escape($data['name']) . "',
						      customer_id = '" . (int)$this->customer->getId() . "',
						      attraction_id = '" . (int)$attraction_id . "',
						      text = '" . $this->db->escape(strip_tags($data['text'])) . "',
						      rating = '" . (int)$data['rating'] . "',
						      date_added = NOW()");
		
		$review_id = $this->db->getLastId();
		//notify administrator of pending review approval
		$language = new ALanguage($this->registry);
		$language->load('attraction/attraction');

		$msg_text = sprintf($language->get('text_pending_review_approval'), $attraction_id, $review_id);
		$msg = new AMessage();
		$msg->saveNotice($language->get('text_new_review'), $msg_text);
				
		$this->cache->delete('attraction.rating.'.(int)$attraction_id);
		$this->cache->delete('attraction.reviews.totals');
		$this->cache->delete('attraction.reviews.totals.'.$attraction_id);

		return '';
	}
		
	public function getReviewsByAttractionId($attraction_id, $start = 0, $limit = 20) {
		$query = $this->db->query("SELECT r.review_id,
										  r.author,
										  r.rating,
										  r.text,
										  p.attraction_id,
										  pd.name,
										  p.price,
										  r.date_added
							        FROM " . $this->db->table("reviews") . " r
							        LEFT JOIN " . $this->db->table("attractions") . " p ON (r.attraction_id = p.attraction_id)
							        LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd ON (p.attraction_id = pd.attraction_id)
							        WHERE p.attraction_id = '" . (int)$attraction_id . "'
							                AND p.date_available <= NOW()
							                AND p.status = '1'
							                AND r.status = '1'
							                AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "'
							        ORDER BY r.date_added DESC
							        LIMIT " . (int)$start . "," . (int)$limit);
		
		return $query->rows;
	}
	
	public function getAverageRating($attraction_id) {
		$cache = $this->cache->get('attraction.rating.'.(int)$attraction_id);
		if(is_null($cache)){
			$query = $this->db->query( "SELECT AVG(rating) AS total
										FROM " . $this->db->table("reviews") . " 
										WHERE status = '1' AND attraction_id = '" . (int)$attraction_id . "'
										GROUP BY attraction_id");
			$cache  = (int)$query->row['total'];
			$this->cache->set('attraction.rating.'.(int)$attraction_id,$cache);
		}
		return $cache;
	}	
	
	public function getTotalReviews() {
		$cache = $this->cache->get('attraction.reviews.totals');
		if(is_null($cache)){
		$query = $this->db->query( "SELECT COUNT(*) AS total
									FROM " . $this->db->table("reviews") . " r
									LEFT JOIN " . $this->db->table("attractions") . " p ON (r.attraction_id = p.attraction_id)
									WHERE p.date_available <= NOW()
										AND p.status = '1'
										AND r.status = '1'");
			$cache = $query->row['total'];
			$this->cache->set('attraction.reviews.totals', $cache);
		}
		return $cache;
	}

	public function getTotalReviewsByAttractionId($attraction_id) {
		$cache = $this->cache->get('attraction.reviews.totals.'.$attraction_id, (int)$this->config->get('storefront_language_id'));
		if(is_null($cache)){
			$query = $this->db->query( "SELECT COUNT(*) AS total
										FROM " . $this->db->table("reviews") . " r
										LEFT JOIN " . $this->db->table("attractions") . " p ON (r.attraction_id = p.attraction_id)
										LEFT JOIN " . $this->db->table("attraction_descriptions") . " pd ON (p.attraction_id = pd.attraction_id)
										WHERE p.attraction_id = '" . (int)$attraction_id . "'
											AND p.date_available <= NOW()
											AND p.status = '1'
											AND r.status = '1'
											AND pd.language_id = '" . (int)$this->config->get('storefront_language_id') . "'");

			$cache = $query->row['total'];
			$this->cache->set('attraction.reviews.totals.'.$attraction_id, $cache, (int)$this->config->get('storefront_language_id'));
		}
		return $cache;
	}
}
?>