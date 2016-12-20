<!-- START: Modal -->
    <div class="modal" id="modal-confirm-delete-all" role="dialog" data-backdrop="false">
    	<form id="modal-confirm-delete-all-form" class="hidden">
        </form>
        <div class="modal-wrapper">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-confirm-wrapper">
                <div class="modal-confirm-header row">
                    <div class="col-xs-12">Delete All</div>
                </div>
                <div class="modal-confirm-body row">
                    <div class="col-xs-12">Are you sure that you want to permanently delete all removed trips? You can't undo this action.</div>
                </div>
                <div class="modal-confirm-footer row">
                    <div class="col-xs-6" data-dismiss="modal"><a>CANCEL</a></div>
                    <div class="col-xs-6" data-dismiss="modal" onclick="deleteAll();"><a>DELETE ALL</a></div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-confirm-delete-all").on("show.bs.modal", function () {
		$('#modal-confirm-delete-all .modal-confirm-wrapper').hide();
	});
	$("#modal-confirm-delete-all").on("shown.bs.modal", function () {
		$('#modal-confirm-delete-all .modal-confirm-wrapper').fadeIn();
	});
	$("#modal-confirm-delete-all").on("hide.bs.modal", function () {
		$('#modal-confirm-delete-all .modal-confirm-wrapper').fadeOut();
	});
</script>