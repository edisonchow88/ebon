<div class="content-header fixed-width noselect">
    <div class="row navbar navbar-primary navbar-main">
        <div class="col-xs-3 text-left">
            <a class="btn" data-toggle="modal" data-target="#menu-mobile-main" onclick="closePageMenuInstant();"><i class="fa fa-fw fa-lg fa-bars"></i></a>
        </div>
        <div class="col-xs-6 text-center">
            <a onclick="togglePageMenu();"><h1>Removed</h1><i class="fa fa-fw fa-caret-down"></i></a>
        </div>
        <div class="col-xs-3 text-right">
            <a class="btn hidden" data-toggle="modal" data-target="#modal-trip-search" onclick="closePageMenuInstant();"><i class="fa fa-fw fa-lg fa-search"></i></a>
        </div>
    </div>
    <?php echo $menu_list_trip; ?>
    <div class="row navbar navbar-secondary navbar-general">
        <div class="col-xs-6 text-left">
            <a class="btn btn-edit-trip" onclick="openEditTrip();">Edit</a>
        </div>
        <div class="col-xs-6 text-right">
            <a class="btn btn-delete-all" data-toggle="modal" data-target="#modal-confirm-delete-all">Delete All</a>
        </div>
    </div>
    <div class="row navbar navbar-secondary navbar-edit hidden">
        <div class="col-xs-6 text-left">
            <a class="btn" onclick="closeEditTrip();">Done</a>
        </div>
        <div class="col-xs-6 text-right">
            <a class="btn btn-navbar-edit-right disabled" data-toggle="modal" data-target="#modal-confirm-delete-multi">Delete Forever</a>
        </div>
    </div>
</div>
<div class="content-body-loading fixed-width">
    <div class="col-xs-12">
        <i class="fa fa-circle-o-notch fa-spin fa-5x fa-fw"></i>
    </div>
</div>
<div class="content-body-empty fixed-width">
	<div class="content-body-alert"></div>
    <div class="col-xs-12">
    	<div><b>No Removed Trip</b></div>
         <!-- <div>Click to create a <a href="<?php echo $link['wizard/new']; ?>">new trip</a></div> -->
        <div>Click to create a <a onclick="openLinkNewTrip();">new trip</a></div>
    </div>
</div>
<div class="content-body fixed-width">
	<div class="navbar navbar-shadow"></div>
    <div class="navbar navbar-shadow"></div>
    <div class="row navbar navbar-quaternary">
        <div class="col-xs-6 text-left">
            <span class="text-sub">Sort by</span>
        </div>
        <div class="col-xs-6 text-right">
            <a class="btn btn-sort-trip" data-toggle="modal" data-target="#modal-trip-sort">&uarr; DATE</a>
        </div>
    </div>
    <div class="content-body-alert"></div>
    <div class="content-body-result la la-70 la-border noselect">
    </div>
</div>

<!-- START: [menu] -->
	<?php echo $menu_mobile_main; ?>
<!-- END -->
<!-- START: [modal] -->
    <?php echo $modal_trip_search; ?>
    <?php echo $modal_trip_sort; ?>
    <?php echo $modal_trip_action; ?>
    <?php echo $modal_confirm_delete; ?>
    <?php echo $modal_confirm_delete_multi; ?>
    <?php echo $modal_confirm_delete_all; ?>
<!-- END -->
<!-- START: [script] -->
	<?php echo $script_list_trip; ?>
<!-- END -->

<script>
	function refreshTrip() {
		<!-- START: reset loading screen -->
			$('.content-body-loading').show();
			$('.content-body-empty').show();
			$('.content-body').css('min-height','100vh');
			closeEditTrip();
		<!-- END -->
		<!-- START: clear old result -->
			$('.content-body-result').html('');
		<!-- END -->
		<!-- START: get unsaved trip -->
			var result = {trip:[]}
			var cookie_trip = getCookie('trip');
			var cookie_plan = getCookie('plan');
			if(isset(cookie_trip)) {
				<!-- START: [revisit] -->
					unsaved_plan = new Array();
					unsaved_plan = JSON.parse(cookie_plan);
					unsaved_trip = new Array();
					unsaved_trip = JSON.parse(cookie_trip);
					if(!(isset(unsaved_trip.removed))) { unsaved_trip.removed = 0; }
					unsaved_trip.travel_date = unsaved_plan.travel_date;
					unsaved_trip.num_of_day = unsaved_plan.day.length;
					unsaved_trip.end_date = addDayToDate(unsaved_trip.travel_date,unsaved_trip.num_of_day-1);
					unsaved_trip.username = 'Me';
					unsaved_trip.url = '<?php echo $link["trip/itinerary"]; ?>';
					unsaved_trip.storage = 'cookie';
					if(unsaved_trip.removed == 1) { result.trip.push(unsaved_trip); }
				<!-- END -->
			}
		<!-- END -->
		<!-- START: get new result -->
			<?php if($this->user->isLogged() != false) { ?>
				<!-- START: [logged] -->
					<!-- START: set data -->
						var data = {
							"action":"load_removed_trip",
							"user_id":"<?php echo $this->user->getUserId(); ?>"
						};
					<!-- END -->
					<!-- START: send POST -->
						$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
							if(!(isset(json.trip))) { json.trip = new Array(); }
							if(typeof unsaved_trip != 'undefined' && unsaved_trip.removed == 1) { 
								json.trip.unshift(unsaved_trip); 
							}
							runRefreshTripList(json,'sortTripByDateFromNewToOld');
						}, "json");
					<!-- END -->
				<!-- END -->
			<?php } else { ?>
				<!-- START: [not logged] -->
					runRefreshTripList(result,'sortTripByDateFromNewToOld');
				<!-- END -->
			<?php } ?>
		<!-- END -->
	}
	
	refreshTrip();
</script>