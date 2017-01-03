<!-- START: Modal -->
    <div class="modal" id="modal-trip-search" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-header fixed-width">
            	<div class="navbar navbar-primary navbar-search">
                    <div class="col-xs-2 text-left">
                        <a class="btn" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-long-arrow-left"></i></a>
                    </div>
                    <div class="col-xs-8 text-left">
                    	<form>
                        	<input id="modal-trip-search-form-input-search" type="text" placeholder="Search"/>
                        </form>
                    </div>
                    <div class="col-xs-2 text-right">
                        <a class="btn"><i class="fa fa-fw fa-lg fa-times-circle"></i></a>
                    </div>
                </div>
            </div>
            <div class="modal-body fixed-width">
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-trip-search").on("show.bs.modal", function () {
		$('#modal-trip-search .modal-header').hide();
		$('#modal-trip-search .modal-body').hide();
	});
	$("#modal-trip-search").on("shown.bs.modal", function () {
		$('#modal-trip-search .modal-header').fadeIn('fast');
		$('#modal-trip-search-form-input-search').focus();
	});
	$("#modal-trip-search").on("hide.bs.modal", function () {
		$('#modal-trip-search .modal-header').fadeOut();
	});
</script>