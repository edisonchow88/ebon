<style>
	/* START: wrapper-body */
		#section-body {
			width:100%;
			position:relative;
			overflow:hidden;
			height:calc(100vh - 48px - 3px);
			color:#333;
		}
		
		/* START: section-tab */
			#section-tab {
				width:100%;
				height:40px;
			}
			
			#section-tab li {
				float:left;
				width:33.33%;
				box-sizing: border-box; /* set inner border instead of edge border*/
				-moz-box-sizing: border-box;
				-webkit-box-sizing: border-box;
				border-left:solid thin #BBB;
			}
			
			#section-tab li:first-child {
				border:none;
			}
			
			#section-tab li.active a {
				box-shadow:0 -5px 0 -1px #e93578 inset;
			}
			
			#section-tab a {
				display:block;
				width:100%;
				padding:10px 10px;
				background-color:#CCC;
				color:#333;
				-webkit-touch-callout: none; /* iOS Safari */
				-webkit-user-select: none;   /* Chrome/Safari/Opera */
				-khtml-user-select: none;    /* Konqueror */
				-moz-user-select: none;      /* Firefox */
				-ms-user-select: none;       /* Internet Explorer/Edge */
				user-select: none;           /* Non-prefixed version, currently not supported by any browser */
			}
			
			#section-tab a:hover {
				background-color:#BBB;
				color:#222;
			}
			
			#section-tab li.active a {
				background-color:#AAA;
				color:#111;
				cursor:default;
			}
			
			#section-tab-button {
				position:absolute;
				top:10px;
				right:-1px;
			}
			
			#section-tab-button > .btn {
				font-size:9px;
				padding:10px;
				border:solid thin #EEE;
				border-radius:5px 0 0 5px;
			}
		/* END */
		
		/* START: section-day-bar */
			#section-day-bar {
				width:100%;
			}
			
			#section-day-bar a.btn {
				height:40px;
				width:100%;
				line-height:20px;
				padding:5px 15px;
				border:none;
				border-bottom:solid thin #DDD;
			}
			
			#section-day-bar a.btn:hover {
				background-color:#FFF;
				color:#e93578;
			}
			
			#section-day-bar .disabled {
				opacity:1;
				pointer-events:none;
			}
			
			#section-day-bar .disabled a {
				color:#EEE;
			}
			
			#section-day-bar .disabled:hover a {
				color:#EEE;
			}
			
			#section-day-bar i.fa {
				line-height:20px;
				padding:5px
			}
			
			#section-day-bar-title {
				line-height:30px;
				padding:5px
			}
			
			#section-day-bar-button-add-day a.btn {
				line-height:30px;
				padding:5px 0px;
				color:#e93578;
			}
			
			#section-day-bar-button-add-day a.btn:hover {
				color:#000;
			}
			
			#section-day-bar-button-all-day.disabled a {
				color:#000;
			}
			
			#section-day-bar-button-all-day.disabled:hover a {
				color:#000;
			}
		/* END */
		
		/* START: section-hint */
			#section-hint {
				width:100%;
				height:70px;
				padding:10px 15px;
				line-height:20px;
				background-color:#FFF;
				border-bottom:solid thin #DDD;
			}
		/* END */
		
		/* START: section-content */
			#section-content {
				width:100%;
				height:calc(100vh - 48px - 3px - 40px - 40px);
				overflow:auto;
				background-color:#FFF;
			}
			
			#section-guide {
				width:100%;
				float:left;
				background-color:#EEE;
				padding-bottom:15px;
			}
			
			#section-plan {
				width:100%;
				float:left;
				background-color:#EEE;
				padding-bottom:15px;
			}
			
			#section-map {
				width:100%;
				float:left;
				height:calc(100vh - 48px - 3px - 40px);
			}
		/* END */
	/* END */	
</style>

<?php echo $modal_home_splash; ?>

<div id="section-body">
	<div id="section-tab">
    	<ul>
        	<li id="section-tab-guide" class="section-tab-button active"><a onclick="showTab('guide');">Guide</a></li>
            <li id="section-tab-plan" class="section-tab-button"><a onclick="showTab('plan');">Plan</a></li>
            <li id="section-tab-map" class="section-tab-button"><a onclick="showTab('map');">Map</a></li>
        </ul>
    </div>
    <div id="section-day-bar" class="row">
    	<div class="col-xs-3" id="section-day-bar-button-empty"><a class="btn btn-default disabled"></a></div>
        <div class="col-xs-3" id="section-day-bar-button-previous-day"><a class="btn btn-default"><i class="fa fa-fw fa-chevron-left"></i></a></div>
        <div class="col-xs-6" id="section-day-bar-button-all-day">
        	<a class="btn btn-default">
            	<form id="section-day-bar-form">
                    <input name="day_id" type="hidden"/>
                    <input name="sort_order" type="hidden"/>
                </form>
                <span id="section-day-bar-title">All Days</span>
            </a>
        </div>
        <div class="col-xs-3" id="section-day-bar-button-next-day"><a class="btn btn-default"><i class="fa fa-fw fa-chevron-right"></i></a></div>
        <div class="col-xs-3" id="section-day-bar-button-add-day"><a class="btn btn-default" onclick="addPlanDay();">Add Day</a></div>
    </div>
    <div id="section-hint" class="hidden">
        <div class="alert alert-info">
            <b>HINT:</b> <span>Add your favourite place to Plan from Guide</span>
        </div>
    </div>
    <div id="section-content">
        <div class="section" id="section-guide">
        	<?php echo $section_content_guide; ?>
        </div>
        <div class="section" id="section-plan">
        	<?php echo $section_content_plan; ?>
        </div>
        <div class="section" id="section-map">
        	<?php echo $section_content_map; ?>
        </div>
    </div>
</div>

<script>
	<!-- START: [tab] -->
		function showTab(id) {
			$('.section-tab-button').removeClass('active');
			$('#section-tab-'+id).addClass('active');
			$('.section').hide();
			$('#section-'+id).show();
			if(id == 'plan') {
				<!-- START: go to selected day if any -->
					var day_id = $('#section-day-bar-form input[name=day_id]').val();
					if(day_id != '') {
						showPlanDay(day_id);
					}
				<!-- END -->
				$('#wrapper-title').removeClass('hidden');
				$('#wrapper-button-search').addClass('hidden');
				$('#wrapper-button-save').removeClass('hidden');
			}
			else if(id == 'map') {
				$('#wrapper-title').removeClass('hidden');
				$('#wrapper-button-search').addClass('hidden');
				$('#wrapper-button-save').removeClass('hidden');
				initMap();
			}
			else {
				reset_guide();
				refresh_guide(); 
				
				<!-- START: select last day if no day_id -->
					var day_id = $('#section-day-bar-form input[name=day_id]').val();
					if(day_id == '') {
						day_id = $('.plan-day-form-hidden input[name=day_id]').last().val();
						selectDay(day_id);
					}
				<!-- END -->
				
				$('#wrapper-title').removeClass('hidden');
				$('#wrapper-button-search').addClass('hidden');
				$('#wrapper-button-save').removeClass('hidden');
				/*
				$('#wrapper-title').addClass('hidden');
				$('#wrapper-button-search').removeClass('hidden');
				$('#wrapper-button-save').addClass('hidden');
				*/
			}
		}
		
		function initTab() {
			<?php if($this->request->get_or_post('tab')) { ?>
				showTab("<?php echo $this->request->get_or_post('tab'); ?>");
			<?php } else { ?>
				showTab('guide'); //default browser tab
			<?php } ?>
		}
	<!-- END -->
	
	<!-- START: [day] -->
		function setDay() {
			var day = getCookie('day');
			var day_id;
			var sort_order;
			if(day == '') {
				var day_length = $('.plan-day-form-hidden').length;
				if(day_length == 0) {
					$('#section-day-bar').hide();
				}
				else {
					$('#section-day-bar').show();
					if($('#section-day-bar-form input[name=day_id]').val() == '') { //set first day as default
						day_id = $('.plan-day-form-hidden input[name=day_id]').first().val();
						selectDay(day_id);
					}
				}
			}
			else {
				day = JSON.parse(day);
				selectDay(day.day_id);
			}
		}
		
		function selectDay(day_id) {
			var sort_order = $('#plan-day-'+day_id+'-form-hidden input[name=sort_order]').val();
			$('#section-day-bar-title').html('Day '+sort_order+' <i class="fa fa-fw fa-caret-down"></i>');
			$('#section-day-bar-form input[name=day_id]').val(day_id);
			$('#section-day-bar-form input[name=sort_order]').val(sort_order);
			
			$('.plan-day-tr').removeClass('selected');
			$('#plan-day-'+day_id+'-tr').addClass('selected').trigger("selectedDayChanged");
			
			
			saveDayCookie(day_id,sort_order);
			showPlanDay(day_id);
			
			if($('.plan-day-form-hidden input[name=day_id]').first().val() == $('.plan-day-form-hidden input[name=day_id]').last().val()) {
				$('#section-day-bar-button-empty').hide();
				$('#section-day-bar-button-previous-day').show();
				$('#section-day-bar-button-previous-day').addClass('disabled');
				$('#section-day-bar-button-all-day').removeClass('disabled');
				$('#section-day-bar-button-next-day').show();
				$('#section-day-bar-button-next-day').addClass('disabled');
				$('#section-day-bar-button-add-day').hide();
			}
			else if($('#plan-day-'+day_id+'-form-hidden input[name=day_id]').val() == $('.plan-day-form-hidden input[name=day_id]').first().val()) {
				$('#section-day-bar-button-empty').hide();
				$('#section-day-bar-button-previous-day').show();
				$('#section-day-bar-button-previous-day').addClass('disabled');
				$('#section-day-bar-button-all-day').removeClass('disabled');
				$('#section-day-bar-button-next-day').show();
				$('#section-day-bar-button-next-day').removeClass('disabled');
				$('#section-day-bar-button-add-day').hide();
			}
			else if($('#plan-day-'+day_id+'-form-hidden input[name=day_id]').val() == $('.plan-day-form-hidden input[name=day_id]').last().val()) {
				$('#section-day-bar-button-empty').hide();
				$('#section-day-bar-button-previous-day').show();
				$('#section-day-bar-button-previous-day').removeClass('disabled');
				$('#section-day-bar-button-all-day').removeClass('disabled');
				$('#section-day-bar-button-next-day').show();
				$('#section-day-bar-button-next-day').addClass('disabled');
				$('#section-day-bar-button-add-day').hide();
			}
			else {
				$('#section-day-bar-button-empty').hide();
				$('#section-day-bar-button-previous-day').show();
				$('#section-day-bar-button-previous-day').removeClass('disabled');
				$('#section-day-bar-button-all-day').removeClass('disabled');
				$('#section-day-bar-button-next-day').show();
				$('#section-day-bar-button-next-day').removeClass('disabled');
				$('#section-day-bar-button-add-day').hide();
			}
		}
		
		function selectAllDay() {
			showTab('plan');
			$('#section-day-bar-button-empty').show();
			$('#section-day-bar-button-previous-day').hide()
			$('#section-day-bar-button-all-day').addClass('disabled');
			$('#section-day-bar-button-next-day').hide();
			$('#section-day-bar-button-add-day').show();
			$('#section-day-bar-title').html('All Days');
			$('#section-day-bar-form input[name=day_id]').val('');
			$('#section-day-bar-form input[name=sort_order]').val('');
			setCookie('day','',0);
			showPlanDay('');
		}
		
		function selectPreviousDay() {
			var day = new Array;
			var day_id = $('#section-day-bar-form input[name=day_id]').val();
			$('.plan-day-form-hidden input[name=day_id]').each(function() {
				value = $(this).val();
				day.push(value);
			});
			var i = 0;
			var previous_day_id = false;
			while(previous_day_id == false) {
				if(day[i] == day_id) {
					previous_day_id = day[i-1];
				}
				i = i + 1;
			}
			selectDay(previous_day_id);
		}
		
		function selectNextDay() {
			var day = new Array;
			var day_id = $('#section-day-bar-form input[name=day_id]').val();
			if(day_id == '') {
				//select first day
				day_id = $('.plan-day-form-hidden input[name=day_id]').first().val();
				selectDay(day_id);
			}
			else {
				$('.plan-day-form-hidden input[name=day_id]').each(function() {
					value = $(this).val();
					day.push(value);
				});
				var i = 0;
				var next_day_id = false;
				while(next_day_id == false) {
					if(day[i] == day_id) {
						next_day_id = day[i+1];
					}
					i = i + 1;
				}
				selectDay(next_day_id);
			}
		}
		
		function selectAddDay() {
		}
		
		function saveDayCookie(day_id,sort_order) {
			var day_id = $('#section-day-bar-form input[name=day_id]').val();
			var sort_order = $('#section-day-bar-form input[name=sort_order]').val();
			var day = {'day_id':day_id,'sort_order':sort_order};
			day = JSON.stringify(day);
			setCookie('day',day,7);
		}
		
		$('#section-day-bar-button-all-day').on('click',function() {
			selectAllDay();
		});
		$('#section-day-bar-button-previous-day').on('click',function() {
			selectPreviousDay();
		});
		$('#section-day-bar-button-next-day').on('click',function() {
			selectNextDay();
		});
		$('#section-day-bar-button-add-day').on('click',function() {
			selectAddDay();
		});
	<!-- END -->
	
	<!-- START: [hint] for first timer -->
		function showHintAlert() {
			$('#section-hint').removeClass('hidden');
			var height = 'calc(100vh - 48px - 3px - 40px - 40px - 70px)';
			$('#section-content').css('height',height);
			$('#section-guide').css('min-height',height);
			$('#section-plan').css('min-height',height);
			$('#section-map').css('min-height',height);
			$('#map').css('min-height',height);
		}
		
		function hideHintAlert() {
			$('#section-hint').addClass('hidden');
			var height = 'calc(100vh - 48px - 3px - 40px - 40px)';
			$('#section-content').css('height',height);
			$('#section-guide').css('min-height',height);
			$('#section-plan').css('min-height',height);
			$('#section-map').css('min-height',height);
			$('#map').css('min-height',height);
		}
		/*
		<?php if($this->session->data['memory'] == 'cookie') { ?>
			showHintAlert();
		<?php } else { ?>
			hideHintAlert();
		<?php } ?>
		*/
		hideHintAlert();
	<!-- END -->
</script>