<div class="content-header fixed-width noselect">
    <div class="row navbar navbar-primary navbar-file">
        <div class="col-xs-3 text-left">
        	 <a class="btn" data-toggle="modal" data-target="#menu-mobile-main"><i class="fa fa-fw fa-lg fa-bars"></i></a>
        </div>
        <div class="col-xs-6 text-center">
            <h1>Trip Preview</h1>
        </div>
        <div class="col-xs-3 text-right">
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
    	<div><b>Trip cannot be found</b></div>
        <div>It may have been deleted.</div>
    </div>
</div>
<div class="content-body fixed-width">
	<div class="navbar navbar-shadow"></div>
	<div class="content-body-alert"></div>
    <div class="content-body-result"></div>
</div>

<?php echo $menu_mobile_main; ?>

<?php echo $modal_account_login; ?>
<?php echo $modal_account_signup; ?>
<?php echo $modal_member_join; ?>
<?php echo $script_trip_plan; ?>
<script>
	function requestJoinTrip(trip_id){
		<?php if($this->user->isLogged() == false) { ?>
			showHint('Please Login before request to Join Trip.');
		<?php }else{ ?>
			$('#modal-member-join').modal('show');
			// add this user to member list of the trip
			
			
		<?php } ?>
	}
	
	function showModal(page){
		if (page == "login" ) {			
			$('#modal-account-login').modal('show');
			
		}else if (page == "signup" ) {
			$('#modal-account-signup').modal('show');
		}
	}
	
	function refreshTrip() {
		<!-- START: reset loading screen -->
			$('.content-body-loading').show();
			$('.content-body-empty').show();
		<!-- END -->
		<!-- START: clear old result -->
		<!-- END -->
		<!-- START: get new result -->
			<!-- START: -->
				var trip_id = "<?php echo $this->trip->getTripId(); ?>";
			<!-- END -->
			<!-- START: set data -->
				var data = {
					"action":"get_trip",
					"trip_id":trip_id
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					runRefreshTrip(json);
				}, "json");
			<!-- END -->
		<!-- END -->
		refreshPlan(trip_id);
	}
	
	function runRefreshTrip(json) {
		if(isset(json)) {
			printTrip(json);
			$('.content-body-empty').hide();
			$('.content-body-loading').fadeOut();
		}
	}
	
	function refreshPlan(trip_id) {
		<!-- START: reset loading screen -->
			//$('.content-body-loading').show();
			//$('.content-body-empty').show();
		<!-- END -->
		<!-- START: clear old result -->
			$('.content-plan-result').html('');
		<!-- END -->
		<!-- START: get new result -->
			<!-- START: -->
				var plan_id = "<?php echo $this->trip->getPlanId(); ?>";
			<!-- END -->
			<!-- START: set data -->
				var data = {
					"action":"get_plan",
					"trip_id":"<?php echo $trip_id; ?>",
					"plan_id":"<?php echo $plan_id; ?>"
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					$('.content-plan-result').html('<div id="plan-'+data.plan_id+'"></div>');
					runRefreshPlan(json);
				}, "json");
			<!-- END -->
		<!-- END -->
	}
	
	function runRefreshPlan(json) {
		<!-- START -->
			printPlan('view',json);
		<!-- END -->
		<!-- START: end loading -->
			$('.content-body-empty').hide();
			$('.content-body-loading').fadeOut();
		<!-- END -->
	}
	
	<!-- START -->
		function formatTripDateUpdate(date) {
			var text;
			text = 'Updated ' + fromNow(date);
			return text;
		}
		
		function formatTripHost(name) {
			var text;
			text = 'By '+name;
			return text;
		}
		
		function formatTripMode(mode_id) {
			var text;
			if(mode_id == 1) {
				text = 'By public transport';
			}
			else if(mode_id == 2) {
				text = 'By car';
			}
			else if(mode_id == 3) {
				text = 'By walking';
			}
			return text;
		}
		
		function formatTripPeriod(date_start, num_of_day) {
			<!-- START: set variable -->
				start_date = new Date(date_start);
				end_date = addDayToDate(date_start,num_of_day);
				start_year = date('y',start_date);
				end_year = date('y',end_date);
				start_month = date('m',start_date);
				end_month = date('m',end_date);
			<!-- END -->
			<!-- START: set text -->
				if(start_year == date('y',new Date())) {
					if(num_of_day > 1) {
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
					if(num_of_day > 1) {
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
			text = text_period;
			return text;
		}
		
		function formatTripDuration(num_of_day) {
			var text;
			var text_unit = 'day';
			if(num_of_day > 1) {
				text_unit += 's';
			}
			text = num_of_day+' '+text_unit;
			return text;
		}
		
		function formatTripMember(num_of_member) {
			var text;
			var text_unit = 'person';
			if(num_of_member > 1) {
				text_unit += 's';
			}
			text = num_of_member+' '+text_unit; 
			return text;
		}
		
		function formatTripFee() {
			var text;
			return text;
		}
	<!-- END -->
	
	function printTrip(data) {
		<!-- START: [variable] -->
		<!-- END -->
		<!-- START: [view] -->
			var view_period	= 'hidden';
		<!-- END -->
		<!-- START: [link] -->
			var link_itinerary = "<?php echo $link['trip/itinerary/view'].'&trip='.$this->request->get_or_post('trip'); ?>";
		<!-- END -->
		<!-- START: [text] -->
			var text_mode;
			var text_date_update;
			var text_period;
			var text_duration;
			var text_member;
			
			text_mode			= formatTripMode(data.mode_id);
			text_date_update 	= formatTripDateUpdate(data.date_modified);
			if(isset(data.travel_date)) { 
				text_period = formatTripPeriod(data.travel_date,data.num_of_day);
				view_period = '';
			}
			text_duration 		= formatTripDuration(data.num_of_day);
			text_member 		= formatTripMember(data.num_of_member);
		<!-- END -->
		<!-- START: [html] -->
			var html_country = '';
			
			if(isset(data.country)) {
				html_country = ''
					+ '<div class="la-row">'
						+ '<div class="col-xs-12 text-left">'
							+ '<div class="la-icon">'
								+ '<i class="fa fa-fw fa-map-marker"></i>'
							+ '</div>'
							+ '<div class="la-desc">'
								+ '<div class="la-text">'
									+ data.country
								+ '</div>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
				;
			}
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<img class="ca-img" src="resources/template/japan.png"/>'
				+ '<div style="margin: 20px 15px 5px 15px;">'
					+ '<div>'
						+ '<h1><b>' + data.name + '</b></h1>'
					+ '</div>'
				+ '</div>'
				+ '<div class="la la-30 la-text-small">'
					+ '<div class="la-row">'
						+ '<div class="col-xs-12 text-left">'
							+ '<div class="la-desc">'
								+ '<div class="la-text la-text-sub">'
									+ text_date_update
								+ '</div>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
					+ html_country
					+ '<div class="la-row">'
						+ '<div class="col-xs-12 text-left">'
							+ '<div class="la-icon">'
								+ '<i class="fa fa-fw fa-train"></i>'
							+ '</div>'
							+ '<div class="la-desc">'
								+ '<div class="la-text">'
									+ text_mode
								+ '</div>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
					+ '<div class="la-row ' + view_period + '">'
						+ '<div class="col-xs-12 text-left">'
							+ '<div class="la-icon">'
								+ '<i class="fa fa-fw fa-calendar"></i>'
							+ '</div>'
							+ '<div class="la-desc">'
								+ '<div class="la-text">'
									+ text_period
								+ '</div>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
					+ '<div class="la-row">'
						+ '<div class="col-xs-12 text-left">'
							+ '<div class="la-icon">'
								+ '<i class="fa fa-fw fa-calendar"></i>'
							+ '</div>'
							+ '<div class="la-desc">'
								+ '<div class="la-text">'
									+ text_duration
								+ '</div>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
					+ '<div class="la-row">'
						+ '<div class="col-xs-12 text-left">'
							+ '<div class="la-icon">'
								+ '<i class="fa fa-fw fa-users"></i>'
							+ '</div>'
							+ '<div class="la-desc">'
								+ '<div class="la-text">'
									+ text_member
								+ '</div>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
				+ '</div>'
				+ '<div class="hr hr-12"></div>'
					+ '<div class="content-plan-result"></div>' 
					+ '<div class="trip-'+data.trip_id+'-plan">'
					+ '</div>'
					+ '<div class="padding">'
						+ '<a class="btn btn-block btn-primary box-shadow rounded fixed-height-5"" onclick="requestJoinTrip('+data.trip_id+')">Request to Join Trip</a>'
						+ '<div class="padding text-right shortcut-login">'
							+ '<a onclick="showModal(\'login\');" >Login</a>'
							+ ' &nbsp;| &nbsp;'
							+ '<a onclick="showModal(\'signup\');">Sign Up</a>'
						+ '</div>'
					+ '</div>'
					+ '<div class="padding">'
						
					+ '</div>'
				+ '</div>'
			;
			$('.content-body-result').append(content);
		<!-- END -->
		
		<?php if($this->user->isLogged() == true) { ?>
			$('.shortcut-login').hide();
		
		<?php } ?>
		
	}
	
	refreshTrip();
</script>