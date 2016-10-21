<style>
	#wrapper-trip-archive-bar {
		border-bottom:solid thin #DDD;
	}
	
	#wrapper-trip -list {
		padding:0;
		padding-bottom:70px;
	}
	
	#wrapper-trip-action {
		position:fixed;
		bottom:0;
		height:40px;
		border-top:solid thin #DDD;
		background-color:#EEE;
	}
	
	/* START: [list] */
		.result-trip-row {
			border-bottom:solid thin #DDD;
			padding:15px 0 15px 15px;
			cursor:pointer;
		}
		
		.result-trip-row a {
			color:#000;
		}
		
		.result-trip-title {
			font-weight:bold;
			overflow:hidden;
		}
		
		.result-trip-blurb {
			color:#777;
			overflow:hidden;
			font-size:12px;
		}
		
		.result-trip-button {
			text-align:right;
			line-height:40px;
			padding-right:16px;
		}
		
		.result-trip-status {
			line-height:40px;
		}
	/* END */
</style>

<div id="wrapper-trip-header-general" class="fixed-bar wrapper-header-main row">
    <div class="col-xs-3 text-left">
        <a class="btn btn-header button-trip-edit" onclick="openEditTrip();">Edit</a>
    </div>
    <div class="col-xs-6">
        <h1>Trips</h1>
    </div>
    <div class="col-xs-3 text-right">
        <a class="btn btn-header" onclick="openModalNewTrip();"><i class="fa fa-fw fa-lg fa-plus"></i></a>
    </div>
</div>
<div id="wrapper-trip-header-edit" class="fixed-bar wrapper-header-main row">
    <div class="col-xs-3 text-left">
        <a id="wrapper-trip-button-edit" class="btn btn-header" onclick="closeEditTrip();">Done</i></a>
    </div>
    <div class="col-xs-6 text-center">
        <h1>Trips</h1>
    </div>
    <div class="col-xs-3 text-right">
    </div>
</div>
<div id="wrapper-trip-list-alert"></div>
<?php if($this->user->isLogged() != false) { ?>
    <div id="wrapper-trip-archive-bar" class="fixed-bar row hidden">
        <div class="col-xs-3 text-left">
            <a class="btn btn-header" data-toggle="modal" data-target="#modal-trip-archive">Archived Trips</a>
        </div>
        <div class="col-xs-6">
        </div>
        <div class="col-xs-3 text-right">
        </div>
    </div>
<?php } ?>
<div id="wrapper-unsaved-trip-list" class="unsaved-trip-list"></div>
<div id="wrapper-trip-list" class="trip-list"></div>
<div id="wrapper-trip-list-empty" class="empty-list">
	<div class="title">Your List is Empty</div>
    <div class="cta">Click to create a <a data-toggle="modal" data-target="#modal-trip-new">new trip</a>.</div>
</div>

<div id="wrapper-trip-action" class="fixed-bar row">
    <div class="col-xs-3 text-left">
        <a class="btn btn-header button-archive-trip disabled hidden" onclick="removeTrip(); closeEditTrip();">Archive</a>
    </div>
    <div class="col-xs-6">
    </div>
    <div class="col-xs-3 text-right">
        <a class="btn btn-header button-delete-trip disabled" onclick="deleteTrip(); closeEditTrip();">Delete</a>
    </div>
</div>

<!-- START: [modal] -->
	<?php echo $modal_trip_archive; ?>
    <?php echo $modal_trip_load; ?>
    <?php echo $modal_trip_save; ?>
    <?php echo $modal_trip_delete; ?>
    <?php echo $modal_trip_remove; ?>
    <?php echo $modal_trip_share; ?>
    <?php echo $modal_trip_quota; ?>
<!-- END -->

<script>
	function printTrip(data) {
		var content = '';
		if(isset(data.storage) && data.storage == 'cookie') {
			content += ''
				+ '<div class="row result-trip-row noselect">'
					+ '<a href="'+data.url+'">'
						+ '<div class="col-xs-6 text-left">'
							+ '<div class="result-trip-title line-clamp-1">'
								+ data.name
							+ '</div>'
							+ '<div class="result-trip-blurb line-clamp-1">'
								+ '<span class="small">Created by <b>'+data.username+'</b></span>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-4 text-right text-danger result-trip-status">'
							+ 'NOT SAVED'
						+ '</div>'
						+ '<div class="col-xs-2 text-right result-trip-button">'
							+ '<i class="fa fa-fw fa-lg fa-chevron-right"></i>'
						+ '</div>'
					+ '</a>'
					+ '<form class="result-trip-form hidden">'
						+ '<input type="hidden" name="trip_id" value=""/>'
					+ '</form>'
				+ '</div>'
			;
			$('#wrapper-unsaved-trip-list').append(content);
		}
		else {
			content += ''
				+ '<div class="row result-trip-row noselect">'
					+ '<a href="'+data.url+'">'
						+ '<div class="col-xs-10 text-left">'
							+ '<div class="result-trip-title line-clamp-1">'
								+ data.name
							+ '</div>'
							+ '<div class="result-trip-blurb line-clamp-1">'
								+ '<span class="small">Created by <b>'+data.username+'</b></span>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-2 text-right result-trip-button">'
							+ '<i class="fa fa-fw fa-lg fa-chevron-right"></i>'
						+ '</div>'
					+ '</a>'
					+ '<form class="result-trip-form hidden">'
						+ '<input type="hidden" name="trip_id" value="' + data.trip_id + '"/>'
					+ '</form>'
				+ '</div>'
			;
			$('#wrapper-trip-list').append(content);
		}
	}
	
	function refreshTripList() {
		<!-- START: clear wrapper -->
			$('#wrapper-trip-list').html('');
			$('#wrapper-unsaved-trip-list').html('');
		<!-- END -->
		
		<!-- START: [unsaved trip] -->
			var trip = {};
			var unsaved_trip = getCookie('trip');
			if(unsaved_trip == '') {
				<!-- START: [first time] -->
					trip.num_of_unsaved_trip = 0;
				<!-- END -->
			}
			else {
				<!-- START: [revisit] -->
					trip.num_of_unsaved_trip = 1;
					trip.unsaved_trip = new Array();
					trip.unsaved_trip[0] = JSON.parse(unsaved_trip);
					trip.unsaved_trip[0].username = 'Me';
					trip.unsaved_trip[0].url = '<?php echo $link["trip/itinerary"]; ?>';
					trip.unsaved_trip[0].storage = 'cookie';
				<!-- END -->
			}
		<!-- END -->
		
		<!-- START: [saved trip] -->
			<?php if($this->user->isLogged() != false) { ?>
				<!-- START: [logged] -->
					<!-- START: set data -->
						var data = {
							"action":"load_trip",
							"user_id":"<?php echo $this->user->getUserId(); ?>"
						};
					<!-- END -->
					<!-- START: send POST -->
						$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
							
							for (var attrname in trip) { json[attrname] = trip[attrname]; }
							runRefreshTripList(json);
						}, "json");
					<!-- END -->
				<!-- END -->
			<?php } else { ?>
				<!-- START: [not logged] -->
					runRefreshTripList(trip);
				<!-- END -->
			<?php } ?>
		<!-- END -->
	}
	
	function runRefreshTripList(trip) {
		if(trip.num_of_active_trip > 0 && trip.num_of_unsaved_trip > 0) {
			$('#wrapper-trip-list-empty').hide();
			$('#content-trip').css('background-color','#FFF');
			for(i=0;i<trip.num_of_unsaved_trip;i++) {
				printTrip(trip.unsaved_trip[i]);
			}
			for(i=0;i<trip.num_of_active_trip;i++) {
				printTrip(trip.active_trip[i]);
			}
			$('.button-trip-edit').removeClass('disabled');
		}
		else if(trip.num_of_active_trip > 0) {
			$('#wrapper-trip-list-empty').hide();
			$('#content-trip').css('background-color','#FFF');
			for(i=0;i<trip.num_of_active_trip;i++) {
				printTrip(trip.active_trip[i]);
			}
			$('.button-trip-edit').removeClass('disabled');
		}
		else if(trip.num_of_unsaved_trip > 0) {
			$('#wrapper-trip-list-empty').hide();
			$('#content-trip').css('background-color','#FFF');
			for(i=0;i<trip.num_of_unsaved_trip;i++) {
				printTrip(trip.unsaved_trip[i]);
			}
			$('.button-trip-edit').removeClass('disabled');
		}
		else {
			$('#wrapper-trip-list-empty').show();
			$('#content-trip').css('background-color','#EEE');
			$('.button-trip-edit').addClass('disabled');
		}
	}
	
	function openEditTrip() {
		$('#section-tab').hide();
		$('#wrapper-trip-header-general').hide();
		$('#wrapper-trip-header-edit').show();
		$('#wrapper-trip-archive-bar').hide();
		$('.result-trip-button').html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$('.result-trip-button').css('color','#CCC');
		$('.result-trip-row a').css('pointer-events','none');
		$('.result-trip-row').off().on('click',function() { 
			var button = $(this).find('.result-trip-button');
			if($(this).hasClass('selected')) {
				$(this).removeClass('selected');
				deselectTrip(button);
			}
			else {
				$(this).addClass('selected');
				selectTrip(button);
			}
		});
		$('#wrapper-trip-list-alert').html('');
	}
	
	function closeEditTrip() {
		$('#section-tab').show();
		$('#wrapper-trip-header-general').show();
		$('#wrapper-trip-header-edit').hide();
		$('#wrapper-trip-archive-bar').show();
		$('#wrapper-trip-button-delete').addClass('disabled');
		$('.result-trip-button').html('<i class="fa fa-fw fa-lg fa-chevron-right"></i>');
		$('.result-trip-button').css('color','#000');
		$('.result-trip-row a').css('pointer-events','auto');
		$('.result-trip-row').off();
		$('.button-archive-trip').addClass('disabled');
		$('.button-delete-trip').addClass('disabled');
	}
	
	function selectTrip(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-check-square"></i>');
		$(button).css('color','#e93578');
		if($('.result-trip-row.selected').length > 0) {
			$('#wrapper-trip-button-delete').removeClass('disabled');
			$('.button-delete-trip').removeClass('disabled');
		}
		if($('.trip-list .result-trip-row.selected').length > 0) {
			if($('.unsaved-trip-list .result-trip-row.selected').length > 0) {
				$('.button-archive-trip').addClass('disabled');
			}
			else {
				$('.button-archive-trip').removeClass('disabled');
			}
		}
	}
	
	function deselectTrip(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$(button).css('color','#CCC');
		if($('.result-trip-row.selected').length < 1) {
			$('#wrapper-trip-button-delete').addClass('disabled');
			$('.button-delete-trip').addClass('disabled');
		}
		if($('.trip-list .result-trip-row.selected').length < 1) {
			$('.button-archive-trip').addClass('disabled');
		}
		else {
			if($('.unsaved-trip-list .result-trip-row.selected').length > 0) {
				$('.button-archive-trip').addClass('disabled');
			}
			else {
				$('.button-archive-trip').removeClass('disabled');
			}
		}
	}
	
	function updateTripButton(length) {
		if(length == '') {
			length = $('.result-trip-row').length;
		}
		if(length > 0) {
			$('#wrapper-trip-button').html('<span class="badge">'+length+'</span>'+'<i class="fa fa-fw fa-lg fa-heart"></i>');
			$('#wrapper-trip-list-empty').hide();
			$('#content-trip').css('background-color','#FFF');
			$('#wrapper-trip-button-edit').removeClass('disabled');
		}
		else {
			$('#wrapper-trip-button').html('<i class="fa fa-fw fa-lg fa-heart-o"></i>');
			$('#wrapper-trip-list-empty').show();
			$('#content-trip').css('background-color','#EEE');
			$('#wrapper-trip-button-edit').addClass('disabled');
		}
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
	
	function deleteTrip() {
		//Google Analytics Event
		ga('send', 'event','trip','delete-trip');
		var num_of_deleted_trip = $('.result-trip-row.selected').length;
		var num_of_deleted_saved_trip = $('.trip-list .result-trip-row.selected').length;
		var num_of_deleted_unsaved_trip = $('.unsaved-trip-list .result-trip-row.selected').length;
		
		<?php if($this->user->isLogged() == false) { ?>
			<!-- START: set cookie -->
				setCookie('trip','',0);
				setCookie('plan','',0);
			<!-- END -->
			<!-- START: set view -->
				refreshTripList();
			<!-- END -->
			<!-- START: show hint -->
				showHint('Trip Deleted');
			<!-- END -->
		<?php } else { ?>
			<!-- START: set cookie -->
				if(num_of_deleted_unsaved_trip > 0) {
					setCookie('trip','',0);
					setCookie('plan','',0);
				}
			<!-- END -->
			<!-- START: get data -->
				var trip = new Array();
				var trip_id = '';
				var e;
				for(i=0;i<num_of_deleted_saved_trip;i++) {
					e = $('.trip-list .result-trip-row.selected .result-trip-form input[name=trip_id]').get(i);
					trip_id = $(e).val();
					trip.push(trip_id);
				}
			<!-- END -->
			<!-- START: set data -->
				var data = {
					"action":"delete_trip",
					"trip":trip
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					$('.result-trip-row.selected').remove();
					<!-- START: set view -->
						refreshTripList();
					<!-- END -->
					<!-- START: show hint -->
						if(num_of_deleted_trip > 1) {
							showHint('Trips Deleted');
						}
						else {
							showHint('Trip Deleted');
						}
					<!-- END -->
				}, "json");
			<!-- END -->
		<?php } ?>
	}
	
	refreshTripList();
	closeEditTrip();
</script>