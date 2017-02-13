<style>
	/* START: [swiper] */
		.swiper-container {
			width: 100%;
		}
		
		.swiper-slide:first-child {
			border-left:solid thin #DDD;
		}
		
		.swiper-slide {
			border-right:solid thin #DDD;
		}
		
		.swiper-slide-content {
			height:calc(100vh - 80px);
			padding-bottom:80px;
		}
	/* END */
</style>
<style>
	#hidden-swiper-left-column {
		position:absolute;
		bottom:0;
		left:0;
		width:10px;
		height:calc(100% - 80px);
		background-color:transparent;
		z-index:5;
	}
	
	#hidden-swiper-right-column {
		position:absolute;
		bottom:0;
		right:0;
		width:30px;
		height:calc(100% - 80px);
		background-color:transparent;
		z-index:5;
	}
</style>
<style>
	.ui-placeholder {
		width:100%;
		height:40px;
		padding-top:3px;
		background-color:#EEE;
		border-top:solid thin #DDD;
		border-bottom:solid thin #DDD;
	}
	
	.ui-placeholder > div {
		opacity:0.3;
	}
	
	.ui-helper {
		max-width:60px;
		max-height:60px;
		background-color:transparent;
	}
</style>
<style>
	/* START: [itinerary] */
		.bar-day {
			height:40px;
			color:#000;
			border-bottom:solid thin #DDD;
		}
		
		.bar-day .title {
			display:inline-block;
			padding:9px;
			line-height:20px;
			font-weight:normal;
			color:#000;
			background-color:#FFF;
			background-color:transparent;
		}
		
		.bar-day .btn {
			padding:0 15px;
			border:none;
			line-height:39px;
			box-shadow:none;
		}
	/* END */
</style>
<style>	
	/* START: [itinerary] */	
		.button-prev.disabled, .button-next.disabled {
			color:#DDD;
			cursor:default;
		}
		
		.button-set-date {
			color:#333;
			font-size:12px;
			line-height:20px;
			padding:0px;
			margin:10px 15px;
		}
		
		.button-view-map {
			border:solid thin #999;
			border-radius:10px;
			color:#333;
			font-size:12px;
			line-height:20px;
			padding:0px 10px;
			margin:10px 15px;
		}
	/* END */
</style>
<style>
	/* START: [plan-day-line-empty] */
		.plan-day-line-empty {
			width:100%;
			color:#777;
			padding-top:10vh;
			font-weight:bold;
			text-align:center;
		}
	/* END */
	/* START: [plan-button-add-line] */
		.plan-button-add-line {
			padding:15px;
			text-align:center;
		}
		
		.plan-button-add-line div {
			display:inline-block;
			color:#333;
			border:solid 2px #EEE;
			border-radius:20px;
			padding:7px 15px;
			font-size:12px;
			cursor:pointer;
		}
	/* END */
</style>
<style>
	.transport-row {
		position:relative;
		height:40px;
	}
	
	.plan-line .transport, .plan-line-twins .transport {
		width:100%;
		display:inline-block;
		background-color:#FFF;
		color:#999;
	}
	
	.line-transport-mode {
		position:relative; 
	}
	
	.mode-option-selector{
		position:absolute;
		display:inline-block;
		width: 40px;
		font-size:1.1em;
		z-index: 12;
		border:solid thin transparent;
	}
	
	.border{
		border: #CCC thin solid;
	}
	
	.mode-option-selector .mode-icon{
		width: 30px;
		display: inline-block;
	}
	
	.mode-option-selector .mode-option{
		background:  #FFF;
	}
	
	.mode-option-display { 
		position:absolute;
		display:inline-block;
		left: 50px;
	}
	
	.click-blocker {
		width: 150vw;
		height: 200vh;
		z-index: 10;
		position:absolute;
		top: -100vh;
		left: -50vw;
		/*background-color:#0F3;*/
	
	}
</style>
<style>
	.plan-edit .plan-line-twins .pa-icon .fa {
		color:transparent;
	}
	
	.plan-edit .plan-line-twins .pa-icon::before {
		display:block;
		position:absolute;
		top:17.5px;
		left:0;
		height:5px;
		width:42px;
		background-color:#777;
		content:'';
	}
</style>


<!-- START: [modal] -->
    <?php echo $modal_account_signup; ?>
    <?php echo $modal_account_login; ?>
    <?php echo $modal_trip_save; ?>
    <?php echo $modal_itinerary_map; ?>
	<?php echo $modal_itinerary_day; ?>
    <?php echo $modal_itinerary_date; ?>
    <?php echo $modal_line_filter; ?>
    <?php echo $modal_line_add; ?>
    <?php echo $modal_line_favourite; ?>
    <?php echo $modal_line_explore; ?>
    <?php echo $modal_line_custom; ?>
    <?php echo $modal_line_delete; ?>
<!-- END -->

<script>
	var mySwiper;
	var planFormat;
</script>
<script>
<!-- START: [init] -->
	function initSwiperButton() {
		$('.button-next').on('click',function() { mySwiper.slideNext(); });
		$('.button-prev').on('click',function() { mySwiper.slidePrev(); });
		$('.button-prev').first().addClass('disabled');
		$('.button-next').last().addClass('disabled');
	}
	
	function initDayButton() {
		$('.button-view-day').on('click',function() { $('#modal-trip-day').modal('show'); });
	}
	
	
	function initDateButton() {
		$('.button-set-date').on('click',function() { 
			$('#modal-itinerary-date').modal('show');
		});
	}
	
	function initMapButton() {
		$('.button-view-map').on('click',function() { $('#modal-trip-map').modal('show'); });
	}
	
	function initSortableLine() { 
		var autoSlideNext;
		var autoSlidePrev;
		var slideNext = false;
		var slidePrev = false;
		
		$('.plan-day-line').sortable({
			delay:100,
			items:'>.plan-line',
			handle:'.button-move',
			connectWith:'.plan-day-line',
			containment:'.swiper-container',
			zindex:200,
			tolerance:'pointer',
			scrollSensitivity:10,
			scrollSpeed:10,
			cursor:'move',
			cursorAt: { 
				top: 30,
				left: 30
			},
			placeholder: "ui-placeholder plan-line",
			helper:function(event,ul) {
				return $('<div class="ui-helper"></div>');
			},
			start:function(event,ui) {
				mySwiper.endNow();
				mySwiper.detachEvents();
				$('.plan-line .button-action').hide();
				$('.plan-line .pa-bullet').hide();
				$('.plan-line .pa-text.data-title').addClass('text-clamp-1');
				$('.plan-line .pa-text.data-description').hide();
				$('.plan-line .transport-row').addClass('hidden');
				$('.plan-line-twin .transport-row').addClass('hidden');
				ui.placeholder.html(ui.item.html());
				$(this).sortable('refreshPositions');
				$('.plan-day-line').css('min-height','calc(100vh - 120px)');
				$('.plan-day-footer').hide();
			},
			sort: function( event, ui ) {
				if(collision($('.ui-helper'),$('#hidden-swiper-right-column')) == true) {
					if(slideNext == false) {
						autoSlideNext = setInterval(function () {
							mySwiper.slideNext();
							mySwiper.update(true);
							setTimeout(function() {
								$('.plan-day-line').sortable('refreshPositions');
								ui.helper.position.top = 30;
								ui.helper.position.left = 30;
							},100);
						}, 300);
						slideNext = true;
					}
				}
				else {
					clearInterval(autoSlideNext);
					slideNext = false;
				}
				
				if(collision($('.ui-helper'),$('#hidden-swiper-left-column')) == true) {
					if(slidePrev == false) {
						autoSlidePrev = setInterval(function () {
							mySwiper.slidePrev();
							mySwiper.update(true);
							setTimeout(function() {
								$('.plan-day-line').sortable('refreshPositions');
								ui.helper.position.top = 30;
								ui.helper.position.left = 30;
							},100);
						}, 300);
						slidePrev = true;
					}
				}
				else {
					clearInterval(autoSlidePrev);
					slidePrev = false;
				}
			},
			stop:function(event,ui) {
				clearInterval(autoSlideNext);
				clearInterval(autoSlidePrev);
				
				mySwiper.attachEvents();
				
				$('.plan-line .button-action').show();
				$('.plan-line .pa-bullet').show();
				$('.plan-line .pa-text.data-description').show();
				$('.plan-line .pa-text.data-title').removeClass('text-clamp-1');
				$('.plan-line .transport-row').removeClass('hidden');
				$('.plan-line-twin .transport-row').removeClass('hidden');
				$('.plan-day-line').css('min-height','0px');
				$('.plan-day-footer').show();
				
				refreshPlanDayLineEmpty();
				
				$('#hidden-swiper-right-column').off();
				$('#hidden-swiper-left-column').off();
			},
			update:function(event,ui) {
				updatePlanTableLineDayIdAndSortOrder();

				<?php if($this->session->data['memory'] == 'cookie') { ?>
					updatePlanTableCookie();
					showHint('Activity Sorted');
				<?php } else { ?>
					var line = new Array();
					var line_id;
					var sort_order;
					var order;
					
					$('.plan-line-form-hidden').each(function() {
						line_id = $(this).find('input[name=line_id]').val();
						day_id = $(this).find('input[name=day_id]').val();
						sort_order = $(this).find('input[name=sort_order]').val();
						line.push({"line_id":line_id,"day_id":day_id,"sort_order":sort_order});
					});
					order = JSON.stringify(line);
					
					<!-- START: set data -->
						var data = {
							"action":"sort_line",
							"order":order
						};
					<!-- END -->
				
					<!-- START: send POST -->
						$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
							if(typeof json.warning != 'undefined') {
								showAlert(json.warning);
							}
							else if(typeof json.success != 'undefined') {
								showHint('Activity Sorted');
							}
						}, "json");
					<!-- END -->
				<?php } ?>
				$(document).trigger("refreshDistance");
			}
			
		});
	}
<!-- END -->
</script>
<script>
	function collision($div1, $div2) {
		var x1 = $div1.offset().left;
		var y1 = $div1.offset().top;
		var h1 = $div1.outerHeight(true);
		var w1 = $div1.outerWidth(true);
		var b1 = y1 + h1;
		var r1 = x1 + w1;
		var x2 = $div2.offset().left;
		var y2 = $div2.offset().top;
		var h2 = $div2.outerHeight(true);
		var w2 = $div2.outerWidth(true);
		var b2 = y2 + h2;
		var r2 = x2 + w2;
		  
		if (b1 < y2 || y1 > b2 || r1 < x2 || x1 > r2) return false;
		return true;
    }
</script>
<script>
<!-- START: [format] -->
	function formatLine(data) {
		var text = {};
		
		text.title = 'Untitled Activity';
		text.time = '';
		text.duration = '';
		text.description = '';
		text.company = '';
		text.address = '';
		text.phone = '';
		text.fax = '';
		text.website = '';
		text.website_link = '';
		
		if(isset(data.title)) { text.title = data.title; }
		if(isset(data.description)) { text.description = formatLineDescription(data.description); }
		if(isset(data.time)) { text.time = formatLineTime(data.time); }
		if(isset(data.duration)) { text.duration = formatLineDuration(data.duration); }
		if(isset(data.time) && isset(data.duration) && data.duration != 0) { 
			text.time = formatLineTime(data.time) + ' ~ ' + formatLineTime(addDurationToTime(data.time,data.duration)); 
		}
		if(isset(data.website)) { 
			text.website = convertUrlToText(data.website);
			text.website_link = convertTextToUrl(data.website);
		}
		
		text.company = data.company;
		text.address = data.address;
		text.phone = data.phone;
		text.fax = data.fax;
		
		return text;
	}
	
	function formatDayDate(date) {
		var formatted_date;
		date = new Date(date);
		var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
		var weekday = new Array(7);
			weekday[0]=  "Ｓ";
			weekday[1] = "Ｍ";
			weekday[2] = "Ｔ";
			weekday[3] = "Ｗ";
			weekday[4] = "Ｔ";
			weekday[5] = "Ｆ";
			weekday[6] = "Ｓ";
		var myWeekday = weekday[date.getDay()];
		formatted_date = ("0" + date.getDate()).slice(-2) + "&nbsp;" + monthNames[(date.getMonth())] + "&nbsp;&nbsp;&nbsp;(" + myWeekday + ")";
		return formatted_date;
	}
	
	function formatLineTime(time) {
		var formatted_time;
		if(isset(time)) {
			var hour = time.substring(0, time.indexOf(':'));
			var minute = time.substring(time.indexOf(':')+1);
			var ampm = 'am';
			if(hour == 12) {
				ampm = 'pm';
			}
			else if(hour > 12) {
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
	
	function formatLineDuration(duration) {
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
	
	function formatLineDescription(description) {
		var formatted_description;
		formatted_description = description.replace(new RegExp('\r?\n','g'), '<br />');
		return formatted_description;
	}
<!-- START: [end] -->
</script>
<script>
<!-- START: [print] -->
	function printPlan(mode, data) {
		<!-- START -->
			if(mode == 'template') {
				planFormat = {
					mode:'template',
					day:'list',
					editable:false,
					expanded:false,
					expandable:false,
					sortable:false,
					dayDate:false,
					lineContentAction:'read',
					lineButtonExpand:false,
					lineButtonMore:false,
					lineDetail:false,
					lineMenu:false,
					lineTransport:false,
				}
				if(isset(data.plan_id)) {
					$('#plan-'+data.plan_id).addClass('plan-template');
				}
				else {
					$('#plan').addClass('plan-template');
				}
			}
			else if(mode == 'edit') {
				planFormat = {
					mode:'edit',
					day:'slide',
					editable:true,
					expanded:true,
					expandable:false,
					sortable:true,
					dayDate:true,
					lineContentAction:'edit',
					lineButtonExpand:false,
					lineButtonMore:true,
					lineDetail:true,
					lineMenu:false,
					lineTransport:true,
				}
				if(isset(data.plan_id)) {
					$('#plan-'+data.plan_id).addClass('plan-edit');
				}
				else {
					$('#plan').addClass('plan-edit');
				}
			}
			else {
				planFormat = {
					mode:'view',
					day:'list',
					editable:false,
					expanded:false,
					expandable:true,
					sortable:false,
					dayDate:true,
					lineContentAction:'expand',
					lineButtonExpand:true,
					lineButtonMore:false,
					lineDetail:true,
					lineMenu:true,
					lineTransport:true,
				}
				if(isset(data.plan_id)) {
					$('#plan-'+data.plan_id).addClass('plan-view');
				}
				else {
					$('#plan').addClass('plan-view');
				}
			}
		<!-- END -->
		<!-- START -->
			if(planFormat.day == 'slide') {
				content = ''
					+ '<div id="hidden-swiper-left-column"></div>'
					+ '<div id="hidden-swiper-right-column"></div>'
					+ '<div class="swiper-container">'
						+ '<div class="swiper-wrapper">'
						+ '</div>'
					+ '</div>'
				;
				if(isset(data.plan_id)) {
					$('#plan-'+data.plan_id).append(content);
				}
				else {
					$('#plan').append(content);
				}
			}
		<!-- END -->
		<!-- START -->
			printDate(data);
		<!-- END -->
		<!-- START: [hidden form] -->
			var column = <?php echo $column_plan; ?>;
			var hidden_form = '';
			$.each(column, function(i, col) {
				hidden_form += ''
					+ '<input '
						+ 'name="' + col.name + '" '
						+ 'value="' + data[col.name] + '"'
					+ '/>'
				;
			});
		<!-- END -->
		<!-- START: [html] -->
			var html_hidden_form = '';
			
			html_hidden_form = ''
				+ '<form class="plan-form-hidden hidden" id="plan-form-hidden">'
					+ hidden_form
				+ '</form>'
			;
			
			
			if(isset(data.plan_id)) {
				$('#plan-'+data.plan_id).append(html_hidden_form);
			}
			else {
				$('#plan').append(html_hidden_form);
			}
		<!-- END -->
		<!-- START -->
			$.each(data.day, function(i) {
				printDay(planFormat, data.day[i]);
				if(isset(data.day[i].line)) {
					if(data.day[i].line.length > 0) {
						$.each(data.day[i].line, function(j) {
							printLine(planFormat, data.day[i].line[j]);
						});
					}
				}
			});
		<!-- END -->
		<!-- START -->
			if(planFormat.day == 'slide') {
				mySwiper = new Swiper ('.swiper-container', {
					direction:'horizontal',
					loop:false,
					threshold:30
				})
			}
		<!-- END -->
		<!-- START -->
			initDateButton();
			initDayButton();
			initMapButton();
			if(planFormat.day == 'slide') {
				initSwiperButton();
			}
			if(planFormat.sortable == true) {
				initSortableLine();
			}
			refreshLineTransportModeMain();
		<!-- END -->
	}
	
	function printDay(planFormat, data) {
		<!-- START: [hidden form] -->
			var column = <?php echo $column_json; ?>;
			var hidden_form = '';
			$.each(column, function(i, col) {
				hidden_form += ''
					+ '<input '
						+ 'id="plan-day-' + data.day_id + '-col-' + col.id + '-input-hidden" '
						+ 'name="' + col.name + '" '
						+ 'class="plan-input-hidden hidden" '
						+ 'value="' + data[col.name] + '"'
					+ '/>'
				;
			});
		<!-- END -->
		<!-- START [display] -->
			var hidden_day_date = 'hidden';
			var hidden_day_line_empty = 'hidden';
			var hidden_day_button_add_line = 'hidden';
			
			if(planFormat.dayDate == true) { hidden_day_date = ''; }
			if(!(isset(data.line)) || data.line.length == 0) { hidden_day_line_empty = ''; }
			if(planFormat.editable == true) { hidden_day_button_add_line = ''; }
		<!-- END -->
		<!-- START [text] -->
			var text_day = '';
			var text_date = '';
			
			text_day = 'Day ' + data.sort_order;
			
			var travel_date = $('#plan-form-hidden input[name=travel_date]').val();
			if(isset(travel_date) && travel_date != 'null') {
				travel_date = new Date(travel_date);
				var current_date = addDayToDate(travel_date,data.sort_order-1); 
				text_date = formatDayDate(current_date); 
			} 
			else { 
				text_date = 'Set Date'; 
			}
		<!-- END -->
		<!-- START [html] -->
			var html_date = '';
			var html_day_button_add_line = '';
			var html_day_line_empty = '';
			var html_hidden_form = '';
			
			if(isset(travel_date)) {
				var html_date = ''
					+ '<div class="padding-top ' + hidden_day_date + '">'
						+ '<b>'
							+ text_date
						+ '</b>'
					+ '</div>'
				;
			}
			var html_day_line_empty = ''
				+'<div class="plan-day-line-empty ' + hidden_day_line_empty + '">'
					+ 'No activity in this day'
				+'</div>'
			;
			var html_day_button_add_line = ''
				+'<div class="plan-button-add-line ' + hidden_day_button_add_line + '">'
					+ '<div class="text-center" data-toggle="modal" data-target="#modal-line-add">'
						+ 'ADD NEW ACTIVITY'
					+ '</div>'
				+'</div>'
			;
			var html_hidden_form = ''
				+ '<form class="plan-day-form-hidden plan-form-hidden" id="plan-day-' + data.day_id + '-form-hidden">'
					+ hidden_form
				+ '</form>'
			;
		<!-- END -->
		<!-- START: [content] -->
			if(planFormat.day == 'slide') {
				content = ''
					+ '<div id="plan-day-' + data.day_id + '" class="swiper-slide plan-day noselect">'
						+ '<div class="body-header fixed-width bar-day">'
							+ '<div class="col-xs-3 text-left">'
								+ '<div class="btn button-prev"><i class="fa fa-fw fa-chevron-left"></i></div>'
							+ '</div>'
							+ '<div class="col-xs-6 text-center">'
								+ '<a class="button-view-day"><span class="title">' + text_day + '</span><span class="button-see-all btn-secondary">(see all)</span></a>'
							+ '</div>'
							+ '<div class="col-xs-3 text-right">'
								+ '<div class="btn button-next"><i class="fa fa-fw fa-chevron-right"></i></div>'
							+ '</div>'
						+ '</div>'
						+ '<div class="swiper-slide-content scrollable-y">'
							+ '<div class="swiper-slide-content-header fixed-width row">'
								+ '<div class="col-xs-6 text-left"><div class="btn button-set-date">'+text_date+'</div></div>'
								+ '<div class="col-xs-6 text-right"><div class="btn button-view-map">View Map</div></div>'
							+ '</div>'
							+ '<div class="plan-day-line" id="plan-day-'+data.day_id+'-line">'
							+ '</div>'
							+ '<div class="plan-day-footer" id="plan-day-'+data.day_id+'-footer">'
								+ html_day_line_empty
								+ html_day_button_add_line
							+ '</div>'
						+ '</div>'
						+ html_hidden_form
					+ '</div>'
				;
			}
			else {
				content = ''
					+ '<div class="plan-day padding-bottom" id="plan-day-' + data.day_id + '">'
						+ '<div class="padding">'
							+ '<div class="label label-danger" style="padding:3.6px 7.2px; font-size:12px;">'
								+ '<b>'
									+ text_day
								+ '</b>'
							+'</div>'
							+ html_date
						+ '</div>'
						+ '<div class="plan-day-line-twin" id="plan-day-'+data.day_id+'-line-twin">'
						+ '</div>'
						+ '<div class="plan-day-line" id="plan-day-'+data.day_id+'-line">'
						+ '</div>'
						+'<div class="la la-30 ' + hidden_day_line_empty + '">'
							+ '<div class="la-row">'
								+ '<div class="la-desc">'
									+ '<div class="la-text">'
										+ 'No activity in this day'
									+ '</div>'
								+ '</div>'
							+ '</div>'
						+'</div>'
						+ html_hidden_form
					+ '</div>'
				;
			}
		<!-- END -->
		<!-- START: [canvas] -->
			if(planFormat.day == 'slide') {
				$('.swiper-wrapper').append(content);
			}
			else {
				$('#plan-'+data.plan_id).append(content);
			}
		<!-- END -->
	}
	
	function printLine(planFormat, data) {
		<!-- START: [hidden form] -->
			var column = <?php echo $column_json; ?>;
			var hidden_form = '';
			$.each(column, function(i, col) {
				var value = data[col.name];
				if(typeof value == 'undefined' || value == null || value == '') { value = ''; } 
				if(col.name == 'description') {
					hidden_form += ''
					+ '<textarea '
						+ 'id="plan-line-' + data.line_id + '-col-' + col.id + '-input-hidden" '
						+ 'name="' + col.name + '" '
						+ 'class="plan-input-hidden hidden" '
					+ '>'
					+ value
					+ '</textarea>'
				;
				}
				else {
					hidden_form += ''
						+ '<input '
							+ 'id="plan-line-' + data.line_id + '-col-' + col.id + '-input-hidden" '
							+ 'name="' + col.name + '" '
							+ 'class="plan-input-hidden hidden" '
							+ 'value="' + value + '"'
						+ '/>'
					;
				}
			});
		<!-- END -->
		<!-- START: [] -->
			if(planFormat.sortable == true) {
				line_bullet = '<i class="fa fa-fw fa-arrows"></i>';
			}
			else {
				var line_bullet = '<i class="fa fa-fw bullet">&bull;</i>';
				if(data['activity'] == 'fly_out') {
					line_bullet = '<i class="fa fa-fw bullet icon-plane-up"></i>';
				}
				else if(data['activity'] == 'fly') {
					line_bullet = '<i class="fa fa-fw bullet fa-plane"></i>';
				}
				else if(data['activity'] == 'fly_in') {
					line_bullet = '<i class="fa fa-fw bullet icon-plane-down"></i>';
				}
				else if(data['activity'] == 'eat') {
					line_bullet = '<i class="fa fa-fw bullet icon-food-icon"></i>';
				}
				else if(data['activity'] == 'stay') {
					line_bullet = '<i class="fa fa-fw bullet fa-bed"></i>';
				}
			}
		<!-- END -->
		<!-- START: [format] -->
			<!-- START: [action] -->
				var line_content_action = '';
				if(planFormat.lineContentAction == 'expand') {
					line_content_action = ''
						+ 'onclick="'
							+ '$(\'.plan-line-' + data.line_id + '-detail\').toggleClass(\'hidden\');'
							+ '$(\'.plan-line-' + data.line_id + '-menu\').toggleClass(\'hidden\');'  
							+ '$(\'#plan-line-' + data.line_id + ' .fa-caret-down\').first().toggleClass(\'fa-flip-vertical\');'
						+ '"'
					;
				}
				else if(planFormat.lineContentAction == 'edit') {
					line_content_action = 'data-toggle="modal" data-target="#modal-line-custom" onclick="setModalLineCustomForm(\''+data.line_id+'\');"';
				}
			<!-- END -->
			<!-- START: [expandable] -->
				var button_expand = '';
				if(isset(planFormat.expandable)) {
					if(planFormat.expandable == true) {
						button_expand = ''
							+ '<span class="button-expand">'
								+ '<i class="fa fa-fw fa-caret-down"></i>'
							+ '</span>'
						;
					}
				}
			<!-- END -->
			<!-- START: [expanded] -->
				var hidden_detail = 'hidden';
				if(isset(planFormat.expanded)) {
					if(planFormat.expanded == true) {
						hidden_detail = '';
					}
				}
			<!-- END -->
			<!-- START: [expanded] -->
				var hidden_detail = 'hidden';
				var hidden_line_menu = 'hidden';
				var hidden_line_transport = 'hidden';
				if(isset(planFormat.expanded)) {
					if(planFormat.expanded == true) {
						hidden_detail = '';
						hidden_line_transport = '';
					}
				}
			<!-- END -->
		<!-- END -->
		<!-- START: [display] -->
			var hidden_time = 'hidden';
			var hidden_duration = 'hidden';
			var hidden_description = 'hidden';
			var hidden_company = 'hidden';
			var hidden_address = 'hidden';
			var hidden_phone = 'hidden';
			var hidden_fax = 'hidden';
			var hidden_website = 'hidden';
			if(isset(data.time)) { hidden_time = ''; }
			if(isset(data.duration)) { hidden_duration = ''; }
			if(isset(data.description)) { hidden_description = ''; }
			if(isset(data.company)) { hidden_company = ''; }
			if(isset(data.address)) { hidden_address = ''; }
			if(isset(data.phone)) { hidden_phone = ''; }
			if(isset(data.fax)) { hidden_fax = ''; }
			if(isset(data.website)) { hidden_website = ''; }
		<!-- END -->
		<!-- START: [text] -->
			var text = formatLine(data);
		<!-- END -->
		<!-- START: [html] -->
			var html_line_bullet = '';
			var html_line_content = '';
			var html_line_button = '';
			var html_line_get_direction = '';
			var html_line_menu = '';
			var html_line_transport = '';
			var html_line_hidden_form = '';
			<!-- START: [html_line_bullet] -->
				html_line_bullet = ''
					+ '<div class="pa-icon button-move">'
						+ line_bullet
					+ '</div>'
				;
			<!-- END -->
			<!-- START: [html_line_content] -->
				html_line_content = ''
					+ '<div class="pa-desc" ' + line_content_action + '>'
						+ '<div class="pa-text data-title">'
							+ '<span class="text-title">'
								+ text.title
							+ '</span>'
							+ button_expand
						+ '</div>'
						+ '<div class="plan-line-detail plan-line-' + data.line_id + '-detail '+hidden_detail+'">'
							+ '<div class="pa-bullet text-clamp-1 data-time ' + hidden_time + '">'
								+ '<span>'
									+ '<i class="fa fa-fw fa-clock-o"></i><i class="fa fa-fw"></i>'
									+ '<span class="text-time">' 
										+ text.time
									+ '</span>'
								+ '</span>'
							+ '</div>'
							+ '<div class="pa-bullet text-clamp-1 data-duration ' + hidden_duration + '">'
								+ '<span>'
									+ '<i class="fa fa-fw fa-history"></i><i class="fa fa-fw"></i>'
									+ '<span class="text-duration">' 
										+ text.duration
									+ '</span>'
								+ '</span>'
							+ '</div>'
							+ '<div class="pa-bullet text-clamp-1 data-company ' + hidden_company + '">'
								+ '<span>'
									+ '<i class="fa fa-fw fa-building"></i><i class="fa fa-fw"></i>'
									+ '<span class="text-company">' 
										+ text.company
									+ '</span>'
								+ '</span>'
							+ '</div>'
							+ '<div class="pa-bullet text-clamp-1 data-address ' + hidden_address + '">'
								+ '<span>'
									+ '<i class="fa fa-fw fa-map-marker"></i><i class="fa fa-fw"></i>'
									+ '<span class="text-address">' 
										+ text.address
									+ '</span>'
								+ '</span>'
							+ '</div>'
							+ '<div class="pa-bullet text-clamp-1 data-phone ' + hidden_phone + '">'
								+ '<span>'
									+ '<i class="fa fa-fw fa-phone"></i><i class="fa fa-fw"></i>'
									+ '<span class="text-phone">' 
										+ text.phone
									+ '</span>'
								+ '</span>'
							+ '</div>'
							+ '<div class="pa-bullet text-clamp-1 data-fax ' + hidden_fax + '">'
								+ '<span>'
									+ '<i class="fa fa-fw fa-fax"></i><i class="fa fa-fw"></i>'
									+ '<span class="text-fax">' 
										+ text.fax
									+ '</span>'
								+ '</span>'
							+ '</div>'
							+ '<div class="pa-bullet text-clamp-1 data-website ' + hidden_website + '">'
								+ '<span>'
									+ '<i class="fa fa-fw fa-globe"></i><i class="fa fa-fw"></i>'
									+ '<span class="text-website">' 
										+ text.website
									+ '</span>'
								+ '</span>'
							+ '</div>'
							+ '<div class="pa-text data-description ' + hidden_description + '">'
								+ '<span class="text-description">'
									+ text.description
								+ '</span>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
				;
			<!-- END -->
			<!-- START: [html_line_button] -->
				if(isset(planFormat.lineButtonMore)) {
					if(planFormat.lineButtonMore == true) {
						html_line_button = ''
							+ '<div class="pa-btn button-action hidden">'
								+ '<i class="fa fa-fw fa-ellipsis-v"></i>'
							+ '</div>'
						;
					}
				}
			<!-- END -->
			<!-- START: [html_line_get_direction] -->
				if(isset(data.lat) && isset(data.lng)) {
					html_line_get_direction = ''
						+ '<a href="https://maps.google.com?saddr=Current+Location&amp;daddr='+data.lat+','+data.lng+'" target="_blank">'
							+ '<div class="la-row text-center border">'
								+ '<div class="col-xs-12">'
									+ '<div class="la-desc">'
										+ '<div class="la-text">'
											+ 'Get Direction'
										+ '</div>'
									+ '</div>'
								+ '</div>'
							+ '</div>'
						+ '</a>'
					;
				}
			<!-- END -->
			<!-- START: [html_line_menu] -->
				if(isset(planFormat.lineMenu)) {
					if(planFormat.lineMenu == true) {
						html_line_menu = ''
							+ '<div class="plan-line-menu plan-line-' + data.line_id + '-menu pa-menu row '+hidden_line_menu+'">'
								+ '<div class="la la-30 la-text-small la-hover la-pointer">'
									+ '<a class="hidden">'
										+ '<div class="la-row text-center">'
											+ '<div class="col-xs-12">'
												+ '<div class="la-desc">'
													+ '<div class="la-text">'
														+ 'Read More'
													+ '</div>'
												+ '</div>'
											+ '</div>'
										+ '</div>'
									+ '</a>'
									+ html_line_get_direction
								+ '</div>'
							+ '</div>'
						;
					}
				}
			<!-- END -->
			<!-- START: [html_line_transport] -->
				if(isset(planFormat.lineTransport)) {
					if(planFormat.lineTransport == true) {
						html_line_transport = ''
							+ '<div class="plan-line-' + data.line_id + '-transport pa-transport transport-row '+hidden_line_transport+'">'
								+ '<span class="transport data-transport">'
								+ '</span>'
							+ '</div>'
						;
					}
				}
			<!-- END -->
			<!-- START: [html_line_hidden_form] -->
				html_line_hidden_form = ''
					+ '<form class="plan-line-form-hidden plan-form-hidden hidden" id="plan-line-' + data.line_id + '-form-hidden">'
						+ hidden_form
					+ '</form>'
				;
			<!-- END -->
		<!-- END -->
		<!-- START: [content] -->
			if(planFormat.day == 'slide') { 
				pa_height = 'pa-40'; 
			}
			else { 
				pa_height = 'pa-30'; 
			}	
			content = ''
				+ '<div id="plan-line-' + data.line_id + '" class="pa ' + pa_height + ' plan-line noselect">'
					+ '<div class="pa-row row">'
						+ '<div style="float:left; width:42px;">'
							+ html_line_bullet
						+ '</div>'
						+ '<div style="float:left; width:calc(100% - 84px);">'
							+ html_line_content
							+ html_line_menu
							+ html_line_transport
						+ '</div>'
						+ '<div style="float:left; width:42px;" class="text-right">'
							+ html_line_button
						+ '</div>'
					+ '</div>'
					+ html_line_hidden_form
				+ '</div>'
		<!-- END -->
		<!-- START: [canvas] -->
			$("#plan-day-"+data.day_id+"-line").append(content); 
		<!-- END -->
		<!-- START: [modal] -->	
		<!-- END -->
	}
	
	function refreshPlanDayLineEmpty() {
		$('.plan-day-line-empty').addClass('hidden');
		$('.plan-day').each(function() {
			var day_id = $(this).find('.plan-day-form-hidden input[name=day_id]').val();
			<!-- START: set visibility -->
				var hidden = '';
				var line = $(this).find('.plan-line').length;
				if(line < 1) { $(this).find('.plan-day-line-empty').removeClass('hidden'); }
			<!-- END -->
		});
	}
<!-- START: [end] -->
</script>
<script>
	function sortBySortOrder(a, b) {
		return ((a.sort_order < b.sort_order) ? -1 : ((a.sort_order > b.sort_order) ? 1 : 0));
	}
	
	function updatePlanTableCookie() {
		<?php if($this->session->data['mode'] == 'edit') { ?>
			var serial = '';
			serial += '{';
				serial += '"name":"Plan 1"';
				serial += ',';
				serial += '"travel_date":"'+$('#plan-form-hidden input[name=travel_date]').val()+'"';
				serial += ',';
				serial += '"day":';
				serial += '[';
				<!-- START: [day] -->
					$.each($('.plan-day-form-hidden'), function(i, val) {
						var day_id = $(this).find($('.plan-input-hidden[name=day_id]')).val();
						serial += JSON.stringify($('#plan-day-'+day_id+'-form-hidden').find('.plan-input-hidden').not('[value="undefined"]').serializeObject());
						serial = serial.slice(0,-1);
						<!-- START: [line] -->
							if($('#plan-day-'+day_id+'-line .plan-line-form-hidden').length > 0) {
								serial += ',';
								serial += '"line":';
								serial += '[';
									$.each($('#plan-day-'+day_id+'-line').find($('.plan-line-form-hidden')), function(j, val) {
										var line_id = $(this).find($('.plan-input-hidden[name=line_id]')).val();
										serial += '{'
										$.each($('#plan-line-'+line_id+'-form-hidden .plan-input-hidden'), function(k, val) {
											if(isset($(this).val())) {
												serial += '"' + $(this).attr('name') + '"';
												serial += ':';
												serial += '"' + $(this).val() + '"';
												serial += ',';
											}
										});
										serial = serial.slice(0,-1);
										serial += '}'
										serial += ',';
									});
									serial = serial.slice(0,-1);
								serial += ']';
							}
						<!-- END -->
						serial += '},';
					});
					serial = serial.slice(0,-1);
				<!-- END -->
				serial += ']';
			serial += '}';
			<!-- START: sort day according to sort_order -->
				data = JSON.parse(serial);
				data.day.sort(sortBySortOrder);
				serial = JSON.stringify(data);
			<!-- END -->
			
			setCookie('plan',serial,7);
		<?php } ?>
	}
	
	function updatePlanTableLineDayIdAndSortOrder() {
		var day_id;
		var index;
		$('.plan-day-form-hidden').each(function() {
			index = 1;
			day_id = $(this).find('.plan-input-hidden[name=day_id]').val();
			$(this).parent('.plan-day').find('.plan-line-form-hidden').each(function() {
				$(this).find('.plan-input-hidden[name=day_id]').val(day_id);
				$(this).find('.plan-input-hidden[name=sort_order]').val(index);
				index += 1;
			});
		});
	}
	
	function updateTravelDate() {
		//Google Analytics Event
		ga('send', 'event','date', 'update-date');
		
		var travel_date = $('#plan-date-form-hidden input[name=travel_date]').val();
		$('#plan-form-hidden input[name=travel_date]').val(travel_date);
				
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
			showHint('Day Updated');
			refreshDayList();
			refreshPlan();
			//$(document).trigger("refreshDistance");
		<?php } else { ?>
			<!-- START: set data -->
				var data = {
					"action":"edit_plan_date",
					"plan_id":"<?php echo $plan_id; ?>",
					"travel_date":$('#plan-date-form-hidden input[name=travel_date]').val()
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					if(typeof json.warning != 'undefined') {
						showAlert(json.warning);
					}
					else if(typeof json.success != 'undefined') {
						showHint('Day Updated');
						refreshDayList();
						refreshPlan();
						//$(document).trigger("refreshDistance");
					}
				}, "json");
			<!-- END -->
		<?php } ?>
	}
</script>
<script>
<!-- START: [google] -->
function addGooglePlace() {
		<!-- START: get data -->
			var place_id = $('#wrapper-explore-current-form input[name=place_id]').val();
			var name = $('#wrapper-explore-current-form input[name=name]').val();
			var photo = $('#wrapper-explore-current-form input[name=photo]').val();
			var city = $('#wrapper-explore-current-form input[name=city]').val();
			var region = $('#wrapper-explore-current-form input[name=region]').val();
			var country = $('#wrapper-explore-current-form input[name=country]').val();
		<!-- END -->
		<!-- START: set data -->
			var data = {
				"action"	: "add_place",
				"place_id"	: place_id,
				"name"		: name,
				"photo"		: photo,
				"city"		: city,
				"region"	: region,
				"country"	: country
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['main/ajax_explore']; ?>", data, function(json) {
			}, "json");
		<!-- END -->
	}
<!-- END -->
</script>
<script>
<!-- START: [day] -->
	function addPlanDay() {
		<!-- START: set common data -->
			var sort_order = parseInt($('.plan-day').length) + 1;
		<!-- END -->
		<!-- START: save -->
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				var day_id = 0;
				var i = 1;
				while(day_id < 1) {
					var check_id = $("#plan-day-" + i + "-form-hidden").length;
					if (check_id < 1) { day_id = i; }
					i ++;
				};
				var data = {'day_id':day_id,'sort_order':sort_order};
				runAddPlanDay(data);
			<?php } else { ?>
				<!-- START: set data -->
					var data = {
						"action":"add_day",
						"plan_id":"<?php echo $plan_id; ?>",
						"sort_order":sort_order
					};
				<!-- END -->
			
				<!-- START: send POST -->
					$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
						if(typeof json.warning != 'undefined') {
							showAlert(json.warning);
						}
						else if(typeof json.success != 'undefined') {
							var day_id = json.day_id;
							var data = {'day_id':day_id,'sort_order':sort_order};
							runAddPlanDay(data);
						}
					}, "json");
				<!-- END -->
			<?php } ?>
		<!-- END -->
	}
	
	function runAddPlanDay(data) {
		<!-- START: set google analytic -->
			ga('send', 'event','day', 'new-day');
		<!-- END -->
		
		<!-- START: set variable -->
			var column = <?php echo $column_json; ?>;
		<!-- END -->
			
		<!-- START: print -->
			printDay(planFormat,data);
		<!-- END -->
			
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
		<?php } ?>
		
		<!-- START: init function -->
			refreshDayList();
			$('#modal-trip-day .modal-body').animate({ scrollTop: $('#modal-trip-day .modal-body').height()}, 100);
			refreshPlan();
		<!-- END -->
		
		<!-- START: [swiper] -->
			viewDay(data.day_id);
		<!-- END -->
		
		<!-- START: hint -->
			showHint('Day '+data.sort_order+' Added');
		<!-- END -->
	}
<!-- END -->
</script>
<script>
<!-- START: [line] -->
	function runAddPlanLine(line) {
		<!-- START: set variable -->
			var column = <?php echo $column_json; ?>;
		<!-- END -->
		
		<!-- START: set format -->
			if(isset(line.time) && isset(line.duration) && line.duration != 0) {
				line.time = convertLineTimeFormat(line.time) + ' ~ ' + convertLineTimeFormat(addDurationToTime(line.time,line.duration));
			}
		<!-- END -->
		
		<!-- START: print -->
			printLine(planFormat, line);
		<!-- END -->
		
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
		<?php } ?>
		
		<!-- START: init function -->
			//updatePlanTableButtonEvent();
			//updateDateFormButtonEvent();
			//updatePlanTableDayDuration();
			refreshPlanDayLineEmpty();
			initSortableLine();
			$(document).trigger("refreshDistance");
		<!-- END -->
		
		<!-- START: show hint -->
			var added_line = "";
			if(isset(line.place)) { added_line = line.place; } else { added_line = "New Activity"; }
			var day = $("#plan-day-"+ line.day_id).find(".plan-day-form-hidden input[name=sort_order]").val();
			
			var hint = added_line + " added to Day " + day;
			showHint(hint);
		<!-- END -->
	}
	
	function runEditPlanLine(data) {
		<!-- START: [google analytic] -->
			ga('send', 'event','line', 'edit-line');
		<!-- END -->
		<!-- START: [hidden form] -->
			$('#plan-line-'+data.line_id+'-form-hidden input[name=title]').val(data.title);
			$('#plan-line-'+data.line_id+'-form-hidden textarea[name=description]').val(data.description);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=lat]').val(data.lat);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=lng]').val(data.lng);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=duration]').val(data.duration);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=time]').val(data.time);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=image_id]').val(data.image_id);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=photo]').val(data.photo);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=company]').val(data.company);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=address]').val(data.address);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=phone]').val(data.phone);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=fax]').val(data.fax);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=website]').val(data.website);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=activity]').val(data.activity);
			$('#plan-line-'+data.line_id+'-form-hidden input[name=mode]').val(data.mode);
		<!-- END -->
		<!-- START: [text] -->
			var text = formatLine(data);
		<!-- END -->
		<!-- START: [html] -->
			$('#plan-line-'+data.line_id+' .text-title').html(text.title);
			$('#plan-line-'+data.line_id+' .text-description').html(text.description);
			$('#plan-line-'+data.line_id+' .text-time').html(text.time);
			$('#plan-line-'+data.line_id+' .text-duration').html(text.duration);
			$('#plan-line-'+data.line_id+' .text-company').html(text.company);
			$('#plan-line-'+data.line_id+' .text-address').html(text.address);
			$('#plan-line-'+data.line_id+' .text-phone').html(text.phone);
			$('#plan-line-'+data.line_id+' .text-fax').html(text.fax);
			$('#plan-line-'+data.line_id+' .text-website').html(text.website);
			$('#plan-line-'+data.line_id+' .text-website').attr('href',text.website_link);
		<!-- END -->	
			<!-- START: set visibility -->
				var detail = 0;
				var description = 0;
				var bullet = 0;
				var duration = 0;
				var time = 0;
				var company = 0;
				var address = 0;
				var phone = 0;
				var fax = 0;
				var website = 0;
				
				if(isset(data.description)) {
					detail += 1;
					description += 1;
				}
				if(isset(data.duration) && data.duration != 0) {
					detail += 1;
					bullet += 1;
					duration += 1;
				}
				if(isset(data.time)) {
					detail += 1;
					bullet += 1;
					time += 1;
				}
				if(isset(data.company)) {
					detail += 1;
					bullet += 1;
					company += 1;
				}
				if(isset(data.address)) {
					detail += 1;
					bullet += 1;
					address += 1;
				}
				if(isset(data.phone)) {
					detail += 1;
					bullet += 1;
					phone += 1;
				}
				if(isset(data.fax)) {
					detail += 1;
					bullet += 1;
					fax += 1;
				}
				if(isset(data.website)) {
					detail += 1;
					bullet += 1;
					website += 1;
				}
				
				if(detail > 0) {
					$('#plan-line-'+data.line_id+' .detail').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .detail').addClass('hidden');
				}
				if(description > 0) {
					$('#plan-line-'+data.line_id+' .data-description').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .data-description').addClass('hidden');
				}
				if(bullet > 0) {
					$('#plan-line-'+data.line_id+' .bullet').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .bullet').addClass('hidden');
				}
				if(duration > 0) {
					$('#plan-line-'+data.line_id+' .data-duration').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .data-duration').addClass('hidden');
				}
				if(time > 0) {
					$('#plan-line-'+data.line_id+' .data-time').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .data-time').addClass('hidden');
				}
				if(company > 0) {
					$('#plan-line-'+data.line_id+' .data-company').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .data-company').addClass('hidden');
				}
				if(address > 0) {
					$('#plan-line-'+data.line_id+' .data-address').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .data-address').addClass('hidden');
				}
				if(phone > 0) {
					$('#plan-line-'+data.line_id+' .data-phone').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .data-phone').addClass('hidden');
				}
				if(fax > 0) {
					$('#plan-line-'+data.line_id+' .data-fax').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .data-fax').addClass('hidden');
				}
				if(website > 0) {
					$('#plan-line-'+data.line_id+' .data-website').removeClass('hidden');
				}
				else {
					$('#plan-line-'+data.line_id+' .data-website').addClass('hidden');
				}
			<!-- END -->
		<!-- END -->
		
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
		<?php } ?>
		
		<!-- START: init function -->
			//updatePlanTableDayDuration();
			$(document).trigger("refreshDistance");
		<!-- END -->
		
		<!-- START: show hint -->
			showHint("Activity Updated");
		<!-- END -->
	}
	
	<!-- START: add poi from guide -->
		function addPoiFromGuide() {
			<!-- START: add google place if not exist in database -->
				addGooglePlace();
			<!-- END -->
			<!-- START: update button -->
				//$('#wrapper-explore-current-trip .button-add-trip').hide();
				//$('#wrapper-explore-current-trip .button-show-trip').show();
			<!-- END -->
			<!-- START: get form data -->
				var line_id = '';
				var type_id = $('#wrapper-explore-current-form input[name=type_id]').val()||null;
				var type = $('#wrapper-explore-current-form input[name=type]').val()||null;
				var day_id = $('.swiper-slide-active .plan-day-form-hidden input[name=day_id]').val();
				var image_id = $('#wrapper-explore-current-form input[name=image_id]').val()||null;
				var sort_order = $('.swiper-slide-active .plan-line').length + 1;
				var time = null;
				var duration  = null;
				var activity = 'visit';
				var place = $('#wrapper-explore-current-form input[name=name]').val();
				var place_id = $('#wrapper-explore-current-form input[name=place_id]').val();
				var lat = $('#wrapper-explore-current-form input[name=lat]').val()||null;
				var lng = $('#wrapper-explore-current-form input[name=lng]').val()||null;
				var fee = null;
				var currency = null;
				var title = place;
				var description = $('#wrapper-explore-current-form textarea[name=description]').val();
				var note = null;
				var time = time;
				var duration = duration;
			<!-- END -->
			<!-- START: temporary solution for cookie memory limit -->
				<?php if($this->session->data['memory'] == 'cookie') { ?>
					description = '';
				<?php } ?>
			<!-- END -->
			<!-- START: set line_id for Cookie -->
				<?php if($this->session->data['memory'] == 'cookie') { ?>
					var line_id = 0;
					var i = 1;
					while(line_id < 1) {
						var check_id = $("#plan-line-" + i + "-form-hidden").length;
						if (check_id < 1) { line_id = i; }
						i ++;
						if(i > 100) { break; }
					};
				<?php } ?>
			<!-- END -->
			<!-- START: set print data -->
				var line =
					{
						line_id		:line_id,
						type		:type,
						type_id		:type_id,
						day_id		:day_id,
						image_id	:image_id,
						sort_order	:sort_order,
						time		:time,
						duration	:duration,
						activity	:activity,
						place		:place,
						place_id	:place_id,
						lat			:lat,
						lng			:lng,
						fee			:fee,
						currency	:currency,
						title		:title,
						description	:description,
						note		:note
					}
				;
			<!-- END -->
			//Google Analytics Event
			ga('send', 'event','line', 'add-line-explore');
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				runAddPlanLine(line);
			<?php } else { ?>
				<!-- START: set data -->
					var data = {
						"action":"add_line",
						"line":line
					};
				<!-- END -->
			
				<!-- START: send POST -->
					$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
						if(typeof json.warning != 'undefined') {
							showAlert(json.warning);
						}
						else if(typeof json.success != 'undefined') {
							line.line_id = json.line_id;
							runAddPlanLine(line);
						}
					}, "json");
				<!-- END -->
			<?php } ?>
		}
	<!-- END -->
	
	function deletePlanLine() {
		line_id = $('#modal-line-custom input[name=line_id]').val();
		
		<?php if($this->session->data['memory'] == 'cookie') { ?>					
			$("#plan-line-" + line_id).remove();
			$('#modal-line-delete').modal('hide');
			$('#modal-line-custom').modal('hide');
			runDeletePlanLine();
		<?php } else { ?>
			<!-- START: set data -->
				var data = {
					"action":"delete_line",
					"line_id":line_id
				};
			<!-- END -->
		
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					if(typeof json.warning != 'undefined') {
						showAlert(json.warning);
					}
					else if(typeof json.success != 'undefined') {
						$("#plan-line-"+ line_id).remove();
						$('#modal-line-delete').modal('hide');
						$('#modal-line-custom').modal('hide');
						runDeletePlanLine();
					}
				}, "json");
			<!-- END -->
		<?php } ?>
	}
	
	function runDeletePlanLine() {
		//Google Analytics Event
		ga('send', 'event','line', 'delete-line');
		<!-- START: init function -->
			//updatePlanTableDayDuration();
			updatePlanTableLineDayIdAndSortOrder();
			refreshPlanDayLineEmpty();
			$(document).trigger("refreshDistance");
			//updatePlanTableButtonEvent();
		<!-- END -->
		
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
		<?php } ?>
		
		<!-- START: hint -->
			showHint('Activity Deleted');
		<!-- END -->
	}
<!-- END -->
</script>
<script>
	<?php if($last_action != '') { ?>
		showHint("<?php echo $last_action; ?>");
		<?php if($last_action == 'Log In' || $last_action == 'Sign Up') { ?>
			setTimeout(function() {
				$('#modal-trip-save').modal('show');
			}, 100);
		<?php }
	} ?>
</script>
<script>
	function setTransportTypeMenu () {
		var output = "";
		var mode = "";
		var mode_option = <?php echo $mode_option; ?>;
		$.each(mode_option, function(i) {
			mode += ''
					+ '<div class="mode-option" value="'+mode_option[i].mode_id+'">'
						+ '<span class="'+mode_option[i].icon+'"></span>'
					+ '</div>'		
		});	
					
		output += ''
			+ '<div class="line-transport-mode">'
				+ '<div class="click-blocker"></div>'
				+'<div class="mode-option-selector" >'
					+ '<div class="mode-option-selected"><span class="mode-icon"></span><i class="fa fa-caret-down" aria-hidden="true"></i></div>'
					+ mode
				+ '</div>'
				+ '<div class="mode-option-display">'
					+ '<span class="text"></span>'
					+ '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'
					+ '<span class="link"></span>'
					+ '<span class="path hidden"></span>'
					+ '<span class="travel-distance hidden"></span>'
					+ '<span class="travel-duration hidden"></span>'
					+ '<span class="travel-orindes hidden"></span>'
					+ '<span class="path-id hidden"></span>'
				+ '</div>';
			+ '</div>'
		return output;
	}
	
	function activeSelectTransportModeEvent() {
		// Onclick open close menu
		
		
		$(".mode-option-selector").off().on("click",function() {
			if ( $(this).find(".mode-option").is(":visible") ) {
				$(this).find(".mode-option").hide();
				$(this).removeClass("border");
			}else {
				$(".mode-option").hide();
				$(".mode-option-selector").removeClass("border");
				$(this).find(".mode-option").show();
				$(this).addClass("border");
				// create page block
				$(this).parents(".line-transport-mode").find(".click-blocker").show();
			}
		});	
		
		$(".click-blocker").off().on("click",function() {
			$(this).hide();
			$(this).parents(".line-transport-mode").find(".mode-option").hide();
			$(this).parents(".line-transport-mode").find(".mode-option-selector").removeClass("border");					
		});
		
		// onclick change selected 
		$(".mode-option").off().on("click",function() {
			$(this).parents(".line-transport-mode").find(".click-blocker").hide();
			var selected_mode = $(this).siblings(".mode-option-selected");
						
			if ($(this).attr('value') != selected_mode.attr('value')) {	
				selected_mode.find(".mode-icon").html($(this).html());
				selected_mode.attr('value', $(this).attr('value'));	
				
				var line_id, day_id, mode_id;
				
				if($(this).parents(".plan-line-twins").hasClass("plan-line-twins")) {
					//if this is twins, change the master also
					line_id =  $(this).parents(".transport-row").parent().find(".master-line-id").html();
					day_id =  $(this).parents(".transport-row").parent().find(".master-day-id").html();
					mode_id = $(this).attr('value');
					$("#plan-line-"+line_id).find(".mode-option-selected .mode-icon").html($(this).html());	
					$("#plan-line-"+line_id).find(".mode-option-selected").attr('value', $(this).attr('value'));	
				}else {
					line_id = $(this).parents(".plan-line").find($('.plan-input-hidden[name=line_id]')).val();
					day_id = $(this).parents(".plan-line").find($('.plan-input-hidden[name=day_id]')).val();
					mode_id = $(this).attr('value');					
				}
				//save the changes
				var coor = getOriDes (line_id);
				<?php if($this->session->data['memory'] == 'cookie') { ?>
					$(this).parents(".plan-line").find($('.plan-input-hidden[name=mode]')).val(mode_id);
					updatePlanTableCookie();					
					getLineModeDistanceDataViaCookie(line_id,day_id,coor);
				<?php }else { ?>
					editLineMode(line_id, day_id, mode_id,coor);
					//read transport for this line code here
				<?php } ?>
				
			}else {
				return;
			}	
		});
	}
	
	<!-- START: event response when select a transport -->
	function editLineMode(line_id, day_id, mode_id,coor){
		var data = {
					"action":"edit_line_mode",
					"line_id": line_id,
					"mode_id": mode_id
				};
				
		$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
			if (json.success) {
				getLineModeDistanceDataViaDatabase(line_id,day_id,coor);
			}else {
				//alert (json.warning);	
			}
		}, "json");
	}
	
	<!-- START: TRANSPORT MODE MAIN FUNCTION -->
	function refreshLineTransportModeMain(condition) {
		<!-- START: GET TRANSPORT MODE FOR EACH LINE TRANSPORT -->
		$(".plan-line .transport").each(function(i){
			
			// GET CURRENT LINE ID AND DAY ID
			var line_id = $(this).parents(".plan-line").find($('.plan-input-hidden[name=line_id]')).val();
			var day_id = $(this).parents(".plan-line").find($('.plan-input-hidden[name=day_id]')).val();
			
			<!-- SUB: GET ORIGIN AND DESTINATION COORDINATE FOR THIS LINE -->
			var coor = getOriDes (line_id);

			<!-- SUB: CREATE TWINS CONTAINER FOR EACH DAY LAST LINE IF AVAILABLE-->
			 printLineTwin(line_id,day_id);
			
			if (coor) {
				<?php if($this->session->data['memory'] == 'cookie') { ?>
					getLineModeDistanceDataViaCookie(line_id,day_id,coor);		
				<?php }else { ?>
					<!-- SUB: GET MODE ID FROM DATABASE-->	
					getLineModeDistanceDataViaDatabase(line_id,day_id,coor,condition);	
				<?php } ?>
			}else {
				// hide transport mode selector if not use (same coor, without origin or destination)
				$("#plan-line-"+line_id+" .transport-row").hide();
				$(".twins-"+line_id+" .transport-row").hide();	
			}
		});<!-- END -->
		
		<!-- START: PREPARE TRANSPORT CONTAINER -->
		<!-- SUB: CREATE TRANSPORT MODE SELECTOR OUTPUT AND PRINT TO EACH LINE-->
		var transport_menu = setTransportTypeMenu(); 
		$(".transport-row .transport").html(transport_menu);
		$(".mode-option").hide();
		$(".click-blocker").hide();
		<!-- SUB: ACTIVE ALL EVENT LISTENER FOR TRANSPORT MODE SELECTOR-->
		activeSelectTransportModeEvent();	
		
		<!-- EVENT LISTENER: RESPONSE AFTER ACTION ADD, EDIT, DELETE, SORT-->
		$(document).off("refreshDistance").on("refreshDistance",function(){
			$(".plan-line-twins").remove();	
			$(".transport-row").show();	
			refreshLineTransportModeMain("refresh");
		});
		
		$('.splash').fadeOut(500);
	}	
	
	function getLineModeDistanceDataViaDatabase(line_id,day_id,coor,condition) {												
		var data = {
				"action":"get_line_mode_path",
				"line_id": line_id,
				"coor": coor,
				"condition": condition,
				"default_mode_id": "2"
			};
			<!-- END -->
	
			<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				<!-- SUB: PRINT DATA FROM AJAX RESPONSE-->
				printLineModeDistanceData(line_id, coor,json);
					
			}, "json");
			<!-- END -->	
		
	}

	function getLineModeDistanceDataViaCookie(line_id,day_id,coor) {	
			
			if ($("#plan-line-"+line_id).find($('.plan-input-hidden[name=mode]')).val() == "") {
					$("#plan-line-"+line_id).find($('.plan-input-hidden[name=mode]')).val("2");
					updatePlanTableCookie();
					mode_id = "2";
			}else mode_id = $("#plan-line-"+line_id).find($('.plan-input-hidden[name=mode]')).val();

			var data = {
				"action":"get_distance_path",
				"coor": coor,
				"mode_id" : mode_id
			};
			<!-- END -->
	
			<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				<!-- SUB: PRINT DATA FROM AJAX RESPONSE-->
				printLineModeDistanceData(line_id, coor, json);
				
			}, "json");
			<!-- END -->	
	}
	
	function printLineModeDistanceData(line_id, coor ,json) {
		var mode_option = $("#plan-line-"+line_id+" .mode-option-selected");
		var mode_display = $("#plan-line-"+line_id+" .mode-option-display");
		var mode_id = json.mode_id;
		var mode = json.mode_name;
		mode_option.find(".mode-icon").html("<span class='"+json.mode_icon+"'></span>");
		mode_option.attr('value', json.mode_id);	
		
		var coordinates = new Array();
				coordinates [0] = new google.maps.LatLng(coor.ori_lat,  coor.ori_lng);
				coordinates [1] = new google.maps.LatLng(coor.des_lat, coor.des_lng);
						
		var orindesString = JSON.stringify (coordinates);
		
		mode_display.find(".travel-orindes.hidden").html(orindesString);
		
		
		if (json.path_id) {
			//alert (JSON.stringify(json));		
			if (json.path.distance_text == 0 && json.path.distance_text == 0) {
				var input_by_user_icon = '<i data-toggle="tooltip" title="Input By User" class="fa fa-exclamation-triangle"  aria-hidden="true"></i>';
				if (json.path.custom_distance_text || json.path.custom_duration_text) {
					if (json.path.custom_distance_text == "") json.path.custom_distance_text = "--";
					if (json.path.custom_duration_text == "") json.path.custom_duration_text = "--"; 
					var travel_text = json.path.custom_distance_text+", "+json.path.custom_duration_text+input_by_user_icon;				
				}else if (json.path.auto_custom_distance_text || json.path.auto_custom_duration_text ) {
					if (json.path.auto_custom_distance_text == "") json.path.auto_custom_distance_text = "--";
					if (json.path.auto_custom_duration_text == "") json.path.auto_custom_duration_text = "--"; 
					var travel_text = json.path.auto_custom_distance_text+", "+json.path.auto_custom_duration_text+input_by_user_icon;
				}else {
					var travel_text = "No Route Available";	
				}
			}else {
				var travel_text = json.path.distance_text+", "+json.path.duration_text;				
			}
			mode_display.find(".text").html(travel_text);
			mode_display.find(".travel-distance.hidden").html(json.path.distance);
			mode_display.find(".travel-duration.hidden").html(json.path.duration);
			mode_display.find(".path-id.hidden").html(json.path_id);
			mode_display.find(".path.hidden").html(json.path.path);
			var path_id = json.path_id;
			refreshTwinsTransportMode (line_id,coor);	
		}
		else {
			//// get from google
			//retriveGDistance (line_id, mode, data);
			//retriveGPath (line_id, mode, data);
			$.when(retriveGDistance (line_id, mode, coor), retriveGPath (line_id, mode, coor)).then(function( ) {
				addDistancePath (line_id,mode_id, coor);
				refreshTwinsTransportMode (line_id,coor);
			});						
		}	
	}
	
	function retriveGDistance (line_id, mode, data) {			
		var ori_lat = data.ori_lat;
		var ori_lng = data.ori_lng;
		var des_lat = data.des_lat;
		var des_lng = data.des_lng;


		var origin = ori_lat+","+ori_lng;
		var destination = des_lat+","+des_lng;
		var transport_id = $(this).attr("id");	
		//alert(origin + destination);	
		//alert (ori_lat +"" + ori_lng +"" +des_lat+"" +des_lng +"--------"+line_id);		
		if ( origin == destination) {
			$("#plan-line-"+line_id+" .transport-row").hide();
		}else {
			var deferred = new $.Deferred();
			var service = new google.maps.DistanceMatrixService();
			service.getDistanceMatrix({
					origins: [origin],
					destinations:  [destination],
					travelMode: mode,
					unitSystem: google.maps.UnitSystem.METRIC,
					avoidHighways: false,
					avoidTolls: false
				}, function(response, status) {
					if (status !== 'OK') {
						alert('Error was: ' + status);
					} else if (response.rows[0].elements[0].status == "OK") {
						//alert (status);
						var distance = response.rows[0].elements[0].distance.text;
						var duration = response.rows[0].elements[0].duration.text;
						var distance_value = response.rows[0].elements[0].distance.value;
						var duration_value = response.rows[0].elements[0].duration.value;
		
						$("#plan-line-"+line_id+" .mode-option-display .text").html(distance+", "+duration);
						$("#plan-line-"+line_id+" .mode-option-display .travel-distance").html(distance_value);
						$("#plan-line-"+line_id+" .mode-option-display .travel-duration").html(duration_value);
						deferred.resolve(response);
								
					}else if (response.rows[0].elements[0].status == "ZERO_RESULTS"){
						//alert (JSON.stringify(response));
						$("#plan-line-"+line_id+" .mode-option-display .text").html("No Route Available.");
						$("#plan-line-"+line_id+" .mode-option-display .travel-distance").html("");
						$("#plan-line-"+line_id+" .mode-option-display .travel-duration").html("");
						deferred.resolve(response);
					}
				});
			return deferred.promise();	
			}				
	}
	
	function retriveGPath (line_id, mode,data) {
		if (data.ori_place_id && data.des_place_id) {
			ori = { placeId: data.ori_place_id };
			des = { placeId: data.des_place_id };
		}else {
			ori = new google.maps.LatLng(data.ori_lat, data.ori_lng);
			des = new google.maps.LatLng(data.des_lat, data.des_lng);
		}
		
		var request = {
						origin: ori,
						destination: des,
						travelMode: mode
					};	
				
		var coordinates = new Array();
				coordinates [0] = ori;
				coordinates [1] = des;

		var deferred = new $.Deferred();
		var directionsService = new google.maps.DirectionsService();			
		directionsService.route(request, function(response, status) {
		
			if (status == 'OK') {
				
				var routePath = response.routes[0].overview_path;
				var routeString = JSON.stringify (routePath);
				$("#plan-line-"+line_id+" .mode-option-display .path").html(routeString);	
				deferred.resolve(response);			
			}else if (status == 'ZERO_RESULTS'){
				$("#plan-line-"+line_id+" .mode-option-display .path").html("");	
				deferred.resolve(response);	
			}	

		})
		return deferred.promise();	
	}
	
	function addDistancePath (line_id,mode_id, coor) {
		var distance = $("#plan-line-"+line_id+" .mode-option-display .travel-distance").html();
		var duration = $("#plan-line-"+line_id+" .mode-option-display .travel-duration").html();
		var path = $("#plan-line-"+line_id+" .mode-option-display .path").html();
		var text = $("#plan-line-"+line_id+" .mode-option-display .text").html();
		if (text) {
			//set data
			var data = {
					"action":"add_path",
					"line_id": line_id,			
					"mode_id": mode_id,
					"coor": coor,
					"distance": distance,
					"duration": duration,
					"path": path
				};
	
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				$("#plan-line-"+line_id+" .mode-option-display .path-id").html(json.path_id);
			}, "json");
			<!-- END -->
		}
	}
	
	//// SUB FUNCTION OF GET DISTANCE
	function getOriDes (line_id) {
		// add class to line with lat lng
		this_line = $("#plan-line-"+line_id+" .transport");	
		$(".plan-line").each(function(i) {
			if ($(this).find('.plan-line-form-hidden input[name=lat]').val()) $(this).addClass("haslatlng"); 
		});	
		
		var this_haslatlng = this_line.parents().hasClass("haslatlng");
		var next_hasline = this_line.parents().next(".plan-line").length;
		var next_haslatlng = this_line.parents().next(".plan-line").hasClass("haslatlng");
		var after_next_day_haslatlng = this_line.parents(".plan-day").nextAll(".plan-day").find(".plan-line").first().hasClass("haslatlng");
		//alert (next_haslatlng +" " + next_day_haslatlng +""+line_id);
		var ori_lat, ori_lng, des_lat, des_lng;
		if (this_haslatlng) {
			ori_lat = parseFloat(this_line.parents(".plan-line").find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
			ori_lng = parseFloat(this_line.parents(".plan-line").find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);
			ori_place_id = this_line.parents(".plan-line").find('.plan-line-form-hidden input[name=place_id]').val();
			ori_line_id = this_line.parents(".plan-line").find('.plan-line-form-hidden input[name=line_id]').val();
		}else {
			ori_lat = parseFloat(this_line.parents(".plan-line").prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
			ori_lng = parseFloat(this_line.parents(".plan-line").prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);
			ori_place_id = this_line.parents(".plan-line").prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=place_id]').val();
			ori_line_id = this_line.parents(".plan-line").prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=line_id]').val();
		}
		
		if (next_hasline && next_haslatlng) {
			des_lat = parseFloat(this_line.parents(".plan-line").next().find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
			des_lng = parseFloat(this_line.parents(".plan-line").next().find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);		
			des_place_id = this_line.parents(".plan-line").next().find('.plan-line-form-hidden input[name=place_id]').val();
			des_line_id = this_line.parents(".plan-line").next().find('.plan-line-form-hidden input[name=line_id]').val();
		}
		
		if (!next_hasline && after_next_day_haslatlng){
			des_lat = parseFloat(this_line.parents(".plan-day").nextAll(".plan-day").find(".plan-line").first().find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
			des_lng = parseFloat(this_line.parents(".plan-day").nextAll(".plan-day").find(".plan-line").first().find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);	
			des_place_id =this_line.parents(".plan-day").nextAll(".plan-day").find(".plan-line").first().find('.plan-line-form-hidden input[name=place_id]').val();
			des_line_id =this_line.parents(".plan-day").nextAll(".plan-day").find(".plan-line").first().find('.plan-line-form-hidden input[name=line_id]').val();
		}
	
		//alert (ori_lat +"/" + ori_lng +"," +des_lat+"/" +des_lng +"--------"+line_id);	
		if ( ori_lat && ori_lng && des_lat && des_lng && ori_lat !="NaN" && ori_lng !="NaN" && des_lat !="NaN" && des_lng !="NaN" ) {
			//if same coor, return
			if (ori_lat == des_lat && ori_lng == des_lng) return false;
			var coor = {
						"ori_lat": ori_lat,
						"ori_lng": ori_lng,
						"des_lat": des_lat,
						"des_lng": des_lng,
						"ori_place_id": ori_place_id,
						"des_place_id": des_place_id,
						"ori_line_id": ori_line_id,
						"des_line_id": des_line_id,
					};
			return coor;
		}else { 
			return false;
		}
		
	}
	
	function refreshTwinsTransportMode (line_id,coor) {
		// add link to google for transit mode
		linkTransitDirection (line_id,coor);
	
		if ($(".twins-"+line_id))	{
			var info_option = $("#plan-line-"+line_id).find(".transport .mode-option-selected").html();
			var info_display = $("#plan-line-"+line_id).find(".transport .mode-option-display").html();
			$(".twins-"+line_id).last().find(".transport .mode-option-selected").html(info_option);	
			$(".twins-"+line_id).last().find(".transport .mode-option-display").html(info_display);										
		}
	}
	
	function printLineTwin(line_id,day_id) {
		<!-- START: get global format -->
			var format = planFormat;
		<!-- END -->
		<!-- START: set stakeholder -->
			var day_last_line = $("#plan-day-"+day_id+"-line .plan-line").last();
			var next_day_id = $("#plan-day-"+day_id).next().attr('id');
			var day_after_this = $("#plan-day-"+day_id).nextAll(".plan-day");
		<!-- END -->
		<!-- START: verify condition -->
			//check if is last line 
			if (line_id == day_last_line.find($('.plan-input-hidden[name=line_id]')).val()) {
				var is_last_line = true;
			}
			//check if have next day
			if (next_day_id) {
				var have_next_day = true;
			}
		<!-- END -->
		<!-- START: set visibility -->
			var hidden_twin = '';
			var hidden_transport = '';
			if(format.day == 'list') { hidden_twin = 'hidden'; }
			if(format.lineTransport == false || format.day == 'list') { hidden_transport = 'hidden'; }
		<!-- END -->
		if (is_last_line && have_next_day) {

			var info_name = $("#plan-line-"+line_id+"-form-hidden input[name=title]").val();
			
			var twins_content = ''
				+ '<div class="pa pa-40 plan-line-twins twins-'+line_id+' '+hidden_twin+'">'
					+ '<div class="pa-row row">'
						+ '<div class="col-xs-12">'
							+ '<div class="pa-icon">'
								+ '<i class="fa fa-fw fa-long-arrow-right"></i>'
							+ '</div>'
							+ '<div class="pa-desc">'
								+ '<div class="pa-text data-title">'
									+'<span>'+info_name+' </span>'
									+'<span class="text-sub small">(from previous day)</span>'
								+ '</div>'
								+ '<div class="transport-row '+hidden_transport+'">'
									+ '<div class="transport data-transport">'
									+ '</div>'
								+ '</div>'
								+ '<div class="hidden">'
									+'<span class="master-day-id">'+day_id+'</span>'
									+'<span class="master-line-id">'+line_id+'</span>'
								+'</div>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
				+ '</div>'
			;
			
			if ($(".twins-"+line_id).length < 1 ) {
			/*	// create the twin line
				$("#"+next_day_id).find(".plan-day-line").prepend(twins_content);
				*/// hide the last line transport mode
				var day_after_this = $("#plan-day-"+day_id).nextAll(".plan-day");
				day_after_this.each(function(){
					if ( $(this).find(".plan-line-twins").length < 1) {
						
						$(this).find(".plan-day-line").prepend(twins_content);
						
						if ($(this).find(".plan-line").length > 0) {
							return false;	
						}
					}
				});
				$("#plan-line-"+line_id+" .transport-row").hide();
				$(".twins-"+line_id+" .transport-row").hide();	
				$(".twins-"+line_id).last().find(".transport-row").show();		
			}
		}
	}
	
	function linkTransitDirection (line_id,coor) {
		var selected_mode_id = $("#plan-line-"+line_id+" .mode-option-selected").attr('value');
		if (selected_mode_id == "1") {
			var this_line = $("#plan-line-"+line_id+" .transport .mode-option-display");	
			var g_link = 'https://maps.google.com?saddr='+coor.ori_lat+'+'+coor.ori_lng+'+&daddr='+coor.des_lat+','+coor.des_lng+'&dirflg=r';
			var output = '';
			if ( this_line.find(".travel-distance").html() == "0" && this_line.find(".travel-duration").html() =="0" ) {
				<?php if(isset($trip_id)) { ?>
				output += ''
					+ '<a data-toggle="modal" data-target="#modal-transport-custom" onclick="setOriginDestination('+coor.ori_line_id+','+coor.des_line_id+',&quot;'+g_link+'&quot;)" >'
						+ '<i class="fa fa-pencil-square-o" aria-hidden="true"></i>&nbsp;&nbsp;&nbsp;&nbsp;'
					+ '</a>';
				<?php } ?>
			}
				output += ''					
					+ '<a href="'+g_link+'" target="_blank">'
						+ '<i class="fa fa-compass" aria-hidden="true"></i>&nbsp;'
					+ '</a>'					
					;
							
			$("#plan-line-"+line_id+" .mode-option-display .link").html(output);		
		}else {
			$("#plan-line-"+line_id+" .mode-option-display .link").html("");
		}
	}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initMap" async defer></script>