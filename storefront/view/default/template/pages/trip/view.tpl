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
			color:#000;
		}
		
		.body {
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
	
		.modal-modal {
			position:fixed;
			top:40px;
			left:0;
			right:0;
			height:calc(100vh - 40px);
			margin:auto;
			background-color:#000;
			opacity:.5;
			z-index:20;
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
	/* START: [menu] */
		.menu li {
			height:50px;
			padding:15px;
			border-bottom:solid thin #DDD;
			cursor:pointer;
		}
		
		.menu li .fa {
			color:#666;
		}
		
		.menu li:hover {
			background-color:#EEE;
		}
		
		.menu li.text-danger {
			color:#F00;
		}
		
		.menu li.text-danger .fa {
			color:#C00;
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
			opacity:1;
			-webkit-text-fill-color:#FFF;
		}
		
		#trip-description {
			padding:20px;
			border-bottom:solid thin #DDD;
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
	
	.plan-day {
		font-size:16px;
		color:#000;
		font-weight:bold;
		margin-bottom:30px;
	}
	
	.plan-day .day {
		padding:3.6px 7.2px;
	}
	
	.plan-day .date {
		line-height:50px;
	}
	
	.itinerary {
		padding:15px;
	}
	
	.plan-line {
		line-height:30px;
		font-size:14px;
		color:#333;
		font-weight:normal;
	}
	
	.plan-line .bullet {
		color:#999;
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
<style>
	.swiper-container {
		background-color:#000;
		margin-top:-2px;
		border-bottom:solid thin #DDD;
	}
	
	.swiper-slide:first-child {
		border-left:none; !important
	}
	
	.swiper-slide {
		border:none; !important
	}
	
	.swiper-pagination-bullet {
	}
</style>
<style>
	.trip-itinerary-bar {
		padding:15px;
	}
	
	.trip-itinerary-bar .title {
		font-size:18px;
		line-height:50px;
	}
	
	.trip-itinerary-bar .btn {
		margin:10px 0;
		padding:0 12px;
		line-height:30px;
		border-radius:15px;
	}
	
	.trip-photo-wrapper {
		position:relative;
		vertical-align:middle;
		overflow:hidden;
	}
	
	.trip-photo-background {
		width:100%;
		height:300px;
	}
	
	.trip-photo {
		position:absolute;
		top:0;
		bottom:0;
		left:0;
		margin:auto;
		width:100%;
		height:300px;
	}
	
	.plan-line .fa-link {
		color:#e93578;
	}
	
	.plan-line-detail {
		margin-bottom:15px;
		font-size:13px;
		color:#666;
	}
	
	.plan-line-description .fa {
		color:#999;
	}
	
	.plan-line-description a {
		color:#666;
		text-decoration:underline;
	}
	
	.plan-line-description {
		margin-left:36px;
		margin-right:36px;
	}
	
	.text-line-description {
		margin-bottom:15px;
	}
</style>
<style>
	/* START: disable exisiting style and function */
		.button-edit-trip-info,
		.button-preview-trip
		{
			display:none;
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
        <input id="wrapper-title-input" disabled/>
    </div>
    <div class="col-xs-2 text-right">
    	<a class="btn" data-toggle="modal" data-target="#modal-itinerary-menu"><i class="fa fa-fw fa-lg fa-ellipsis-v"></i></a>
    </div>
</div>
<div class="body fixed-width noselect">
	<div class="swiper-container">
        <div class="swiper-wrapper">
        </div>
        <div class="swiper-pagination"></div>
    </div>
	<div id="trip-description" class="hidden">
    </div>
    <div class="trip-itinerary-bar row">
    	<div class="col-xs-8">
        	<span class="title">Itinerary</span>
        </div>
    	<div class="col-xs-4 text-right">
    		<!-- <a class="btn btn-default btn-block button-show-detail" onclick="toggleAllLineDetail();">Show Details</a> -->
    		<a class="btn btn-default btn-block" data-toggle="modal" data-target="#modal-itinerary-map">Show Map</a>
        </div>
    </div>
	<div class="itinerary">
    </div>
</div>

<!-- START: [modal] -->
	<?php echo $modal_itinerary_menu; ?>
    <?php echo $modal_itinerary_map; ?>
    <?php echo $modal_trip_share; ?>
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
					if(isset(trip.description)) {
						$("#trip-description").removeClass('hidden');
						$("#trip-description").html(trip.description);
					}
				}, "json");
			<!-- END -->
		<?php } ?>
	}
	
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
			//printDate(data_raw);
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
				//printDayLineEmpty(this.day_id);
				//printButtonAddLine(this.day_id);
			});
		<!-- END -->
		
		<!-- START: end loading -->
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
				+ '<div id="plan-day-' + day.day_id + '" class="plan-day">'
					+ '<div class="label label-danger day">'
						+ 'DAY ' + day.sort_order 
					+ '</div>'
					+ '<div class="date">'
						+ data.date
					+ '</div>'
					+ '<div class="plan-day-line" id="plan-day-'+day.day_id+'-line">'
					+ '</div>'
				+ '</div>'
			;
		<!-- END -->
		<!-- START: print content -->
			$('.itinerary').append(content);
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
		<!-- START: [] -->
			var hidden_button_show_detail = 'hidden';
			var action = '';
			var hidden_button_link = 'hidden';
			var hidden_time = 'hidden';
			var hidden_duration = 'hidden';
			var hidden_company = 'hidden';
			var hidden_address = 'hidden';
			var hidden_phone = 'hidden';
			var hidden_fax = 'hidden';
			var hidden_website = 'hidden';
			var hidden_description = 'hidden';
						
			if(isset(line_raw.time)) { hidden_time = ''; }
			if(isset(line_raw.duration) && line_raw.duration != 0) { hidden_duration = ''; }
			if(isset(line_raw.company)) { hidden_company = ''; }
			if(isset(line_raw.address)) { hidden_address = ''; }
			if(isset(line_raw.phone)) { hidden_phone = ''; }
			if(isset(line_raw.fax)) { hidden_fax = ''; }
			if(isset(line_raw.website)) { hidden_website = ''; }
			if(isset(line_raw.description)) { hidden_description = ''; }
			
			if(isset(line_raw.time) || isset(line_raw.duration) && line_raw.duration != 0 || isset(line_raw.company) || isset(line_raw.address) || isset(line_raw.phone) || isset(line_raw.fax) || isset(line_raw.website) || isset(line_raw.description)) {
				hidden_button_show_detail = '';
				action = 'onclick="toggleLineDetail('+line.line_id+');"';
			}
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<div id="plan-line-' + line.line_id + '" class="plan-line">'
					+ '<div class="row">'
						+ '<div class="col-xs-11" '+action+'>'
							+ bullet
							+ '<i class="fa fa-fw"></i>'
							+ '<span class="text-title">'+line.title+'</span>'
							+ '<span class="button-show-detail-'+line.line_id+' '+hidden_button_show_detail+'" >'
								+ ' <i class="fa fa-fw fa-caret-down"></i>'
							+ '</span>'
						+ '</div>'
						+ '<div class="col-xs-1 text-right button-link-'+line.line_id+' '+hidden_button_link+'" onclick="explore('+line.line_id+');">'
							+ ' <i class="fa fa-fw fa-link"></i>'
						+ '</div>'
					+ '</div>'
					+ '<div class="row">'
						+ '<div class="plan-line-detail plan-line-detail-'+line.line_id+' hidden">'
							+ '<div class="plan-line-description text-line-description '+hidden_description+'">'
								+ line.description
							+ '</div>'
							+ '<div class="plan-line-description '+hidden_time+'">'
								+ '<i class="fa fa-fw fa-clock-o"></i>'
								+ '<i class="fa fa-fw"></i>'
								+ line.time
							+ '</div>'
							+ '<div class="plan-line-description '+hidden_duration+'">'
								+ '<i class="fa fa-fw fa-history"></i>'
								+ '<i class="fa fa-fw"></i>'
								+ line.duration
							+ '</div>'
							+ '<div class="plan-line-description '+hidden_company+'">'
								+ '<i class="fa fa-fw">By</i>'
								+ '<i class="fa fa-fw"></i>'
								+ line.company
							+ '</div>'
							+ '<div class="plan-line-description '+hidden_address+'">'
								+ '<i class="fa fa-fw fa-map-marker"></i>'
								+ '<i class="fa fa-fw"></i>'
								+ line.address
							+ '</div>'
							+ '<div class="plan-line-description '+hidden_phone+'">'
								+ '<i class="fa fa-fw fa-phone"></i>'
								+ '<i class="fa fa-fw"></i>'
								+ line.phone
							+ '</div>'
							+ '<div class="plan-line-description '+hidden_fax+'">'
								+ '<i class="fa fa-fw fa-fax"></i>'
								+ '<i class="fa fa-fw"></i>'
								+ line.fax
							+ '</div>'
							+ '<div class="plan-line-description '+hidden_website+'">'
								+ '<i class="fa fa-fw fa-globe"></i>'
								+ '<i class="fa fa-fw"></i>'
								+ '<a href="' + convertTextToUrl(line.website) + '" target="blank">' + convertUrlToText(line.website) + '</a>'
							+ '</div>'
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
	
	refreshTrip();
	refreshPlanTable();
</script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/swiper.jquery.min.js'); ?>"></script>
<script>
	function initSwiper() {
		var mySwiper = new Swiper ('.swiper-container', {
			autoplay:5000,
			direction:'horizontal',
			loop:true,
			threshold:30,
			pagination:'.swiper-pagination',
			paginationClickable:true
		})
	}
</script>
<script>
	function refreshTripPhoto() {
		<!-- START: set POST data -->
			var data = {
				"action":"refresh_trip_photo",
				"trip_id":"<?php echo $trip_id; ?>"
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				$('#album .trip-photo-col').remove();
				if(isset(json)) {
					$.each(json.photo, function() {
						printTripPhoto(this);
					});
					initSwiper();
				}
			}, "json");
		<!-- END -->
	}
	
	function printTripPhoto(photo) {
		var content = '';
		content = ''
			+ '<div class="swiper-slide">'
				+ '<div class="trip-photo-wrapper">'
					+ '<img class="trip-photo-background" src="resources/image/black_rectangle.png"/>'
					+ '<img class="trip-photo" src="'+photo.path+'"/>'
				+ '</div>'
			+ '</div>'
		;
		$('.swiper-wrapper').append(content);
	}
	
	refreshTripPhoto();
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
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initMap" async defer></script>