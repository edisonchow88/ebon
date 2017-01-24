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
					if(today >= start_date && today <= end_date) { //ongoing trip
						text_icon = '<i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#FD0;"></i>';
					}
					else if(today < start_date) { //upcoming trip
						text_icon = '<i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#3C0;"></i>';
					}
					else { //past trip
						text_icon = '<i class="fa fa-fw fa-lg fa-dot-circle-o" style="color:#FA0;"></i>';
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
								+ '<a class="la-btn" data-toggle="modal" data-target="#modal-trip-action" onclick="setModalTripAction(\'upcoming\',\''+data.name+'\',0);"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>'
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
								+ '<a class="la-btn" data-toggle="modal" data-target="#modal-trip-action" onclick="setModalTripAction(\''+data.type+'\',\''+data.name+'\',\''+data.trip_id+'\');"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>'
							+ '</div>'
						+ '</a>'
						+ '<form class="result-trip-form hidden">'
							+ '<input type="hidden" name="trip_id" value="'+data.trip_id+'"/>'
						+ '</form>'
					+ '</div>'
				;
				$('.content-body-result').append(content);
			}
			else if(data.type == 'cancelled') {
				content = ''
					+ '<div class="la-row result-trip result-saved-trip" data-date="'+sort_date+'" data-saved="1">'
						+ '<a href="'+data.url+'">'
							+ '<div class="col-xs-7 text-left">'
								+ '<div class="la-icon">' 
									+ '<i class="fa fa-fw fa-lg fa-times-circle-o" style="color:#B00;"></i>'
								+ '</div>'
								+ text_description
							+ '</div>'
							+ '<div class="col-xs-3 text-right">'
								+ '<div class="la-desc">'
									+ '<div class="la-text text-sub">'
										+ 'CANCELLED'
									+ '</div>'
								+ '</div>'
							+ '</div>'
							+ '<div class="col-xs-2 text-right">'
								+ '<a class="la-btn" data-toggle="modal" data-target="#modal-trip-action" onclick="setModalTripAction(\''+data.type+'\',\''+data.name+'\',\''+data.trip_id+'\');"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>'
							+ '</div>'
						+ '</a>'
						+ '<form class="result-trip-form hidden">'
							+ '<input type="hidden" name="trip_id" value="'+data.trip_id+'"/>'
						+ '</form>'
					+ '</div>'
				;
				$('.content-body-result').append(content);
			}
			else if(data.type == 'invited') {
				content = ''
					+ '<div class="la-row result-trip result-saved-trip" data-date="'+sort_date+'" data-saved="1">'
						+ '<a href="'+data.url+'">'
							+ '<div class="col-xs-7 text-left">'
								+ '<div class="la-icon">' 
									+ '<i class="fa fa-fw fa-lg fa-envelope" style="color:#555;"></i>'
								+ '</div>'
								+ text_description
							+ '</div>'
							+ '<div class="col-xs-3 text-right">'
								+ '<div class="la-desc">'
									+ '<div class="la-text text-sub">'
										+ 'INVITED'
									+ '</div>'
								+ '</div>'
							+ '</div>'
							+ '<div class="col-xs-2 text-right">'
								+ '<a class="la-btn" data-toggle="modal" data-target="#modal-trip-action" onclick="setModalTripAction(\''+data.type+'\',\''+data.name+'\',\''+data.trip_id+'\');"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>'
							+ '</div>'
						+ '</a>'
						+ '<form class="result-trip-form hidden">'
							+ '<input type="hidden" name="trip_id" value="'+data.trip_id+'"/>'
						+ '</form>'
					+ '</div>'
				;
				$('.content-body-result').append(content);
			}
			else if(data.type == 'requested') {
				content = ''
					+ '<div class="la-row result-trip result-saved-trip" data-date="'+sort_date+'" data-saved="1">'
						+ '<a href="'+data.url+'">'
							+ '<div class="col-xs-7 text-left">'
								+ '<div class="la-icon">' 
									+ '<i class="fa fa-fw fa-lg fa-envelope" style="color:#555;"></i>'
								+ '</div>'
								+ text_description
							+ '</div>'
							+ '<div class="col-xs-3 text-right">'
								+ '<div class="la-desc">'
									+ '<div class="la-text text-sub">'
										+ 'REQUESTED'
									+ '</div>'
								+ '</div>'
							+ '</div>'
							+ '<div class="col-xs-2 text-right">'
								+ '<a class="la-btn" data-toggle="modal" data-target="#modal-trip-action" onclick="setModalTripAction(\''+data.type+'\',\''+data.name+'\',\''+data.trip_id+'\');"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>'
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
				if(data.status_id == 0) { //removed cancelled trip
					content = ''
						+ '<div class="la-row result-trip result-saved-trip" data-date="'+sort_date+'" data-saved="1">'
							+ '<a href="'+data.url+'">'
								+ '<div class="col-xs-7 text-left">'
									+ '<div class="la-icon">' 
										+ '<i class="fa fa-fw fa-lg fa-times-circle-o" style="color:#666;"></i>'
									+ '</div>'
									+ text_description
								+ '</div>'
								+ '<div class="col-xs-3 text-right">'
									+ '<div class="la-desc">'
										+ '<div class="la-text text-sub">'
											+ 'CANCELLED'
										+ '</div>'
									+ '</div>'
								+ '</div>'
								+ '<div class="col-xs-2 text-right">'
									+ '<a class="la-btn" data-toggle="modal" data-target="#modal-trip-action" onclick="setModalTripAction(\''+data.type+'\',\''+data.name+'\',\''+data.trip_id+'\');"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>'
								+ '</div>'
							+ '</a>'
							+ '<form class="result-trip-form hidden">'
								+ '<input type="hidden" name="trip_id" value="'+data.trip_id+'"/>'
							+ '</form>'
						+ '</div>'
					;
				}
				else if(data.member_status_id == 1 || data.member_status_id == 5) { //removed invited trip
					content = ''
						+ '<div class="la-row result-trip result-saved-trip" data-date="'+sort_date+'" data-saved="1">'
							+ '<a href="'+data.url+'">'
								+ '<div class="col-xs-10 text-left">'
									+ '<div class="la-icon">' 
										+ '<i class="fa fa-fw fa-lg fa-envelope" style="color:#666;"></i>'
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
				}
				else { //normal removed trip
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
				}
				$('.content-body-result').append(content);
			}
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
		$('.btn-navbar-edit-right').addClass('disabled');
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
			$('.btn-navbar-edit-right').removeClass('disabled');
		}
	}
	
	function deselectTrip(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$(button).css('color','#CCC');
		if($('.result-trip.selected').length < 1) {
			$('.btn-navbar-edit-right').addClass('disabled');
		}
	}
	
	function removeTripMulti() {
		var num_of_removed_trip = $('.result-trip.selected').length;
		var num_of_removed_saved_trip = $('.result-saved-trip.selected').length;
		var num_of_removed_unsaved_trip = $('.result-unsaved-trip.selected').length;
		
		<!-- START: show loading -->
			showLoad('Removing');
		<!-- END -->
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
					"action":"remove_multi_trip",
					"user_id":"<?php echo $this->user->getUserId(); ?>",
					"trip":trip
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data)
					.done(function(json) {
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
					}, "json")
					.fail(function() {
						<!-- START: show hint -->
							showAlert('Connection Error');
						<!-- END -->
					})
				;
			<!-- END -->
		<?php } ?>
	}
	
	function deleteMulti() {
		var num_of_removed_trip = $('.result-trip.selected').length;
		var num_of_removed_saved_trip = $('.result-saved-trip.selected').length;
		var num_of_removed_unsaved_trip = $('.result-unsaved-trip.selected').length;
		
		<!-- START: show loading -->
			showLoad('Deleting');
		<!-- END -->
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
				setCookie('trip','',0);
				setCookie('plan','',0);
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
					"action":"delete_multi",
					"user_id":"<?php echo $this->user->getUserId(); ?>",
					"trip":trip
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data)
					.done(function(json) {
						<!-- START: reload result -->
							refreshTrip();
						<!-- END -->
						<!-- START: show hint -->
							if(num_of_removed_trip > 1) {
								showHint('Trips Deleted');
							}
							else {
								showHint('Trip Deleted');
							}
						<!-- END -->
					}, "json")
					.fail(function() {
						<!-- START: show hint -->
							showAlert('Connection Error');
						<!-- END -->
					})
				;
			<!-- END -->
		<?php } ?>
	}
	
	function deleteAll() {
		var num_of_removed_trip = $('.result-trip').length;
		var num_of_removed_saved_trip = $('.result-saved-trip').length;
		var num_of_removed_unsaved_trip = $('.result-unsaved-trip').length;
		
		<!-- START: show loading -->
			showLoad('Deleting');
		<!-- END -->
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
				setCookie('trip','',0);
				setCookie('plan','',0);
			<!-- END -->
			<!-- START: get data -->
				var trip = new Array();
				var trip_id = '';
				var e;
				for(i=0;i<num_of_removed_saved_trip;i++) {
					e = $('.result-saved-trip .result-trip-form input[name=trip_id]').get(i);
					trip_id = $(e).val();
					trip.push(trip_id);
				}
			<!-- END -->
			<!-- START: set data -->
				var data = {
					"action":"delete_multi",
					"user_id":"<?php echo $this->user->getUserId(); ?>",
					"trip":trip
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data)
					.done(function(json) {
						<!-- START: reload result -->
							refreshTrip();
						<!-- END -->
						<!-- START: show hint -->
							if(num_of_removed_trip > 1) {
								showHint('Trips Deleted');
							}
							else {
								showHint('Trip Deleted');
							}
						<!-- END -->
					}, "json")
					.fail(function() {
						<!-- START: show hint -->
							showAlert('Connection Error');
						<!-- END -->
					})
				;
			<!-- END -->
		<?php } ?>
	}
	
	function openModalNewTrip() {
		var trip = getCookie('trip');
		if(isset(trip)) { trip = JSON.parse(trip); }
		
		if($('.result-trip-status').length > 0) {
			var content;
			content = '<div class="alert alert-warning"><b>'+trip.name+' is not saved.</b><br/>Please save or delete it before create a new trip.</div>';
			$('#wrapper-trip-list-alert').html(content);
		}
		else {
			$('#wrapper-trip-list-alert').html('');
			$('#modal-trip-new').modal('show');
			//Google Analytics Event
			ga('send', 'event','trip','open-modal-new-trip');
		}
	}
	
	function setModalTripAction(type,name,trip_id) {
		$('.modal-trip-action-trip-name').html(name);
		$('#modal-trip-action-form input[name=trip_id]').val(trip_id);
		$('#modal-trip-action-form input[name=name]').val(name);
		if(type == 'unsaved') {
			$('.modal-trip-action-save').show();
			$('.modal-trip-action-share').hide();
			$('.modal-trip-action-duplicate').hide();
			$('.modal-trip-action-template').hide();
			$('.modal-trip-action-cancel').hide();
			$('.modal-trip-action-resume').hide();
			$('.modal-trip-action-read').hide();
			$('.modal-trip-action-report').hide();
			$('.modal-trip-action-remove').hide();
			$('.modal-trip-action-restore').hide();
			$('.modal-trip-action-delete').hide();
		}
		else if(type == 'upcoming') {
			$('.modal-trip-action-save').hide();
			$('.modal-trip-action-share').show();
			$('.modal-trip-action-duplicate').show();
			$('.modal-trip-action-template').hide();
			$('.modal-trip-action-cancel').show();
			$('.modal-trip-action-resume').hide();
			$('.modal-trip-action-read').hide();
			$('.modal-trip-action-report').hide();
			$('.modal-trip-action-remove').show();
			$('.modal-trip-action-restore').hide();
			$('.modal-trip-action-delete').hide();
		}
		else if(type == 'past') {
			$('.modal-trip-action-save').hide();
			$('.modal-trip-action-share').show();
			$('.modal-trip-action-duplicate').show();
			$('.modal-trip-action-template').hide();
			$('.modal-trip-action-cancel').show();
			$('.modal-trip-action-resume').hide();
			$('.modal-trip-action-read').hide();
			$('.modal-trip-action-report').hide();
			$('.modal-trip-action-remove').show();
			$('.modal-trip-action-restore').hide();
			$('.modal-trip-action-delete').hide();
		}
		else if(type == 'invited') {
			$('.modal-trip-action-save').hide();
			$('.modal-trip-action-share').hide();
			$('.modal-trip-action-duplicate').hide();
			$('.modal-trip-action-template').hide();
			$('.modal-trip-action-cancel').hide();
			$('.modal-trip-action-resume').hide();
			$('.modal-trip-action-read').show();
			$('.modal-trip-action-report').show();
			$('.modal-trip-action-remove').show();
			$('.modal-trip-action-restore').hide();
			$('.modal-trip-action-delete').hide();
		}
		else if(type == 'requested') {
			$('.modal-trip-action-save').hide();
			$('.modal-trip-action-share').hide();
			$('.modal-trip-action-duplicate').hide();
			$('.modal-trip-action-template').hide();
			$('.modal-trip-action-cancel').hide();
			$('.modal-trip-action-resume').hide();
			$('.modal-trip-action-read').show();
			$('.modal-trip-action-report').show();
			$('.modal-trip-action-remove').show();
			$('.modal-trip-action-restore').hide();
			$('.modal-trip-action-delete').hide();
		}
		else if(type == 'cancelled') {
			$('.modal-trip-action-save').hide();
			$('.modal-trip-action-share').show();
			$('.modal-trip-action-duplicate').show();
			$('.modal-trip-action-template').hide();
			$('.modal-trip-action-cancel').hide();
			$('.modal-trip-action-resume').show();
			$('.modal-trip-action-read').hide();
			$('.modal-trip-action-report').hide();
			$('.modal-trip-action-remove').show();
			$('.modal-trip-action-restore').hide();
			$('.modal-trip-action-delete').hide();
		}
		else if(type == 'removed') {
			$('.modal-trip-action-save').hide();
			$('.modal-trip-action-share').hide();
			$('.modal-trip-action-duplicate').hide();
			$('.modal-trip-action-template').hide();
			$('.modal-trip-action-cancel').hide();
			$('.modal-trip-action-resume').hide();
			$('.modal-trip-action-read').hide();
			$('.modal-trip-action-report').hide();
			$('.modal-trip-action-remove').hide();
			$('.modal-trip-action-restore').show();
			$('.modal-trip-action-delete').show();
		}
	}
</script>