<!-- START: Modal -->
    <div class="modal fade" id="modal-trip-action" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-dialog fixed-width">
            	<form id="modal-trip-action-form" class="hidden">
                	<input type="text" name="trip_id"/>
                    <input type="text" name="name"/>
                </form>
            </div>
            <div class="modal-footer fixed-width">
            	<div class="la la-50 la-border la-hover noselect">
                	<div class="la-row la-row-subtitle">
                    	<div class="col-xs-12">
                            <div class="la-desc">
                                <div class="la-text modal-trip-action-trip-name"></div>
                            </div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-duplicate disabled" data-dismiss="modal">
                    	<div class="col-xs-10">
                            <div class="la-icon">
                                <i class="fa fa-fw fa-lg fa-copy"></i>
                            </div>
                            <div class="la-desc">
                                <div class="la-text">Duplicate</div>
                            </div>
                        </div>
                        <div class="col-xs-2">
                            <div class="la-btn">
                                <i class="fa fa-fw fa-lg fa-exclamation-circle"></i>
                            </div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-save" data-dismiss="modal">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-save"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text">Save</div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-share" data-dismiss="modal">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-share"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text">Share</div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-template" data-dismiss="modal">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-level-up"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text">Saved as Template</div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-cancel" data-dismiss="modal" onclick="cancelTrip();">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-times-circle-o"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text">Cancel</div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-resume" data-dismiss="modal" onclick="resumeTrip();">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-undo"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text">Undo Cancellation</div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-read" data-dismiss="modal">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-envelope-open"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text">Read</div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-report" data-dismiss="modal">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-flag"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text">Report as ...</div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-remove" data-dismiss="modal" onclick="removeTrip();">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-trash text-danger"></i>
                        </div>
                        <div class="la-desc text-danger">
                            <div class="la-text">Remove</div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-restore" data-dismiss="modal" onclick="restoreTrip();">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-history"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text">Restore</div>
                        </div>
                    </div>
                    <div class="la-row modal-trip-action-delete" data-dismiss="modal" data-toggle="modal" data-target="#modal-confirm-delete" onclick="triggerConfirmDeleteTrip();">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-trash text-danger"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text text-danger">Delete Forever</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-trip-action").on("show.bs.modal", function () {
		$('#modal-trip-action .modal-footer').hide();
	});
	$("#modal-trip-action").on("shown.bs.modal", function () {
		$('#modal-trip-action .modal-footer').slideDown('fast');
	});
	$("#modal-trip-action").on("hide.bs.modal", function () {
		$('#modal-trip-action .modal-footer').slideUp();
	});
</script>
<script>
	function removeTrip() {
		<!-- START: set data -->
			var data = {
				"action":"remove_trip",
				"user_id":"<?php echo $this->user->getUserId(); ?>",
				"trip_id":$('#modal-trip-action-form input[name=trip_id]').val()
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				<!-- START: if error -->
					if(isset(json['error'])) {
						processError(json['error']);
						return;
					}
				<!-- END -->
				<!-- START: reload result -->
					refreshTrip();
				<!-- END -->
				<!-- START: show hint -->
					showHint('Trip Removed');
				<!-- END -->
			}, "json");
		<!-- END -->
	}
	
	function deleteTrip() {
		<!-- START: set data -->
			var data = {
				"action":"delete_trip",
				"user_id":"<?php echo $this->user->getUserId(); ?>",
				"trip_id":$('#modal-trip-action-form input[name=trip_id]').val()
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				<!-- START: if error -->
					if(isset(json['error'])) {
						processError(json['error']);
						return;
					}
				<!-- END -->
				<!-- START: reload result -->
					refreshTrip();
				<!-- END -->
				<!-- START: show hint -->
					showHint('Trip Deleted');
				<!-- END -->
			}, "json");
		<!-- END -->
	}
	
	function restoreTrip() {
		<?php if($this->user->isLogged() == false) { ?>
			var trip_id = $('#modal-trip-action-form input[name=trip_id]').val();
			if(trip_id == 0) { //means it is unsaved trip
				<!-- START: set cookie -->
					var cookie_trip;
					cookie_trip = getCookie('trip');
					cookie_trip = JSON.parse(cookie_trip);
					cookie_trip.removed = 0;
					cookie_trip = JSON.stringify(cookie_trip);
					setCookie('trip',cookie_trip,1);
				<!-- END -->
				<!-- START: reload result -->
					refreshTrip();
				<!-- END -->
				<!-- START: show hint -->
					showHint('Trip Restored');
				<!-- END -->
			}
		<?php } else { ?>
			<!-- START: set data -->
				var data = {
					"action":"restore_trip",
					"user_id":"<?php echo $this->user->getUserId(); ?>",
					"trip_id":$('#modal-trip-action-form input[name=trip_id]').val()
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					<!-- START: if error -->
						if(isset(json['error'])) {
							processError(json['error']);
							return;
						}
					<!-- END -->
					<!-- START: reload result -->
						refreshTrip();
					<!-- END -->
					<!-- START: show hint -->
						showHint('Trip Restored');
					<!-- END -->
				}, "json");
			<!-- END -->
		<?php } ?>
	}
	
	function cancelTrip() {
		<!-- START: set data -->
			var data = {
				"action":"cancel_trip",
				"trip_id":$('#modal-trip-action-form input[name=trip_id]').val()
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				<!-- START: if error -->
					if(isset(json['error'])) {
						processError(json['error']);
						return;
					}
				<!-- END -->
				<!-- START: reload result -->
					refreshTrip();
				<!-- END -->
				<!-- START: show hint -->
					showHint('Trip Cancelled');
				<!-- END -->
			}, "json");
		<!-- END -->
	}
	
	function resumeTrip() {
		<!-- START: set data -->
			var data = {
				"action":"resume_trip",
				"trip_id":$('#modal-trip-action-form input[name=trip_id]').val()
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				<!-- START: if error -->
					if(isset(json['error'])) {
						processError(json['error']);
						return;
					}
				<!-- END -->
				<!-- START: reload result -->
					refreshTrip();
				<!-- END -->
				<!-- START: show hint -->
					showHint('Trip Resumed');
				<!-- END -->
			}, "json");
		<!-- END -->
	}
	
	function triggerConfirmDeleteTrip() {
		var trip_id = $('#modal-trip-action-form input[name=trip_id]').val();
		var name = $('#modal-trip-action-form input[name=name]').val();
		$('#modal-confirm-delete-form input[name=trip_id]').val(trip_id);
		$('#modal-confirm-delete-form input[name=name]').val(name);
		$('#modal-confirm-delete .modal-confirm-target').html(name);
	}
</script>