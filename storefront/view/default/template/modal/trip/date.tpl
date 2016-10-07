<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-trip-date" role="dialog">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-trip-date-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a id="modal-trip-date-button-close" class="btn btn-header" data-toggle="modal" data-target="#modal-trip-date">Done</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Set Dates</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body">
                    	<?php echo $component['form']; ?>
                    	<?php echo $component['form_hidden']; ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-trip-date").on("show", function () {
		$("body").addClass("modal-open");
	}).on("hidden", function () {
		$("body").removeClass("modal-open");
	});
	
	$("#modal-trip-date").on( "show.bs.modal", function() {
		$('#plan-date-form-input-number-of-days').siblings('label').removeClass('hidden');
	});
	$("#modal-trip-date").on( "shown.bs.modal", function() {
		$('#modal-trip-date .modal-content').scrollTop(0);
	});
	$("#modal-trip-date").on( "hide.bs.modal", function() {
	});
</script>
<script>
	function printDate(data) {
		var travel_date;
		var last_date;
		var day;
		var month;
		var num_of_day;
		
		if(isset(data.travel_date)) {
			date = new Date(data.travel_date);
			num_of_day = data.day.length; 
			
			travel_date = date;
			day = ("0" + travel_date.getDate()).slice(-2);
			month = ("0" + (travel_date.getMonth() + 1)).slice(-2);
			travel_date = travel_date.getFullYear() + "-" + (month) + "-" + (day) ;
			
			last_date = new Date(date.setDate(date.getDate() + num_of_day - 1));
			day = ("0" + last_date.getDate()).slice(-2);
			month = ("0" + (last_date.getMonth() + 1)).slice(-2);
			last_date = last_date.getFullYear() + "-" + (month) + "-" + (day) ;
			
			$('#plan-date-form input[name=num_of_day]').val(data.day.length);
			$('#plan-date-form input[name=travel_date]').val(travel_date);
			$('#plan-date-form input[name=last_date]').val(last_date);
			$('#plan-date-form-hidden input[name=travel_date]').val(travel_date);
			$('#plan-date-form-hidden input[name=last_date]').val(last_date);
			$('#plan-date-form-hidden input[name=num_of_day]').val(data.day.length);
		}
	}
</script>