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
		
		.header-secondary {
			top:40px;
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
			font-weight:normal;
			cursor:pointer;
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
		
		.menu-white {
			background-color:#FFF;
		}
		
		.menu-white li {
			border-bottom:solid thin #DDD;
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
		
		.btn.active {
			box-shadow:none;
		}
		
		.btn:active {
			box-shadow:none;
		}
		
		.title {
			color:#000;
			background-color:transparent;
		}
		
		.alert {
			border-radius:0;
			margin-bottom:0;
		}
	/* END */
</style>
<style>
	/* START: modal */
		.modal {
			text-align:center;
			color:#000;
		}
		
		.modal-dialog {
			margin:0 auto;
			text-align:left;
		}
		
		.modal-content {
			position:relative;
			border-radius:0;
			border:none;
			box-shadow:none;
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
	
	/* START: [popover alert] */	
		#section-popover-alert {
			position:fixed;
			bottom:10px;
			right:0;
			left:0;
			width:100%;
			z-index:15000;
		}
		
		#popover-alert{
			margin:auto;
			width:390px;
			line-height:50px;
			max-width:calc(100% - 10px);
			height:auto;
			background-color: rgba(139,0,0,0.9);
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
		/*
		.header .btn.button-save-trip {
			color:#e93578;
		}
		*/
		
		#wrapper-title-input {
			background-color:transparent;
			border:none;
			width:100%;
			height:40px;
			text-align:center;
			font-weight:bold;
			text-overflow: ellipsis;
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
		
		.bar-day .btn {
			padding:0 15px;
			border:none;
			line-height:39px;
			box-shadow:none;
		}
		
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
	}
	
	.plan-line, .plan-line-twins {
		padding:7px 15px;
		line-height:20px;
		font-size:12px;
		color:#000;
	}
	
	.plan-line .image, .plan-line-twins .image {
		position:relative;
		float:left;
		height:60px;
		width:60px;
		background-color:#999;
		border-radius:30px;
	}
	
	.plan-line .image, .plan-line .image img {
		cursor: pointer; /* fallback if grab cursor is unsupported */
		cursor: grab;
		cursor: -moz-grab;
		cursor: -webkit-grab;
	}
	
	.plan-line .image:active,.plan-line .image img:active {
		cursor: grabbing;
		cursor: -moz-grabbing;
		cursor: -webkit-grabbing;
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
	
	.plan-line .image img, .plan-line-twins .image img {
		height:60px;
		width:60px;
		border-radius:30px;
	}
	
	.plan-line .info, .plan-line-twins .description {
		display:block;
		float:right;
		width:calc(100% - 60px);
		padding-left:15px;
		cursor:pointer;
	}
	
	.plan-line .title, .plan-line-twins .title{
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
	
	.plan-line .transport, .plan-line-twins .transport {
		float:right;
		width:calc(100% - 60px);
		padding-left:15px;
		display:inline-block;
		background-color:#FFF;
		color:#999;
		margin-top:15px;
		font-size:11px;
	}
	/* START: [plan-day-line-empty] */
		.plan-day-line-empty {
			width:100%;
			color:#777;
			padding-top:20vh;
			font-weight:bold;
			text-align:center;
		}
	/* END */
	/* START: [plan-btn-add-line] */
		.plan-btn-add-line {
			padding:15px;
			text-align:center;
		}
		
		.plan-btn-add-line div {
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

<!-- START: [splash] -->
	<?php echo $modal_itinerary_splash; ?>
<!-- END -->

<div id="section-popover-hint"><div id="popover-hint" class="fixed-width" onclick="$(this).hide();"></div></div>
<div id="section-popover-alert"><div id="popover-alert" class="fixed-width" onclick="$(this).hide();"></div></div>
<div class="header header-black fixed-width fixed-bar noselect">
    <div class="col-xs-2 text-left">
        <a class="btn" href="<?php echo $link['main/home'];?>"><i class="fa fa-fw fa-lg fa-times"></i></a>
    </div>
    <div class="col-xs-8 text-left">
        <input id="wrapper-title-input" type="text"/>
    </div>
    <div class="col-xs-2 text-right">
    	<?php if($this->session->data['memory'] == 'cookie') { ?>
    		<a class="btn button-save-trip" data-toggle="modal" data-target="#modal-trip-save">Save</a>
        <?php } else { ?>
        	<a class="btn" data-toggle="modal" data-target="#modal-itinerary-menu"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>
        <?php } ?>
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
	<?php echo $modal_itinerary_menu; ?>
    <?php echo $modal_itinerary_map; ?>
	<?php echo $modal_itinerary_day; ?>
    <?php echo $modal_account_signup; ?>
    <?php echo $modal_account_login; ?>
    <?php echo $modal_trip_save; ?>
    <?php echo $modal_trip_share; ?>
    <?php echo $modal_line_filter; ?>
    <?php echo $modal_line_add; ?>
    <?php echo $modal_line_favourite; ?>
    <?php echo $modal_line_explore; ?>
    <?php echo $modal_line_custom; ?>
    <?php echo $modal_line_delete; ?>
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
	<!-- START: [popover alert] -->
		function showAlert(text) {
			$("#popover-alert").hide();
			$("#popover-alert").html(text).fadeIn(100);
			setTimeout(function() { $("#popover-alert").delay(1000).fadeOut(300); }, 2000);
		}
	<!-- END -->
	
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
		loop:false,
		threshold:30
	})
	
	function initSwiperButton() {
		$('.button-next').on('click',function() { mySwiper.slideNext(); });
		$('.button-prev').on('click',function() { mySwiper.slidePrev(); });
		$('.button-prev').first().addClass('disabled');
		$('.button-next').last().addClass('disabled');
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
				$('.transport-row').hide();
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
				
				$('.plan-line .detail').show();
				$('.plan-line .transport-row').show();
				$('.plan-line-twin .transport-row').show();
				$('.plan-day-line').css('min-height','0px');
				$('.plan-day-footer').show();
				
				refreshPlanDayLineEmpty();
				
				$('#hidden-swiper-right-column').off();
				$('#hidden-swiper-left-column').off();
			},
			update:function(event,ui) {
				//Google Analytics Event
				ga('send', 'event','line', 'sort-line');
				updatePlanTableLineDayIdAndSortOrder();
				$(document).trigger("refreshRoute");
				
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
						setCookie('trip',trip,7)
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
			setCookie('trip',trip,7);
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
			$('.button-set-date').on('click',function() { 
				$('#modal-trip-day').modal('show');
				openEditDate(); 
			});
		}
	<!-- END -->
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
		
	function setPlanTableDataFormatForLineTime(plan) {
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
	
	function setPlanTableDataFormatForLineDuration(plan) {
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
<!-- START: [google] -->
	function replaceGoogleImage(line_id, place_id) {
		<!-- START: set data -->
			var data = {
				"action":"get_place",
				"place_id":place_id
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['main/ajax_explore']; ?>", data, function(json) {
				$('#plan-line-'+line_id+' .image img').attr('src',json.photo);
			}, "json");
		<!-- END -->
	}
	
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
						var plan = {"name":"Plan 1","travel_date":"2016-02-09","day":[{"day_id":"1","sort_order":"1","line":[{"day_id":"1","line_id":"1","type":"destination","type_id":"26","time":"10:30","sort_order":"1","image_id":"236","title":"New Chitose Airport","description":"international airport","duration":"60","activity":"Visit","place":"New Chitose Airport","place_id":"ChIJ3RpcnUUgdV8R9oH25Xxguho","lat":"42.792595","lng":"141.670486"},{"day_id":"1","line_id":"2","type":"destination","type_id":"9","time":"14:00","sort_order":"2","image_id":"226","title":"Sapporo","duration":"60","activity":"Visit","place":"Sapporo","place_id":"ChIJMzaXWnXUCl8R1bqHRp1-kzM","lat":"43.062096","lng":"141.354370"}]},{"day_id":"2","sort_order":"2","line":[{"day_id":"2","line_id":"6","type":"destination","type_id":"9","sort_order":"1","image_id":"226","title":"Sapporo","duration":"60","activity":"Visit","place":"Sapporo","place_id":"ChIJMzaXWnXUCl8R1bqHRp1-kzM","lat":"43.062096","lng":"141.354370"},{"day_id":"2","line_id":"7","type":"destination","type_id":"13","sort_order":"2","image_id":"217","title":"Furano","duration":"60","activity":"Visit","place":"Furano","place_id":"ChIJj1EPMdVPc18RKt8wkJs2fB8","lat":"43.342140","lng":"142.383224"},{"day_id":"2","line_id":"8","type":"destination","type_id":"16","sort_order":"3","image_id":"220","title":"Biei","duration":"60","activity":"Visit","place":"Biei","place_id":"ChIJL_Q3O3jODF8Rbc5gAOO92fM","lat":"43.588188","lng":"142.466965"}]},{"day_id":"3","sort_order":"3"},{"day_id":"4","sort_order":"4"}]};
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
			plan = setPlanTableDataFormatForLineTime(plan);
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
				if(isset(this.line)) {
					if(this.line.length > 0) {
						$.each(this.line, function(j) {
							printLine(column, this, data_raw.day[i].line[j]);
						});
					}
				}
				printDayLineEmpty(this.day_id);
				printButtonAddLine(this.day_id);
			});
			//printButtonAddDay(column);
		<!-- END -->
		
		<!-- START: init function -->
			//updatePlanTableButtonEvent();
			//updateDateFormButtonEvent();
			//initSortableDay();
			initSwiperButton();
			initDateButton();
			initDayButton();
			initMapButton();
			$(document).trigger("refreshRoute");
			<?php if($this->session->data['mode'] == 'view') { ?>
				$('.button-move').hide();
				$('.plan-btn-add-line').hide();
				$('.button-set-date.nodate').hide();
				$('.plan-line .info').prop('onclick',null).off('click');
				$('.plan-line .info').attr('data-toggle',null);
				$('.plan-line .info').attr('data-target',null);
				$('.plan-line .btn-secondary').attr('data-toggle',null);
				$('.plan-line .btn-secondary').attr('data-target',null);
				$('#wrapper-explore-current-action').hide();
				$('#modal-trip-day-header-general').addClass('hidden');
				$('#modal-trip-day .modal-header-shadow').first().addClass('hidden');
				$('#modal-trip-day .btn-header').hide();
			<?php } else { ?>
				initSortableLine();
			<?php } ?>
		<!-- END -->
		
		<!-- START: end loading -->
			//swithMobileMode();
			//setDay();
			$('.splash').fadeOut(500);
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
			var nodate = '';
			if(isset(day.date)) {
				data.date = day.date;
			}
			else {
				data.date = 'Set Dates';
				nodate = 'nodate';
			}
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<div id="plan-day-' + day.day_id + '" class="swiper-slide plan-day">'
					+ '<div class="body-header fixed-width fixed-bar bar-day">'
						+ '<div class="col-xs-3 text-left">'
							+ '<div class="btn button-prev"><i class="fa fa-fw fa-chevron-left"></i></div>'
						+ '</div>'
						+ '<div class="col-xs-6 text-center">'
							+ '<a class="button-view-day"><span class="title">Day ' + day.sort_order + '</span><span class="button-see-all btn-secondary">(see all)</span></a>'
						+ '</div>'
						+ '<div class="col-xs-3 text-right">'
							+ '<div class="btn button-next"><i class="fa fa-fw fa-chevron-right"></i></div>'
						+ '</div>'
					+ '</div>'
					+ '<div class="swiper-slide-content scrollable-y">'
						+ '<div class="swiper-slide-content-header fixed-width fixed-bar">'
							+ '<div class="col-xs-4 text-left"><div class="btn button-set-date '+nodate+'">'+data.date+'</div></div>'
							+ '<div class="col-xs-4 text-center"></div>'
							+ '<div class="col-xs-4 text-right"><div class="btn button-view-map">View Map</div></div>'
						+ '</div>'
						+ '<div class="plan-day-line" id="plan-day-'+day.day_id+'-line">'
						+ '</div>'
						+ '<div class="plan-day-footer" id="plan-day-'+day.day_id+'-footer">'
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
			var hidden_read = 'hidden';
			var hidden_description = 'hidden';
			var hidden_detail = 'hidden';
			var hidden_bullet = 'hidden';
			var hidden_time = 'hidden';
			var hidden_duration = 'hidden';
			var hidden_company = 'hidden';
			var hidden_address = 'hidden';
			var hidden_phone = 'hidden';
			var hidden_fax = 'hidden';
			var hidden_website = 'hidden';
			var note = '';
			var image = '';
			if(isset(line['place_id'])) {
				hidden_read = '';
			}
			if(isset(line['title']) == false) {
				line.title = 'Untitled Activity';
			}
			if(isset(line['image_id'])) {
				image = 'resources/image/cropped/'+line.image_id+'.jpg';
			}
			else if(isset(line['photo'])) {
				image = line.photo;
			}
			else {
				image = 'resources/image/error/noimage.png';
			}
			if(isset(line['description'])) {
				hidden_detail = '';
				hidden_description = '';
			}
			if(isset(line['time'])) {
				hidden_detail = '';
				hidden_bullet = '';
				hidden_time = '';
				
			}
			if(isset(line['duration']) && line_raw['duration'] != 0) {
				hidden_detail = '';
				hidden_bullet = '';
				hidden_duration = '';
			}
			if(isset(line['company'])) {
				hidden_detail = '';
				hidden_bullet = '';
				hidden_company = '';
			}
			if(isset(line['address'])) {
				hidden_detail = '';
				hidden_bullet = '';
				hidden_address = '';
			}
			if(isset(line['phone'])) {
				hidden_detail = '';
				hidden_bullet = '';
				hidden_phone = '';
			}
			if(isset(line['fax'])) {
				hidden_detail = '';
				hidden_bullet = '';
				hidden_fax = '';
			}
			if(isset(line['website'])) {
				hidden_detail = '';
				hidden_bullet = '';
				hidden_website = '';
			}
			if(isset(line['note'])) {
				note = ''
					+ '<div class="note">'
						+ '<span class="text-note">'
							+ line['note']
						+ '</span>'
					+ '</div>'
				;
				hidden_detail = '';
			}
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<div id="plan-line-' + line.line_id + '" class="plan-line">'
					+ '<div class="row">'
						+ '<div class="image">'
							+ '<img class="noselect" src="'+image+'" onerror="this.onerror = \'\';this.src = \'resources/image/error/noimage.png\';"/>'
							+ '<div class="button-move"><i class="fa fa-fw fa-arrows"></i></div>'
						+ '</div>'
						+ '<div class="info" data-toggle="modal" data-target="#modal-line-custom" onclick="setModalLineCustomForm(\''+line.line_id+'\');">'
							+ '<div class="title">'
								+'<span class="text-title">'+line.title+'</span>'
								+' <span class="btn-secondary ' + hidden_read + '" data-toggle="modal" data-target="#modal-line-custom" onclick="explorePlace(\''+line.place_id+'\');">(read)</span>'
							+ '</div>'
							+ '<div class="detail ' + hidden_detail + '">'
								+ '<div class="bullet ' + hidden_bullet + '">'
									+ '<div class="time ' + hidden_time + '">'
										+ '<span>'
											+ '<i class="fa fa-fw fa-clock-o"></i><i class="fa fa-fw"></i>'
											+ '<span class="text-time">' + line['time'] + '</span>'
										+ '</span>'
									+ '</div>'
									+ '<div class="duration ' + hidden_duration + '">'
										+ '<span>'
											+ '<i class="fa fa-fw fa-history"></i><i class="fa fa-fw"></i>'
											+ '<span class="text-duration">' + line['duration'] + '</span>'
										+ '</span>'
									+ '</div>'
									+ '<div class="company ' + hidden_company + '">'
										+ '<span>'
											+ '<i class="fa fa-fw">By</i><i class="fa fa-fw"></i>'
											+ '<span class="text-company">' + line['company'] + '</span>'
										+ '</span>'
									+ '</div>'
									+ '<div class="address ' + hidden_address + '">'
										+ '<span>'
											+ '<i class="fa fa-fw fa-map-marker"></i><i class="fa fa-fw"></i>'
											+ '<span class="text-address">' + line['address'] + '</span>'
										+ '</span>'
									+ '</div>'
									+ '<div class="phone ' + hidden_phone + '">'
										+ '<span>'
											+ '<i class="fa fa-fw fa-phone"></i><i class="fa fa-fw"></i>'
											+ '<span class="text-phone">' + line['phone'] + '</span>'
										+ '</span>'
									+ '</div>'
									+ '<div class="fax ' + hidden_fax + '">'
										+ '<span>'
											+ '<i class="fa fa-fw fa-fax"></i><i class="fa fa-fw"></i>'
											+ '<span class="text-fax">' + line['fax'] + '</span>'
										+ '</span>'
									+ '</div>'
									+ '<div class="website ' + hidden_website + '">'
										+ '<span>'
											+ '<i class="fa fa-fw fa-globe"></i><i class="fa fa-fw"></i>'
											+ '<span data-toggle="modal" data-target="#modal-line-custom"><a class="text-website" href="' + convertTextToUrl(line['website']) + '" target="blank">' + convertUrlToText(line['website']) + '</a></span>'
										+ '</span>'
									+ '</div>'
								+ '</div>'
								+ '<div class="description ' + hidden_description + '">'
									+ '<span class="text-description">'
										+ line.description
									+ '</span>'
								+ '</div>'
								+ note
							+ '</div>'
						+ '</div>'
					+ '</div>' 
					+ '<div class="transport-row row">'
						+ '<div class="transport">'
							+ '<span class="icon">'
							+ '</span>'
							+ '<span class="text">'
							+ '</span>'
							+ '<span class="path hidden"></span>'
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
		<!-- START: replace image -->
			if(isset(line['image_id']) == false && isset(line['photo']) == false && isset(line.place_id)) {
				replaceGoogleImage(line.line_id, line.place_id);
			}
		<!-- END -->
	}
	
	function printDayLineEmpty(day_id) {
		<!-- START: set visibility -->
			var hidden = '';
			var line = $('#plan-day-'+day_id+'-line .plan-line').length;
			if(line > 0) { hidden = 'hidden'; }
		<!-- END -->
		<!-- START: set output -->
			var content = ''
				+'<div class="plan-day-line-empty ' + hidden + '">'
					+ 'No activity in this day'
				+'</div>'
			;
		<!-- END -->
		<!-- START: print content -->
			$("#plan-day-"+day_id+"-footer").append(content); 
		<!-- END -->
	}
	
	function printButtonAddLine(day_id) {
		<!-- START: set output -->
			var content = ''
				+'<div class="plan-btn-add-line">'
					+ '<div class="text-center" data-toggle="modal" data-target="#modal-line-add">'
						+ 'ADD SOMETHING NEW'
					+ '</div>'
				+'</div>'
			;
		<!-- END -->
		<!-- START: print content -->
			$("#plan-day-"+day_id+"-footer").append(content); 
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
	
	refreshPlanTable();
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
		//Google Analytics Event
		ga('send', 'event','day', 'new-day');
		<!-- START: set variable -->
			var column = <?php echo $column_json; ?>;
		<!-- END -->
		
		<!-- START: update hidden input -->
			//$('#plan-date-form-hidden input[name=num_of_day]').val(data.sort_order);
		<!-- END -->
			
		<!-- START: print -->
			printDay(column,data,data);
			//printButtonAddLine(column, "#plan-day-" + data.day_id + "-content");
		<!-- END -->
			
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
		<?php } ?>
		
		<!-- START: init function -->
			refreshPlanTable();
			refreshDayList();
			//refreshDateForm();
			//updateDateFormButtonEvent();
			//updatePlanTableButtonEvent();
			//updatePlanTableDayDate();
			//updatePlanTableDayDuration();
			//initSortableDay();
			//initSortableLine();
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
<!-- START: [date] -->
	function updateTravelDate() {
		//Google Analytics Event
		ga('send', 'event','date', 'update-date');		
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
			showHint('Day Updated');
			refreshDayList();
			refreshPlanTable();
			$(document).trigger("refreshRoute");
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
						refreshPlanTable();
						$(document).trigger("refreshRoute");
					}
				}, "json");
			<!-- END -->
		<?php } ?>
	}
<!-- END -->
</script>
<script>
<!-- START: [line] -->
	function runAddPlanLine(line,line_raw) {
		<!-- START: set variable -->
			var column = <?php echo $column_json; ?>;
		<!-- END -->
		
		<!-- START: set format -->
			if(isset(line_raw.time) && isset(line_raw.duration) && line_raw.duration != 0) {
				line.time = convertLineTimeFormat(line_raw.time) + ' ~ ' + convertLineTimeFormat(addDurationToTime(line_raw.time,line_raw.duration));
			}
		<!-- END -->
		
		<!-- START: print -->
			printLine(column,line,line_raw);
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
			$(document).trigger("refreshRoute");
		<!-- END -->
		
		<!-- START: show hint -->
			var added_line = "";
			if(isset(line.place)) { added_line = line.place; } else { added_line = "New Activity"; }
			var day = $("#plan-day-"+ line.day_id).find(".plan-day-form-hidden input[name=sort_order]").val();
			
			var hint = added_line + " added to Day " + day;
			showHint(hint);
		<!-- END -->
	}
	
	function runEditPlanLine(line,line_raw) {
		//Google Analytics Event
		ga('send', 'event','line', 'edit-line');
		<!-- START: update hidden value -->
			$('#plan-line-'+line.line_id+'-form-hidden input[name=title]').val(line_raw.title);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=description]').val(line_raw.description);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=lat]').val(line_raw.lat);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=lng]').val(line_raw.lng);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=duration]').val(line_raw.duration);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=time]').val(line_raw.time);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=image_id]').val(line_raw.image_id);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=photo]').val(line_raw.photo);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=company]').val(line_raw.company);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=address]').val(line_raw.address);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=phone]').val(line_raw.phone);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=fax]').val(line_raw.fax);
			$('#plan-line-'+line.line_id+'-form-hidden input[name=website]').val(line_raw.website);
		<!-- END -->
		<!-- START: update html -->
			<!-- START: set format -->
				if(isset(line_raw.time) && isset(line_raw.duration) && line_raw.duration != 0) {
					line.time = convertLineTimeFormat(line_raw.time) + ' ~ ' + convertLineTimeFormat(addDurationToTime(line_raw.time,line_raw.duration));
				}
			<!-- END -->
			
			$('#plan-line-'+line.line_id+' .text-title').html(line.title||'Untitled Activity');
			$('#plan-line-'+line.line_id+' .text-description').html(line.description);
			$('#plan-line-'+line.line_id+' .text-duration').html(line.duration);
			$('#plan-line-'+line.line_id+' .text-time').html(line.time);
			$('#plan-line-'+line.line_id+' .text-company').html(line.company);
			$('#plan-line-'+line.line_id+' .text-address').html(line.address);
			$('#plan-line-'+line.line_id+' .text-phone').html(line.phone);
			$('#plan-line-'+line.line_id+' .text-fax').html(line.fax);
			$('#plan-line-'+line.line_id+' .text-website').html(convertUrlToText(line.website));
			$('#plan-line-'+line.line_id+' .text-website').attr('href',convertTextToUrl(line.website));
			
			if($('#plan-line-'+line.line_id+' .image img').attr('src') != line_raw.photo || isset(line_raw.photo)) {
				if(isset(line_raw.photo)) {
					$('#plan-line-'+line.line_id+' .image img').attr('src',line_raw.photo);
				}
				else {
					var photo = 'resources/image/error/noimage.png';
					$('#plan-line-'+line.line_id+' .image img').attr('src',photo);
				}
			}
			
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
				
				if(isset(line.description)) {
					detail += 1;
					description += 1;
				}
				if(isset(line.duration) && line_raw.duration != 0) {
					detail += 1;
					bullet += 1;
					duration += 1;
				}
				if(isset(line.time)) {
					detail += 1;
					bullet += 1;
					time += 1;
				}
				if(isset(line.company)) {
					detail += 1;
					bullet += 1;
					company += 1;
				}
				if(isset(line.address)) {
					detail += 1;
					bullet += 1;
					address += 1;
				}
				if(isset(line.phone)) {
					detail += 1;
					bullet += 1;
					phone += 1;
				}
				if(isset(line.fax)) {
					detail += 1;
					bullet += 1;
					fax += 1;
				}
				if(isset(line.website)) {
					detail += 1;
					bullet += 1;
					website += 1;
				}
				
				if(detail > 0) {
					$('#plan-line-'+line.line_id+' .detail').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .detail').addClass('hidden');
				}
				if(description > 0) {
					$('#plan-line-'+line.line_id+' .description').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .description').addClass('hidden');
				}
				if(bullet > 0) {
					$('#plan-line-'+line.line_id+' .bullet').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .bullet').addClass('hidden');
				}
				if(duration > 0) {
					$('#plan-line-'+line.line_id+' .duration').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .duration').addClass('hidden');
				}
				if(time > 0) {
					$('#plan-line-'+line.line_id+' .time').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .time').addClass('hidden');
				}
				if(company > 0) {
					$('#plan-line-'+line.line_id+' .company').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .company').addClass('hidden');
				}
				if(address > 0) {
					$('#plan-line-'+line.line_id+' .address').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .address').addClass('hidden');
				}
				if(phone > 0) {
					$('#plan-line-'+line.line_id+' .phone').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .phone').addClass('hidden');
				}
				if(fax > 0) {
					$('#plan-line-'+line.line_id+' .fax').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .fax').addClass('hidden');
				}
				if(website > 0) {
					$('#plan-line-'+line.line_id+' .website').removeClass('hidden');
				}
				else {
					$('#plan-line-'+line.line_id+' .website').addClass('hidden');
				}
			<!-- END -->
		<!-- END -->
		
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			updatePlanTableCookie();
		<?php } ?>
		
		<!-- START: init function -->
			//updatePlanTableDayDuration();
			$(document).trigger("refreshRoute");
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
				var activity = 'Visit';
				var place = $('#wrapper-explore-current-form input[name=name]').val();
				var place_id = $('#wrapper-explore-current-form input[name=place_id]').val();
				var lat = $('#wrapper-explore-current-form input[name=lat]').val()||null;
				var lng = $('#wrapper-explore-current-form input[name=lng]').val()||null;
				var fee = null;
				var currency = null;
				var title = place;
				var description = null;
				var note = null;
				var formatted_time = convertLineTimeFormat(time);
				var formatted_duration = convertLineDurationFormat(duration);
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
						time		:formatted_time,
						duration	:formatted_duration,
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
				var line_raw =
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
				runAddPlanLine(line,line_raw);
			<?php } else { ?>
				<!-- START: set data -->
					var data = {
						"action":"add_line",
						"line":line_raw
					};
				<!-- END -->
			
				<!-- START: send POST -->
					$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
						if(typeof json.warning != 'undefined') {
							showAlert(json.warning);
						}
						else if(typeof json.success != 'undefined') {
							line.line_id = json.line_id;
							line_raw.line_id = json.line_id;
							runAddPlanLine(line,line_raw);
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
			$(document).trigger("refreshRoute");
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
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initMap" async defer></script>