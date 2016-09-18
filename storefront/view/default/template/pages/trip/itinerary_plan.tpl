<style>
	/* START: [section] */
		#section-content-itinerary {
			position:relative;
		}
		
		#section-content-itinerary-header {
			border-bottom:solid thin #DDD;
			height:50px;
		}
		
		#section-content-itinerary-header {
			position:relative;
			overflow-y:scroll;
			overflow-x:hidden;
			direction:rtl;
		}
		
		#section-content-itinerary-header > div {
			direction:ltr;
		}
		
		#section-content-itinerary-header::-webkit-scrollbar {
			background:transparent;
		}
		
		#section-content-itinerary-header::-webkit-scrollbar-thumb {
			background:rgba(255,0,0,0.1) !important;
		}
		
		#section-content-itinerary-header a {
			display:block;
			height:49px;
			padding:15px 22px;
		}
		
		#section-content-itinerary-header label {
			color:#333;
			font-size:11px;
		}
		
		#section-content-itinerary-header input {
			height:30px;
			margin:9px;
			color:#333;
			font-size:11px;
		}
		
		#section-content-itinerary-header-set-date {
			padding-left:7px;
		}
		
		#section-content-itinerary-content {
			position:relative;
		}
		
		#section-content-itinerary-content-modal-background {
			position:absolute;
			background-color:#000;
			opacity:0.2;
			width:100%;
			height:500px;
			z-index:1;
		}
		
		#plan-date-form-alert {
			font-size:11px;
		}
		
		#btn-search {
			border-radius: 10px;
			margin:8px 0;
			height:33px !important;
			padding:7px 10px !important;
			border:none;
		}
	/* END */
	
	/* START: [plan table] */
		.plan-table {
			text-align:left;
			font-size:11px;
			line-height:26px;
			color:#333;
		}
		
		.plan-thead {
			position:relative;
			overflow-y:scroll;
			overflow-x:hidden;
			direction:rtl;
		}
		
		.plan-thead > div {
			direction:ltr;
		}
		
		.plan-thead::-webkit-scrollbar {
		  background:transparent;
		}
		
		.plan-thead::-webkit-scrollbar-thumb {
		  background:rgba(255,0,0,0.1) !important;
		}
		
		.plan-tbody {
			position:relative;
		}
		
		.plan-thead {
			border-bottom:solid thin #DDD;
			font-weight:bold;
		}
		
		.plan-thead-tr.plan-tr {
			border-bottom:none;
		}
		
		.plan-form {
			overflow:hidden;
			cursor:pointer;
		}
		
		.plan-day-form {
			border-bottom:solid thin #DDD;
			background-color:#FFF;
		}
		
		/*
		.plan-form:hover {
			background-color:#EEE;
		}
		*/
		
		.plan-line-tr .plan-form {
			height:100px;
		}
		
		.plan-tr > .plan-th:last-of-type, .plan-form > .plan-td:last-of-type {
			float:right;
		}
		
		.plan-day-tr > .plan-form:last-of-type {
			border-bottom:none;
		}
		
		.plan-th, .plan-td {
			float:left;
			padding:7px;
		}
		
		.plan-th input, .plan-td input {
			height:26px;
		}
		
		.plan-btn {
			padding:2px 7px;
		}
		
		.plan-btn-tr {
			overflow:hidden;
			height:40px;
			padding:7px;
		}
		
		.plan-day-tr.selected {
			background-color:#FF6;
		}
		
		.plan-line-tr {
			height:110px;
			padding:5px 15px;
			margin-bottom:5px;
		}
		
		.plan-line-image {
			width:100px;
			height:100px;
			display:block;
			float:left;
			border-radius:7px 0px 0px 7px;
			background-color:#333;
			color:#CCC;
			text-align:center;
		}
		
		.plan-line-image i {
			margin-top:28px;
		}
		
		.plan-line-image img {
			border-radius:5px 0px 0px 5px;
		}
		
		.plan-line-form {
			position:relative;
			width:calc(100% - 100px);
			padding:7px;
			display:block;
			float:left;
			background-color:#FFF;
			border-radius:0px 5px 5px 0px;
		}
		
		.plan-line-tr .plan-td {
			padding:0;
			line-height:20px;
		}
		
		.plan-line-tr .plan-col-command {
			position:absolute;
			bottom:5px;
			right:0;
		}
		
		.plan-line-tr .plan-col-title {
			width:100%;
			font-weight:bold;
		}
		
		.plan-line-tr .plan-col-time {
			width:100%;
		}
		
		.plan-col-command .btn-simple {
			width:64px;
		}
		
		.plan-btn-add-line {
			padding:5px 15px;
			height:48px;
		}
		
		.plan-btn-add-line a {
			border:thin dashed #CCC;
			border-radius:5px;
		}
		
		.plan-btn-add-line a:hover {
			border:thin dashed #333;
			border-radius:5px;
		}
		
		.plan-btn-tr a {
			color:#777;
		}
		
		.plan-btn-tr a:hover {
			color:#333;	
		}
		
		.plan-btn-tr:hover {
			background-color:#EEE;
		}
		
		.plan-mobile-tr {
			background-color:transparent !important;
		}
		
		.plan-empty {
			width:100%;
			padding-top:50px;
			color:#999;
			text-align:center;
			font-size:14px;
			font-weight:bold;
			display:none;
		}
	/* END */
	
	/* START: itinerary table row */
		.backup {
			background-color:#DDD;
		}
		
		.progress {
			width:45px;
			height:14px;
			margin:6px 0;
		}
		
		.toggle {
			border-radius:2px;
			margin:6px 0;
		}
		
		.toggle-on, .toggle-off {
			font-size:9px;
			padding:3px 0;
		}
		
		.action-button span{
			font-size: 0.8em !important;
		}
		
		.action-button a {
			margin:2px 0;
			padding:0;
			height:30px;
			width:30px;
			text-align:center;
		}
		
		.poi-action-button a {
			margin:2px 0;
			padding:0;
			height:30px;
			width:30px;
			text-align:center;
		}
		
		.add-poi td {
			text-align:right;
			border:0 !important;
		}
	/* END */	
	
	/* START: [draggable effect] */
		.ui-draggable-placeholder-day {
			background-color: #EEE;
			text-align: center;
			height: 41px;
			line-height:26px;
			padding:7px;
			border-bottom:solid thin #DDD;
		}
		
		.ui-draggable-placeholder {
			background-color: rgba(220,220,220,0.3);
			height: 115px;
			text-align: center;
			border-top:solid thin #DDD;
			border-bottom:solid thin #DDD;
		}
		
		.ui-draggable-helper {
			height: 40px;
			background-color: white;
			opacity: 0.5;
			font-size: 11px;
			text-align:center;
			border: medium dotted #666;
		}
		
		.drophover {
			background-color: #FC3 !important;
		}
		
	/* END */
	
	/* START: hint helper popover*/	
		#hint-popover{
			position:absolute;
			bottom: 20px;
			right: 30px;
			height:auto;
			min-width: 100px;
			background-color: rgba(0,0,0,0.7);
			border: thin #FFF solid;
			border-radius : 5px;
			color:#FFF;
			padding: 5px;
			display: none;
			z-index: 10;
		}
	/* END */		
</style>

<!-- START: [not edit mode] -->
    <?php if($this->session->data['mode'] != 'edit') { ?>
        <style>
            .icon-edit,
			.icon-delete,
			.icon-sort,
			.plan-btn-tr,
			#section-content-guide-button-add,
			#section-content-guide-button-add-text
			{
                display:none !important;
            }
        </style>
    <?php } ?>
<!-- END -->

<div id="section-content-itinerary">
	<div id="section-content-itinerary-header">
    	<div id="section-content-itinerary-header-content">
            <div id="section-content-itinerary-header-button">
            	<a id='btn-search' class="btn btn-primary pull-left noselect"><i class="fa fa-fw fa-search"></i> Discover</a>
                <?php if($this->session->data['mode'] == 'edit') { ?>
                	<a class="btn-show-date-form pull-right noselect">Set Date</a>
                <?php } ?>
            </div>
            <div id="section-content-itinerary-header-set-date" class="text-left hidden">
            	<form id="plan-date-form">
                    <label>Start :</label>
                    <input type="date" name="travel_date" min="" max=""/>
                    <label class="input-last-date">End :</label>
                    <input class="input-last-date" type="date" name="last_date" min="" max="" required/>
                    <span id='plan-date-form-alert'></span>
                    <a class="btn-save-date-form pull-right noselect btn-primary">Done</a>
                	<a class="btn-cancel-date-form pull-right noselect btn-default">Cancel</a>
                </form>
                <form id="plan-date-form-hidden" class="hidden">
                    <input type="date" name="travel_date"/>
                    <input type="date" name="last_date"/>
                    <input name="num_of_day"/>
                </form>
            </div>
        </div>
    </div>
    <div id="section-content-itinerary-content">
    	<div id="hint-popover"><span></span></div>
    	<div id="section-content-itinerary-content-modal-background" class="hidden"></div>
    	<div class='plan-table' id='plan-table'>
        	<div class='plan-thead'>
            	<div class='plan-thead-tr plan-tr'>
                    <?php
                        foreach($column as $c) {
                            echo '<div ';
                                echo 'style="';
                                    echo 'text-align:'.$c['headerAlign'].';';
                                    echo 'width:'.$c['width'].';';
                                    echo $c['headerStyle'];
                                echo '" ';
                                echo 'class="';
                                    echo 'plan-th ';
                                    if($c['visible'] == 'false') { echo 'hidden '; }
                                    echo $c['class'];
                                echo '" ';
                            echo '>';
                            echo $c['title'];
                            echo '</div>';
                        }
                    ?>
                </div>
            </div>
            <div class='plan-tbody'>
            	<div class='plan-day'>
            	</div>
                <div class="plan-no-day plan-empty">No plan</div>
                <div class="plan-no-activity plan-empty">No activity in this day</div>
            </div>
        </div>
    </div>
</div>

<script>
	<!-- START: script for manage display -->
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
					printButtonAddLine(column, "#plan-day-" + this.day_id + "-content");
				});
				printButtonAddDay(column);
			<!-- END -->
			
			<!-- START: init function -->
				updatePlanTableButtonEvent();
				updateDateFormButtonEvent();
				initSortableDay();
				initSortableLine();
				//updateSectionLimiter();
			<!-- END -->
			
			<!-- START: end loading -->
				swithMobileMode();
				setDay();
				initTab();
				$('#wrapper-splash').fadeOut();
			<!-- END -->
		}
	<!-- END -->
	
	<!-- START: script to print on screen -->
		function printDate(data) {
			var travel_date;
			var last_date;
			var day;
			var month;
			var num_of_day;
			
			if(typeof data.travel_date != 'undefined' && data.travel_date != null && data.travel_date != '') {
				date = new Date(data.travel_date);
				num_of_day = data.day.length; 
				
				travel_date = date;
				day = ("0" + travel_date.getDate()).slice(-2);
				month = ("0" + (travel_date.getMonth() + 1)).slice(-2);
				travel_date = travel_date.getFullYear() + "-" + (month) + "-" + (day) ;
				
				last_date = new Date(date.setDate(date.getDate() + num_of_day - 1));
				day = ("0" + last_date.getDate()).slice(-2);
				month = ("0" + (last_date.getMonth() + 1)).slice(-2);
				last_date = last_date.getFullYear() + "-" + (month) + "-" + (day) ;
				
				$('#plan-date-form input[name=travel_date]').val(travel_date);
				$('#plan-date-form input[name=last_date]').val(last_date);
				$('#plan-date-form-hidden input[name=travel_date]').val(travel_date);
				$('#plan-date-form-hidden input[name=last_date]').val(last_date);
				$('#plan-date-form-hidden input[name=num_of_day]').val(data.day.length);
			}
		}
		
		function printDay(column, day, day_raw) {
			<!-- START: set html_plan_form -->
				var html_plan_form = '';
				$.each(column, function(i, col) {
					<!-- START: select <td> property -->
						if(typeof col.dayId != 'undefined') { col.id = col.dayId; }
						if(typeof col.dayName != 'undefined') { col.name = col.dayName; }
						if(typeof col.dayClass != 'undefined') { col.class = col.dayClass; }
					<!-- END -->
					<!-- START: set <td> property -->
						html_plan_form += "<div ";
							html_plan_form += "id='plan-day-" + day.day_id + "-col-" + col.id + "' ";
							html_plan_form += 'class="';
								html_plan_form += 'plan-day-td plan-td ';
								if(typeof col.class != 'undefined') { html_plan_form += col.class+' '; }
								if(col.visible == 'false') { html_plan_form += 'hidden '; }
							html_plan_form += '" ';
							html_plan_form += 'style="';
								if(typeof col.dayStyle != 'undefined') { html_plan_form += col.dayStyle; }
								if(col.align != '') { html_plan_form += 'text-align:' + col.align + ';'; }
								if(col.width != '') { html_plan_form += 'width:' + col.width + ';'; }
							html_plan_form += '" ';
						html_plan_form += ">";
					<!-- END -->
					<!-- START: set <td> value -->
						if(col.type == 'progress') {
							html_plan_form += ""
								+ "<div class='progress'>"
									+ "<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='" + day[col.name] + "' aria-valuemin='0' aria-valuemax='100' style='width:" + (day[col.name]/(60*12))*100 + "%'>"
									+ "</div>"
								+ "</div>"
							;
						}
						else if(col.type == 'input') {
							html_plan_form += ""
								+ "<input "
									+ "id='plan-day-" + day.day_id + "-col-" + col.id + "-input' "
									+ 'name="' + col.name + '" '
									+ "value='" + day[col.name] + "'"
								+ "/>"
							;
						}
						else {
							if(typeof day[col.name] != 'undefined') {
								html_plan_form += day[col.name];
							}
						}
					<!-- END -->
					<!-- START: close <td> -->
						html_plan_form += "</div>";
					<!-- END -->
					
				});
			<!-- END -->
			
			<!-- START: [hidden form] -->
				var html_plan_form_hidden = "";
				$.each(column, function(i, col) {
					html_plan_form_hidden += ""
						+ "<input "
							+ "id='plan-day-" + day.day_id + "-col-" + col.id + "-input-hidden' "
							+ 'name="' + col.name + '" '
							+ "class='plan-input-hidden hidden' "
							+ "value='" + day_raw[col.name] + "'"
						+ "/>"
					;
				});
			<!-- END -->
			
			<!-- START: set output for day -->
				var output_day = ""
					+ "<div class='plan-day-tr plan-tr' id='plan-day-" + day.day_id + "-tr'>"
						+ "<form class='plan-day-form plan-form'  id='plan-day-" + day.day_id + "-form'>"
							+ html_plan_form
						+ "</form>"
						+ "<form class='plan-day-form-hidden plan-form-hidden' id='plan-day-" + day.day_id + "-form-hidden'>"
							+ html_plan_form_hidden
						+ "</form>"
						+ "<div class='plan-day-content hidden' id='plan-day-" + day.day_id + "-content'>"
							+ "<div class='plan-day-line' id='plan-day-" + day.day_id + "-line'>"
							+ "<div class='target-sort-line hidden' style='height:5px;'></div>"
							+ "</div>"
						+ "</div>"
					+ "</div>"
				;
			<!-- END -->
			<!-- START: set output for command -->
				var output_command = ""
					+ "<div>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-select' onclick='selectDay("+day.day_id+");'>"
							+ "Select"
						+ "</a>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-sort icon-sort-day'>"
							+ "Move"
						+ "</a>"
						
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-delete icon-delete-day'>"
							+ "Delete"
						+ "</a>"
						/*
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-delete' data-toggle='confirmation-delete-day' data-id='plan-day-" + day.day_id+"-tr'>"
							+ "Delete"
						+ "</a>"
						*/
						/*
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-toggle-day'>"
							+ "<i class='fa fa-fw fa-chevron-circle-down' aria-hidden='true'></i>"
						+ "</a>"
						*/
					+ "</div>"
				;
			<!-- END -->
			
			<!-- START: print output for day -->
				$(".plan-day").append(output_day); 
			<!-- END -->
			
			<!-- START: print output for command -->
				$("#plan-day-" + day.day_id + "-col-command").html("");
				$("#plan-day-" + day.day_id + "-col-command").append(output_command);
			<!-- END -->
		}
		
		function printLine(column, line, line_raw) {
			<!-- START: set html_plan_form -->
				var html_plan_form = '';
				$.each(column, function(i, col) {
					<!-- START: select <td> property -->
						if(typeof col.lineId != 'undefined') { col.id = col.lineId; }
						if(typeof col.lineName != 'undefined') { col.name = col.lineName; }
						if(typeof col.lineClass != 'undefined') { col.class = col.lineClass; }
					<!-- END -->
					<!-- START: set <td> property -->
						html_plan_form += "<div ";
							html_plan_form += "id='plan-line-" + line.line_id + "-col-" + col.id + "' ";
							html_plan_form += 'class="';
								html_plan_form +='plan-line-td plan-td ';
								if(typeof col.class != 'undefined') { html_plan_form += col.class+' '; }
								if(col.visible == 'false') { html_plan_form += 'hidden '; }
							html_plan_form += '" ';
							html_plan_form += 'style="';
								if(typeof col.lineStyle != 'undefined') { html_plan_form += col.lineStyle; }
								if(col.align != '') { html_plan_form += 'text-align:' + col.align + ';'; }
								if(col.width != '') { html_plan_form += 'width:' + col.width + ';'; }
							html_plan_form += '" ';
						html_plan_form += ">";
					<!-- END -->
					<!-- START: set <td> text -->
						if(col.name == 'description') {
							if(typeof line[col.name] != 'undefined' && line[col.name] != null && line[col.name] != '') {
								html_plan_form += '<i class="fa fa-fw fa-ellipsis-h" data-toggle="tooltip" data-placement="bottom" title="'+line[col.name]+'"></i>';
							}
							else {
								html_plan_form += '<i class="fa fa-fw fa-ellipsis-h hidden" data-toggle="tooltip" data-placement="bottom"></i>';
							}
						}
						else if(col.name == 'note') {
							if(typeof line[col.name] != 'undefined' && line[col.name] != null && line[col.name] != '') {
								html_plan_form += '<i class="fa fa-fw fa-sticky-note" data-toggle="tooltip" data-placement="bottom" title="'+line[col.name]+'"></i>';
							}
							else {
								html_plan_form += '<i class="fa fa-fw fa-sticky-note hidden" data-toggle="tooltip" data-placement="bottom"></i>';
							}
						}
						else if(typeof line[col.name] != 'undefined' && line[col.name] != null) {
							html_plan_form += line[col.name];
						}
					<!-- END -->
					<!-- START: close <td> -->
						html_plan_form += "</div>";
					<!-- END -->
				});
			<!-- END -->
			
			<!-- START: set image -->
					if(typeof line['image_id'] != 'undefined' && line['image_id'] != null && line['image_id'] != '') {
						var html_plan_image = '<img id="image-'+line['image_id']+'" src="resources/image/cropped/'+line['image_id']+'.jpg" title="'+line['title']+'" alt="'+line['title']+'" width="100px">';
					}
					else {
						var html_plan_image = '<i class="fa fa-fw fa-4x fa-map-marker"></i>';
					}
			<!-- END -->
			
			<!-- START -->
				var html_plan_form_hidden='';
				$.each(column, function(i, col) {
					var value = line_raw[col.name];
					if(typeof value == 'undefined' || value == null || value == '') { value = ''; } 
					html_plan_form_hidden += ""
						+ "<input "
							+ "id='plan-line-" + line.line_id + "-col-" + col.id + "-input-hidden' "
							+ 'name="' + col.name + '" '
							+ "class='plan-input-hidden hidden' "
							+ "value='" + value + "'"
						+ "/>"
					;
				});
			<!-- END -->
			
			<!-- START: set output for line -->
				var output_line = ""
					+ "<div class='plan-line-tr row' id='plan-line-" + line.line_id + "-tr'>"
						+ "<div class='plan-line-image box-shadow' id='plan-line-" + line.line_id + "-image'>"
							+ html_plan_image
						+ "</div>"
						+ "<form class='plan-line-form plan-form box-shadow' id='plan-line-" + line.line_id + "-form'>"
							+ html_plan_form
						+ "</form>"
						+ "<form class='plan-line-form-hidden plan-form-hidden hidden' id='plan-line-" + line.line_id + "-form-hidden'>"
							+ html_plan_form_hidden
						+ "</form>"
					+ "</div>"
				;
			<!-- END -->
			
			<!-- START: set output for command -->
				var info_btn;
				var navigation = '';
				
				navigation = 'var type = $(\'#plan-line-'+line['line_id']+'-form-hidden input[name=type]\').val();';
				navigation += 'var type_id = $(\'#plan-line-'+line['line_id']+'-form-hidden input[name=type_id]\').val();';
				navigation += 'navigate_guide(type, type_id);';
				navigation += 'setTimeout(function() { $(\'#btn-search\').trigger(\'click\'); }, 100);';
				navigation += 'setTimeout(function() { $(\'#section-view-xs-list-guide a\').trigger(\'click\'); }, 100);';
				
				if(typeof line['type'] != 'undefined' && line['type'] != null && line['type'] != '') {
					info_btn = '<a class="plan-btn btn btn-simple" onclick="'+navigation+'">Read</a>';
				}
				else {
					info_btn = '<a class="plan-btn btn btn-simple hidden">Read</a>';
				}
				
				var output_command = ""
					+ "<div>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-sort icon-sort-line'>"
							+ "Move"
						+ "</a>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-delete icon-delete-line'>"
							+ "Delete"
						+ "</a>"
						/*
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-delete' data-toggle='confirmation-delete-line' data-id='plan-line-" + line.line_id+"-tr'>"
							+ "Delete"
						+ "</a>"
						*/
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-edit' data-toggle='modal' data-target='#modal-edit-line'>"
							+ "Edit"
						+ "</a>"
						+ info_btn
					+ "</div>"
				;
			<!-- END -->
			
			<!-- START: print output for line -->
				$("#plan-day-"+line.day_id+"-line").append(output_line); 
			<!-- END -->
			
			<!-- START: print output for command -->
				$("#plan-line-" + line.line_id + "-col-command").html("");
				$("#plan-line-" + line.line_id + "-col-command").append(output_command);
			<!-- END -->
			
			<!-- START: initiate tooltip -->
				$('.fa-ellipsis-h').tooltip();
				$('.fa-sticky-note').tooltip();
				$('.fa-info-circle').tooltip();
			<!-- END -->
			
			<!-- START: temporary code (to be replaced) -->
				//$('.icon-edit').hide();
			<!-- END -->
		}
		
		function printButtonAddLine(column, plan_day_content) {
			<!-- START: set output -->
				var output = ""
					+"<div class='plan-btn-add-line plan-btn-tr'>"
						+ "<a class='text-center btn-block' data-toggle='modal' data-target='#modal-edit-line'>"
							+ "<i class='fa fa-plus' aria-hidden='true'></i> &nbsp;&nbsp;"
							+ "Add New Activity"
						+ "</a>"
					+"</div>"
				;
			<!-- END -->
			
			<!-- START: print output -->
				$(plan_day_content).append(output); 
			<!-- END -->
		}
		
		function printButtonAddDay(column) {
			<!-- START: set output -->
				var output = ""
					+"<div class='plan-btn-add-day plan-btn-tr '>"
						+ "<a class='text-center btn-block'>"
							+ "<i class='fa fa-plus' aria-hidden='true'></i> &nbsp;&nbsp;"
							+ "Add New Day"
						+ "</a>"
					+"</div>"
					<!-- DIV for additional space below the table, better layout-->
					+ "<div style='height:100px; bottom:0px;'></div>"        
                
				;
			<!-- END -->
			
			<!-- START: print output -->
				$(".plan-tbody").append(output); 
			<!-- END -->
		}
	<!-- END -->
	
	<!-- START: [data format] -->
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
							if(hour >= 1) {
								minute = ("0" + minute).slice(-2);
								plan.day[i].line[j].duration = hour+'h '+minute+'m';
							}
							else {
								plan.day[i].line[j].duration = minute+'m';
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
	<!-- END -->
	
		<!-- START: [date form] -->
			function showDateForm() {
				$("#section-content-itinerary-header-button").addClass("hidden");
				$("#section-content-itinerary-header-set-date").removeClass("hidden");
				$("#section-content-itinerary-content-modal-background").removeClass("hidden");
				$('#plan-date-form-hidden input[name=num_of_day]').val($('.plan-day-tr').length);
				refreshDateForm();
				//$("#section-content-itinerary-content-modal-background").off().on("click", cancelDateForm);
			}
			
			function hideDateForm() {
				$("#section-content-itinerary-header-button").removeClass("hidden");
				$("#section-content-itinerary-header-set-date").addClass("hidden");
				$("#section-content-itinerary-content-modal-background").addClass("hidden");
				$("#section-content-itinerary-content-modal-background").off();
			}
			
			function saveDateForm() {
				var updated = false;
				if($('#plan-date-form-hidden input[name=travel_date]').val != $('#plan-date-form input[name=travel_date]').val()) {
					updated = true;
				}
				
				$('#plan-date-form-hidden input[name=travel_date]').val($('#plan-date-form input[name=travel_date]').val());
				$('#plan-date-form-hidden input[name=last_date]').val($('#plan-date-form input[name=last_date]').val());
				var day_difference = parseInt($('#plan-date-form-hidden input[name=num_of_day]').val()  - $('.plan-day-tr').length);
				if(day_difference > 0) {
					updated = true;
					for(i=0;i<day_difference;i++) {
						setTimeout(function() {
							addPlanDay();
						}, 10);
					}
				}
				
				if(updated == true) {
					updatePlanTableDayDate();
					<?php if($this->session->data['memory'] == 'cookie') { ?>
						updatePlanTableCookie();
						showHint('Date updated');
					<?php } else { ?>
						<!-- START: set data -->
							var data = {
								"action":"edit_plan_date",
								"plan_id":"<?php echo $plan_id; ?>",
								"travel_date":$('#plan-date-form-hidden input[name=travel_date]').val()
							};
						<!-- END -->
					
						<!-- START: send POST -->
							$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
								if(typeof json.warning != 'undefined') {
									showHint(json.warning);
								}
								else if(typeof json.success != 'undefined') {
									showHint(json.success);
								}
							}, "json");
						<!-- END -->
					<?php } ?>
				}
				hideDateForm();
			}
			
			function cancelDateForm() {
				$('#plan-date-form input[name=travel_date]').val($('#plan-date-form-hidden input[name=travel_date]').val());
				$('#plan-date-form input[name=last_date]').val($('#plan-date-form-hidden input[name=last_date]').val());
				hideDateForm();
			}
			
			function refreshDateForm() {
				<!-- START: get variable -->
					var first_date = $('#plan-date-form-hidden input[name=travel_date]').val();
					var num_of_day = $('.plan-day-tr').length;
					var last_date = calculateNewLastDate(num_of_day);
				<!-- END -->
				<!-- START: set unit -->
					if(num_of_day > 1) { 
						day_unit = 'days'; 
					}
					else { 
						day_unit = 'day'; 
					}
				<!-- END -->
				<!-- START: print alert -->
					$('#plan-date-form input[name=travel_date]').val(first_date);
					$('#plan-date-form input[name=last_date]').val(last_date);
					$('#plan-date-form-hidden input[name=last_date]').val(last_date);
					$('#plan-date-form-alert').html('Total ' + num_of_day + '&nbsp;' + day_unit);	
					$('#plan-date-form-hidden input[name=num_of_day]').val(num_of_day);
				<!-- END -->
				<!-- START: set max and min for input -->
					var today = new Date();
					var dd = today.getDate();
					var mm = today.getMonth()+1;
					var yyyy = today.getFullYear();
					if(dd<10){
						dd='0'+dd
					} 
					if(mm<10){
						mm='0'+mm
					}
					today = yyyy+'-'+mm+'-'+dd;
					
					date = new Date($('#plan-date-form input[name=travel_date]').val());
					min_last_date = new Date(date.setDate(date.getDate() + $('.plan-day-tr').length - 1));
					day = ("0" + min_last_date.getDate()).slice(-2);
					month = ("0" + (min_last_date.getMonth() + 1)).slice(-2);
					min_last_date = min_last_date.getFullYear() + "-" + (month) + "-" + (day);
					
					$('#plan-date-form input[name=travel_date]').attr('min',today);
					$('#plan-date-form input[name=last_date]').attr('min',min_last_date);
				<!-- END -->
			}
			
			function updateDateForm() {
				<!-- START: get variable -->
					var first_date = $('#plan-date-form input[name=travel_date]').val();
					var last_date = $('#plan-date-form input[name=last_date]').val();
					var num_of_day = parseInt($('#plan-date-form-hidden input[name=num_of_day]').val());
				<!-- END -->
				<!-- START: set max and min for input -->
					var today = new Date();
					var dd = today.getDate();
					var mm = today.getMonth()+1;
					var yyyy = today.getFullYear();
					if(dd<10){
						dd='0'+dd
					} 
					if(mm<10){
						mm='0'+mm
					}
					today = yyyy+'-'+mm+'-'+dd;
					
					date = new Date($('#plan-date-form input[name=travel_date]').val());
					min_last_date = new Date(date.setDate(date.getDate() + $('.plan-day-tr').length - 1));
					day = ("0" + min_last_date.getDate()).slice(-2);
					month = ("0" + (min_last_date.getMonth() + 1)).slice(-2);
					min_last_date = min_last_date.getFullYear() + "-" + (month) + "-" + (day);
					
					$('#plan-date-form input[name=travel_date]').attr('min',today);
					$('#plan-date-form input[name=last_date]').attr('min',min_last_date);
				<!-- END -->
				
				if(first_date == '') {
					$('#plan-date-form input[name=last_date]').val('');
					$('.input-last-date').addClass('hidden');
				}
				else if(first_date != '' && last_date == '') {
					new_last_date = calculateNewLastDate(num_of_day);
					$('#plan-date-form input[name=last_date]').val(new_last_date);
					$('.input-last-date').removeClass('hidden');
				}
				else if(first_date > last_date) {
					new_last_date = calculateNewLastDate(num_of_day);
					$('#plan-date-form input[name=last_date]').val(new_last_date);
				}
				else {
					var one_day = 24*60*60*1000;
					var firstDate = new Date(first_date);
					var secondDate = new Date(last_date);
					var new_num_of_day = Math.round(Math.abs((firstDate.getTime() - secondDate.getTime())/(one_day))) + 1;
					if(new_num_of_day <= $('#plan-date-form-hidden input[name=num_of_day]').val()) {
						if(this.name == 'last_date') {
							num_of_day = new_num_of_day;
						}
						else {
							new_last_date = calculateNewLastDate(num_of_day);
							$('#plan-date-form input[name=last_date]').val(new_last_date);
							num_of_day = $('#plan-date-form-hidden input[name=num_of_day]').val();
						}
					}
					else {
						num_of_day = new_num_of_day;
					}
				}
				
				<!-- START: set unit -->
					if(num_of_day > 1) { 
						day_unit = 'days'; 
					}
					else { 
						day_unit = 'day'; 
					}
				<!-- END -->
				<!-- START: print alert -->
					$('#plan-date-form-alert').html('Total ' + num_of_day + '&nbsp;' + day_unit);
					$('#plan-date-form-hidden input[name=num_of_day]').val(num_of_day);
				<!-- END -->
			}
			
			function calculateNewLastDate(num_of_day) {
				var date;
				var day;
				var month;
				var new_last_day;
				var day_unit;
				
				date = new Date($('#plan-date-form input[name=travel_date]').val());
				new_last_date = new Date(date.setDate(date.getDate() + num_of_day - 1));
				day = ("0" + new_last_date.getDate()).slice(-2);
				month = ("0" + (new_last_date.getMonth() + 1)).slice(-2);
				return new_last_date = new_last_date.getFullYear() + "-" + (month) + "-" + (day);
			}
		<!-- END -->
		
		function toggleDay() {
			var selected_day = $(this).closest(".plan-day-tr").attr("id");
			if($("#" + selected_day).hasClass("selected") == true && $("#" + selected_day + " .plan-day-content").hasClass("hidden") == false) {
				$(".plan-day-content").addClass("hidden");
				$(".fa-chevron-circle-down").removeClass("fa-flip-vertical");
			}
			else {
				$(".plan-day-tr").removeClass("selected");
				$(".plan-day-content").addClass("hidden");
				$(".fa-chevron-circle-down").removeClass("fa-flip-vertical");
				$("#" + selected_day).toggleClass("selected");
				$("#" + selected_day + " .plan-day-content").toggleClass("hidden");
				$("#" + selected_day + " .fa-chevron-circle-down").toggleClass("fa-flip-vertical");
				// Map refresh trigger
				$(".plan-day-tr").trigger('selectedDayChanged');
				
			}
		}
		
		function initSortableDay () {	
				$(".plan-day").sortable({	
					delay: 100,
					axis: "y",
					items: ">.plan-day-tr", 
					cancel: ">.plan-line-tr",
					handle: ".icon-sort-day",
					appendTo: "parent",	
					containment: ".plan-table",
					scrollSpeed: 10,
					cursorAt: {
						top: 15
					},
					helper: function(event, ui) {
						return $('<div style="white-space:nowrap; height:40px;"></div>');
					},
					placeholder: {
						element: function(currentItem) {
							return $("<div></div>");
						},
						update: function(container, p) {
							return;
						}
					},
					start: function(e, ui) {
						$(".plan-day").sortable("refreshPositions");
						$(ui.helper).addClass("ui-draggable-helper");
						$(ui.placeholder).addClass("ui-draggable-placeholder-day");	
						$(document).trigger("sortStart");	
					},
					sort: function(event, ui) {
						var to_day_text;
						var from_index = $(ui.item).index();
						var to_index = $(ui.placeholder).index();
						$(ui.helper).html(ui.item.find(".plan-col-day").html());
						if ( from_index > to_index) { 
							to_day_text = $(ui.placeholder).next(".plan-day-tr").find(".plan-col-day").html();
							$(ui.placeholder).html("Reschedule to " + to_day_text);	
						}
						else {
							to_day_text = $(ui.placeholder).prev(".plan-day-tr").find(".plan-col-day").html();
							$(ui.placeholder).html("Reschedule to " + to_day_text);	
						}					
					},
					receive: function( event, ui ) {
						var sender_id = ui.sender.attr("id");
						alert(ui.position[0].top);
					},
					stop: function( event, ui ) {
						updatePlanTableDayDate();
						<?php if($this->session->data['memory'] == 'cookie') { ?>
							updatePlanTableCookie();
							showHint('Day sorted');
						<?php } else { ?>
							var day = new Array();
							var day_id;
							var sort_order;
							var order;
							
							$('.plan-day-form-hidden').each(function() {
								day_id = $(this).find('input[name=day_id]').val();
								sort_order = $(this).find('input[name=sort_order]').val();
								day.push({"day_id":day_id,"sort_order":sort_order});
							});
							order = JSON.stringify(day);
							<!-- START: set data -->
								var data = {
									"action":"sort_day",
									"order":order
								};
							<!-- END -->
						
							<!-- START: send POST -->
								$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
									if(typeof json.warning != 'undefined') {
										showHint(json.warning);
									}
									else if(typeof json.success != 'undefined') {
										showHint('Day sorted');
									}
								}, "json");
							<!-- END -->
						<?php } ?>
						$(document).trigger("sortStop");
					}
				}).disableSelection();
			
			<?php if($this->session->data['mode'] != 'edit') { ?>
				$('.plan-day').sortable("destroy");
			<?php } ?>
		}
		
		function initSortableLine() {
			var from_row_day_id;
			var to_row_day_id;
			var drop_id_to_sortable;
			
			
			$(".plan-day-tr").droppable({
				accept: ".plan-line-tr",
				hoverClass: "drophover",
				over: function( event, ui ) {
					var current_drag_id = $(ui.draggable).parent().attr("id");
					var current_over_id = $(this).find(".plan-day-line").attr("id");
					var current_drag_activities_text = $("#"+current_drag_id).find(".plan-col-activity").html();					
					var current_over_day_text = $("#"+current_over_id).parent().parent().find(".plan-col-day").html();
					// Remove hover when it is into same day.
					if (current_over_id == current_drag_id) {
						$(".drophover").not(".plan-line-tr").removeClass("drophover");
					}

					else {
						$(ui.helper).html("Drop "+ current_drag_activities_text +" > " + current_over_day_text);
					}
				},
				drop: function( event, ui ) {
					var drop_id = $(this).find(".plan-day-line").attr("id");
					drop_id_to_sortable = drop_id;	
					$(".plan-day-tr").droppable("disable");
				}
			});

								
			$(".plan-day-line").sortable({
				handle: ".icon-sort-line",
				delay: 100,
				axis: "y",
				items: ">.plan-line-tr",
				appendTo: "parent",
				containment: ".plan-table",
				scrollSpeed: 10,
				cursorAt: { 
					top: 15
				},
				helper: function(event, ui) {
					return $('<div style="white-space:nowrap; height:40px;"></div>');
				},
				placeholder: {
					element: function(currentItem) {
						return $("<div></div>");
					},
					update: function(container, p) {
						return;
					}
				},
				start: function(e, ui) {
					$(ui.helper).addClass("ui-draggable-helper");
					$(ui.placeholder).addClass("ui-draggable-placeholder");
					//map trigger sortstart
					$(document).trigger("sortStart");
				},
				over: function(e, ui) {
					$(".plan-day-tr").droppable("disable");
					$(ui.helper).html(ui.item.find(".plan-col-title").html());
					$(".drophover").removeClass("drophover");
				},
				out: function(e, ui) {
					$(".plan-day-tr").droppable("enable");
				},
				sort: function(event, ui) {
					var day = $(ui.placeholder).closest(".plan-day-tr").attr("id");
					day_sort_order = $("#" + day + " .col-sort-order").html();
					$(ui.placeholder).children("div").html("Drop into D"+ day_sort_order);
					to_row_day_id = $(ui.placeholder).prev().attr("id");	
				},
				stop: function( event, ui ) {
					//drop activieties into the day.
					$(ui.item).appendTo("#"+drop_id_to_sortable);
					//ensure hoverclass is not active after drop.
					$(".drophover").removeClass("drophover");
					updatePlanTableLineDayIdAndSortOrder();
					updatePlanTableDayDuration();
					
					$( ".plan-day-tr" ).droppable( "destroy" );
					initSortableLine();
					

					<?php if($this->session->data['memory'] == 'cookie') { ?>
						updatePlanTableCookie();
						showHint('Activity sorted');
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
							$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
								if(typeof json.warning != 'undefined') {
									showHint(json.warning);
								}
								else if(typeof json.success != 'undefined') {
									showHint('Activity sorted');
								}
							}, "json");
						<!-- END -->
					<?php } ?>

					$(document).trigger("sortStop");
				}
			}).disableSelection();
			
			<?php if($this->session->data['mode'] != 'edit') { ?>
				$('.plan-day-tr').droppable("destroy");
				$('.plan-day-line').sortable("destroy");
			<?php } ?>
		}
	<!-- END -->
	
	<!-- START: [update data] -->
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
				setCookie('plan',serial,7);
				//updateSectionLimiter();
			<?php } ?>
		}
		
		function updatePlanTableDayDate() {
			var travel_date = $('#plan-date-form input[name=travel_date]').val();
			var num_of_day = $('#plan-date-form-hidden input[name=num_of_day]').val();
			var day = new Array();
			var date;
			
			if(typeof travel_date != 'undefined' && travel_date != null && travel_date != '') {
				var first_date = new Date(travel_date);
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
				for (i=0; i<num_of_day; i++) {
					myDate = new Date(first_date.setDate(first_date.getDate() + 1));
					var myWeekday = weekday[myDate.getDay()];
					date = ("0" + myDate.getDate()).slice(-2) + "&nbsp;" + monthNames[(myDate.getMonth())] + "&nbsp;&nbsp;&nbsp;(" + myWeekday + ")";
					day.push(date);
				}
			}
			else {
				for (i=0; i<num_of_day; i++) {
					day.push('');
				}
			}
			
			$('.plan-day-tr').each(function(){
				var speed = 300;
				var index = $('.plan-day-tr').index(this) + 1;
				$(this).find(".plan-day-form .plan-col-sort-order").fadeOut(speed, function() {
					$(this).html(index).fadeIn(speed);
				});
				$(this).find(".plan-day-form-hidden").find('.plan-input-hidden[name=sort_order]').val(index);
				$(this).find(".plan-day-form .plan-col-day").fadeOut(speed, function() {
					$(this).html("D" +index).fadeIn(speed);
				});
				$(this).find(".plan-day-form .plan-col-date").fadeOut(speed, function() {
					$(this).html(day[index-1]).fadeIn(speed);
				});
				if($('#section-content-guide').is(':visible')) {
					minimizePlanTableColumn();
				}
			})
		}
		
		function updatePlanTableDayDuration() {
			var day_duration;
			var line_duration;
			var percentage;
			
			$('.plan-day-tr').each(function() {
				day_duration = 0;
				$(this).find('.plan-line-tr').each(function() {
					line_duration = $(this).find(".plan-line-form-hidden").find('.plan-input-hidden[name=duration]').val();
					if(typeof line_duration != 'undefined' && line_duration != null && line_duration != '') { 
						day_duration += parseInt(line_duration);
					}
				});
				$(this).find('.progress-bar').attr('value',day_duration);
				percentage = day_duration / (60*12) * 100;
				$(this).find('.progress-bar').css('width', percentage + "%");
			});
		}
		
		function updatePlanTableLineDayIdAndSortOrder() {
			var day_id;
			var index;
			$('.plan-day-tr').each(function() {
				index = 1;
				day_id = $(this).find('.plan-day-form-hidden').find('.plan-input-hidden[name=day_id]').val();
				$(this).find('.plan-line-tr').each(function() {
					$(this).find(".plan-line-form-hidden").find('.plan-input-hidden[name=day_id]').val(day_id);
					$(this).find(".plan-line-form-hidden").find('.plan-input-hidden[name=sort_order]').val(index);
					index += 1;
				});
			});
		}
		
		function updatePlanTableButtonEvent() {
			//$(".plan-day-form").off().on("click", toggleDay);
			// Function for delete Day & Line
			//deletePlanDay();
			//deletePlanLine();
			// Event Listener: Add Day and Add/ Edit Line
			$(".plan-btn-add-day").off().on("click", addPlanDay);
			$(".plan-btn-add-line").off().on("click", openAddPlanLineModal);
			$('.icon-edit').off().on('click', function() {
				var line = $(this).closest('.plan-line-tr').attr('id');
				openEditPlanLineModal(line);
			});
			$('.icon-delete-day').off().on('click', function() {
				var day = $(this).closest('.plan-day-tr').attr('id');
				deletePlanDayTemporary(day);
			});
			$('.icon-delete-line').off().on('click', function() {
				var line = $(this).closest('.plan-line-tr').attr('id');
				deletePlanLineTemporary(line);
			});			
			//THIS MAY MOVE TO ANOTHER FUNCTION : Refresh sortable to new added day and activities
			$(".plan-day").sortable();
			$(".plan-day-line").sortable();
			$(".plan-day-tr").droppable();
		}
		
		function updateDateFormButtonEvent() {
			$(".btn-show-date-form").off().on("click", showDateForm);
			$(".btn-save-date-form").off().on("click", saveDateForm);
			$(".btn-cancel-date-form").off().on("click", cancelDateForm);
			$("#plan-date-form input[name=travel_date]").off().on("change", updateDateForm);
			$("#plan-date-form input[name=last_date]").off().on("change", updateDateForm);
		}
	<!-- END -->
	
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

	<!-- START: [edit day] -->
		function addPlanDay() {
			<!-- START: set common data -->
				var sort_order = parseInt($('.plan-day-tr').length) + 1;
			<!-- END -->
			<!-- START: save -->
				<?php if($this->session->data['memory'] == 'cookie') { ?>
					var day_id = 0;
					var i = 1;
					while(day_id < 1) {
						var check_id = $("#plan-day-" + i + "-tr").length;
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
						$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
							if(typeof json.warning != 'undefined') {
								showHint(json.warning);
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
		
		function deletePlanDay(){
			var selected_delete_id, hint_text, day_id, sort_order;
			$('[data-toggle=confirmation-delete-day').confirmation({
				container: "body",
				singleton: true,
				popout: true,
				title: "Confirm DELETE?",
				html: true,
				content: function (){
					selected_delete_id = $(this).attr('data-id');
					content_text ="";
					
					day_id = $('#'+selected_delete_id+' .plan-day-form-hidden input[name=day_id]').val();
					sort_order = $('#'+selected_delete_id+' .plan-day-form-hidden input[name=sort_order]').val();
					
					if ($("#" + selected_delete_id).find(".plan-line-tr").length > 0) {
						content_text += "<div class='alert alert-danger'>Day "+ sort_order 														
						content_text += " is not <strong>empty.</strong></div>"
					}
					else {
						content_text = "Day " + sort_order;
					}
					
					return content_text;
				},
				onConfirm: function () {
					if ($("#" + selected_delete_id).hasClass("plan-day-tr") && $(".plan-day-tr").length < 2) {
						content_text = "";
						showHint("Cannot be deleted. There must be at least one day.");
					}
					else {
						<?php if($this->session->data['memory'] == 'cookie') { ?>
							var data = { "day_id":day_id ,"sort_order":sort_order };
							$(this).confirmation('destroy');							
							$("#"+ selected_delete_id).remove();
							runDeletePlanDay(data);
						<?php } else { ?>
							<!-- START: set data -->
								var data = {
									"action":"delete_day",
									"day_id":day_id,
									"sort_order":sort_order
								};
							<!-- END -->
						
							<!-- START: send POST -->
								$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
									if(typeof json.warning != 'undefined') {
										showHint(json.warning);
									}
									else if(typeof json.success != 'undefined') {
										$(this).confirmation('destroy');							
										$("#"+ selected_delete_id).remove();
										runDeletePlanDay(data);
									}
								}, "json");
							<!-- END -->
						<?php } ?>
					}
				}
			});	
		}
		
		function deletePlanDayTemporary(day) {
			day_id = $('#'+day+' .plan-day-form-hidden input[name=day_id]').val();
			sort_order = $('#'+day+' .plan-day-form-hidden input[name=sort_order]').val();
			
			<!-- START: set previous day -->
				var day_list = new Array;
				var num_of_day = $('.plan-day-form-hidden').length;
				$('.plan-day-form-hidden input[name=day_id]').each(function() {
					value = $(this).val();
					day_list.push(value);
				});
				var i = 0;
				var target_day_id = false;
				if(day_id == $('.plan-day-form-hidden input[name=day_id]').first().val()) {
					<!-- START: select next day -->
						while(target_day_id == false && i <= num_of_day) {
							if(day_list[i] == day_id) {
								target_day_id = day_list[i+1];
							}
							i = i + 1;
						}
					<!-- END -->
				}
				else {
					<!-- START: select next day -->
						while(target_day_id == false && i <= num_of_day) {
							if(day_list[i] == day_id) {
								target_day_id = day_list[i-1];
							}
							i = i + 1;
						}
					<!-- END -->
				}
			<!-- END -->
			
			if ($("#" + day).hasClass("plan-day-tr") && $(".plan-day-tr").length < 2) {
					content_text = "";
					showHint("Cannot be deleted. There must be at least one day.");
				}
				else {
					<?php if($this->session->data['memory'] == 'cookie') { ?>
						var data = { "day_id":day_id ,"sort_order":sort_order };				
						$("#"+ day).remove();
						runDeletePlanDay(data);
						selectDay(target_day_id);
					<?php } else { ?>
						<!-- START: set data -->
							var data = {
								"action":"delete_day",
								"day_id":day_id,
								"sort_order":sort_order
							};
						<!-- END -->
					
						<!-- START: send POST -->
							$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
								if(typeof json.warning != 'undefined') {
									showHint(json.warning);
								}
								else if(typeof json.success != 'undefined') {							
									$("#"+ day).remove();
									runDeletePlanDay(data);
									selectDay(target_day_id);
								}
							}, "json");
						<!-- END -->
					<?php } ?>
				}
		}
		
		function deletePlanLineTemporary(line) {
			line_id = $('#'+line+' .plan-line-form-hidden input[name=line_id]').val();
			<?php if($this->session->data['memory'] == 'cookie') { ?>					
				$("#"+ line).remove();
				runDeletePlanLine();
			<?php } else { ?>
				<!-- START: set data -->
					var data = {
						"action":"delete_line",
						"line_id":line_id
					};
				<!-- END -->
			
				<!-- START: send POST -->
					$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
						if(typeof json.warning != 'undefined') {
							showHint(json.warning);
						}
						else if(typeof json.success != 'undefined') {
							$("#"+ line).remove();
							runDeletePlanLine();
						}
					}, "json");
				<!-- END -->
			<?php } ?>
		}
		
		function runAddPlanDay(data) {
			<!-- START: set variable -->
				var column = <?php echo $column_json; ?>;
			<!-- END -->
			
			<!-- START: update hidden input -->
				$('#plan-date-form-hidden input[name=num_of_day]').val(data.sort_order);
			<!-- END -->
				
			<!-- START: print -->
				printDay(column,data,data);
				printButtonAddLine(column, "#plan-day-" + data.day_id + "-content");
			<!-- END -->
			
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				updatePlanTableCookie();
			<?php } ?>
			
			<!-- START: init function -->
				refreshDateForm();
				updateDateFormButtonEvent();
				updatePlanTableButtonEvent();
				updatePlanTableDayDate();
				updatePlanTableDayDuration();
				initSortableDay();
				initSortableLine();
			<!-- END -->
			
				adjustPlanDayView();
			
			<!-- START -->
				if($('#section-content-guide').is(':visible')) {
					minimizePlanTableColumn();
				}
			<!-- END -->
			
			<!-- START: hint -->
				showHint('Day '+data.sort_order+' added');
			<!-- END -->
		}
		
		function runDeletePlanDay(data) {
			<!-- START: update hidden input -->
				$('#plan-date-form-hidden input[name=num_of_day]').val(data.sort_order);
			<!-- END -->
			
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				updatePlanTableCookie();
			<?php } ?>
			
			<!-- START: init function -->
				refreshDateForm();
				updateDateFormButtonEvent();
				updatePlanTableButtonEvent();
				updatePlanTableDayDate();
				updatePlanTableDayDuration();
				updatePlanTableLineDayIdAndSortOrder();
				initSortableDay();
				initSortableLine();
			<!-- END -->
			
			<!-- START: hint -->
				showHint('Day '+data.sort_order+' deleted');
			<!-- END -->
		}
	<!-- END -->
	
	<!-- START: [edit line] -->
		function openAddPlanLineModal() {
			$('#modal-edit-line-form-search').trigger("reset");
			$('#modal-edit-line-form').trigger("reset");
			$('#modal-edit-line-form input[type=hidden]').val(''); //reset hidden input
			
			<!-- START: [modal] -->
				$('#modal-edit-line .modal-title').html('Add Activity');
				$('#modal-edit-line-form input[name=action]').val('add');
				$('#modal-edit-line .btn-primary').off().on('click', saveAddPlanLineForm);;
			<!-- END -->
			
			<!-- START: [value] -->
				var day_id = $(this).closest('.plan-day-tr').find('.plan-day-form-hidden input[name=day_id]').val();
				$('#modal-edit-line-form input[name=day_id]').val(day_id);
			<!-- END -->
			
			<!-- START: [time] -->
				$('#modal-edit-line-form input[name=time]').attr('type','text');
				$('#modal-edit-line-form input[name=time]').val('');
			<!-- END -->
			
			<!-- START: [duration] -->
				$('#modal-edit-line-form input[name=duration]').val(''); 
				$('#modal-edit-line-form input[name=duration]').show();
				$('#modal-edit-line-form-input-hourminute').hide();
			<!-- END -->
		}
		
		function openEditPlanLineModal(line) {
			$('#modal-edit-line-form-search').trigger("reset");
			$('#modal-edit-line-form').trigger("reset");
			$('#modal-edit-line-form input[type=hidden]').val(''); //reset hidden input
			
			<!-- START: [modal] -->
				$('#modal-edit-line .modal-title').html('Edit Activity');
				$('#modal-edit-line-form input[name=action]').val('edit');
				$('#modal-edit-line .btn-primary').off().on('click', saveEditPlanLineForm);
			<!-- END -->
			
			var day_id = $('#'+line).find('.plan-line-form-hidden input[name=day_id]').val();
			var line_id = $('#'+line).find('.plan-line-form-hidden input[name=line_id]').val();
			var type_id = $('#'+line).find('.plan-line-form-hidden input[name=type_id]').val();
			var type = $('#'+line).find('.plan-line-form-hidden input[name=type]').val();
			var place = $('#'+line).find('.plan-line-form-hidden input[name=place]').val();
			var lat = $('#'+line).find('.plan-line-form-hidden input[name=lat]').val();
			var lng = $('#'+line).find('.plan-line-form-hidden input[name=lng]').val();
			var activity = $('#'+line).find('.plan-line-form-hidden input[name=activity]').val();
			var time = $('#'+line).find('.plan-line-form-hidden input[name=time]').val();
			var duration = $('#'+line).find('.plan-line-form-hidden input[name=duration]').val();
			var hour = Math.floor(duration/60);
			var minute = duration%60;
			minute = ("0" + minute).slice(-2);
			var fee = $('#'+line).find('.plan-line-form-hidden input[name=fee]').val();
			var currency = $('#'+line).find('.plan-line-form-hidden input[name=currency]').val();
			var title = $('#'+line).find('.plan-line-form-hidden input[name=title]').val();
			var description = $('#'+line).find('.plan-line-form-hidden input[name=description]').val();
			var note = $('#'+line).find('.plan-line-form-hidden input[name=note]').val();
			
			$('#modal-edit-line-form input[name=line_id]').val(line_id);
			if(typeof type_id != 'undefined') { $('#modal-edit-line-form input[name=type_id]').val(type_id); }
			if(typeof type != 'undefined') { $('#modal-edit-line-form input[name=type]').val(type); }
			if(typeof place != 'undefined') { $('#modal-edit-line-form input[name=place]').val(place); }
			if(typeof lat != 'undefined') { $('#modal-edit-line-form input[name=lat]').val(lat); }
			if(typeof lng != 'undefined') { $('#modal-edit-line-form input[name=lng]').val(lng); }
			if(typeof activity != 'undefined') { $('#modal-edit-line-form input[name=activity]').val(activity); }
			if(typeof time != 'undefined' && time != '' && time != null) { 
				$('#modal-edit-line-form input[name=time]').attr('type','time');
				$('#modal-edit-line-form input[name=time]').val(time);
			}
			else {
				$('#modal-edit-line-form input[name=time]').attr('type','text');
				$('#modal-edit-line-form input[name=time]').val('');
			}
			if(typeof duration != 'undefined' && duration != '' && duration != null) { 
				$('#modal-edit-line-form input[name=duration]').val(duration); 
				$('#modal-edit-line-form input[name=duration]').hide();
				$('#modal-edit-line-form-input-hourminute').show();
				$('#modal-edit-line-form input[name=hour]').val(hour);
				$('#modal-edit-line-form input[name=minute]').val(minute);
			}
			else {
				$('#modal-edit-line-form input[name=duration]').val(''); 
				$('#modal-edit-line-form input[name=duration]').show();
				$('#modal-edit-line-form-input-hourminute').hide();
			}
			if(typeof fee != 'undefined' && fee != '' && fee != null) {  $('#modal-edit-line-form input[name=fee]').val(fee); }
			if(typeof currency != 'undefined' && currency != '' && currency != null) {  $('#modal-edit-line-form select[name=currency]').val(currency); }
			if(typeof title != 'undefined' && title != '' && title != null) { $('#modal-edit-line-form input[name=title]').val(title); }
			if(typeof description != 'undefined' && description != '' && description != null) { $('#modal-edit-line-form textarea[name=description]').val(description); }
			if(typeof note != 'undefined' && note != '' && note != null) { $('#modal-edit-line-form textarea[name=note]').val(note); }
		}
		
		function convertLineDurationFormat(duration) {
			var formatted_duration;
			if(typeof duration != 'undefined' && duration != null && duration != '') {
				var hour = Math.floor(duration/ 60);
				var minute = duration % 60;
				if(hour >= 1) {
					minute = ("0" + minute).slice(-2);
					formatted_duration = hour+'h '+minute+'m';
				}
				else {
					formatted_duration = minute+'m';
				}
			}
			else {
				formatted_duration = '';
			}
			return formatted_duration;
		}
		
		function saveAddPlanLineForm() {
			<!-- START: get form data -->
				var type_id = $('#modal-edit-line-form input[name=type_id]').val()||null;
				var type = $('#modal-edit-line-form input[name=type]').val()||null;
				var image_id = $('#modal-edit-line-form input[name=image_id]').val()||null;
				var day_id = $('#modal-edit-line-form input[name=day_id]').val();
				var sort_order = $('#plan-day-'+day_id+'-line .plan-line-tr').length + 1;
				var time = $('#modal-edit-line-form input[name=time]').val()||null;
				var hour = $('#modal-edit-line-form input[name=hour]').val();
				var minute = $('#modal-edit-line-form input[name=minute]').val();
				var duration  = (parseInt(hour) * 60 + parseInt(minute))||null;
				var formatted_duration = convertLineDurationFormat(duration);
				var activity = $('#modal-edit-line-form input[name=activity]').val()||null;
				var place = $('#modal-edit-line-form input[name=place]').val()||null;
				var lat = $('#modal-edit-line-form input[name=lat]').val()||null;
				var lng = $('#modal-edit-line-form input[name=lng]').val()||null;
				var fee = $('#modal-edit-line-form input[name=fee]').val()||null;
				var currency = $('#modal-edit-line-form select[name=currency]').val()||null;
				var title = $('#modal-edit-line-form input[name=title]').val()||null;
				var description = $('#modal-edit-line-form textarea[name=description]').val()||null;
				var note = $('#modal-edit-line-form textarea[name=note]').val()||null;
			<!-- END -->
			
			<!-- START: set line_id for cookie -->
				var line_id = 0;
				var i = 1;
				while (line_id < 1) {
					var check_id = $("#plan-line-" + i + "-tr").length;
					if (check_id < 1) line_id = i;
					i ++;
				} ;
			<!-- END -->
			
			<!-- START: set print data -->
				var line = 
					{
						line_id		:line_id,
						type		:type,
						type_id		:type_id,
						image_id	:image_id,
						day_id		:day_id,
						sort_order	:sort_order,
						time		:time,
						duration	:formatted_duration,
						activity	:activity,
						place		:place,
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
						image_id	:image_id,
						day_id		:day_id,
						sort_order	:sort_order,
						time		:time,
						duration	:duration,
						activity	:activity,
						place		:place,
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
					$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
						if(typeof json.warning != 'undefined') {
							showHint(json.warning);
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
		
		function runAddPlanLine(line,line_raw) {
			<!-- START: set variable -->
				var column = <?php echo $column_json; ?>;
			<!-- END -->
			
			<!-- START: print -->
				printLine(column,line,line_raw);
			<!-- END -->
			
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				updatePlanTableCookie();
			<?php } ?>
			
			<!-- START: init function -->
				updatePlanTableButtonEvent();
				updateDateFormButtonEvent();
				updatePlanTableDayDuration();
				initSortableLine();
			<!-- END -->
			
			<!-- START: show hint -->
				var place = line.place;
				var added_line = "";
				if(typeof place != 'undefined' && place != null && place != '') { added_line = place; } else { added_line = "New Activity"; }
				var day = $("#plan-day-"+ line.day_id +"-tr").find(".plan-day-form-hidden input[name=sort_order]").val();
				
				var hint = added_line + " added to Day " + day;
				showHint(hint);
			<!-- END -->
		}
		
		function saveEditPlanLineForm() {
			<!-- START: get value -->
				var line_id = $('#modal-edit-line-form input[name=line_id]').val();
				var type = $('#modal-edit-line-form input[name=type]').val();
				var type_id = $('#modal-edit-line-form input[name=type_id]').val();
				var image_id = $('#modal-edit-line-form input[name=image_id]').val();
				var time = $('#modal-edit-line-form input[name=time]').val()||null;
				var hour = $('#modal-edit-line-form input[name=hour]').val()||null;
				var minute = $('#modal-edit-line-form input[name=minute]').val()||null;
				var duration = (parseInt(hour) * 60 + parseInt(minute))||null;
				var activity = $('#modal-edit-line-form input[name=activity]').val()||null;
				var place = $('#modal-edit-line-form input[name=place]').val();
				var lat = $('#modal-edit-line-form input[name=lat]').val()||null;
				var lng = $('#modal-edit-line-form input[name=lng]').val()||null;
				var fee = $('#modal-edit-line-form input[name=fee]').val()||null;
				var currency = $('#modal-edit-line-form select[name=currency]').val()||null;
				var title = $('#modal-edit-line-form input[name=title]').val()||null;
				var description = $('#modal-edit-line-form textarea[name=description]').val()||null;
				var note = $('#modal-edit-line-form textarea[name=note]').val()||null;
			<!-- END -->
			
			<!-- START: set print data -->
				var line = 
					{
						line_id		:line_id,
						type		:type,
						type_id		:type_id,
						image_id	:image_id,
						time		:time,
						duration	:duration,
						activity	:activity,
						place		:place,
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
			
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				runEditPlanLine(line);
			<?php } else { ?>
				<!-- START: set data -->
					var data = {
						"action":"edit_line",
						"line":line
					};
				<!-- END -->
			
				<!-- START: send POST -->
					$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
						if(typeof json.warning != 'undefined') {
							showHint(json.warning);
						}
						else if(typeof json.success != 'undefined') {
							runEditPlanLine(line);
						}
					}, "json");
				<!-- END -->
			<?php } ?>
		}
		
		function runEditPlanLine(line) {
			<!-- START: update hidden value -->
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=type_id]').val(line.type_id);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=type]').val(line.type);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=place]').val(line.place);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=lat]').val(line.lat);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=lng]').val(line.lng);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=activity]').val(line.activity);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=time]').val(line.time);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=duration]').val(line.duration);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=fee]').val(line.fee);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=currency]').val(line.currency);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=title]').val(line.title);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=description]').val(line.description);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-line-form-hidden input[name=note]').val(line.note);
			<!-- END -->
			
			<!-- START: update html -->
				$('#plan-line-'+line.line_id+'-tr').find('.plan-col-place').html(line.place);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-col-activity').html(line.activity);
				$('#plan-line-'+line.line_id+'-tr').find('.plan-col-time').html(line.time);
				<!-- START: [duration] -->
					if(line.duration == null) { 
						$('#plan-line-'+line.line_id+'-tr').find('.plan-col-duration').html('');
					}
					else {
						var formatted_duration = convertLineDurationFormat(line.duration);
						$('#plan-line-'+line.line_id+'-tr').find('.plan-col-duration').html(formatted_duration);
					}
				<!-- END -->
				<!-- START: [fee] -->
					$('#plan-line-'+line.line_id+'-tr').find('.plan-col-fee').html(line.fee);
				<!-- END -->
				<!-- START: [currency] -->
					$('#plan-line-'+line.line_id+'-tr').find('.plan-col-currency').html(line.currency);
				<!-- END -->
				<!-- START: [title] -->
					$('#plan-line-'+line.line_id+'-tr').find('.plan-col-title').html(line.title);
				<!-- END -->
				<!-- START: [description] -->
					$('#plan-line-'+line.line_id+'-tr').find('.plan-col-description').find('.fa').attr('data-original-title',line.description);
					if(line.description == null || line.description == '') { 
						$('#plan-line-'+line.line_id+'-tr').find('.plan-col-description').find('.fa').addClass('hidden'); 
					}
					else {
						$('#plan-line-'+line.line_id+'-tr').find('.plan-col-description').find('.fa').removeClass('hidden'); 
					}
				<!-- END -->
				<!-- START: [note] -->
					$('#plan-line-'+line.line_id+'-tr').find('.plan-col-note').find('.fa').attr('data-original-title',line.note);
					if(line.note == null || line.note == '') { 
						$('#plan-line-'+line.line_id+'-tr').find('.plan-col-note').find('.fa').addClass('hidden'); 
					}
					else {
						$('#plan-line-'+line.line_id+'-tr').find('.plan-col-note').find('.fa').removeClass('hidden'); 
					}
				<!-- END -->
				<!-- START: [info] -->
					if(line.type == null || line.type == '') { 
						$('#plan-line-'+line.line_id+'-tr').find('.plan-col-command').find('.fa-info-circle').addClass('hidden'); 
					}
					else {
						$('#plan-line-'+line.line_id+'-tr').find('.plan-col-command').find('.fa-info-circle').removeClass('hidden'); 
					}
				<!-- END -->
			<!-- END -->
			
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				updatePlanTableCookie();
			<?php } ?>
			
			<!-- START: init function -->
				updatePlanTableDayDuration();
			<!-- END -->
			
			<!-- START: show hint -->
				showHint("Activity updated");
			<!-- END -->
		}
		
		function deletePlanLine(){
			var selected_delete_id, hint_text;
			$('[data-toggle=confirmation-delete-line').confirmation({
				container: "body",
				singleton: true,
				popout: true,
				title: "Confirm DELETE?",
				html: true,
				content: function (){
					selected_delete_id = $(this).attr('data-id');
					content_text ="";
					
					line_id = $('#'+selected_delete_id+' .plan-line-form-hidden input[name=line_id]').val();
					place = $('#'+selected_delete_id+' .plan-line-form-hidden input[name=place]').val();
					if(place == '') { place = 'Activity'; }
					day = $("#"+selected_delete_id).parent().parent().parent().find(".plan-col-day").html().replace( /^\D+/g, '');
					content_text = place + " in Day " + day;
					
					if (!hint_text) hint_text  = content_text;
					return content_text;
				},
				onConfirm: function () {
					<?php if($this->session->data['memory'] == 'cookie') { ?>
						$(this).confirmation('destroy');							
						$("#"+ selected_delete_id).remove();
						runDeletePlanLine();
					<?php } else { ?>
						<!-- START: set data -->
							var data = {
								"action":"delete_line",
								"line_id":line_id
							};
						<!-- END -->
					
						<!-- START: send POST -->
							$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
								if(typeof json.warning != 'undefined') {
									showHint(json.warning);
								}
								else if(typeof json.success != 'undefined') {
									$(this).confirmation('destroy');							
									$("#"+ selected_delete_id).remove();
									runDeletePlanLine();
								}
							}, "json");
						<!-- END -->
					<?php } ?>
				}
			});	
		}
		
		function runDeletePlanLine(data) {
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				updatePlanTableCookie();
			<?php } ?>
			
			<!-- START: init function -->
				updatePlanTableCookie();
				updatePlanTableDayDuration();
				updatePlanTableLineDayIdAndSortOrder();
				updatePlanTableButtonEvent();
			<!-- END -->
			
			<!-- START: hint -->
				showHint('Activity deleted');
			<!-- END -->
		}	
	<!-- END -->
	
	<!-- START: add activity from guide -->
		function addActivityFromGuide() {
			<!-- START: get form data -->
				var line_id = $('.plan-line-tr').length + 1;
				var type_id = $('#section-content-guide-form input[name=type_id]').val();
				var type = $('#section-content-guide-form input[name=type]').val();
				var day_id = $('#section-day-bar-form input[name=day_id]').val();
				var image_id = $('#section-content-guide-form input[name=image_id]').val()||null;
				var sort_order = $('#plan-day-'+day_id+'-line .plan-line-tr').length + 1;
				var time = null;
				var duration  = 60;
				var formatted_duration = convertLineDurationFormat(duration);
				var activity = 'Visit';
				var place = $('#section-content-guide-form input[name=name]').val();
				var lat = $('#section-content-guide-form input[name=lat]').val()||null;
				var lng = $('#section-content-guide-form input[name=lng]').val()||null;
				var fee = null;
				var currency = null;
				var title = place;
				var description = null;
				var note = null;
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
						duration	:formatted_duration,
						activity	:activity,
						place		:place,
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
			
			<?php if($this->session->data['memory'] == 'cookie') { ?>
				updateGuideCurrentAddButton(true);
				runAddPlanLine(line,line_raw);
			<?php } else { ?>
				<!-- START: set data -->
					var data = {
						"action":"add_line",
						"line":line_raw
					};
				<!-- END -->
			
				<!-- START: send POST -->
					$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
						if(typeof json.warning != 'undefined') {
							showHint(json.warning);
						}
						else if(typeof json.success != 'undefined') {
							line.line_id = json.line_id;
							line_raw.line_id = json.line_id;
							updateGuideCurrentAddButton(true);
							runAddPlanLine(line,line_raw);
						}
					}, "json");
				<!-- END -->
			<?php } ?>
		}
	<!-- END -->
		
	$(document).ready(function() {
		refreshPlanTable();
		$(".plan-day-form").first().trigger("click");
	})
	
	
</script>

<!-- START: add function to search button -->
	<script>
		function adjustPlanDayView() {
			$('.plan-day-tr .plan-col-image-id').hide();
			$('.plan-day-form .plan-col-title').hide();
		}
		
		function showPlanDay(day_id) {
			$('#section-content-itinerary-header').hide();
			$('.plan-day-form .plan-col-duration').show();
			$('.plan-line-form .plan-col-duration').hide();
			$('.plan-thead').hide();
			//$('.plan-btn-add-line').hide();
			$('.plan-btn-add-day').hide();
			$('.icon-toggle-day').hide();
			//$('.icon-edit').hide();
			$('.plan-no-activity').hide();
			if(day_id == '') {
				adjustPlanDayView();
				$('.plan-day-form').show();
				$('.plan-day-content').hide();
				$('.plan-line-tr').hide();
			}
			else {
				$('.plan-day-form').hide();
				$('.plan-day-content').hide();
				$('#plan-day-'+day_id+'-content').show();
				$('.plan-line-tr').show();
				$('.plan-line-tr .plan-col-day').hide();
				$('.plan-line-tr .plan-col-title').show();
				if($('#plan-day-'+day_id+'-content .plan-line-tr').length == 0) {
					$('.plan-no-activity').show();
				}
			}
		}
		
		function minimizePlanTableColumn() {
			$('.plan-thead').hide();
			$('.plan-tbody').addClass('noscrollbar');
			$('.plan-col-datetime').hide();
			$('.plan-col-date').hide();
			$('.plan-col-time').hide();
			$('.plan-col-fee').hide();
			$('.plan-col-currency').hide();
			$('.plan-col-title').hide();
			$('.plan-col-description').hide();
			$('.plan-col-note').hide();
			$('.plan-col-command').hide();
			$('.plan-day-content').hide();
			$('.plan-col-day').css('padding-left','15px');
			
			<!-- START: modify itinerary header -->
				$('.btn-show-date-form').hide();
				$('#btn-search').addClass('btn-block');
				$('#btn-search').removeClass('pull-left');
				$('#btn-search').removeClass('btn');
				$('#btn-search').removeClass('btn-primary');
				$('#btn-search').html('View Itinerary');
				$('#section-content-itinerary-header').css('overflow-y','hidden');
			<!-- END -->
		}
		
		function maximizePlanTableColumn() {
			$('.plan-thead').show();
			$('.plan-tbody').removeClass('noscrollbar');
			$('.plan-col-datetime').show();
			$('.plan-col-date').show();
			$('.plan-col-time').show();
			$('.plan-col-fee').show();
			$('.plan-col-currency').show();
			$('.plan-col-title').show();
			$('.plan-col-description').show();
			$('.plan-col-note').show();
			$('.plan-col-command').show();
			$('.plan-day-content').show();
			$('.plan-col-day').css('padding-left','7px');
			
			<!-- START: modify itinerary header -->
				$('.btn-show-date-form').show();
				$('#btn-search').removeClass('btn-block');
				$('#btn-search').addClass('pull-left');
				$('#btn-search').addClass('btn');
				$('#btn-search').addClass('btn-primary');
				$('#btn-search').html('<i class="fa fa-fw fa-search"></i> Discover');
				$('#section-content-itinerary-header').css('overflow-y','scroll');
			<!-- END -->
		}
		
		function swithMobileMode() {
			maximizePlanTableColumn();
			<!-- START: [header] -->
			//$('#wrapper-header').addClass('view-mode');
			//$('#wrapper-title').tooltip('disable');
			//$('#wrapper-title-input').attr("disabled", true);
			//$('#wrapper-account-icon').hide();
			//$('#wrapper-mobile-icon').removeClass('hidden');
			<!-- END -->
			<!-- START: [menu] -->
			//$('#wrapper-menu .menu-itinerary-list').hide();
			//$('#wrapper-menu .menu-account-list').show();
			<!-- END -->
			<!-- START: [guide] -->
			//$('#section-content-guide-content').addClass('noscrollbar');
			//$('#section-content-guide-button-add').hide();
			//$('#section-content-guide-button-add-text').hide();
			<!-- END -->
			<!-- START: [itinerary] -->
			//$('#btn-search').hide();
			$('#section-content-itinerary-header').hide();
			$('.plan-thead').hide();
			$('.plan-tbody').addClass('noscrollbar');
			$('.plan-col-duration').hide();
			$('.plan-col-fee').hide();
			$('.plan-col-currency').hide();
			$('.plan-col-description').hide();
			$('.plan-col-note').hide();
			//$('.plan-col-command').css('display','block');
			$('.plan-day-form').hide();
			$('.plan-day-tr .plan-col-title').hide();
			$('.plan-day-tr .plan-col-image-id').hide();
			$('.icon-toggle-day').hide();
			//$('.icon-edit').hide();
			//$('.plan-btn-add-line').hide();
			$('.plan-btn-add-day').hide();
			$('.plan-line-tr .plan-col-day').hide();
			$('.plan-line-tr .plan-col-title').show();
			//[event]
			//$(".plan-day-tr").css('pointer-events','none');
			//$('.plan-btn').css('pointer-events','auto');
			//[line]
			setTimeout(function() {$('.plan-day-content').removeClass('hidden');}, 100);
			$('.plan-day-tr').addClass('plan-mobile-tr');
			$('.plan-line-tr').addClass('plan-mobile-tr');
			<!-- END -->
		}
		
		function swithDesktopMode() {
			if($('#wrapper-mobile-icon').hasClass('hidden')) {
			}
			else {
				<!-- START: [header] -->
				$('#wrapper-header').removeClass('view-mode');
				$('#wrapper-title').tooltip('enable');
				$('#wrapper-title-input').attr("disabled", false);
				$('#wrapper-account-icon').show();
				$('#wrapper-mobile-icon').addClass('hidden');
				<!-- END -->
				<!-- START: [menu] -->
				$('#wrapper-menu .menu-itinerary-list').show();
				$('#wrapper-menu .menu-account-list').hide();
				<!-- END -->
				<!-- START: [guide] -->
				$('#section-content-guide-content').removeClass('noscrollbar');
				$('#section-content-guide-button-add').show();
				$('#section-content-guide-button-add-text').show();
				<!-- END -->
				<!-- START: [itinerary] -->
				//[event]
				$(".plan-day-tr").css('pointer-events','auto');
				toggleDay();
				//[column]
				$('#section-content-itinerary-header').show();
				$('.plan-thead').show();
				$('.plan-tbody').removeClass('noscrollbar');
				$('.plan-col-duration').show();
				$('.plan-col-fee').show();
				$('.plan-col-currency').show();
				$('.plan-col-description').show();
				$('.plan-col-note').show();
				$('.icon-toggle-day').show();
				$('.icon-sort').show();
				$('.icon-delete').show();
				$('.icon-edit').show();
				$('.plan-btn-tr').show();
				//[line]
				$('.plan-day-tr').removeClass('plan-mobile-tr');
				$('.plan-line-tr').removeClass('plan-mobile-tr');
				<!-- END -->
				setTimeout(function() {
					if($('#section-content-guide').is(':visible')) {
						minimizePlanTableColumn();
					}
					else {
						maximizePlanTableColumn();
					}
				}, 100);
			}
		}
		
        $('#btn-search').on('click', function() {
            showTab('guide');
        });
<!-- END -->

<!-- Show popover hint (helper) -->

	function showHint(hint) {
		$("#hint-popover").hide();
		$("#hint-popover").html(hint).fadeIn(100);
		setTimeout(function() { $("#hint-popover").delay(1000).fadeOut(300); }, 2000);
	}
<!-- END -->
	</script>