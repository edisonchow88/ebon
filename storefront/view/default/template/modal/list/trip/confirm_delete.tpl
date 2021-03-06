<!-- START: Modal -->
    <div class="modal" id="modal-confirm-delete" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-body modal-body-center">
                <form id="modal-confirm-delete-form" class="hidden">
                    <input name="trip_id" />
                    <input name="name" />
                </form>
                <div class="modal-body-header row">
                    <div class="col-xs-12">Delete Forever</div>
                </div>
                <div class="modal-body-body row">
                    <div class="col-xs-12">Are you sure that you want to permanently delete <div class="modal-target"></div>? You can't undo this action.</div>
                </div>
                <div class="modal-body-footer row">
                    <div class="col-xs-6" data-dismiss="modal"><a>CANCEL</a></div>
                    <div class="col-xs-6" data-dismiss="modal" onclick="deleteTrip();"><a>DELETE FOREVER</a></div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-confirm-delete").on("show.bs.modal", function () {
		$('#modal-confirm-delete .modal-body').hide();
	});
	$("#modal-confirm-delete").on("shown.bs.modal", function () {
		$('#modal-confirm-delete .modal-body').fadeIn();
	});
	$("#modal-confirm-delete").on("hide.bs.modal", function () {
		$('#modal-confirm-delete .modal-body').fadeOut();
	});
</script>