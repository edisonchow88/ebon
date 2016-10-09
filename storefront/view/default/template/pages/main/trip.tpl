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
		.trip-list .result-trip-row {
			border-bottom:solid thin #DDD;
			padding:15px 0 15px 15px;
			cursor:pointer;
		}
		
		.trip-list .result-trip-row a {
			color:#000;
		}
		
		.trip-list .result-trip-title {
			font-weight:bold;
			overflow:hidden;
		}
		
		.trip-list .result-trip-blurb {
			color:#777;
			overflow:hidden;
			font-size:12px;
		}
		
		.trip-list .result-trip-button {
			text-align:right;
			line-height:40px;
			padding-right:16px;
		}
	/* END */
</style>

<div id="wrapper-trip-header-general" class="fixed-bar wrapper-header-main row">
    <div class="col-xs-3 text-left">
        <a class="btn btn-header" onclick="openEditTrip();">Edit</a>
    </div>
    <div class="col-xs-6">
        <h1>Trips</h1>
    </div>
    <div class="col-xs-3 text-right">
        <a class="btn btn-header" data-toggle="modal" data-target="#modal-trip-new"><i class="fa fa-fw fa-lg fa-plus"></i></a>
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
    
<?php if($this->user->isLogged() != false) { ?>
    <div id="wrapper-trip-archive-bar" class="fixed-bar row">
        <div class="col-xs-3 text-left">
            <a class="btn btn-header" data-toggle="modal" data-target="#modal-trip-archive">Archived Trips</a>
        </div>
        <div class="col-xs-6">
        </div>
        <div class="col-xs-3 text-right">
        </div>
    </div>
<?php } ?>
<div id="wrapper-trip-list" class="trip-list"></div>
<div id="wrapper-trip-list-empty" class="empty-list">
	<div class="title">Your List is Empty</div>
    <div class="cta">Click to create a <a data-toggle="modal" data-target="#modal-trip-new">new trip</a>.</div>
</div>

<div id="wrapper-trip-action" class="fixed-bar row">
    <div class="col-xs-3 text-left">
        <a class="btn btn-header disabled" onclick="removeTrip(); closeEditTrip();">Archive</a>
    </div>
    <div class="col-xs-6">
    </div>
    <div class="col-xs-3 text-right">
        <a class="btn btn-header disabled" onclick="deleteTrip(); closeEditTrip();">Delete</a>
    </div>
</div>

<!-- START: [modal] -->
	<?php echo $modal_trip_archive; ?>
    <?php echo $modal_trip_new; ?>
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
			+ '</div>'
		;
		$('#wrapper-trip-list').append(content);
	}
	
	function refreshTripList() {
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
						runRefreshTripList(json);
					}, "json");
				<!-- END -->
			<!-- END -->
		<?php } else { ?>
			<!-- START: [not logged] -->
				var trip = getCookie('trip');
				if(trip == '') {
					<!-- START: [first time] -->
						var trip = [];
						trip = JSON.stringify(trip);
						setCookie('trip',trip,7);
						trip = JSON.parse(trip);
						runRefreshTripList(trip);
					<!-- END -->
				}
				else {
					<!-- START: [revisit] -->
						trip = JSON.parse(trip);
						runRefreshTripList(trip);
					<!-- END -->
				}
			<!-- END -->
		<?php } ?>
	}
	
	function runRefreshTripList(trip) {
		if(trip.num_of_active_trip > 0) {
			$('#wrapper-trip-list-empty').hide();
			$('#content-trip').css('background-color','#FFF');
			for(i=0;i<trip.num_of_active_trip;i++) {
				printTrip(trip.active_trip[i]);
			}
		}
		else {
			$('#wrapper-trip-list-empty').show();
			$('#content-trip').css('background-color','#EEE');
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
	}
	
	function selectTrip(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-check-square"></i>');
		$(button).css('color','#e93578');
		if($('.result-trip-row.selected').length > 0) {
			$('#wrapper-trip-button-delete').removeClass('disabled');
		}
	}
	
	function deselectTrip(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$(button).css('color','#CCC');
		if($('.result-trip-row.selected').length < 1) {
			$('#wrapper-trip-button-delete').addClass('disabled');
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
	
	refreshTripList();
	closeEditTrip();
</script>