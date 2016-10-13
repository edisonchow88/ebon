<?php
if (! defined ( 'DIR_CORE' )) {
	header ( 'Location: static_pages/' );
}

class ControllerModalItineraryLineReview extends AController {

  	public function main() {
        //START: init controller data
        	$this->extensions->hk_InitData($this,__FUNCTION__);
		//END
		
		//START: set template
			$this->processTemplate('modal/itinerary/line/review.tpl' );
		//END

        //START: update controller data
        	$this->extensions->hk_UpdateData($this,__FUNCTION__);
		//END
	}
}
?>

