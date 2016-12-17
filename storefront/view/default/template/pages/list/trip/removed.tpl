<div class="content-header fixed-width noselect">
    <div class="row navbar navbar-primary navbar-main">
        <div class="col-xs-3 text-left">
            <a class="btn" data-toggle="modal" data-target="#modal-home-menu" onclick="closePageMenuInstant();"><i class="fa fa-fw fa-lg fa-bars"></i></a>
        </div>
        <div class="col-xs-6 text-center">
            <a onclick="togglePageMenu();"><h1>Removed</h1><i class="fa fa-fw fa-caret-down"></i></a>
        </div>
        <div class="col-xs-3 text-right">
            <a class="btn" data-toggle="modal" data-target="#modal-trip-search" onclick="closePageMenuInstant();"><i class="fa fa-fw fa-lg fa-search"></i></a>
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
            <a class="btn btn-delete-trip disabled" data-toggle="modal" data-target="#modal-confirm-delete-multi">Delete Forever</a>
        </div>
    </div>
</div>
<div class="content-body-loading fixed-width">
    <div class="col-xs-12">
        <i class="fa fa-circle-o-notch fa-spin fa-5x fa-fw"></i>
    </div>
</div>
<div class="content-body-empty fixed-width">
    <div class="col-xs-12">
    	<div><b>No Removed Trip</b></div>
        <div>Click to create a <a href="<?php echo $link['trip/new']; ?>">new trip</a></div>
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
            <a class="btn btn-sort-trip" data-toggle="modal" data-target="#modal-trip-sort">&#8595; DATE</a>
        </div>
    </div>
    <div class="content-body-alert"></div>
    <div class="content-body-result la la-70 la-border noselect">
    </div>
</div>

<!-- START: [modal] -->
	<?php echo $modal_home_menu; ?>
    <?php echo $modal_trip_search; ?>
    <?php echo $modal_trip_sort; ?>
    <?php echo $modal_trip_action; ?>
    <?php echo $modal_confirm_delete; ?>
    <?php echo $modal_confirm_delete_multi; ?>
    <?php echo $modal_confirm_delete_all; ?>
<!-- END -->

<script>
	function togglePageMenu() {
		$('.page-menu .menu-shadow').fadeToggle();
		$('.page-menu .menu').slideToggle();
		$('.navbar-primary .fa-caret-down').toggleClass('fa-flip-vertical');
		$('body').toggleClass('modal-open');
	}
	
	function closePageMenu() {
		$('.page-menu .menu-shadow').fadeOut('slow');
		$('.page-menu .menu').slideUp();
		$('.navbar-primary .fa-caret-down').removeClass('fa-flip-vertical');
		$('body').removeClass('modal-open');
	}
	
	function closePageMenuInstant() {
		$('.page-menu .menu-shadow').hide();
		$('.page-menu .menu').hide();
		$('.navbar-primary .fa-caret-down').removeClass('fa-flip-vertical');
		$('body').removeClass('modal-open');
	}
</script>
<script>
	function printTrip(data) {
		<!-- START: define variable -->
			var text_period;
			var text_icon;
			var text_description;
			var today = new Date(date('Y-m-d',new Date()));
			var sort_date;
			var start_date;
			var end_date;
			var start_year;
			var end_year;
			var start_month;
			var end_month;
			var content;
		<!-- END -->
		<!-- START -->
			if(isset(data.travel_date)) {
				<!-- START: set variable -->
					sort_date = data.travel_date;
					start_date = new Date(data.travel_date);
					end_date = new Date(data.end_date);
					start_year = date('y',start_date);
					end_year = date('y',end_date);
					start_month = date('m',start_date);
					end_month = date('m',end_date);
				<!-- END -->
				<!-- START: set text_period -->
					if(start_year == date('y',new Date())) {
						if(data.num_of_day > 1) {
							if(start_month == end_month) {
								text_period = date('M d',start_date) + ' - ' + date('d',end_date);
							}
							else {	
								text_period = date('M d',start_date) + ' - ' + date('M d',end_date);
							}
						}
						else {
							text_period = date('M d',start_date);
						}
		
					}
					else {
						if(data.num_of_day > 1) {
							if(start_month == end_month) {
								text_period = date('M d',start_date) + ' - ' + date('d, Y',end_date);
							}
							else {	
								text_period = date('M d',start_date) + ' - ' + date('M d, Y',end_date);
							}
						}
						else {
							text_period = date('M d, Y',start_date);
						}
					}
				<!-- END -->
				<!-- START: set text_description -->
					text_description = ''
						+ '<div class="la-desc la-desc-line-2">'
							+ '<div class="la-text la-text-sub">'
								+ text_period
							+ '</div>'
							+ '<div class="la-text la-text-main">'
								+ data.name
							+ '</div>'
						+ '</div>'
					;
				<!-- END -->
				<!-- START: set text_icon -->
					if(today >= start_date && today <= end_date) {
						text_icon = '<i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#FD0;"></i>';
					}
					else if(today < start_date) {
						text_icon = '<i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#3C0;"></i>';
					}
					else {
						text_icon = '<i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#B00;"></i>';
					}
				<!-- END -->
			}
			else {
				<!-- START: set variable -->
					sort_date = addDayToDate(today,3650);
				<!-- END -->
				<!-- START: set text_description -->
					text_description = ''
						+ '<div class="la-desc la-desc-line-1">'
							+ '<div class="la-text la-text-main">'
								+ data.name
							+ '</div>'
						+ '</div>'
					;
				<!-- END -->
				<!-- START: set text_icon -->
					text_icon = '<i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#3C0;"></i>';
				<!-- END -->
			}
		<!-- END -->
		<!-- START: [content] -->
			if(isset(data.storage) && data.storage == 'cookie') {
				content = ''
					+ '<div class="la-row result-trip result-unsaved-trip" data-date="'+sort_date+'" data-saved="0">'
						+ '<a href="'+data.url+'">'
							+ '<div class="col-xs-7 text-left">'
								+ '<div class="la-icon"><i class="fa fa-fw fa-lg fa-exclamation-triangle text-danger"></i></div>'
								+ text_description
							+ '</div>'
							+ '<div class="col-xs-3 text-right">'
								+ '<div class="la-desc">'
									+ '<div class="la-text text-danger">'
										+ 'UNSAVED'
									+ '</div>'
								+ '</div>'
							+ '</div>'
							+ '<div class="col-xs-2 text-right">'
								+ '<a class="la-btn" data-toggle="modal" data-target="#modal-trip-action" onclick="setModalTripAction(\'removed\',\''+data.name+'\',0);"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>'
							+ '</div>'
						+ '</a>'
						+ '<form class="result-trip-form hidden">'
							+ '<input type="hidden" name="trip_id" value="'+data.trip_id+'"/>'
						+ '</form>'
					+ '</div>'
				;
				$('.content-body-result').append(content);
			}
			else if(data.type == 'upcoming' || data.type == 'past') {
				content = ''
					+ '<div class="la-row result-trip result-saved-trip" data-date="'+sort_date+'" data-saved="1">'
						+ '<a href="'+data.url+'">'
							+ '<div class="col-xs-10 text-left">'
								+ '<div class="la-icon">' 
									+ text_icon 
								+ '</div>'
								+ text_description
							+ '</div>'
							+ '<div class="col-xs-2 text-right">'
								+ '<a data-toggle="modal" data-target="#modal-trip-action" class="la-btn"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>'
							+ '</div>'
						+ '</a>'
						+ '<form class="result-trip-form hidden">'
							+ '<input type="hidden" name="trip_id" value="'+data.trip_id+'"/>'
						+ '</form>'
					+ '</div>'
				;
				$('.content-body-result').append(content);
			}
			else if(data.type == 'removed') {
				content = ''
					+ '<div class="la-row result-trip result-saved-trip" data-date="'+sort_date+'" data-saved="1">'
						+ '<a href="'+data.url+'">'
							+ '<div class="col-xs-10 text-left">'
								+ '<div class="la-icon">' 
									+ '<i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#666;"></i>'
								+ '</div>'
								+ text_description
							+ '</div>'
							+ '<div class="col-xs-2 text-right">'
								+ '<a class="la-btn" data-toggle="modal" data-target="#modal-trip-action" onclick="setModalTripAction(\'removed\',\''+data.name+'\',\''+data.trip_id+'\');"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>'
							+ '</div>'
						+ '</a>'
						+ '<form class="result-trip-form hidden">'
							+ '<input type="hidden" name="trip_id" value="'+data.trip_id+'"/>'
						+ '</form>'
					+ '</div>'
				;
				$('.content-body-result').append(content);
			}
		<!-- END -->
	}
	
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
							runRefreshTripList(json,'sortTripByDateFromOldToNew');
						}, "json");
					<!-- END -->
				<!-- END -->
			<?php } else { ?>
				<!-- START: [not logged] -->
					runRefreshTripList(result,'sortTripByDateFromOldToNew');
				<!-- END -->
			<?php } ?>
		<!-- END -->
	}
	
	function runRefreshTripList(trip,sorting) {
		if(isset(trip.trip)) {
			for(i=0;i<=trip.trip.length||0;i++) {
				if(i==trip.trip.length) {
					$('.content-body-loading').fadeOut();
					if(trip.trip.length > 0) {
						setTimeout(function() {
							switch(sorting) {
								case 'sortTripByDateFromOldToNew':
									sortTripByDateFromOldToNew();
									break;
								case 'sortTripByDateFromNewToOld':
									sortTripByDateFromNewToOld();
									break;
								default:
									sortTripByDateFromOldToNew();
							}
						},1);
						$('.content-body').css('min-height','calc(100vh + 40px)');
						$('body').animate({scrollTop: 40},1);
						$('.content-body-empty').hide();
					}
				}
				else {
					printTrip(trip.trip[i]);
				}
			}
		}
		else {
			$('.btn-edit-trip').addClass('disabled');
			$('.btn-delete-all').addClass('disabled');
			$('.content-body-loading').fadeOut();
		}
	}
	
	function openEditTrip() {
		$('.navbar-general').addClass('hidden');
		$('.navbar-edit').removeClass('hidden');
		$('.result-trip .la-btn').html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$('.result-trip .la-btn').css('color','#CCC');
		$('.result-trip a').css('pointer-events','none');
		$('.result-trip').off().on('click',function() { 
			var button = $(this).find('.la-btn');
			if($(this).hasClass('selected')) {
				$(this).removeClass('selected');
				deselectTrip(button);
			}
			else {
				$(this).addClass('selected');
				selectTrip(button);
			}
		});
		$('#content-body-alert').html('');
	}
	
	function closeEditTrip() {
		$('.navbar-general').removeClass('hidden');
		$('.navbar-edit').addClass('hidden');
		$('.btn-delete-trip').addClass('disabled');
		$('.result-trip .la-btn').html('<i class="fa fa-fw fa-lg fa-ellipsis-v"></i>');
		$('.result-trip .la-btn').css('color','#000');
		$('.result-trip a').css('pointer-events','auto');
		$('.result-trip').off();
		$('.result-trip').removeClass('selected');
		$('#content-body-alert').html('');
	}
	
	function selectTrip(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-check-square"></i>');
		$(button).css('color','#e93578');
		if($('.result-trip.selected').length > 0) {
			$('.btn-delete-trip').removeClass('disabled');
		}
	}
	
	function deselectTrip(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$(button).css('color','#CCC');
		if($('.result-trip.selected').length < 1) {
			$('.btn-delete-trip').addClass('disabled');
		}
	}
	
	function removeTrip() {
		var num_of_removed_trip = $('.result-trip.selected').length;
		var num_of_removed_saved_trip = $('.result-saved-trip.selected').length;
		var num_of_removed_unsaved_trip = $('.result-unsaved-trip.selected').length;
		
		<?php if($this->user->isLogged() == false) { ?>
			<!-- START: set cookie -->
				setCookie('trip','',0);
				setCookie('plan','',0);
			<!-- END -->
			<!-- START: reload result -->
				refreshTrip();
			<!-- END -->
			<!-- START: show hint -->
				showHint('Trip Deleted');
			<!-- END -->
		<?php } else { ?>
			<!-- START: set cookie -->
				if(num_of_removed_unsaved_trip > 0) {
					cookie_trip = getCookie('trip');
					cookie_trip = JSON.parse(cookie_trip);
					cookie_trip.removed = 1;
					cookie_trip = JSON.stringify(cookie_trip);
					setCookie('trip',cookie_trip,1);
				}
			<!-- END -->
			<!-- START: get data -->
				var trip = new Array();
				var trip_id = '';
				var e;
				for(i=0;i<num_of_removed_saved_trip;i++) {
					e = $('.result-saved-trip.selected .result-trip-form input[name=trip_id]').get(i);
					trip_id = $(e).val();
					trip.push(trip_id);
				}
			<!-- END -->
			<!-- START: set data -->
				var data = {
					"action":"remove_trip",
					"trip":trip
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					<!-- START: reload result -->
						refreshTrip();
					<!-- END -->
					<!-- START: show hint -->
						if(num_of_removed_trip > 1) {
							showHint('Trips Removed');
						}
						else {
							showHint('Trip Removed');
						}
					<!-- END -->
				}, "json");
			<!-- END -->
		<?php } ?>
	}
	
	function setModalTripAction(type,name,trip_id) {
		$('.modal-trip-action-trip-name').html(name);
		$('#modal-trip-action-form input[name=trip_id]').val(trip_id);
		$('#modal-trip-action-form input[name=name]').val(name);
		if(type == 'removed') {
			$('.modal-trip-action-view').hide();
			$('.modal-trip-action-edit').hide();
			$('.modal-trip-action-share').hide();
			$('.modal-trip-action-duplicate').hide();
			$('.modal-trip-action-template').hide();
			$('.modal-trip-action-cancel').hide();
			$('.modal-trip-action-leave').hide();
			$('.modal-trip-action-restore').show();
			$('.modal-trip-action-delete').show();
		}
	}
	
	refreshTrip();
</script>