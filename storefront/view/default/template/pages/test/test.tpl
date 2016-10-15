<style>
	body {
		overflow-y:scroll;
		overflow-x:hidden;
		text-align:center;
		padding-top:1px;
		margin-top:-1px;
		-webkit-overflow-scrolling:touch;
	}
	
	/* START: [page] */
		.header {
			position:fixed;
			top:0;
			right:0;
			left:0;
			margin:auto;
			z-index:10;
		}
		
		.header .btn {
			padding:10px 15px;
			line-height:20px;
			border:none;
		}
		
		.header .title {
			padding:10px 15px;
			line-height:20px;
		}
		
		.header.header-gray {
			background-color:#DDD;
			color:#000;
			border-bottom:solid thin #CCC;
		}
		
		.header.header-gray .btn {
			color:#000;
		}
		
		.header.header-black {
			background-color:#000;
			color:#FFF;
			border-bottom:solid thin #333;
		}
		
		.header.header-black .btn {
			color:#FFF;
		}
		
		.body {
			position:relative;
			min-height:100vh;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
			margin:auto;
			text-align:left;
			background-color:white;
		}
		
		.body {
			height:100vh;
			padding-top:40px;
			padding-bottom:70px;
		}
		
		.body-header {
			border-bottom:solid thin #DDD;
		}
	/* END */
	/* START: [new common class] */
		.fixed-bar {
			height:40px;
		}
		
		.fixed-width {
			width:100%;
			max-width:400px;
		}
		
		.text-wrap {
			white-space: nowrap;
			text-overflow: ellipsis;
			overflow: hidden;
		}
		
		.scrollable-y {
			overflow-y:scroll;
			overflow-x:hidden;
			padding-top:1px;
			margin-top:-1px;
			-webkit-overflow-scrolling:touch;
		}
		
		.btn-secondary {
			color:#999;
			font-size:12px;
			line-height:20px;
			padding:0px 10px;
			margin:10px 10px;
		}
		
		.btn-secondary:active {
			box-shadow:none;
		}
		
		.btn-secondary:hover {
			color:#000;
		}
		
		.grabbable {
			cursor: pointer; /* fallback if grab cursor is unsupported */
			cursor: grab;
			cursor: -moz-grab;
			cursor: -webkit-grab;
		}
	
		.grabbable:active {
			cursor: grabbing;
			cursor: -moz-grabbing;
			cursor: -webkit-grabbing;
		}
	/* END */
	/* START: [fix for exisiting class] */
		img {
			-webkit-touch-callout: none; /* iOS Safari */
			-webkit-user-select: none;   /* Chrome/Safari/Opera */
			-khtml-user-select: none;    /* Konqueror */
			-moz-user-select: none;      /* Firefox */
			-ms-user-select: none;       /* Internet Explorer/Edge */
			user-select: none; 
		}
		
		.noselect {
			cursor:default;
		}
		
		.btn:active {
			box-shadow:none;
		}
		
		.title {
			color:#000;
			background-color:transparent;
		}
	/* END */
</style>
<style>
	/* START: modal */
		.modal {
			text-align:center;
		}
		
		.modal-dialog {
			margin:0 auto;
			text-align:left;
		}
		
		.modal-content {
			position:relative;
			border-radius:0;
			border:none;
		}
		
		.modal-header {
			border-radius:0;
			background-color:#DDD;
			height:40px;
			padding:0;
			border-bottom:solid thin #CCC;
		}
		
		.modal-body {
			min-height:calc(100vh - 40px);
		}
		
		.modal-title {
			color:#000;
			font-weight:bold;
		}
	/* END */
	/* START: [modal form] */
		.modal-body-footnote {
			width:100%;
			text-align:center;
		}
		
		.modal-button {
			border-radius:3px;
			line-height:40px;
			padding:0;
		}
		
		.modal-form .form-group {
			position:relative;
		}
		
		.modal-form .form-control {
			border:none;
			border-bottom:solid thin #DDD;
			height:40px;
			margin-top:15px;
			margin-bottom:15px;
			box-shadow: 0 2px 0 0 #FFF;
			padding:0;
			color:#000;
		}
		
		.modal-form .form-control:focus {
			border-bottom:solid thin #e93578;
			box-shadow: 0 2px 0 0 #e93578;
		}
		
		.modal-form .form-control:focus ~label {
			color:#e93578;
		}
		
		.modal-form .form-group:first-child {
			margin-top:15px;
		}
		
		.modal-form .form-group:last-child {
			margin-bottom:30px;
		}
		
		.modal-form label {
			position:absolute;
			top:0;
			left:0;
			padding:0;
			margin:0;
			font-size:12px;
			z-index:3;
			color:#999;
		}
		.modal-form input:-webkit-autofill {
			-webkit-box-shadow: 0 0 0 1000px white inset !important;
		}
		.modal-form input.form-control::-webkit-input-placeholder { /* Chrome/Opera/Safari */
		  color: #999;
			}
		.modal-form input.form-control::-moz-placeholder { /* Firefox 19+ */
		  color: #999;
		}
		.modal-form input.form-control:-ms-input-placeholder { /* IE 10+ */
		  color: #999;
		}
		.modal-form input.form-control:-moz-placeholder { /* Firefox 18- */
		  color: #999;
		}
		
		.modal-form input[type='date'] {
			-webkit-appearance: none;
		}
	/* END */
	/* START: [modal fixed-top] */
		body.modal-open {
			overflow: hidden;
			position:fixed;
			top:0;
			bottom:0;
			left:0;
			right:0;
		}
		.modal.modal-fixed-top {
			top: 0; 
			right: 0; 
			bottom: 0; 
			left: 0;
			-webkit-overflow-scrolling:auto;
			overflow-x:hidden;
			overflow-y:hidden;
		}
		.modal-fixed-top .modal-wrapper {
			position:relative;
		}
		.modal-fixed-top .modal-header {
			position:absolute;
			top:0;
			width:100%;
			text-align:center;
			border-radius:0;
			padding:0;
			z-index:10500;
			background-color:transparent;
			border-bottom:none;
		}
		.modal-fixed-top .modal-header > .fixed-bar {
			height:40px;
			margin:0 auto;
			background-color:#DDD;
			border-bottom:solid thin #CCC;
		}
		.modal-fixed-top .modal-header-shadow {
			display:block;
			height:40px;
		}
		.modal-fixed-top .modal-dialog {
			background-color:#FFF;
		}
		.modal-fixed-top .modal-content {
			overflow-y:scroll;
			overflow-x:hidden;
			-webkit-overflow-scrolling:touch;
			height:calc(100vh - 40px);
			padding-top:1px;
			margin-top:-1px;
		}
		.modal-fixed-top .modal-body {
			padding-bottom:70px;
		}
		.modal-fixed-top .modal-footer {
			position:absolute;
			bottom:0;
			width:100%;
			text-align:center;
			border-radius:0;
			padding:0;
			z-index:10500;
			background-color:transparent;
			border-top:none;
		}
	/* END */
</style>
<style>
	/* START: [popover hint] */	
		#section-popover-hint {
			position:fixed;
			bottom:10px;
			right:0;
			left:0;
			width:100%;
			z-index:15000;
		}
		
		#popover-hint{
			margin:auto;
			width:390px;
			line-height:50px;
			max-width:calc(100% - 10px);
			height:auto;
			background-color: rgba(0,0,0,0.9);
			color:#FFF;
			padding: 5px;
			display: none;
		}
	/* END */
</style>
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
	/* START: [itinerary] */
		#wrapper-title-input {
			background-color:transparent;
			border:none;
			width:100%;
			height:40px;
			text-align:center;
			font-weight:bold;
		}
		
		#wrapper-title-input:focus {
			outline:none;
		}
		
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
		
		.bar-day .button-see-all {
			display:inline-block;
			font-size:12px;
			color:#999;
		}
		
		.bar-day .btn {
			padding:0 15px;
			border:none;
			line-height:39px;
			box-shadow:none;
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
		height:80px;
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
	
	.plan-day-line {
		min-height:calc(100vh - 120px);
	}
	
	.plan-line {
		padding:7px 15px;
		line-height:20px;
		font-size:12px;
		color:#000;
		cursor: pointer; /* fallback if grab cursor is unsupported */
		cursor: grab;
		cursor: -moz-grab;
		cursor: -webkit-grab;
	}
	
	.plan-line:active {
		cursor: grabbing;
		cursor: -moz-grabbing;
		cursor: -webkit-grabbing;
	}
	
	.plan-line .image {
		position:relative;
		float:left;
		height:60px;
		width:60px;
		background-color:#999;
		border-radius:30px;
	}
	
	.button-move {
		position:absolute;
		bottom:0;
		right:0;
		height:22px;
		width:22px;
		background-color:#FFF;
		color:#333;
		border:solid thin #999;
		border-radius:11px;
		text-align:center;
		font-size:12px;
	}
	
	.plan-line .image img {
		height:60px;
		width:60px;
		border-radius:30px;
	}
	
	.plan-line .description {
		display:block;
		float:right;
		width:calc(100% - 60px);
		padding-left:15px;
	}
	
	.plan-line .title {
		display:table-cell;
		height:60px;
		vertical-align:middle;
		background-color:transparent;
		color:#000;
		font-weight:bold;
		text-align:left;
		padding:0;
	}
	
	.plan-line .bullet {
		margin-bottom:15px;
	}
	
	.transport-row {
		position:relative;
	}
	
	.plan-line .transport {
		float:right;
		width:calc(100% - 60px);
		padding-left:15px;
		display:inline-block;
		background-color:#FFF;
		color:#999;
		margin-top:15px;
		font-size:11px;
	}
</style>
<div id="section-popover-hint"><div id="popover-hint" class="fixed-width" onclick="$(this).hide();"></div></div>
<div class="header header-gray fixed-width fixed-bar noselect">
    <div class="col-xs-2 text-left">
        <a class="btn" href="<?php echo $link['main/home'];?>"><i class="fa fa-fw fa-lg fa-times-circle"></i></a>
    </div>
    <div class="col-xs-8 text-left">
        <input id="wrapper-title-input" type="text"/>
    </div>
    <div class="col-xs-2 text-right">
    	<a class="btn"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>
    </div>
</div>
<div class="body fixed-width noselect">
    <div id="hidden-swiper-left-column"></div>
    <div id="hidden-swiper-right-column"></div>
    <div class="swiper-container">
        <div class="swiper-wrapper">
        </div>
    </div>
</div>

<!-- START: [modal] -->
	<?php echo $modal_trip_day; ?>
	<?php echo $modal_trip_date; ?>
    <?php echo $modal_trip_map; ?>
<!-- END -->

<script>
	function isset(x) {
		if(typeof x != 'undefined' && x != null && x != '') {
			return true;
		}
		else {
			return false;
		}
	}
</script>
<script>
	<!-- START: jquery function to serialize form -->
		$.fn.serializeObject = function() {
			var o = {};
			var a = this.serializeArray();
			$.each(a, function() {
				if (o[this.name] !== undefined) {
					if (!o[this.name].push) {
						o[this.name] = [o[this.name]];
					}
					o[this.name].push(this.value || '');
				} else {
					o[this.name] = this.value || '';
				}
			});
			return o;
		};
	<!-- END -->
</script>
<script>
	<!-- START: [popover hint] -->
		function showHint(hint) {
			$("#popover-hint").hide();
			$("#popover-hint").html(hint).fadeIn(100);
			setTimeout(function() { $("#popover-hint").delay(1000).fadeOut(300); }, 2000);
		}
	<!-- END -->
	
	<?php if($last_action != '') { ?>
		showHint("<?php echo $last_action; ?>");
	<?php } ?>
</script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/swiper.jquery.min.js'); ?>"></script>
<script>
	var mySwiper = new Swiper ('.swiper-container', {
		direction:'horizontal',
		loop:false
	})
	
	function initSwiperButton() {
		$('.button-next').on('click',function() { mySwiper.slideNext(); });
		$('.button-prev').on('click',function() { mySwiper.slidePrev(); });
	}
	
	function initDayButton() {
		$('.button-view-day').on('click',function() { $('#modal-trip-day').modal('show'); });
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
			handle:'.image',
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
				$('.plan-line .detail').hide();
				$('.plan-line .transport-row').hide();
				ui.placeholder.html(ui.item.html());
				$(this).sortable('refreshPositions');
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
				
				$('.plan-line .detail').show();
				$('.plan-line .transport-row').show();
				
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
								showHint(json.warning);
							}
							else if(typeof json.success != 'undefined') {
								showHint('Activity Sorted');
							}
						}, "json");
					<!-- END -->
				<?php } ?>
			}
		});
	}
	
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
<!-- START: [cookie] -->
	function sortBySortOrder(a, b) {
		return ((a.sort_order < b.sort_order) ? -1 : ((a.sort_order > b.sort_order) ? 1 : 0));
	}
	
	function updatePlanTableCookie() {
		<?php if($this->session->data['mode'] == 'edit') { ?>
			var serial = '';
			serial += '{';
				serial += '"name":"Plan 1"';
				serial += ',';
				serial += '"travel_date":"'+$('#plan-date-form-hidden input[name=travel_date]').val()+'"';
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
										serial += JSON.stringify($('#plan-line-'+line_id+'-form-hidden').find('.plan-input-hidden').not('[value="undefined"]').not('[value=""]').serializeObject());
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
<!-- END -->
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
</script>
<script>
	function refreshTrip() {
		<?php if(isset($trip_id)) { ?>
			<!-- START: set POST data -->
				var data = {
					"action":"refresh_trip",
					"trip_id":"<?php echo $trip_id; ?>"
				};
			<!-- END -->
			
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(trip) {
					$("#wrapper-title-input").val(trip.name);
				}, "json");
			<!-- END -->
		<?php } else { ?>
			<!-- START: get data from cookie without login -->
				var trip = getCookie('trip');
				if(trip == '') {
					<!-- START: [first time] -->
						var trip = {
							name:"Untitled Trip"
						};
						trip = JSON.stringify(trip);
						setCookie('trip',trip,1)
					<!-- END -->
				}
				trip = JSON.parse(trip);
				$("#wrapper-title-input").val(trip.name);
			<!-- END -->
		<?php } ?>
	}
	
	$("#wrapper-title-input").change(function() {
		if($(this).val() == null || $(this).val() == '') {
			$(this).val('Untitled Trip');
		}
		<?php if($this->user->isLogged() == false) { ?>
			var trip = {
				name:$("#wrapper-title-input").val()
			};
			trip = JSON.stringify(trip);
			setCookie('trip',trip,1);
			showHint('Title Updated');
		<?php } else { ?>
			<!-- START: set POST data -->
				var data = {
					"action"	: "edit_trip_name",
					"trip_id"	: "<?php echo $this->trip->getTripId(); ?>",
					"name"		: $("#wrapper-title-input").val()
				};
			<!-- END -->
			
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					showHint('Title Updated');
				}, "json");
			<!-- END -->
		<?php } ?>
	});
	
	refreshTrip();
</script>
<script>
	<!-- START: [date] -->
		function initDateButton() {
			$('.button-set-date').on('click',function() { $('#modal-trip-date').modal('show'); });
		}
	<!-- END -->
</script>
<script>
	function setPlanTableDataFormatForDayDay(plan) {
		for (i=0; i<plan.day.length; i++) {
			plan.day[i].day = 'D'+plan.day[i].sort_order;
		}
		return plan;
	}
	
	function setPlanTableDataFormatForDayDate(plan) {	
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
	
	function setPlanTableDataFormatForDayDuration(plan) {
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
	
	function setPlanTableDataFormatForLineDuration(plan) {
		for(i=0; i<plan.day.length; i++) {
			if(typeof plan.day[i].line != 'undefined' && plan.day[i].line != null && plan.day[i].line != '' &&  plan.day[i].line.length > 0) {
				for(j=0; j<plan.day[i].line.length; j++) {
					var duration = plan.day[i].line[j].duration;
					if(typeof duration != 'undefined' && duration != null && duration != '') {
						var hour = Math.floor(duration/ 60);
						var minute = duration % 60;
						if(hour >= 1 && minute >= 1) {
							minute = ("0" + minute).slice(-2);
							plan.day[i].line[j].duration = hour+' hrs '+minute+' min';
						}
						else if(hour >= 1) {
							plan.day[i].line[j].duration = hour+' hrs';
						}
						else {
							plan.day[i].line[j].duration = minute+' min';
						}
					}
					else {
						plan.day[i].line[j].duration = '';
					}
				}
			}
		}
		return plan;
	}
</script>
<script>
	function refreshPlanTable() {
		<?php if(isset($trip_id)) { ?>
			<!-- START: [logged] -->
				<!-- START: set data -->
					var data = {
						"action":"refresh_plan",
						"trip_id":"<?php echo $trip_id; ?>",
						"plan_id":"<?php echo $plan_id; ?>"
					};
				<!-- END -->
			
				<!-- START: send POST -->
					$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(plan) {
						runRefreshPlanTable(plan);
					}, "json");
				<!-- END -->
			<!-- END -->
		<?php } else { ?>
			<!-- START: [not logged] -->
				var plan = getCookie('plan');
				if(plan == '') {
					<!-- START: [first time] -->
						var plan = {"name":"Plan 1","travel_date":"2016-02-09","day":[{"day_id":"1","sort_order":"1","line":[{"day_id":"1","line_id":"1","type":"destination","type_id":"26","time":"10:00","sort_order":"1","image_id":"236","title":"New Chitose Airport","duration":"60","activity":"Visit","place":"New Chitose Airport","lat":"42.792595","lng":"141.670486"},{"day_id":"1","line_id":"2","type":"destination","type_id":"9","time":"11:00","sort_order":"2","image_id":"226","title":"Sapporo","duration":"60","activity":"Visit","place":"Sapporo","lat":"43.062096","lng":"141.354370"}]},{"day_id":"2","sort_order":"2","line":[{"day_id":"2","line_id":"6","type":"destination","type_id":"9","sort_order":"1","image_id":"226","title":"Sapporo","duration":"60","activity":"Visit","place":"Sapporo","lat":"43.062096","lng":"141.354370"},{"day_id":"2","line_id":"7","type":"destination","type_id":"13","sort_order":"2","image_id":"217","title":"Furano","duration":"60","activity":"Visit","place":"Furano","lat":"43.342140","lng":"142.383224"},{"day_id":"2","line_id":"8","type":"destination","type_id":"16","sort_order":"3","image_id":"220","title":"Biei","duration":"60","activity":"Visit","place":"Biei","lat":"43.588188","lng":"142.466965"}]},{"day_id":"3","sort_order":"3"},{"day_id":"4","sort_order":"4"}]};
						plan = JSON.stringify(plan);
						setCookie('plan',plan,7);
						plan = JSON.parse(plan);
						runRefreshPlanTable(plan);
					<!-- END -->
				}
				else {
					<!-- START: [revisit] -->
						plan = JSON.parse(plan);
						runRefreshPlanTable(plan);
					<!-- END -->
				}
			<!-- END -->
		<?php } ?>
	}
	
	function runRefreshPlanTable(plan) {
		<!-- START: set column -->
			var column = <?php echo $column_json; ?>;
		<!-- END -->
		
		<!-- START: set raw data -->
			var data_raw = $.extend(true,{},plan); //IMPORTANT: to make sure clone without reference
		<!-- END -->
		
		<!-- START: set data format-->
			plan = setPlanTableDataFormatForDayDay(plan);
			plan = setPlanTableDataFormatForDayDate(plan);
			plan = setPlanTableDataFormatForDayDuration(plan);
			plan = setPlanTableDataFormatForLineDuration(plan);
		<!-- END -->
		
		<!-- START: set modified data -->
			data_cooked = plan;
		<!-- END -->
		
		<!-- START: set plan date -->
			printDate(data_raw);
			mySwiper.removeAllSlides();
		<!-- END -->
		
		<!-- START: print table -->
			$.each(data_cooked.day, function(i) {
				printDay(column, this, data_raw.day[i]);
				if(typeof this.line != 'undefined' && this.line != null && this.line != '') {
					if(this.line.length > 0) {
						$.each(this.line, function(j) {
							printLine(column, this, data_raw.day[i].line[j]);
						});
					}
				}
				//printButtonAddLine(column, "#plan-day-" + this.day_id + "-content");
			});
			//printButtonAddDay(column);
		<!-- END -->
		
		<!-- START: init function -->
			//updatePlanTableButtonEvent();
			//updateDateFormButtonEvent();
			//initSortableDay();
			initSortableLine();
			initSwiperButton();
			initDayButton();
			initDateButton();
			initMapButton()
		<!-- END -->
		
		<!-- START: end loading -->
			//swithMobileMode();
			//setDay();
			//$('#wrapper-splash').fadeOut();
		<!-- END -->
	}
	
	function printDay(column, day, day_raw) {
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
			if(isset(day.date)) {
				data.date = day.date;
			}
			else {
				data.date = 'Set Dates';
			}
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<div class="swiper-slide plan-day">'
					+ '<div class="body-header fixed-width fixed-bar bar-day">'
						+ '<div class="col-xs-3 text-left">'
							+ '<div class="btn button-prev"><i class="fa fa-fw fa-chevron-left"></i></div>'
						+ '</div>'
						+ '<div class="col-xs-6 text-center">'
							+ '<a class="button-view-day"><span class="title">Day ' + day.sort_order + '</span><span class="button-see-all">(see all)</span></a>'
						+ '</div>'
						+ '<div class="col-xs-3 text-right">'
							+ '<div class="btn button-next"><i class="fa fa-fw fa-chevron-right"></i></div>'
						+ '</div>'
					+ '</div>'
					+ '<div class="swiper-slide-content scrollable-y">'
						+ '<div class="swiper-slide-content-header fixed-width fixed-bar">'
							+ '<div class="col-xs-4 text-left"><div class="btn button-set-date">'+data.date+'</div></div>'
							+ '<div class="col-xs-4 text-center"></div>'
							+ '<div class="col-xs-4 text-right"><div class="btn button-view-map">View Map</div></div>'
						+ '</div>'
						+ '<div class="plan-day-line" id="plan-day-'+day.day_id+'-line">'
						+ '</div>'
					+ '</div>'
					+ '<form class="plan-day-form-hidden plan-form-hidden" id="plan-day-' + day.day_id + '-form-hidden">'
						+ hidden_form
					+ '</form>'
				+ '</div>'
			;
		<!-- END -->
		<!-- START: print content -->
			mySwiper.appendSlide(content);
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
		<!-- START: [info] -->
			var hidden_detail = 'hidden';
			var hidden_bullet = 'hidden';
			var time = '';
			var duration = '';
			var note = '';
			if(isset(line['time'])) {
				time = ''
					+ '<div class="time">'
						+ '<span>'
							+ '<i class="fa fa-fw fa-clock-o"></i><i class="fa fa-fw"></i>'
							+ line['time']
						+ '</span>'
					+ '</div>'
				;
				hidden_detail = '';
				hidden_bullet = '';
			}
			if(isset(line['duration'])) {
				duration = ''
					+ '<div class="duration">'
						+ '<span>'
							+ '<i class="fa fa-fw fa-history"></i><i class="fa fa-fw"></i>'
							+ line['duration']
						+ '</span>'
					+ '</div>'
				;
				hidden_detail = '';
				hidden_bullet = '';
			}
			if(isset(line['note'])) {
				note = ''
					+ '<div class="note">'
						+ '<span>'
							+ line['note']
						+ '</span>'
					+ '</div>'
				;
				hidden_detail = '';
			}
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<div class="plan-line">'
					+ '<div class="row">'
						+ '<div class="image">'
							+ '<img class="noselect" src="resources/image/cropped/'+line.image_id+'.jpg" />'
							+ '<div class="button-move"><i class="fa fa-fw fa-arrows"></i></div>'
						+ '</div>'
						+ '<div class="description">'
							+ '<div class="title">'
								+'<span>'+line.title+'</span>'
							+ '</div>'
							+ '<div class="detail ' + hidden_detail + '">'
								+ '<div class="bullet ' + hidden_bullet + '">'
									+ time
									+ duration
								+ '</div>'
								+ note
							+ '</div>'
						+ '</div>'
					+ '</div>' 
					+ '<div class="transport-row row">'
						+ '<div class="transport">'
							+ '<span>'
								+ '<i class="fa fa-fw fa-car"></i><i class="fa fa-fw"></i>'
								+ '3.7 km / 45 mins'
							+ '</span>'
						+ '</div>'
					+ '</div>' 
					+ '<form class="plan-line-form-hidden plan-form-hidden hidden" id="plan-line-' + line.line_id + '-form-hidden">'
						+ hidden_form
					+ '</form>'
				+ '</div>'
			;
		<!-- END -->
		<!-- START: print content -->
			$("#plan-day-"+line.day_id+"-line").append(content); 
		<!-- END -->
	}
	
	refreshPlanTable();
</script>