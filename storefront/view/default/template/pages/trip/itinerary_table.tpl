<!-- START: [Bootstrap toggle button] -->
    <link href="<?php echo $this->templateResource('/stylesheet/bootstrap-toggle.min.css'); ?>" rel="stylesheet">
    <script type="text/javascript" src="<?php echo $this->templateResource('/javascript/bootstrap-toggle.min.js'); ?>"></script>
<!-- END -->

<style>
	/* START: [section] */
		#section-content-itinerary {
			position:relative;
		}
		
		#section-content-itinerary-header {
			border-bottom:solid thin #DDD;
		}
		
		#section-content-itinerary-header-button {
			height:50px;
		}
		
		#section-content-itinerary-header-button > a {
			display:block;
			padding:0;
			height:30px;
			padding:15px 22px;
		}
	/* END */
	
	/* START: [plan table] */
		.plan-table {
			text-align:left;
			font-size:11px;
			line-height:26px;
		}
		
		.plan-thead {
			position:relative;
			overflow-y:scroll;
			overflow-x:auto;
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
			overflow-y:scroll;
			overflow-x:auto;
			direction:rtl;
			height:420px;	
		}
		
		.plan-tbody > div {
			direction:ltr;
		}
		
		.plan-thead {
			border-bottom:solid thin #DDD;
		}
		
		.plan-thead-tr.plan-tr {
			border-bottom:none;
		}
		
		.plan-form {
			overflow:hidden;
			border-bottom:solid thin #DDD;
			cursor:pointer;
		}
		
		.plan-form:hover {
			background-color:#EEE;
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
			border-bottom:solid thin #DDD;
			height:40px;
			padding:7px;
		}
		
		.plan-day-tr.selected {
			background-color:#FF6;
		}
		
		.plan-line-tr {
			background-color:#FFC;
		}
		
		.plan-btn-add-line {
			background-color:#FFE;
		}
		
		.plan-btn-add-line:hover {
			background-color:#FFA;
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
			height: 40px;
			line-height:26px;
			padding:7px;
		}
		
		.ui-draggable-placeholder {
			background-color: rgba(220,220,220,0.3);
			height: 30px;
			text-align: center;
		}
		
		.ui-draggable-helper {
			height: 40px;
			background-color: white;
			opacity: 0.5;
			font-size: 1.5em;
			text-align:center;
			border: medium dotted #666;
		}
	/* END */
</style>

<div id="section-content-itinerary">
	<div id="section-content-itinerary-header">
    	<div id="section-content-itinerary-header-button">
            <a class="pull-right noselect">Set Date</a>
        </div>
    </div>
    <div id="section-content-itinerary-content">
    	<div class='plan-table'>
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
            </div>
        </div>
    </div>
</div>

<script>
	<!-- START: script for manage display -->
		function refreshPlanTable() {
			<?php if($this->user->isLogged() != '') { ?>
				<!-- START: [logged] -->
					<!-- START: set data -->
						var data = {
							"action":"refresh_plan",
							"plan_id":"4",
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
							var plan = {
								name:"Plan 1",
								travel_date:new Date("2016-02-09"),
								day:[
									{
										day_id:1,
										sort_order:1,
										line:[
											{
												line_id:1,
												day_id:1,
												sort_order:1,
												time:"10:00",
												duration:30,
												title:"Tokyo Tower"
											},
											{
												line_id:2,
												day_id:1,
												sort_order:2,
												time:"11:00",
												duration:60,
												title:"Osaka Tower"
											},
											{
												line_id:3,
												day_id:1,
												sort_order:3,
												time:"15:00",
												duration:90,
												title:"Kyoto Tower"
											}
										]
									},
									{
										"day_id":2,
										"sort_order":2,
									},
									{
										"day_id":3,
										"sort_order":3,
									}
								]
							};
							plan = JSON.stringify(plan);
							setCookie('plan',plan,1);
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
			
			<!-- START: print table -->
				$.each(data_cooked.day, function(i) {
					printDay(column, this, data_raw.day[i]);
					if(typeof this.line != 'undefined' && this.line.length > 0) {
						$.each(this.line, function(j) {
							printLine(column, this, data_raw.day[i].line[j]);
						});
					}
					printButtonAddLine(column, "#plan-day-" + this.day_id + "-content");
				});
				printButtonAddDay(column);
			<!-- END -->
			
			<!-- START: init function -->
				updatePlanTableButtonEvent();
				initSortableDay(data_cooked);
				initSortableLine();
			<!-- END -->
		}
	<!-- END -->
	
	<!-- START: script to print on screen -->
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
							+ "</div>"
						+ "</div>"
					+ "</div>"
				;
			<!-- END -->
			<!-- START: set output for command -->
				var output_command = ""
					+ "<div>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-sort'>"
							+ "<i class='fa fa-fw fa-arrows-v' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-delete' data-toggle='confirmation-delete'>"
							+ "<i class='fa fa-fw fa-trash' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-toggle-day'>"
							+ "<i class='fa fa-fw fa-chevron-circle-down' aria-hidden='true'></i>"
						+ "</a>"
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
						if(typeof line[col.name] != 'undefined' && line[col.name] != null) {
							if(col.name == 'time') {
								html_plan_form += ''
									+ '<input '
										+ 'type="time" '
										+ 'value="' + line[col.name] + '" '
									+ '/>'
								;
							}
							else if(col.type == 'input') {
								html_plan_form += ""
									+ "<input "
										+ "id='plan-line-" + line.line_id + "-col-" + col.id + "-input' "
										+ "class='plan-input' "
										+ 'name="' + col.name + '" '
										+ "value='" + line_raw[col.name] + "'"
									+ "/>"
								;
							}
							else {
								html_plan_form += line[col.name];
							}
						}
						else {
							if(col.name == 'time') {
								html_plan_form += ''
									+ '<input '
										+ 'type="time" '
									+ '/>'
								;
							}
						}
					<!-- END -->
					<!-- START: close <td> -->
						html_plan_form += "</div>";
					<!-- END -->
				});
			<!-- END -->
			
			<!-- START -->
				var html_plan_form_hidden='';
			<!-- END -->
			
			<!-- START: set output for line -->
				var output_line = ""
					+ "<div class='plan-line-tr' id='plan-line-" + line.line_id + "-tr'>"
						+ "<div class='plan-line-form plan-form' id='plan-line-" + line.line_id + "-form'>"
							+ html_plan_form
						+ "</div>"
						+ "<div class='plan-line-form-hidden plan-form-hidden hidden' id='plan-line-" + line.line_id + "-form-hidden'>"
							+ html_plan_form_hidden
						+ "</div>"
					+ "</div>"
				;
			<!-- END -->
			
			<!-- START: set output for command -->
				var output_command = ""
					+ "<div>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-sort'>"
							+ "<i class='fa fa-fw fa-arrows-v' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-delete' data-toggle='confirmation-delete'>"
							+ "<i class='fa fa-fw fa-trash' aria-hidden='true'></i>"
						+ "</a>"
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
		}
		
		function printButtonAddLine(column, plan_day_content) {
			<!-- START: set output -->
				var output = ""
					+"<div class='plan-btn-add-line plan-btn-tr'>"
						+ "<a class='text-center btn-block'>"
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
						+ "<a class='text-center btn-block' onclick='getFormPlanValue();'>"
							+ "Add New Day"
						+ "</a>"
					+"</div>"
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
			var first_date = new Date(plan.travel_date);
			var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
			for (i=0; i<plan.day.length; i++) {
				myDate = new Date(first_date.setDate(first_date.getDate() + 1));
				var weekday = new Array(7);
				weekday[0]=  "Ｓ";
				weekday[1] = "Ｍ";
				weekday[2] = "Ｔ";
				weekday[3] = "Ｗ";
				weekday[4] = "Ｔ";
				weekday[5] = "Ｆ";
				weekday[6] = "Ｓ";
				var myWeekday = weekday[myDate.getDay()];
				plan.day[i].date = myDate.getDate() + "&nbsp;" + monthNames[(myDate.getMonth())] + "&nbsp;&nbsp;&nbsp;(" + myWeekday + ")";
			}
			return plan;
		}
		
		function setPlanTableDataFormatForDayDuration(plan) {
			for(i=0; i<plan.day.length; i++) {
				if(typeof plan.day[i].line != 'undefined' &&  plan.day[i].line.length > 0) {
					plan.day[i].duration = 0;
					for(j=0; j<plan.day[i].line.length; j++) {
						var duration = plan.day[i].line[j].duration;
						plan.day[i].duration += duration;
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
				if(typeof plan.day[i].line != 'undefined' &&  plan.day[i].line.length > 0) {
					for(j=0; j<plan.day[i].line.length; j++) {
						var duration = plan.day[i].line[j].duration;
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
				}
			}
			return plan;
		}
	<!-- END -->
	
	<!-- START: [button function] -->
		function updatePlanTableButtonEvent() {
			$(".plan-day-form").on("click", toggleDay);
			$('.icon-sort').on('mousedown', function() {
				var selected_day = $(this).closest(".plan-day-tr").attr("id");
				$("# "+ selected_day + " .plan-day-content").addClass("hidden");
				$(this).on('mouseup', function() {	
					$("# "+ selected_day + " .plan-day-content").removeClass("hidden");
				});
			})
			;
		}
		
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
			}
		}
		
		function initSortableDay (data_cooked) {	
			var from_row_day_index;
			var from_row_day_id;
			var to_row_day_id;
			$(".plan-day").sortable({	
				delay: 100,
				axis: "y",
				items: ">.plan-day-tr", 
				handle: ">.plan-day-form",
				appendTo: "parent",	
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
					$(ui.placeholder).addClass("ui-draggable-placeholder-day");
					from_row_day_index = $(ui.item).index();
					from_row_day_id = ui.item.attr("id");
				},
				sort: function(event, ui) {
					if (from_row_day_index > $(ui.placeholder).index()) { 
						to_row_day_id = $(ui.placeholder).next(".plan-day-tr").attr("id");
					}
					else {
						to_row_day_id = $(ui.placeholder).prev(".plan-day-tr").attr("id");
					}
					sort_order = $("#" + to_row_day_id + " .plan-col-sort-order").html();
					$(ui.placeholder).html("Reschedule to D"+sort_order);
				},
				stop: function( event, ui ) {
					updatePlanTableDayDate(data_cooked);
				}
			}).disableSelection();
		}
		
		function initSortableLine() {
			var from_row_day_id;
			var to_row_day_id;
			$(".plan-day-line").sortable({
				delay: 100,
				axis: "y",
				items: ">.plan-line-tr",
				appendTo: "parent",
				connectWith: ".plan-day-content",	
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
					from_row_day_id = ui.item.parent().attr("id");
				},
				sort: function(event, ui) {
					var day = $(ui.placeholder).closest(".plan-day-tr").attr("id");
					day_sort_order = $("#" + day + " .col-sort-order").html();
					$(ui.placeholder).children("div").html("Move to D"+ day_sort_order);
				},
				update: function( event, ui ) {
					var selected_day = $(this).closest(".plan-day-tr").attr("id");
					to_row_day_id = selected_day;
				},
				stop: function( event, ui ) {
				}
			}).disableSelection();
		}
	<!-- END -->
	
	<!-- START: [update data] -->
		function updatePlanTableDayDate(data_cooked) {
			$('.plan-day-tr').each(function(){
				var speed = 300;
				var index = $('.plan-day-tr').index(this) + 1;
				$(this).find(".plan-col-sort-order").fadeOut(speed, function() {
					$(this).html(index).fadeIn(speed);
				});
				$(this).find(".plan-col-day").fadeOut(speed, function() {
					$(this).html("D" +index).fadeIn(speed);
				});
				$(this).find(".plan-col-date").fadeOut(speed, function() {
					$(this).html(data_cooked.day[index-1].date).fadeIn(speed);
				});
			})	
		}
	<!-- END -->
	
	$(document).ready(function() {
		refreshPlanTable();
	});
</script>