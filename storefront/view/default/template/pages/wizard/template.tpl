<style>
	.swiper-slide {
		border-left:solid thin #CCC;
		border-right:solid thin #CCC;
	}
	
	.swiper-page {
		position:absolute;
		background-color:#EEE;
		border:solid thin #CCC;
		border-radius:15px;
		left:0;
		right:0;
		bottom:10px;
		width:110px;
		margin:auto;
		padding:3px 6px;
		z-index:100;
	}
	
	.swiper-button-left {
		display:inline-block;
		color:#999;
	}
	
	.swiper-button-right {
		display:inline-block;
		color:#999;
	}
	
	.swiper-pagination {
		display:inline-block;
		position:relative;
		bottom:0;
		width:auto;
	}
</style>

<form class="mobile-form hidden" id="modal-trip-new-form" autocomplete="off">
    <input type="hidden" name="action" value="new_trip" />
    <input type="hidden" name="user_id" value="<?php echo $this->user->getUserId(); ?>" />
    <input type="hidden" name="role_id" value="<?php echo $this->user->getRoleId(); ?>" />
    <input type="hidden" name="language_id" value="<?php echo $this->language->getLanguageId(); ?>" />
    <input type="hidden" name="name" value="<?php echo $this->request->get_or_post('name'); ?>"/>
    <input type="hidden" name="country_id" value="<?php echo $this->request->get_or_post('country_id'); ?>"/>
    <input type="hidden" name="month" value="<?php echo $this->request->get_or_post('month'); ?>"/>
    <input type="hidden" name="mode_id" value="<?php echo $this->request->get_or_post('mode_id'); ?>"/>
    <input type="hidden" name="duration" value="<?php echo $this->request->get_or_post('duration'); ?>"/>
</form>
<div class="content-header fixed-width noselect">
    <div class="row navbar navbar-primary navbar-modal">
        <div class="col-xs-3 text-left">
            <a class="btn" onclick="window.history.back();">Back</a>
        </div>
        <div class="col-xs-6 text-center">
            <h1>Template</h1>
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
    	<div><b>Template cannot be found</b></div>
        <div>It may have been removed.</div>
    </div>
</div>
<div class="swiper-container">
    <div class="swiper-wrapper"></div>
    <div class="swiper-page">
        <div class="col-xs-3 text-left">
            <a>
                <div class="swiper-button-left"><i class="fa fa-fw fa-lg fa-angle-left"></i></div>
            </a>
        </div>
        <div class="col-xs-6 text-center">
            <div class="swiper-pagination"></div>
        </div>
        <div class="col-xs-3 text-right">
            <a>
                <div class="swiper-button-right"><i class="fa fa-fw fa-lg fa-angle-right"></i></div>
            </a>
        </div>
    </div>
</div>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/swiper.jquery.min.js'); ?>"></script>
<script>
	var mySwiper;
	
	function initSwiper() {
		mySwiper = new Swiper ('.swiper-container', {
			direction:'horizontal',
			loop:false,
			threshold:30,
			pagination: '.swiper-pagination',
			paginationType: 'fraction',
			nextButton: '.swiper-button-right',
			prevButton: '.swiper-button-left'
		})
	}
</script>
<script>
	function toggleAllLineDetail() {
		if($('.button-show-detail').html() == 'Show Details') {
			$('.plan-line-detail').removeClass('hidden');
			$('.button-show-detail').html('Hide Details');
		}
		else if($('.button-show-detail').html() == 'Hide Details') {
			$('.plan-line-detail').addClass('hidden');
			$('.button-show-detail').html('Show Details');
		}
	}
	
	function toggleLineDetail(line_id) {
		if($('.plan-line-detail-'+line_id).hasClass('hidden')) {
			$('.plan-line-detail-'+line_id).removeClass('hidden');
			$('.button-show-detail-'+line_id+' .fa').addClass('fa-flip-vertical');
		}
		else {
			$('.plan-line-detail-'+line_id).addClass('hidden');
			$('.button-show-detail-'+line_id+' .fa').removeClass('fa-flip-vertical');
		}
	}
</script>
<script>
	<!-- START: common function -->
		function convertTimeToMinute(time) {
			var hrs = parseInt(time.substring(0, time.indexOf(':')));
			var mins =  parseInt(time.substring(time.indexOf(':')+1));
			return (hrs * 60 + mins);
		}
		
		function convertMinuteToTime(minute) {
			var hrs = Math.floor(minute / 60);          
			var mins = minute % 60;
			hrs = ("0" + hrs).slice(-2);
			mins = ("0" + mins).slice(-2);
			var string = hrs + ':' + mins;
			return (string);
		}
		
		function addDurationToTime(time,duration) {
			time = convertTimeToMinute(time);
			duration = parseInt(duration);
			var new_time = time + duration;
			new_time = convertMinuteToTime(new_time);
			return new_time;
		}
	<!-- END -->
	
	function setPlanDataFormatForDayDay(plan) {
		for (i=0; i<plan.day.length; i++) {
			plan.day[i].day = 'D'+plan.day[i].sort_order;
		}
		return plan;
	}
	
	function setPlanDataFormatForDayDate(plan) {	
		if(typeof plan.travel_date != 'undefined' && plan.travel_date != null && plan.travel_date != '' && plan.travel_date != '0000-00-00') {
			var first_date = new Date(plan.travel_date);
			first_date.setDate(first_date.getDate() - 1);
			var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
			var weekday = new Array(7);
				weekday[0]=  "Ｓ";
				weekday[1] = "Ｍ";
				weekday[2] = "Ｔ";
				weekday[3] = "Ｗ";
				weekday[4] = "Ｔ";
				weekday[5] = "Ｆ";
				weekday[6] = "Ｓ";
			for (i=0; i<plan.day.length; i++) {
				myDate = new Date(first_date.setDate(first_date.getDate() + 1));
				var myWeekday = weekday[myDate.getDay()];
				plan.day[i].date = ("0" + myDate.getDate()).slice(-2) + "&nbsp;" + monthNames[(myDate.getMonth())] + "&nbsp;&nbsp;&nbsp;(" + myWeekday + ")";
			}
		}
		else {
			for (i=0; i<plan.day.length; i++) {
				plan.day[i].date = '';
			}
		}
		return plan;
	}
	
	function setPlanDataFormatForDayDuration(plan) {
		for(i=0; i<plan.day.length; i++) {
			if(typeof plan.day[i].line != 'undefined' && plan.day[i].line != null && plan.day[i].line != '' &&  plan.day[i].line.length > 0) {
				plan.day[i].duration = 0;
				for(j=0; j<plan.day[i].line.length; j++) {
					var duration = plan.day[i].line[j].duration;
					if(typeof duration != 'undefined' && duration != null && duration != '') {
						plan.day[i].duration += parseInt(duration);
					}
				}
			}
			else {
				plan.day[i].duration = 0;
			}
		}
		return plan;
	}
		
	function setPlanDataFormatForLineTime(plan) {
		for(i=0; i<plan.day.length; i++) {
			if(isset(plan.day[i].line) && plan.day[i].line.length > 0) {
				for(j=0; j<plan.day[i].line.length; j++) {
					var time = plan.day[i].line[j].time;
					var duration = plan.day[i].line[j].duration;
					if(isset(time) && isset(duration) && duration != 0) {
						var end_time = addDurationToTime(time,duration);
						plan.day[i].line[j].time = convertLineTimeFormat(time) + ' ~ ' + convertLineTimeFormat(end_time);
					}
					else {
						plan.day[i].line[j].time = convertLineTimeFormat(time);
					}
				}
			}
		}
		return plan;
	}
	
	function setPlanDataFormatForLineDuration(plan) {
		for(i=0; i<plan.day.length; i++) {
			if(isset(plan.day[i].line) && plan.day[i].line.length > 0) {
				for(j=0; j<plan.day[i].line.length; j++) {
					var duration = plan.day[i].line[j].duration;
					plan.day[i].line[j].duration = convertLineDurationFormat(duration);
				}
			}
		}
		return plan;
	}
	
	function convertLineTimeFormat(time) {
		var formatted_time;
		if(isset(time)) {
			var hour = time.substring(0, time.indexOf(':'));
			var minute = time.substring(time.indexOf(':')+1);
			var ampm = 'am';
			if(hour >= 12) {
				hour = parseInt(hour) - 12;
				ampm = 'pm';
			}
			hour = ("0" + hour).slice(-2);
			formatted_time = hour+':'+minute+' '+ampm;
		}
		else {
			formatted_time = '';
		}
		return formatted_time;
	}
	
	function convertLineDurationFormat(duration) {
		var formatted_duration;
		if(isset(duration)) {
			var hour = Math.floor(duration/ 60);
			var minute = duration % 60;
			if(hour >= 1 && minute >= 1) {
				minute = ("0" + minute).slice(-2);
				formatted_duration = hour+' hrs '+minute+' min';
			}
			else if(hour >= 1) {
				formatted_duration = hour+' hrs';
			}
			else {
				formatted_duration = minute+' min';
			}
		}
		else {
			formatted_duration = '';
		}
		return formatted_duration;
	}
	
	function convertUrlToText(url) {
		var text = url;
		if(isset(url)) {
			if(url.indexOf('http') >= 0) {
				var text = url.substring(url.indexOf('//')+2||0);
			}
		}
    	return text;
	}
	
	function convertTextToUrl(text) {
		var url = text;
		if(isset(text)) {
			if(text.indexOf('http') < 0) {
				var url = 'http://' + text;
			}
		}
    	return url;
	}
</script>
<script>
	function refreshTrip(trip_id) {
		<!-- START: set POST data -->
			var data = {
				"action":"refresh_trip",
				"trip_id":trip_id
			};
		<!-- END -->
		
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(trip) {
			}, "json");
		<!-- END -->
	}
	
	function refreshPlan(trip_id, plan_id) {
		<!-- START: set data -->
			var data = {
				"action":"refresh_plan",
				"trip_id":trip_id,
				"plan_id":plan_id
			};
		<!-- END -->
	
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(plan) {
				runRefreshPlan(trip_id, plan);
			}, "json");
		<!-- END -->
	}
	
	function runRefreshPlan(trip_id, plan) {
		<!-- START: set column -->
			var column = <?php echo $column_json; ?>;
		<!-- END -->
		
		<!-- START: set raw data -->
			var data_raw = $.extend(true,{},plan); //IMPORTANT: to make sure clone without reference
		<!-- END -->
		
		<!-- START: set data format-->
			plan = setPlanDataFormatForDayDay(plan);
			plan = setPlanDataFormatForDayDate(plan);
			plan = setPlanDataFormatForDayDuration(plan);
			plan = setPlanDataFormatForLineTime(plan);
			plan = setPlanDataFormatForLineDuration(plan);
		<!-- END -->
		
		<!-- START: set modified data -->
			data_cooked = plan;
		<!-- END -->
		
		<!-- START: set plan date -->
			//printDate(data_raw);
		<!-- END -->
		
		<!-- START: print table -->
			$.each(data_cooked.day, function(i) {
				printDay(trip_id, column, this, data_raw.day[i]);
				if(isset(this.line)) {
					if(this.line.length > 0) {
						$.each(this.line, function(j) {
							printLine(column, this, data_raw.day[i].line[j]);
						});
					}
				}
			});
		<!-- END -->
		
		<!-- START: end loading -->
			$('.splash').fadeOut(500);
		<!-- END -->
	}
	
	function printDay(trip_id, column, day, day_raw) {
		var content = '';
		var hidden_form = '';
		
		<!-- START: [hidden form] -->
			$.each(column, function(i, col) {
				hidden_form += ""
					+ "<input "
						+ "id='plan-day-" + day.day_id + "-col-" + col.id + "-input-hidden' "
						+ 'name="' + col.name + '" '
						+ "class='plan-input-hidden hidden' "
						+ "value='" + day_raw[col.name] + "'"
					+ "/>"
				;
			});
		<!-- END -->
		<!-- START: [info] -->
			var data = {};
			var nodate = '';
			if(isset(day.date)) {
				data.date = day.date;
			}
			else {
				data.date = '';
				nodate = 'nodate';
			}
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<div id="plan-day-' + day.day_id + '" class="plan-day">'
					+ '<div class="day padding"><b>'
						+ 'Day ' + day.sort_order 
					+ '</b></div>'
					+ '<div class="date">'
						+ data.date
					+ '</div>'
					+ '<div class="plan-day-line la la-30 la-text-small" id="plan-day-'+day.day_id+'-line">'
					+ '</div>'
					+ '<form class="plan-day-form-hidden plan-form-hidden" id="plan-day-' + day.day_id + '-form-hidden">'
						+ hidden_form
					+ '</form>'
				+ '</div>'
			;
		<!-- END -->
		<!-- START: print content -->
			$('.trip-'+trip_id+'-plan').append(content);
		<!-- END -->
	}
	
	function printLine(column, line, line_raw) {
		var content = '';
		var hidden_form = '';
		
		<!-- START: [hidden form] -->
			$.each(column, function(i, col) {
				var value = line_raw[col.name];
				if(typeof value == 'undefined' || value == null || value == '') { value = ''; } 
				hidden_form += ""
					+ "<input "
						+ "id='plan-line-" + line.line_id + "-col-" + col.id + "-input-hidden' "
						+ 'name="' + col.name + '" '
						+ "class='plan-input-hidden hidden' "
						+ "value='" + value + "'"
					+ "/>"
				;
			});
		<!-- END -->
		<!-- START: [set variable] -->
			var bullet = '<i class="fa fa-fw bullet">&bull;</i>';
			if(line_raw['activity'] == 'fly_out') {
				bullet = '<i class="fa fa-fw bullet icon-plane-up"></i>';
			}
			else if(line_raw['activity'] == 'fly') {
				bullet = '<i class="fa fa-fw bullet fa-plane"></i>';
			}
			else if(line_raw['activity'] == 'fly_in') {
				bullet = '<i class="fa fa-fw bullet icon-plane-down"></i>';
			}
			else if(line_raw['activity'] == 'eat') {
				bullet = '<i class="fa fa-fw bullet icon-food-icon"></i>';
			}
			else if(line_raw['activity'] == 'stay') {
				bullet = '<i class="fa fa-fw bullet fa-bed"></i>';
			}
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<div id="plan-line-' + line.line_id + '" class="plan-line la-row">'
					+ '<div class="col-xs-12">'
						+ '<div class="la-icon">'
							+ bullet
						+ '</div>'
						+ '<div class="la-desc">'
							+ '<div class="la-text">'
								+ line.title
							+ '</div>'
						+ '</div>'
					+ '</div>'
				+ '</div>'
			;
		<!-- END -->
		<!-- START: print content -->
			$("#plan-day-"+line.day_id+"-line").append(content); 
		<!-- END -->
	}
	
	function refreshTemplate() {
		<!-- START: reset loading screen -->
			$('.content-body-loading').show();
			$('.content-body-empty').show();
		<!-- END -->
		<!-- START: clear old result -->
			$('.text-num-of-result').html('');
			$('.btn-set-filter').addClass('hidden');
			$('.content-body-optional').addClass('hidden');
		<!-- END -->
		<!-- START: get new result -->
			<!-- START: -->
				var country_id = $('#modal-trip-new-form input[name=country_id]').val();
				var month = $('#modal-trip-new-form input[name=month]').val();
				var mode_id = $('#modal-trip-new-form input[name=mode_id]').val();
				var duration = $('#modal-trip-new-form input[name=duration]').val();
			<!-- END -->
			<!-- START: set data -->
				var data = {
					"action":"refresh_template",
					"country_id":country_id,
					"month":month,
					"mode_id":mode_id,
					"duration":duration
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['wizard/ajax_trip']; ?>", data, function(json) {
					runRefreshTemplate(json);
				}, "json");
			<!-- END -->
		<!-- END -->
	}
	
	function runRefreshTemplate(json) {
		if(isset(json)) {
			for(i=0;i<=json.template.length;i++) {
				if(i==json.template.length) {
					if(json.template.length > 0) {
						initSwiper();
						mySwiper.slideTo("<?php echo $this->request->get_or_post('index'); ?>",0,false);
						$('.content-body-empty').hide();
					}
					$('.content-body-loading').fadeOut();
				}
				else {
					printTemplate(json.template[i]);
				}
			}
		}
	}
	
	function printTemplate(data) {
		<!-- START: [variable] -->
		<!-- END -->
		<!-- START: [text] -->
			if(data.mode_id == 1) {
				text_transport = 'By public transport';
			}
			else if(data.mode_id == 2) {
				text_transport = 'By car';
			}
			else if(data.mode_id == 3) {
				text_transport = 'By walking';
			}
			
			var text_month = '';
			var month = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
			var month2 = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"];
			if(isset(data.month)) {
				for(m=0;m<data.month.length;m++) {
					text_month += month[data.month[m]-1];
					if(m<data.month.length-1) { text_month += ', '; }
				}
			}
			
			var text_day = '';
			var text_day_unit = 'day';
			if(data.num_of_day > 1) { text_day_unit = 'days'; }
			text_day = data.num_of_day + ' ' + text_day_unit;
			
			var text_date_update = '';
			text_date_update = fromNow(data.date_modified);
			
			var url = "<?php echo $link['wizard/template']; ?>";
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<div class="swiper-slide">'
					+ '<div class="content-body fixed-width fixed-height scrollable-y">'
						+ '<div class="navbar navbar-shadow"></div>'
						+ '<div class="row action-bar">'
							+ '<div class="col-xs-4 text-center">'
								+ '<a>'
									+ '<div>'
										+ '<i class="fa fa-fw fa-lg fa-bookmark"></i>'
									+ '</div>'
									+ '<div>'
										+ '<span>Bookmark</span>'
									+ '</div>'
								+ '</a>'
							+ '</div>'
							+ '<div class="col-xs-4 text-center">'
								+ '<a>'
									+ '<div>'
										+ '<i class="fa fa-fw fa-lg fa-share"></i>'
									+ '</div>'
									+ '<div>'
										+ '<span>Share</span>'
									+ '</div>'
								+ '</a>'
							+ '</div>'
							+ '<div class="col-xs-4 text-center">'
								+ '<a>'
									+ '<div>'
										+ '<i class="fa fa-fw fa-lg fa-check"></i>'
									+ '</div>'
									+ '<div>'
										+ '<span onclick="useTemplate('+data.trip_id+')">Use Template</span>'
									+ '</div>'
								+ '</a>'
							+ '</div>'
						+ '</div>'
						+ '<img class="ca-img" src="resources/template/japan.png"/>'
						+ '<div class="padding">'
							+ '<div>'
								+ '<b>' + data.name + '</b>'
							+ '</div>'
						+ '</div>'
						+ '<div class="la la-30 la-text-small">'
							+ '<div class="la-row">'
								+ '<div class="col-xs-12 text-left">'
									+ '<div class="la-desc">'
										+ '<div class="la-text la-text-sub">'
											+ 'Updated ' + text_date_update
											+ '&nbsp;&nbsp;&bull;&nbsp;&nbsp;By ' + data.email.substring(0, data.email.indexOf('@'))
										+ '</div>'
									+ '</div>'
								+ '</div>'
							+ '</div>'
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
							+ '<div class="la-row">'
								+ '<div class="col-xs-12 text-left">'
									+ '<div class="la-icon">'
										+ '<i class="fa fa-fw fa-calendar-o"></i>'
									+ '</div>'
									+ '<div class="la-desc">'
										+ '<div class="la-text">'
											+ text_transport
										+ '</div>'
									+ '</div>'
								+ '</div>'
							+ '</div>'
							+ '<div class="la-row">'
								+ '<div class="col-xs-12 text-left">'
									+ '<div class="la-icon">'
										+ '<i class="fa fa-fw fa-clock-o"></i>'
									+ '</div>'
									+ '<div class="la-desc">'
										+ '<div class="la-text">'
											+ text_day
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
											+ text_month
										+ '</div>'
									+ '</div>'
								+ '</div>'
							+ '</div>'
						+ '</div>'
						+ '<div class="hr hr-12"></div>'
						+ '<div class="trip-'+data.trip_id+'-plan">'
						+ '</div>'
						+ '<div class="padding">'
							+ '<a class="btn btn-block btn-primary box-shadow rounded fixed-height-5"" onclick="useTemplate('+data.trip_id+')">Use This Template</a>'
						+ '</div>'
					+ '</div>'
				+ '</div>'
			;
			$('.swiper-wrapper').append(content);
			refreshPlan(data.trip_id,'');
		<!-- END -->
	}
	
	function useTemplate(trip_id){
		<!-- START: set data -->
				var data = {
					"action":"use_template",
					"trip_id":trip_id
				};
			<!-- END -->
			
			<!-- START: send POST -->
				$.post("<?php echo $ajax['wizard/ajax_trip']; ?>", data, function(json) {
					alert(JSON.stringify(json));
				}, "json");
			<!-- END -->
			//window.location = json.redirect;
	}
		
	$('#modal-trip-new-form').on('change',function() {
		refreshTemplate();
	});
	
	refreshTemplate();
</script>