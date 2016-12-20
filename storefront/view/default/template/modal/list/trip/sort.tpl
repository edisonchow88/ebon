<!-- START: Modal -->
    <div class="modal fade" id="modal-trip-sort" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-dialog fixed-width">
            </div>
            <div class="modal-footer fixed-width">
            	<div class="la la-50 la-border la-hover noselect">
                	<div class="la-row la-row-subtitle">
                    	<div class="col-xs-12">
                            <div class="la-desc">
                                <div class="la-text">Sort By</div>
                            </div>
                        </div>
                    </div>
                    <div class="la-row btn-sort-trip-by-date-from-old-to-new" data-dismiss="modal" onclick="sortTripByDateFromOldToNew();">
                    	<div class="col-xs-3">
                            <div class="la-desc">
                                <div class="la-text">Date</div>
                            </div>
                        </div>
                        <div class="col-xs-7">
                            <div class="la-desc">
                                <div class="la-text">Oldest &rarr; Newest</div>
                            </div>
                        </div>
                        <div class="col-xs-2">
                        	<div class="la-btn">
                            	<i class="fa fa-fw fa-lg fa-check"></i>
                            </div>
                        </div>
                    </div>
                    <div class="la-row btn-sort-trip-by-date-from-new-to-old" data-dismiss="modal" onclick="sortTripByDateFromNewToOld();">
                        <div class="col-xs-3">
                            <div class="la-desc">
                                <div class="la-text">Date</div>
                            </div>
                        </div>
                        <div class="col-xs-7">
                            <div class="la-desc">
                                <div class="la-text">Newest &rarr; Oldest</div>
                            </div>
                        </div>
                        <div class="col-xs-2">
                        	<div class="la-btn">
                            	<i class="fa fa-fw fa-lg fa-check hidden"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function sortTripByDateFromOldToNew() {
		sortList({
			element:'.result-trip',
			container:'.content-body-result',
			dataset:[{'data':'saved','order':'asc'},{'data':'date','order':'asc'}]
		});
		$('#modal-trip-sort .fa-check').addClass('hidden');
		$('.btn-sort-trip-by-date-from-old-to-new').find('.fa-check').removeClass('hidden');
		$('.btn-sort-trip').html('&darr; DATE');
	}
	function sortTripByDateFromNewToOld() {
		sortList({
			element:'.result-trip',
			container:'.content-body-result',
			dataset:[{'data':'saved','order':'asc'},{'data':'date','order':'desc'}]
		});
		$('#modal-trip-sort .fa-check').addClass('hidden');
		$('.btn-sort-trip-by-date-from-new-to-old').find('.fa-check').removeClass('hidden');
		$('.btn-sort-trip').html('&uarr; DATE');
	}
</script>
<script>
	$("#modal-trip-sort").on("show.bs.modal", function () {
		$('#modal-trip-sort .modal-footer').hide();
	});
	$("#modal-trip-sort").on("shown.bs.modal", function () {
		$('#modal-trip-sort .modal-footer').slideDown('fast');
	});
	$("#modal-trip-sort").on("hide.bs.modal", function () {
		$('#modal-trip-sort .modal-footer').slideUp();
	});
</script>