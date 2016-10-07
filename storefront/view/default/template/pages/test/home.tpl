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
		
		.fixed-shadow-bar {
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
		
		.button-view-map {
			border:solid thin #999;
			color:#333;
			border-radius:10px;
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
	
	.day {
		min-height:calc(100vh - 40px);
	}
	
	.line {
		padding:7px 15px;
		line-height:20px;
		font-size:12px;
		color:#000;
		cursor: pointer; /* fallback if grab cursor is unsupported */
		cursor: grab;
		cursor: -moz-grab;
		cursor: -webkit-grab;
	}
	
	.line:active {
		cursor: grabbing;
		cursor: -moz-grabbing;
		cursor: -webkit-grabbing;
	}
	
	.line .image {
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
	
	.line .image img {
		height:60px;
		width:60px;
		border-radius:30px;
	}
	
	.line .description {
		display:block;
		float:right;
		width:calc(100% - 60px);
		padding-left:15px;
	}
	
	.line .title {
		display:table-cell;
		height:60px;
		vertical-align:middle;
		background-color:transparent;
		color:#000;
		font-weight:bold;
		text-align:left;
		padding:0;
	}
	
	.line .bullet {
		margin-bottom:15px;
	}
	
	.transport-row {
		position:relative;
	}
	
	.line .transport {
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
            <div class="swiper-slide">
            	<div class="body-header fixed-width fixed-bar bar-day">
                	<div class="col-xs-3 text-left">
                    	<div class="btn button-prev"><i class="fa fa-fw fa-chevron-left"></i></div>
                    </div>
                    <div class="col-xs-6 text-center">
                    	<a><span class="title">Day 1</span><span class="button-see-all">(see all)</span></a>
                    </div>
                    <div class="col-xs-3 text-right">
                    	<div class="btn button-next"><i class="fa fa-fw fa-chevron-right"></i></div>
                    </div>
                </div>
            	<div class="swiper-slide-content scrollable-y">
                	<div class="swiper-slide-content-header fixed-width fixed-bar">
                        <div class="col-xs-4 text-left"></div>
                        <div class="col-xs-4 text-center"></div>
                        <div class="col-xs-4 text-right"><div class="btn button-view-map">View Map</div></div>
                    </div>
                    <div class="day">
                        <div class="line">
                            <div class="row">
                                <div class="image">
                                    <img class="noselect" src="resources/image/cropped/217.jpg" />
                                    <div class="button-move"><i class="fa fa-fw fa-arrows"></i></div>
                                </div>
                                <div class="description">
                                    <div class="title">
                                        <span>Malaysia Kuala Lumpur Chinese Association Buildings</span>
                                    </div>
                                    <div class="detail">
                                        <div class="bullet">
                                            <div class="time">
                                                <span><i class="fa fa-fw fa-clock-o"></i><i class="fa fa-fw"></i>09:00</span>
                                            </div>
                                            <div class="duration">
                                                <span><i class="fa fa-fw fa-history"></i><i class="fa fa-fw"></i>1 hours</span>
                                            </div>
                                        </div>
                                        <div class="note">
                                            <span>Meet up with driver and tour guide before buy international phone card and rent a portable wifi device</span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="transport-row row">
                                <div class="transport">
                                    <span><i class="fa fa-fw fa-car"></i><i class="fa fa-fw"></i>3.7 km / 45 mins</span>
                                </div>
                            </div>
                        </div>
                        <div class="line">
                            <div class="row">
                                <div class="image">
                                    <img class="noselect" src="resources/image/cropped/221.jpg" />
                                    <div class="button-move"><i class="fa fa-fw fa-arrows"></i></div>
                                </div>
                                <div class="description">
                                    <div class="title">
                                        <span>Tokyo Disneyland</span>
                                    </div>
                                </div>
                            </div>
                            <div class="transport-row row">
                                <div class="transport">
                                    <span><i class="fa fa-fw fa-car"></i><i class="fa fa-fw"></i>3.7 km / 45 mins</span>
                                </div>
                            </div>
                        </div>
                        <div class="line">
                            <div class="row">
                                <div class="image">
                                    <img class="noselect" src="resources/image/cropped/219.jpg" />
                                    <div class="button-move"><i class="fa fa-fw fa-arrows"></i></div>
                                </div>
                                <div class="description">
                                    <div class="title">
                                        <span>Tokyo Tower</span>
                                    </div>
                                </div>
                            </div>
                            <div class="transport-row row">
                                <div class="transport">
                                    <span><i class="fa fa-fw fa-car"></i><i class="fa fa-fw"></i>3.7 km / 45 mins</span>
                                </div>
                            </div>
                        </div>
                        <div class="line">
                            <div class="row">
                                <div class="image">
                                    <img class="noselect" src="resources/image/cropped/223.jpg" />
                                    <div class="button-move"><i class="fa fa-fw fa-arrows"></i></div>
                                </div>
                                <div class="description">
                                    <div class="title">
                                        <span>Tokyo Station</span>
                                    </div>
                                </div>
                            </div>
                            <div class="transport-row row">
                                <div class="transport">
                                    <span><i class="fa fa-fw fa-car"></i><i class="fa fa-fw"></i>3.7 km / 45 mins</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="swiper-slide">
            	<div class="body-header fixed-width fixed-bar bar-day">
                	<div class="col-xs-3 text-left">
                    	<div class="btn button-prev"><i class="fa fa-fw fa-chevron-left"></i></div>
                    </div>
                    <div class="col-xs-6 text-center">
                    	<a><span class="title">Day 2</span><span class="button-see-all">(see all)</span></a>
                    </div>
                    <div class="col-xs-3 text-right">
                    	<div class="btn button-next"><i class="fa fa-fw fa-chevron-right"></i></div>
                    </div>
                </div>
            	<div class="swiper-slide-content scrollable-y">
                	<div class="swiper-slide-content-header fixed-width fixed-bar">
                        <div class="col-xs-4 text-left"></div>
                        <div class="col-xs-4 text-center"></div>
                        <div class="col-xs-4 text-right"><div class="btn button-view-map">View Map</div></div>
                    </div>
                    <div class="day"></div>
                </div>
            </div>
            <div class="swiper-slide">
            	<div class="body-header fixed-width fixed-bar bar-day">
                	<div class="col-xs-3 text-left">
                    	<div class="btn button-prev"><i class="fa fa-fw fa-chevron-left"></i></div>
                    </div>
                    <div class="col-xs-6 text-center">
                    	<a><span class="title">Day 3</span><span class="button-see-all">(see all)</span></a>
                    </div>
                    <div class="col-xs-3 text-right">
                    	<div class="btn button-next"><i class="fa fa-fw fa-chevron-right"></i></div>
                    </div>
                </div>
            	<div class="swiper-slide-content scrollable-y">
                	<div class="swiper-slide-content-header fixed-width fixed-bar">
                        <div class="col-xs-4 text-left"></div>
                        <div class="col-xs-4 text-center"></div>
                        <div class="col-xs-4 text-right"><div class="btn button-view-map">View Map</div></div>
                    </div>
                    <div class="day"></div>
                </div>
            </div>
        </div>
    </div>
</div>

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
	
	$('.button-next').on('click',function() { mySwiper.slideNext(); });
	$('.button-prev').on('click',function() { mySwiper.slidePrev(); });
	
	function initLineSortable() { 
		var autoSlideNext;
		var autoSlidePrev;
		var slideNext = false;
		var slidePrev = false;
		
		$('.day').sortable({
			delay:100,
			items:'>.line',
			handle:'.image',
			connectWith:'.day',
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
			placeholder: "ui-placeholder line",
			helper:function(event,ul) {
				return $('<div class="ui-helper"></div>');
			},
			start:function(event,ui) {
				mySwiper.endNow();
				mySwiper.detachEvents();
				$('.line .detail').hide();
				$('.line .transport-row').hide();
				ui.placeholder.html(ui.item.html());
				$(this).sortable('refreshPositions');
			},
			stop:function(event,ui) {
				clearInterval(autoSlideNext);
				clearInterval(autoSlidePrev);
				
				mySwiper.attachEvents();
				$('.line .detail').show();
				$('.line .transport-row').show();
				$('#hidden-swiper-right-column').off();
				$('#hidden-swiper-left-column').off();
			},
			sort: function( event, ui ) {
				if(collision($('.ui-helper'),$('#hidden-swiper-right-column')) == true) {
					if(slideNext == false) {
						autoSlideNext = setInterval(function () {
							mySwiper.slideNext();
							mySwiper.update(true);
							setTimeout(function() {
								$('.day').sortable('refreshPositions');
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
								$('.day').sortable('refreshPositions');
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
			over: function(event,ui) {
			},
			out: function(event,ui) {
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
	
	initLineSortable();
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
				$.post("<?php echo $ajax_itinerary; ?>", data, function(trip) {
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
				$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
					showHint('Title Updated');
				}, "json");
			<!-- END -->
		<?php } ?>
	});
	
	refreshTrip();
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
					$.post("<?php echo $ajax_itinerary; ?>", data, function(plan) {
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
			//plan = setPlanTableDataFormatForDayDay(plan);
			//plan = setPlanTableDataFormatForDayDate(plan);
			//plan = setPlanTableDataFormatForDayDuration(plan);
			//plan = setPlanTableDataFormatForLineDuration(plan);
		<!-- END -->
		
		<!-- START: set modified data -->
			data_cooked = plan;
		<!-- END -->
		
		<!-- START: set plan date -->
			//printDate(data_raw);
		<!-- END -->
		
		<!-- START: print table -->
			$.each(data_cooked.day, function(i) {
				printDay(this);
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
			//initSortableLine();
		<!-- END -->
		
		<!-- START: end loading -->
			//swithMobileMode();
			//setDay();
			//$('#wrapper-splash').fadeOut();
		<!-- END -->
	}
	
	function printDay(day) {
	}
	
	function printLine(column, line, line_raw) {
	}
	
	refreshPlanTable();
</script>