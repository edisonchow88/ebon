<div class="row" style="background-color:#CCC; text-align:center; display:none; margin-bottom:20px;">
	<form id="form_trip" action="" method="post">
    	
    	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_conn">Ajax</label>
            <input class="col-xs-6" type="text" id="input_ajax_url" name="ajax_url" value="<?php echo $this->html->getURL('ajax/draft'); ?>"></input>
        </div>
    	<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_conn">Connect</label>
            <input class="col-xs-6" type="text" id="input_conn" name="conn" value="connection"></input>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_action">Action</label>
            <input class="col-xs-6" type="text" id="input_action" name="action" value=""></input>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_view">View</label>
            <input class="col-xs-6" type="text" id="input_view" name="view" value="<?php echo $view; ?>"></input>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_customer_id">Customer Id</label>
            <input class="col-xs-6" type="text" id="input_customer_id" name="customer_id" value="<?php echo $customer_id; ?>"></input>
        </div>
        
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_itinerary_code">Itinerary Code</label>
            <input class="col-xs-6" type="text" id="input_itinerary_code" name="itinerary_code" value="<?php echo $itinerary_code; ?>"></input>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_draft_id">Draft Id</label>
            <input class="col-xs-6" type="text" id="input_draft_id" name="draft_id" value="<?php echo $draft_id; ?>"></input>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_trip_id">Trip Id</label>
            <input class="col-xs-6" type="text" id="input_trip_id" name="trip_id" value="<?php echo $trip_id; ?>"></input>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_day_id">Day Id</label>
            <input class="col-xs-6" type="text" id="input_day_id" name="day_id" value="<?php echo $day_id; ?>"></input>
        </div>
        <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3">
        	<label class="col-xs-6" for="input_activity_id">Activity Id</label>
            <input class="col-xs-6" type="text" id="input_activity_id" name="activity_id" value="<?php echo $activity_id; ?>"></input>
        </div>
    </form>
</div>