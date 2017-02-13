<?php
/*------------------------------------------------------------------------------
  $Id$

  TREVOL, 
  http://www.trevol.co

  Tool Added by Loh CS on 02032017.
  Main Purpose is to read short url used by share.
------------------------------------------------------------------------------*/
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}
class ModelToolShortUrl extends Model {
	public function getLongUrl($link) {
		
		$host = str_replace( 'www.', '', $_SERVER['HTTP_HOST']);
		$link_path = str_replace( array( 'https://', 'http://', 'https://www.', 'http://www.' ), '', $link );
		$link_path = str_replace( $host , '', $link );
		// for local host only
		$link_path = str_replace( '/ebon' , '', $link );
		$key = explode('/', $link_path);
		// if it is share then need to redirect to other address.
		if ($key[2] == "share") {
			// $key[1] is host, not used here.
			// $key[3] is page type (trip, itinerary,member,preview,summary)
			// $key[4] is trip,code (6 number code)
			
			$trip_code = $key[4]; 
			
			switch ($key[3]) {
    			case 'summary':
        			$redirect_link = $this->html->getSEOURL('trip/summary' ,'&trip='. $trip_code);
       			 	break;
				case 'itinerary':
					$redirect_link = $this->html->getSEOURL('trip/itinerary/view' ,'&trip='. $trip_code);
					break;
				case 'member':
					$redirect_link = $this->html->getSEOURL('trip/member' ,'&trip='. $trip_code);
					break;
				case 'preview':
					$redirect_link = $this->html->getSEOURL('trip/preview' ,'&trip='. $trip_code);
					break;
				case 'full':
					$redirect_link = $this->html->getSEOURL('trip/full' ,'&trip='. $trip_code);
					break;
			}
			
		}else {
			return;
		}
		return $redirect_link;
	}
	
	public function getShortUrl($page, $trip_code, $host_name) {
		
		$host = str_replace( 'www.', '', $_SERVER['HTTP_HOST']);
		// for local host only
		if ($host == "localhost") {
			$host  = $host ."/ebon";
		}
		if (!$host_name) {
			$host_name = "host";
		}
		$short_url = $host .'/'. $host_name .'/share/'. $page .'/'. $trip_code;
		
		
		return $short_url;
	}
	
}
?>