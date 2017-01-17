<style>
	#modal-itinerary-date label {
		line-height:40px;
		margin:0;
		padding-left:15px;
		color:#000;
		font-weight:normal;
	}
	
	#modal-itinerary-date input {
		width:100%;
		height:34px;
		margin:3px;
		padding:7px 15px;
		border:solid thin #CCC;
		outline:none;
		color:#000;
	}
</style>

<!-- START: Modal -->
    <div class="modal" id="modal-itinerary-date" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-header fixed-width">
            	<form id="plan-date-form-hidden">
                    <div class="navbar navbar-primary navbar-modal">
                        <div class="col-xs-3 text-left">
                            <label for="travel_date">Start Date</label>
                        </div>
                        <div class="col-xs-6 text-left">
                            <input type="date" min="<?php echo date('Y-m-d'); ?>" name="travel_date" />
                        </div>
                        <div class="col-xs-3 text-right">
                            <a class="btn" data-dismiss="modal">Done</a>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-itinerary-date").on("shown.bs.modal", function () {
		$('#plan-date-form-hidden input[name=travel_date]').focus();
	});
</script>
<script>
	$('#plan-date-form-hidden input[name=travel_date]').on('change',function() {
		updateTravelDate();
	});
</script>