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
			overflow-x:auto;
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
			height:calc(100vh - 50px - 30px - 50px - 40px - 40px);	
		}
		
		.plan-tbody > div {
			direction:ltr;
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
		
		.plan-btn-add-line a {
			outline:thin dashed #CCC;
		}
		
		.plan-btn-tr a {
			color:#CCC;
		}
		
		.plan-btn-tr a:hover {
			color:#333;	
		}
		
		.plan-btn-tr:hover {
			background-color:#EEE;
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
			height: 41px;
			text-align: center;
			border-bottom:solid thin #DDD;
		}
		
		.ui-draggable-helper {
			height: 40px;
			background-color: white;
			opacity: 0.5;
			font-size: 1.5em;
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
<div id="section-content-itinerary">
	<div id="section-content-itinerary-header">
    	<div id="section-content-itinerary-header-content">
            <div id="section-content-itinerary-header-button">
            	<a id='btn-search' class="btn btn-primary pull-left noselect"><i class="fa fa-fw fa-search"></i> Discover</a>
                <a class="btn-show-date-form pull-right noselect">Set Date</a>
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
												activity:"Visit",
												place:"Tokyo Tower",
												fee:500,
												currency:'JPY',
												note:"Check out One Piece"
											},
											{
												line_id:2,
												day_id:1,
												sort_order:2,
												time:"11:00",
												duration:60,
												activity:"Visit",
												place:"Osaka Tower",
												fee:600,
												currency:'JPY',
												note:''
											},
											{
												line_id:3,
												day_id:1,
												sort_order:3,
												time:null,
												duration:null,
												activity:"Visit",
												place:"Kyoto Tower",
												fee:null,
												currency:null,
												note:null
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
			
			<!-- START: set plan date -->
				printDate(data_raw);
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
				updateDateFormButtonEvent();
				initSortableDay();
				initSortableLine();
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
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-sort'>"
							+ "<i class='fa fa-fw fa-arrows-v' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-delete' data-toggle='confirmation-delete' data-id='plan-day-" + day.day_id+"-tr'>"
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
						if(col.name == 'note') {
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
					+ "<div class='plan-line-tr' id='plan-line-" + line.line_id + "-tr'>"
						+ "<form class='plan-line-form plan-form' id='plan-line-" + line.line_id + "-form'>"
							+ html_plan_form
						+ "</form>"
						+ "<form class='plan-line-form-hidden plan-form-hidden hidden' id='plan-line-" + line.line_id + "-form-hidden'>"
							+ html_plan_form_hidden
						+ "</form>"
					+ "</div>"
				;
			<!-- END -->
			
			<!-- START: set output for command -->
				var output_command = ""
					+ "<div>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-sort'>"
							+ "<i class='fa fa-fw fa-arrows-v' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-delete' data-toggle='confirmation-delete' data-id='plan-line-" + line.line_id+"-tr'>"
							+ "<i class='fa fa-fw fa-trash' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='plan-btn btn btn-simple pull-right icon-edit' data-toggle='modal' data-target='#modal-edit-line'>"
							+ "<i class='fa fa-fw fa-pencil' aria-hidden='true'></i>"
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
			
			<!-- START: initiate tooltip for note -->
				$('.fa-sticky-note').tooltip();
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
			if(plan.travel_date != '') {
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
			return plan;
		}
		
		function setPlanTableDataFormatForDayDuration(plan) {
			for(i=0; i<plan.day.length; i++) {
				if(typeof plan.day[i].line != 'undefined' &&  plan.day[i].line.length > 0) {
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
				if(typeof plan.day[i].line != 'undefined' &&  plan.day[i].line.length > 0) {
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
	
	<!-- START: [button function] -->
		function updatePlanTableButtonEvent() {
			$(".plan-day-form").off().on("click", toggleDay).trigger("update-map");;
			// Function for delete Day & Line
			deleteDayLine();
			
			// Event Listener: Repeated????????
			/*$('.icon-edit').off().on('click', function() {
				var line = $(this).closest('.plan-line-tr').attr('id');
				editPlanLine(line);
			});*/
			
			// Event Listener: Add Day and Add/ Edit Line
			$(".plan-btn-add-day").off().on("click", addPlanDay);
			$(".plan-btn-add-line").off().on("click", openAddPlanLineModal);
			$('.icon-edit').off().on('click', function() {
				var line = $(this).closest('.plan-line-tr').attr('id');
				openEditPlanLineModal(line);
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
		
		<!-- START: [date form] -->
			function showDateForm() {
				$("#section-content-itinerary-header-button").addClass("hidden");
				$("#section-content-itinerary-header-set-date").removeClass("hidden");
				$("#section-content-itinerary-content-modal-background").removeClass("hidden");
				$('#plan-date-form-hidden input[name=num_of_day]').val($('.plan-day-tr').length);
				updateDateForm();
				//$("#section-content-itinerary-content-modal-background").off().on("click", cancelDateForm);
			}
			
			function hideDateForm() {
				$("#section-content-itinerary-header-button").removeClass("hidden");
				$("#section-content-itinerary-header-set-date").addClass("hidden");
				$("#section-content-itinerary-content-modal-background").addClass("hidden");
				$("#section-content-itinerary-content-modal-background").off();
			}
			
			function saveDateForm() {
				$('#plan-date-form-hidden input[name=travel_date]').val($('#plan-date-form input[name=travel_date]').val());
				$('#plan-date-form-hidden input[name=last_date]').val($('#plan-date-form input[name=last_date]').val());
				var day_difference = parseInt($('#plan-date-form-hidden input[name=num_of_day]').val()  - $('.plan-day-tr').length);
				if(day_difference > 0) {
					for(i=0;i<day_difference;i++) {
						setTimeout(function() {
							addPlanDay();
						}, 10);
					}
				}
				savePlanTravelDate();
				updatePlanTableDayDate();
				hideDateForm();
			}
			
			function cancelDateForm() {
				$('#plan-date-form input[name=travel_date]').val($('#plan-date-form-hidden input[name=travel_date]').val());
				$('#plan-date-form input[name=last_date]').val($('#plan-date-form-hidden input[name=last_date]').val());
				hideDateForm();
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
			}
		}
		
		function initSortableDay () {	
			$(".plan-day").sortable({	
				delay: 100,
				axis: "y",
				items: ">.plan-day-tr", 
				cancel: ">.plan-line-tr",
				handle: ">.plan-day-form",
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
					updatePlanTableCookie();
				}
			}).disableSelection();
		}
		
		function initSortableLine() {
			var from_row_day_id;
			var to_row_day_id;
			var drop_id_to_sortable;
			
			function initRefreshDroppable () {
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
			}
			initRefreshDroppable ();
								
			$(".plan-day-line").sortable({
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
				},
				over: function(e, ui) {
					$(".plan-day-tr").droppable("disable");
					$(ui.helper).html(ui.item.find(".plan-col-activity").html());
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
					updatePlanTableDuration();
					updatePlanTableCookie();
					
					//$( ".plan-day-line").sortable("refreshPositions");
					$( ".plan-day-tr" ).droppable( "destroy" );
					//initRefreshDroppable ();
					initSortableLine();
				}
			}).disableSelection();
		}
	<!-- END -->
	
	<!-- START: [update data] -->
		function updatePlanTableCookie() {
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
										serial += JSON.stringify($('#plan-line-'+line_id+'-form-hidden').find('.plan-input-hidden').not('[value="undefined"]').serializeObject());
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
			setCookie('plan',serial,1);
			
			//initMap();
		}
		
		function updatePlanTableDayDate() {
			var travel_date = $('#plan-date-form input[name=travel_date]').val();
			var num_of_day = $('#plan-date-form-hidden input[name=num_of_day]').val();
			var day = new Array();
			var date;
			
			if(travel_date != '') {
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
		
		function updatePlanTableDuration() {
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
	
	<!-- START: [edit plan] -->
		function savePlanTravelDate() {
			updatePlanTableCookie(); 
		}
	<!-- END -->
		
		function deleteDayLine(){
			var selected_delete_id, hint_text;
			$('[data-toggle=confirmation-delete').confirmation({
				container: "body",
				singleton: true,
				popout: true,
				title: "Confirm DELETE?",
				html: true,
				content: function (){
					selected_delete_id = $(this).attr('data-id');
					content_text ="";
					
					if (selected_delete_id.includes("day")) {
						day_number = $("#"+selected_delete_id).find(".plan-col-day").html().replace( /^\D+/g, '');
						if ($("#" + selected_delete_id).find(".plan-line-tr").length > 0) {
							content_text += "<div class='alert alert-danger'>Day "+ day_number 														
							content_text += " is not <strong>empty.</strong></div>"
							hint_text = "Day " + day_number;
						}
						else content_text = "Day " + day_number;
					}
					
					else {
						line_name = $("#"+ selected_delete_id).find(".plan-col-place").html();
						day_number = $("#"+selected_delete_id).parent().parent().parent().find(".plan-col-day").html().replace( /^\D+/g, '');
						content_text = line_name + " in Day " + day_number;
					}
					if (!hint_text) hint_text  = content_text;
					return content_text;					
				},
				onConfirm: function (){
					
					if ($("#" + selected_delete_id).hasClass("plan-day-tr") && $(".plan-day-tr").length < 2) {
						content_text = "";
						hint_action = "delete-limit";						
					}
					else {
						$(this).confirmation('destroy');							
						$("#"+ selected_delete_id).remove();
						hint_action = "deleted";	
						<!-- START: update hidden input -->
						var old_num_of_day = parseInt($('#plan-date-form-hidden input[name=num_of_day]').val());
						var new_num_of_day = old_num_of_day - 1;
						$('#plan-date-form-hidden input[name=num_of_day]').val(new_num_of_day);
						<!-- END -->									
					}
					updatePlanTableDayDate();
					updatePlanTableCookie();
					updatePlanTableButtonEvent();
					
					showHint(hint_action, hint_text);
				}
			});	
		}	
	
	<!-- START: [edit day] -->
		function addPlanDay() {
			<!-- START: set column -->
				var column = <?php echo $column_json; ?>;
			<!-- END -->
			<!-- START: set data -->
				var sort_order = parseInt($('.plan-day-tr').length) + 1;
				/// lokgot remove line >>>> var day_id = sort_order;
				/// lokgot add line >>>
				var day_id = 0;
				var i = 1;
				while (day_id < 1) {
				var check_id = $("#plan-day-" + i + "-tr").length;
				if (check_id < 1) day_id = i;
				i ++;
				} ;
				var data = {'day_id':day_id,'sort_order':sort_order};
			<!-- END -->
			<!-- START: update hidden input -->
				var old_num_of_day = parseInt($('#plan-date-form-hidden input[name=num_of_day]').val());
				var new_num_of_day = old_num_of_day + 1;
				$('#plan-date-form-hidden input[name=num_of_day]').val(new_num_of_day);
			<!-- END -->
			printDay(column,data,data);
			printButtonAddLine(column, "#plan-day-" + data.day_id + "-content");
						
			<!-- START: init function -->
				updatePlanTableCookie();
				updatePlanTableButtonEvent();
				updateDateFormButtonEvent();
				updatePlanTableDayDate();
				updatePlanTableDuration();
				initSortableDay();
				initSortableLine();
				
				var added_day = "Day " + new_num_of_day;
				showHint("add-day",added_day);
			<!-- END -->
			
			
			<!-- START -->
				if($('#section-content-guide').is(':visible')) {
					minimizePlanTableColumn();
				}
			<!-- END -->
		}
	<!-- END -->
	
	<!-- START: [edit line] -->
		function openAddPlanLineModal() {
			$('#modal-edit-line-form').trigger("reset");
			
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
			$('#modal-edit-line-form').trigger("reset");
			
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
			var note = $('#'+line).find('.plan-line-form-hidden input[name=note]').val();
			
			$('#modal-edit-line-form input[name=line_id]').val(line_id);
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
				/// lokgot remove line >>>var line_id = $('.plan-line-tr').length + 1;
					/// lokgot add line >>>
					var line_id = 0;
					var i = 1;
					while (line_id < 1) {
					var check_id = $("#plan-line-" + i + "-tr").length;
					if (check_id < 1) line_id = i;
					i ++;
					} ;
				
				var type_id = $('#modal-edit-line-form input[name=type_id]').val()||null;
				var type = $('#modal-edit-line-form input[name=type]').val()||null;
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
				var note = $('#modal-edit-line-form textarea[name=note]').val()||null;
			<!-- END -->
			
			<!-- START: set print data -->
				var column = <?php echo $column_json; ?>;
				var line = 
					{
						line_id		:line_id,
						type		:type,
						type_id		:type_id,
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
						note		:note
					}
				;
				var line_raw =
					{
						line_id		:line_id,
						type		:type,
						type_id		:type_id,
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
						note		:note
					}
				;
			<!-- END -->
			
			printLine(column,line,line_raw);
			
			<!-- START: init function -->
				updatePlanTableCookie();
				updatePlanTableButtonEvent();
				updateDateFormButtonEvent();
				updatePlanTableDuration();
				initSortableLine();
				
				var added_line = "";
				if (!place) added_line = "New Line";
				else added_line = place;
				added_line += "," + $("#plan-day-"+ day_id +"-tr").find(".plan-col-day").html().replace( /^\D+/g, '');
				
				showHint("add-line",added_line);
			<!-- END -->
		}
		
		function saveEditPlanLineForm() {
			var line_id = $('#modal-edit-line-form input[name=line_id]').val();
			var type_id = $('#modal-edit-line-form input[name=type_id]').val();
			var type = $('#modal-edit-line-form input[name=type]').val();
			var place = $('#modal-edit-line-form input[name=place]').val();
			var lat = $('#modal-edit-line-form input[name=lat]').val()||null;
			var lng = $('#modal-edit-line-form input[name=lng]').val()||null;
			var activity = $('#modal-edit-line-form input[name=activity]').val()||null;
			var time = $('#modal-edit-line-form input[name=time]').val()||null;
			var hour = $('#modal-edit-line-form input[name=hour]').val()||null;
			var minute = $('#modal-edit-line-form input[name=minute]').val()||null;
			var duration = (parseInt(hour) * 60 + parseInt(minute))||null;
			var fee = $('#modal-edit-line-form input[name=fee]').val()||null;
			var currency = $('#modal-edit-line-form select[name=currency]').val()||null;
			var note = $('#modal-edit-line-form textarea[name=note]').val()||null;
			
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=type_id]').val(type_id);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=type]').val(type);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=place]').val(place);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=lat]').val(lat);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=lng]').val(lng);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=activity]').val(activity);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=time]').val(time);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=duration]').val(duration);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=fee]').val(fee);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=currency]').val(currency);
			$('#plan-line-'+line_id+'-tr').find('.plan-line-form-hidden input[name=note]').val(note);
			
			$('#plan-line-'+line_id+'-tr').find('.plan-col-place').html(place);
			$('#plan-line-'+line_id+'-tr').find('.plan-col-activity').html(activity);
			$('#plan-line-'+line_id+'-tr').find('.plan-col-time').html(time);
			if(duration == null) { 
				$('#plan-line-'+line_id+'-tr').find('.plan-col-duration').html('');
			}
			else {
				$('#plan-line-'+line_id+'-tr').find('.plan-col-duration').html(hour+'h '+minute+'m');
			}
			$('#plan-line-'+line_id+'-tr').find('.plan-col-fee').html(fee);
			$('#plan-line-'+line_id+'-tr').find('.plan-col-currency').html(currency);
			
			$('#plan-line-'+line_id+'-tr').find('.plan-col-note').find('.fa').attr('data-original-title',note);
			
			if(note == null || note == '') { 
				$('#plan-line-'+line_id+'-tr').find('.plan-col-note').find('.fa').addClass('hidden'); 
			}
			else {
				$('#plan-line-'+line_id+'-tr').find('.plan-col-note').find('.fa').removeClass('hidden'); 
			}
			
			updatePlanTableCookie();
			updatePlanTableDuration();
		}
	<!-- END -->
	
	$(document).ready(function() {
		refreshPlanTable();
		$(".plan-day-form").first().trigger("click");
	}).trigger("update-map");
	
	
</script>

<!-- START: add function to search button -->
	<script>
		function minimizePlanTableColumn() {
			$('.plan-thead').hide();
			$('.plan-tbody').css('overflow-y','hidden');
			$('.plan-col-datetime').hide();
			$('.plan-col-date').hide();
			$('.plan-col-time').hide();
			$('.plan-col-place').hide();
			$('.plan-col-activity').hide();
			$('.plan-col-fee').hide();
			$('.plan-col-currency').hide();
			$('.plan-col-note').hide();
			$('.plan-col-command').hide();
			$('.plan-day-content').hide();
			$('.plan-col-day').css('padding-left','15px');
		}
		
		function maximizePlanTableColumn() {
			$('.plan-thead').show();
			$('.plan-tbody').css('overflow-y','scroll');
			$('.plan-col-datetime').show();
			$('.plan-col-date').show();
			$('.plan-col-time').show();
			$('.plan-col-place').show();
			$('.plan-col-activity').show();
			$('.plan-col-fee').show();
			$('.plan-col-currency').show();
			$('.plan-col-note').show();
			$('.plan-col-command').show();
			$('.plan-day-content').show();
			$('.plan-col-day').css('padding-left','7px');
		}
		
        $('#btn-search').on('click', function() {
            toggle_section_content('guide');
            if($('#section-content-guide').is(':visible')) {
				minimizePlanTableColumn();
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
            else {
				maximizePlanTableColumn();
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
        });
 
<!-- END -->

<!-- Show popover hint (helper) -->
	function showHint(action, hint_text) {
		$("#hint-popover").hide();
		switch(action){
			case "deleted": 
				text = hint_text + " is removed."; 
				break;
			case "delete-limit": 
				text = "Cannot remove. There must be atleast 1 day."; 
				break;
			case "add-day": 
				text = hint_text + " is added."; 
				break;
			case "add-line": 
				var str = hint_text.split(",");
				text = str[0] + " is added into Day " + str[1]; 
				break;
		}	

		if (text) {	
			$("#hint-popover").html(text).fadeIn(600);
			setTimeout(function() { $("#hint-popover").delay(1000).fadeOut(300); }, 2000);
		}
	}
<!-- END -->

   </script>