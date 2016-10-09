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