<!-- START: [Bootstrap toggle button] -->
    <link href="<?php echo $this->templateResource('/stylesheet/bootstrap-toggle.min.css'); ?>" rel="stylesheet">
    <script type="text/javascript" src="<?php echo $this->templateResource('/javascript/bootstrap-toggle.min.js'); ?>"></script>
<!-- END -->

<style>
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
    
    #section-content-itinerary-content {
        position:relative;
        overflow-y:scroll;
        overflow-x:auto;
		direction:rtl;	
    }
	
	#section-content-itinerary-content > div {
		direction:ltr; 
	}
	
	/* START: itinerary table */
        .itinerary-table {
			font-size:11px;
			text-align:left;
			table-layout:auto !important;
			width: 100%;
		}
		
		.itinerary-table > thead > tr { 
            /* 
			background-color:#EEE;
            height:70px; 
			*/
			height:40px;
        }
		
		.itinerary-table > thead > tr > th {
			padding:7px;
			border:0;
            border-bottom:solid thin #DDD;
			vertical-align:middle;
			color:#96979d;
			font-weight:normal;
		}
		
		.itinerary-table .row-line {
			background-color:#FFC;
		}
		
		.itinerary-table .row-line-button {
			background-color:#FFC;
		}
		
		.itinerary-table .row-button > td {
			padding:0;
		}
		
		.itinerary-table .row-button a {
			height:47px;
			color:#999;
			padding-top:15px;
		}
		
		.itinerary-table > tbody > tr:hover {
			background-color:#EEE;
			cursor:pointer;
		}
		
		.itinerary-table > tbody > .selected {
			background-color:#FF9;
		}
		
		.itinerary-table > tbody > tr > td {
			height:48px;
			padding:0;
			padding-left:7px;
			padding-right:7px;
			border:0;
            border-bottom:solid thin #DDD;
			vertical-align:middle;
			color:black;
		}
		
		.itinerary-table > tbody+tbody {
			border:0;
		}
	/* END */
	
	/* START: itinerary table row */
		.day-list {
		}
		
		/*
		.row-line {
			background-color:#FFC;
		}
		*/
		
		.backup {
			background-color:#DDD;
		}
		
		.progress {
			width:45px;
			height:15px;
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
		
		.poi-empty {
			text-align:center;
		}
	/* END */
		
	/* START: itinerary table pocket */
		#pocket td{
			text-align:left;
		}
		
		#pocket span{
			font-size: 0.5em !important;
		}
	/* END */
		
	/* START: itinerary table draggable effect */
		.ui-draggable-placeholder-day {
			background-color: #EEE;
			text-align: center;
			height: 48px;
		}
		
		.ui-draggable-placeholder {
			background-color: rgba(220,220,220,0.3);
			height: 30px;
			text-align: center;
		}
		
		.ui-draggable-helper {
			height: 48px;
			background-color: white;
			opacity: 0.5;
			font-size: 1.5em;
			text-align:center;
			border: medium dotted #666;
		}
	/* END */
	
	/* START: */
		.table-plan-row-line-column-time {
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
        <div id="section-content-itinerary-content-table">
            <table class="table itinerary-table" id="table-plan">
                <thead>
                    <?php
                        foreach($column as $c) {
                            echo '<th ';
                                echo 'style="';
                                    echo 'text-align:'.$c['headerAlign'].';';
                                    echo 'width:'.$c['width'].';';
                                    echo $c['headerStyle'];
                                echo '" ';
                                echo 'class="';
                                    if($c['visible'] == 'false') { echo 'hidden '; }
                                    echo $c['class'];
                                echo '" ';
                            echo '>';
                            echo $c['title'];
                            echo '</th>';
                        }
                    ?>
                </thead>
            </table>
        </div>
    </div>
</div>

<script>
	<!-- START: declare global value [!important] -->
		var column = <?php echo $column_json; ?>;
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
	
	//THIS IS INCOMPLETE
	function getFormPlanValue() {
		var serial = $('#form-plan').find('.row-day input').not('[value="undefined"]').serialize();
		var serial = JSON.stringify($('#form-plan').serializeObject());
		var day = 1;
		$.each($('.form-day'), function(i, val) {
			day = JSON.stringify($('#form-day').serializeObject());
		});
		var day = JSON.stringify($('#form-day').serializeObject());
		alert(day);
	}
	//INCOMPLETE
	
	function printDay(column, day, day_raw) {
		<!-- START: set column -->
			$.each(column, function(i, col) {
				<!-- START: select <td> property -->
					if(typeof col.dayId != 'undefined') { col.id = col.dayId; }
					if(typeof col.dayName != 'undefined') { col.name = col.dayName; }
					if(typeof col.dayClass != 'undefined') { col.class = col.dayClass; }
				<!-- END -->
				<!-- START: set <td> property -->
					column += "<td ";
						column += "id='table-plan-tbody-day-" + day.day_id + "-column-" + col.id + "' ";
						column += 'class="';
							if(typeof col.class != 'undefined') { column += col.class+' '; }
							if(col.visible == 'false') { column += 'hidden '; }
						column += '" ';
						column += 'style="';
							if(typeof col.dayStyle != 'undefined') { column += col.dayStyle; }
							if(col.align != '') { column += 'text-align:' + col.align + ';'; }
						column += '" ';
					column += ">";
				<!-- END -->
				<!-- START: set <td> value -->
					if(col.type == 'progress') {
						column += ""
							+ "<div class='progress'>"
								+ "<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='" + day[col.name] + "' aria-valuemin='0' aria-valuemax='100' style='width:" + (day[col.name]/(60*12))*100 + "%'>"
								+ "</div>"
							+ "</div>"
						;
					}
					else {
						if(typeof day[col.name] != 'undefined') {
							column += day[col.name];
						}
					}
				<!-- END -->
				<!-- START: set hidden input -->
					column += ""
						+ "<input "
							+ "id='table-plan-tbody-day-" + day.day_id + "-column-" + col.id + "-hidden-input' "
							+ 'name="day_' + day['day_id'] + '.' + col.name + '" '
							+ "class='hidden' "
							+ "value='" + day_raw[col.name] + "'"
						+ "/>"
					;
				<!-- END -->
				<!-- START: close <td> -->
					column += "</td>";
				<!-- END -->
				
			});
		<!-- END -->
		
		<!-- START: set output for day -->
			var output_day = ""
				+ "<tbody id='table-plan-tbody-day-"+day.day_id+"' class='tbody-day'>"
					+ "<tr class='row-day'>"
							+ column
					+ "</tr>"
				+ "</tbody>"
			;
		<!-- END -->
		
		<!-- START: set output for command -->
			var output_command = ""
				+ "<div>"
					+ "<a type='button' class='btn btn-simple pull-right icon-sort'>"
						+ "<i class='fa fa-fw fa-arrows-v' aria-hidden='true'></i>"
					+ "</a>"
					+ "<a type='button' class='btn btn-simple pull-right icon-delete' data-toggle='confirmation-delete'>"
						+ "<i class='fa fa-fw fa-trash' aria-hidden='true'></i>"
					+ "</a>"
					+ "<a type='button' class='btn btn-simple pull-right icon-toggle-day'>"
						+ "<i class='fa fa-fw fa-chevron-circle-down' aria-hidden='true'></i>"
					+ "</a>"
				+ "</div>"
			;
		<!-- END -->
		
		<!-- START: print output for day -->
			$("#table-plan").append(output_day); 
		<!-- END -->
		
		<!-- START: print output for command -->
			$("#table-plan-tbody-day-" + day.day_id + "-column-command").html("");
			$("#table-plan-tbody-day-" + day.day_id + "-column-command").append(output_command);
		<!-- END -->
	}
	
	function printLine(column, line, line_raw) {
		<!-- START: set column -->
			$.each(column, function(i, col) {
				<!-- START: select <td> property -->
					if(typeof col.lineId != 'undefined') { col.id = col.lineId; }
					if(typeof col.lineName != 'undefined') { col.name = col.lineName; }
					if(typeof col.lineClass != 'undefined') { col.class = col.lineClass; }
				<!-- END -->
				<!-- START: set <td> property -->
					column += "<td ";
						column += "id='table-plan-row-line-" + line.line_id + "-column-" + col.id + "' ";
						column += 'class="';
							if(typeof col.class != 'undefined') { column += col.class+' '; }
							if(col.visible == 'false') { column += 'hidden '; }
						column += '" ';
						column += 'style="';
							if(typeof col.lineStyle != 'undefined') { column += col.lineStyle; }
							if(col.align != '') { column += 'text-align:' + col.align + ';'; }
						column += '" ';
					column += ">";
				<!-- END -->
				<!-- START: set <td> text -->
					if(typeof line[col.name] != 'undefined' && line[col.name] != null) {
						if(col.name == 'time') {
							column += ''
								+ '<input '
									+ 'class="table-plan-row-line-column-time" '
									+ 'type="time" '
									+ 'value="' + line[col.name] + '" '
								+ '/>'
							;
						}
						else {
							column += line[col.name];
						}
					}
					else {
						if(col.name == 'time') {
							column += ''
								+ '<input '
									+ 'class="table-plan-row-line-column-time" '
									+ 'type="time" '
								+ '/>'
							;
						}
					}
				<!-- END -->
				<!-- START: set hidden input -->
					column += ""
						+ "<input "
							+ "id='table-plan-row-line-" + line.line_id + "-column-" + col.id + "-hidden-input' "
							+ 'name="day_' + line['day_id'] + '_line_' + line['line_id'] + '_' + col.name + '" '
							+ "class='hidden' "
							+ "value='" + line_raw[col.name] + "'"
						+ "/>"
					;
				<!-- END -->
				<!-- START: close <td> -->
					column += "</td>";
				<!-- END -->
			});
		<!-- END -->
		
		<!-- START: set output for line -->
			var output_line = ""
				+"<tr class='row-line hidden'>"
					+ column
				+"</tr>"
			;
		<!-- END -->
		
		<!-- START: set output for command -->
			var output_command = ""
				+ "<div>"
					+ "<a type='button' class='btn btn-simple pull-right icon-sort'>"
						+ "<i class='fa fa-fw fa-arrows-v' aria-hidden='true'></i>"
					+ "</a>"
					+ "<a type='button' class='btn btn-simple pull-right icon-delete' data-toggle='confirmation-delete'>"
						+ "<i class='fa fa-fw fa-trash' aria-hidden='true'></i>"
					+ "</a>"
				+ "</div>"
			;
		<!-- END -->
		
		<!-- START: print output for line -->
			$("#table-plan-tbody-day-"+line.day_id).append(output_line); 
		<!-- END -->
		
		<!-- START: print output for command -->
			$("#table-plan-row-line-" + line.line_id + "-column-command").html("");
			$("#table-plan-row-line-" + line.line_id + "-column-command").append(output_command);
		<!-- END -->
	}
	
	function printButtonAddDay(column) {
		<!-- START: set output -->
			var output = ""
				+ "<tbody>"
					+"<tr class='row-button'>>"
						+ "<td "
							+ "colspan='" + column.length + "' "
						+ ">"
							+ "<a class='text-center btn-block' onclick='getFormPlanValue();'>"
								+ "Add New Day"
							+ "</a>"
						+ "</td>"
					+"</tr>"
				+ "</tbody>"
			;
		<!-- END -->
		
		<!-- START: print output -->
			$("#table-plan").append(output); 
		<!-- END -->
	}
	
	function printButtonAddLine(column, tbody) {
		<!-- START: set output -->
			var output = ""
				+"<tr class='row-button row-line-button hidden'>"
					+ "<td "
						+ "colspan='" + column.length + "' "
					+ ">"
						+ "<a class='text-center btn-block'>"
							+ "Add New Line"
						+ "</a>"
					+ "</td>"
				+"</tr>"
			;
		<!-- END -->
		
		<!-- START: print output -->
			$(tbody).append(output); 
		<!-- END -->
	}
	
	function toggleDay() {
		var selected_day = $(this).closest("tbody").attr("id");
		if($("#" + selected_day + " .row-day").hasClass("selected") == true && $("#" + selected_day + " .row-line").hasClass("hidden") == false) {
			$(".row-line").addClass("hidden");
			$(".row-line-button").addClass("hidden");
			$(".fa-chevron-circle-down").removeClass("fa-flip-vertical");
		}
		else {
			$(".row-day").removeClass("selected");
			$(".row-line").addClass("hidden");
			$(".row-line-button").addClass("hidden");
			$(".fa-chevron-circle-down").removeClass("fa-flip-vertical");
			$("#" + selected_day + " .row-day").toggleClass("selected");
			$("#" + selected_day + " .row-line").toggleClass("hidden");
			$("#" + selected_day + " .row-line-button").toggleClass("hidden");
			$("#" + selected_day + " .fa-chevron-circle-down").toggleClass("fa-flip-vertical");
		}
	}
	
	function updateTablePlanButtonEvent() {
		$(".row-day").on("click", toggleDay);
		$('.icon-sort').on('mousedown', function() {
			var selected_day = $(this).closest("tbody").attr("id");
			$("# "+ selected_day + " .row-line").addClass("hidden");
			$(this).on('mouseup', function() {	
				$("# "+ selected_day + " .row-line").removeClass("hidden");
			});
		});
	}
	
	function initSortableDay (data_cooked) {	
		var from_row_day_index;
		var from_row_day_id;
		var to_row_day_id;
		$("#table-plan").sortable({	
			delay: 100,
			axis: "y",
			items: ">.tbody-day", 
			handle: ">.row-day",
			appendTo: "parent",	
			cursorAt: {
				top: 15
			},
			helper: function(event, ui) {
				return $('<div style="white-space:nowrap; height:48px;"></div>');
			},
			placeholder: {
				element: function(currentItem) {
					var count = $("tr").children("td:not(.hidden)").length;
					return $("<tr><td colspan ='"+ count +"'></td></tr>");
				},
				update: function(container, p) {
					return;
				}
			},
			start: function(e, ui) {
				$(ui.helper).addClass("ui-draggable-helper");
				$(ui.placeholder).addClass("ui-draggable-placeholder-day");
				$(ui.helper).html($(ui.item).find(".day").html());
				from_row_day_index = $(ui.item).index();
				from_row_day_id = ui.item.attr("id");
			},
			sort: function(event, ui) {
				if (from_row_day_index > $(ui.placeholder).index()) { 
					to_row_day_id = $(ui.placeholder).next("tbody").attr("id");
				}
				else {
					to_row_day_id = $(ui.placeholder).prev("tbody").attr("id");
				}
				sort_order = $("#" + to_row_day_id + " .col-sort-order").html();
				$(ui.placeholder).children("td").html("Reschedule to D"+sort_order);
			},
			stop: function( event, ui ) {
				updateTablePlanDayDate(data_cooked);
			}
		}).disableSelection();
	}
	
	function initSortableLine () {
		var from_row_day_id;
		var to_row_day_id;
		$(".tbody-day").sortable({
			delay: 100,
			axis: "y",
			items: ">.row-line",
			appendTo: "parent",
			connectWith: ".tbody-day",	
			cursorAt: { 
				top: 15
			},
			helper: function(event, ui) {
				return $('<div style="height:48px;"></div>');
			},
			placeholder: {
				element: function(currentItem) {
					// Customize Placeholder with number of child not hidden
					var count = $("tr").children("td:not(.hidden)").length;
					return $("<tr><td colspan ='"+ count +"'></td></tr>");
				},
				update: function(container, p) {
					return;
				}
			},
			start: function(e, ui) {
				$(ui.helper).addClass("ui-draggable-helper");
				$(ui.helper).html($(ui.item).find(".poi-info").html());
				$(ui.placeholder).addClass("ui-draggable-placeholder");
				from_row_day_id = ui.item.parent().attr("id");
			},
			sort: function(event, ui) {
				var tbody = $(ui.placeholder).closest("tbody").attr("id");
				day_sort_order = $("#" + tbody + " .col-sort-order").html();
				$(ui.placeholder).children("td").html("Move to D"+ day_sort_order);
			},
			update: function( event, ui ) {
				var selected_day = $(this).closest("tbody").attr("id");
				to_row_day_id = selected_day;
			},
			stop: function( event, ui ) {
			}
		}).disableSelection();
	}
	
	<!-- START: script for manage data -->
		function updateTablePlanDayDate(data_cooked) {
			$('.row-day').each(function(){
				var speed = 300;
				var index= $(this).parent('.tbody-day').index();
				$(this).find(".col-sort-order").fadeOut(speed, function() {
					$(this).html(index).fadeIn(speed);
				});
				$(this).find(".col-day").fadeOut(speed, function() {
					$(this).html("D" +index).fadeIn(speed);
				});
				$(this).find(".col-date").fadeOut(speed, function() {
					$(this).html(data_cooked.day[index-1].date).fadeIn(speed);
				});
			})	
		}
	<!-- END -->
	
	<!-- START: script for manage data format -->
		function setTablePlanDataFormatForDayDay(plan) {
			for (i=0; i<plan.day.length; i++) {
				plan.day[i].day = 'D'+plan.day[i].sort_order;
			}
			return plan;
		}
		
		function setTablePlanDataFormatForDayDate(plan) {	
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
		
		function setTablePlanDataFormatForDayDuration(plan) {
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
		
		function setTablePlanDataFormatForLineDuration(plan) {
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
	
	
	<!-- START: script for manage display -->
		function refreshTablePlan() {
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
							runRefreshTablePlan(plan);
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
							runRefreshTablePlan(plan);
						<!-- END -->
					}
					else {
						<!-- START: [revisit] -->
							plan = JSON.parse(plan);
							runRefreshTablePlan(plan);
						<!-- END -->
					}
				<!-- END -->
			<?php } ?>
		}
			
		function runRefreshTablePlan(plan) {
			<!-- START: set raw data -->
				var data_raw = $.extend(true,{},plan); //IMPORTANT: to make sure clone without reference
			<!-- END -->
			
			<!-- START: set data format-->
				plan = setTablePlanDataFormatForDayDay(plan);
				plan = setTablePlanDataFormatForDayDate(plan);
				plan = setTablePlanDataFormatForDayDuration(plan);
				plan = setTablePlanDataFormatForLineDuration(plan);
			<!-- END -->
			
			<!-- START: set modified data -->
				data_cooked = plan;
			<!-- END -->
			
			<!-- START: print table -->
				$.each(data_cooked.day, function(i) {
					printDay(window.column, this, data_raw.day[i]);
					if(typeof this.line != 'undefined' && this.line.length > 0) {
						$.each(this.line, function(j) {
							printLine(window.column, this, data_raw.day[i].line[j]);
						});
					}
					printButtonAddLine(window.column, "#table-plan-tbody-day-" + this.day_id);
				});
				printButtonAddDay(window.column);
			<!-- END -->
			
			<!-- START: init function -->
				updateTablePlanButtonEvent();
				initSortableDay(data_cooked);
				initSortableLine();
			<!-- END -->
		}
	<!-- END -->
	
	$(document).ready(function() {
		refreshTablePlan();
	});
</script>