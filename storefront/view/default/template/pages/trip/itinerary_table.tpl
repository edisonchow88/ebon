<!-- START: [Bootstrap toggle button] -->
    <link href="<?php echo $this->templateResource('/stylesheet/bootstrap-toggle.min.css'); ?>" rel="stylesheet">
    <script type="text/javascript" src="<?php echo $this->templateResource('/javascript/bootstrap-toggle.min.js'); ?>"></script>
<!-- END -->

<!-- START: [Bootstrap confirmation dialog] -->
<!--
	<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/bootstrap-confirmation.js'); ?>"></script>
-->
<!-- END -->

<style>
    #section-content-itinerary {
		position:relative;
    }
	
	#section-content-itinerary-header {
		position:relative;
		margin-right:15px;
    }
	
	#section-content-itinerary-header-button {
		position:absolute;
		top:35px;
		right:0;
		margin-right:7px;
    }
	
	#section-content-itinerary-header-button > a {
		padding:0;
		height:30px;
		width:30px;
	}
    
    #section-content-itinerary-content {
        position:relative;
        overflow-y:scroll;
        overflow-x:auto;	
    }
	
	#section-content-itinerary-footer {
		position:absolute;
		bottom:0;
		width:100%;
    }
	
	#section-content-itinerary-footer > a {
		width:50%;
		height:40px;
		padding:10px;
		display:block;
		float:left;
		border-left:none;
		border-right:none;
		border-bottom:none;
    }
    
    #section-content-itinerary-debug {
        border:1px solid #999;
        height: 100vh;
        padding:10px;
    }
	
	/* START: itinerary table */
        .itinerary-table {
			font-size:12px;
			text-align:left;
			table-layout:auto !important;
			width: 100%;
		}
		
		.itinerary-table > thead > tr { 
            background-color:#EEE;
            height:70px;
        }
		
		.itinerary-table > thead > tr > th {
			padding:7px;
			border:0;
            border-bottom:solid thin #EEE;
		}
		
		.itinerary-table > tbody > tr > td {
			height:48px;
			padding:7px;
			border:0;
            border-bottom:solid thin #EEE;
			vertical-align:middle;
		}
		
		.itinerary-table > tbody+tbody {
			border:0;
		}
	/* END */
	
	/* START: itinerary table row */
		.day-list {
		}
		
		.poi-list {
			background-color:#FFC;
		}
		
		.backup {
			background-color:#DDD;
		}
		
		.progress {
			width:80px;
			height:15px;
			margin:12px 0;
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
			background-color: rgba(220,220,220,0.3);
			height: 80px !important;
			text-align: center;
		}
		
		.ui-draggable-placeholder {
			background-color: rgba(220,220,220,0.3);
			height: 30px;
			text-align: center;
		}
		
		.ui-draggable-helper {
			height: 30px;
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
    </div>
    <div id="section-content-itinerary-content" >
    	<div id="section-content-itinerary-header-button">
            <a 
                class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                onclick="close_section_content('itinerary');"
                data-toggle='tooltip' 
                data-placement='bottom' 
                title='Close Itinerary' 
            >
                <i class="fa fa-fw" id="section-content-map-header-close">&times;</i>
            </a>
            <a 
                class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                onclick="open_section_content('itinerary');"
                data-toggle='tooltip' 
                data-placement='bottom' 
                title='Expand Itinerary' 
            >
                <i class="fa fa-fw fa-arrows-alt"></i>
            </a>
        </div>
        <table class="table itinerary-table" id="planner-table">
            <thead>
            	<th class="hidden">#</th>
                <th>Day</th>
                <th >Date</th>
                <th class="hidden">City</th>
                <th>Activity</th>
                <th class="hidden">Fee</th>
                <th></th>
            </thead>
        </table>
    </div>    

    <div id="section-content-itinerary-footer">
    	<a class="btn btn-primary add-day-icon">Add Day</a>
        <a class="btn btn-default">Add Note</a>
    </div>
</div>

<script>
<?php if($this->user->isLogged() != '') { ?>
	<!-- START: load table -->
		$(document).ready(function(){
			<!-- START: set POST data -->
				var data = {
					"action":"refresh_plan",
					"plan_id":"4",
				};
			<!-- END -->
			
			<!-- START: 1st loop for tbody -->
			$.post("<?php echo $ajax_itinerary; ?>", data, function(plan) {
				$.each(plan.day, function(i, field) {	
					printDay( "#planner-table", i , this.day_id, this.duration);
					<!-- START: 2nd loop for row (poi) -->		
						$.each(this.line, function(x, line) {
						// Call print poi function and send data, more data to be added.
						// >> printLine( tr_id, day_index, poi_index, poi_line_id, poi_info, poi_name ,action)
							printLine("#day-group" + i, i , x, line.id, line.title, line.title);
						})
					<!-- END -->
				});
			
				<!-- START: add pocket at end of table -->
					$("#planner-table").append(""
						+ "<tbody class='pocket' id='pocket'>"
							+ "<tr class='day-list row-fixed'>"
								+ "<td colspan='7' class='index'>"
									+ "<div class='btn-group' role='group' aria-label='Basic example'>"
										+ "<button type='button' class='btn btn-default btn-lg toggle-icon'>"
											+ "<i class='fa fa-shopping-basket fa-lg' aria-hidden='true'></br><span>Pocket</span></i>"
										+ "</button>"
										+ "<button type='button' class='btn btn-default btn-lg'>"
											+ "<i class='fa fa-plus-square fa-lg add-day-icon' aria-hidden='true'></br><span>Add Day</span></i>"
									+ "</div>"
								+ "</td>"
							+ "</tr>" 
						+ "</tbody>"
					);
				<!-- END -->
				
				// INIT: initilize update function
				initPageUpdate();
				updateEvent();
				
				$('.handle-icon').on('mousedown', function() {
					var this_day_group = $(this).closest("tbody").attr("id");
					$("#"+ this_day_group +" .poi-list").hide();
					if (!$("#"+ this_day_group).hasClass("poi-hidden")) {
					$(this).on('mouseup', function() {updatePoiHidden(this_day_group);});
					}
				});
			
			
			}, "json"); //////////// END of getJason Fuction, function must load before this for sequence
		});
	<!-- END -->
<?php } else { ?>
	$('#section-content-itinerary-content').append('Login is required');
<?php } ?>

////////////////////////////// PAGE LOAD INITIATE FUNCTION//////////////////////////////
// START initPageUpdate - To initiate 1st load Update
function initPageUpdate() {
		//Initialize: All bootstrap toggle for Backup
		$('.backup-toggle').bootstrapToggle();
		//Initialize: Set All POI Hidden - kept now for more smooth transition
		$(".day-group tr:not(:first-child)").hide();
		//Initialize: Setting up Sorting for Day (tbody)
		setDaySort();
		//Initialize: Setting up Sorting for POI (tr) 
		setPoiSort();
		//Initialize: Update index and date
		updateIndexDate();
} // END initPageUpdate

function updateEvent() {
		//OnClick Event: Call Function clickTogglePoi- Hide/Show POI
		$('.toggle-icon').off().on('click', clickTogglePoi);
		//OnClick Event: Toggle ready/backup for POI 
		$('.backup-toggle').off().change(function() {
		$(this).closest('.poi-list').toggleClass('backup');
		// !!!!!need to add function to remove total time calculation in a day.
		})		
		// OnClick Event: Run modal - Delete POI, Delete Day
		$('.remove-icon').off().on('click' ,{action:"remove"}, runModal);
		// OnClick Event: Run modal - Delete POI, Delete Day
		$('.add-day-icon').off().on('click' ,{action:"add-day"}, runModal);
		//OnClick Event: Response with Modal ok Button
		$('#modal-confirm').off().on('click' , responseModal );
}

// START print day - output day list and its action button.
function printDay( table_id, index, day_id, duration,action) {
	
		var data =		""+ "<tbody class='day-group poi-hidden' id='day-group"+ index +"'>"
						+ "<tr class='day-list row-fixed'>"
						+ "<td class='index hidden' id='day" + index +"'>" + day_id + "</td>"
						+ "<td class='d-day'></td>"
						+ "<td class='d-date'></td>"
						+ "<td class='hidden'></td>"
						+ "<td>"
							+ "<div class='progress'>"
								+ "<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='"+duration+"' aria-valuemin='0' aria-valuemax='100' style='width:"+(duration/(60*12))*100+"%'>"
								+ "</div>"
								+ "</div>"
						+ "</td>"
						+ "<td class='hidden'></td>"
						+ "<td class='action-button' id='day-action-button_" + index +"'></td>"
						+ "</tr>"
						+ "<tr class='poi-empty'><td colspan='7'>There is no plan for today.</td></tr>";	
	
		var day_button =""+ "<div>"
						+ "<a type='button' class='btn btn-simple pull-right remove-icon' data-toggle='confirmation-delete'>"
							+ "<i class='fa fa-fw fa-trash' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='btn btn-simple pull-right handle-icon'>"
							+ "<i class='fa fa-fw fa-arrows' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='btn btn-simple pull-right toggle-icon'>"
							+ "<i class='fa fa-fw fa-chevron-circle-down' aria-hidden='true'></i>"
						+ "</a>"
						+ "</div>";

		// When add day >> add new day (tbody+tr) to last row			
		if (action == "add-day")$(table_id).children(".pocket").last().before(data); // change if pocket remove
		// When 1st run >> append to table
		else	$( table_id ).append(data); 	
	
		// Print all action button for this day
		$("#day-action-button_" + index ).append(day_button);
		
		if (action == "add-day") {
			// Update index and date for NEW added day 
			updateIndexDate();
			// Update sortable for NEW added day 
			setPoiSort ();
			// Update show empty hint for NEW added day
	   	 	updatePoiEmpty ("day-group" + index);
			// Update close POI list for NEW added day
			updatePoiHidden("day-group" + index);
			// Update onclick event for NEW added day
			updateEvent();
		}
} // END print day

// START print POI - output poi list and its action button for this/selected day.
function printLine( tr_id, day_index, poi_index, poi_line_id, poi_info, poi_name ,action) {

		var data =		""+ "<tr class='poi-list' id='day"+day_index+"poi"+poi_index+"'>"
						+ "<td></td>"
						+ "<td class='order' ></td>"
						+ "<td class='hidden'>" + poi_line_id + "</td>"
						+ "<td class='hidden poi-info'>" + poi_info+ "</td>"
						+ "<td>" + poi_name+ "</td>"
						+ "<td class='hidden'></td>"
						+ "<td class='poi-action-button text-right' id='poi-action-button_"+day_index+"_"+poi_index+"'></td>"
						+ "</tr>";
	
	
		var poi_button= ""+ "<div>"
						+ "<a type='button' class='btn btn-simple pull-right remove-icon' data-toggle='confirmation-delete' data-on-confirm=''>"
						+ "<i class='fa fa-fw fa-trash' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='btn btn-simple pull-right poi-handle-icon'>"
						+ "<i class='fa fa-fw fa-arrows' aria-hidden='true'></i>"
						+ "</a>"
							+ "<div class='pull-right'>"
							+ "<input class='backup-toggle' type='checkbox' checked data-toggle='toggle' data-on='ON' data-off='OFF' data-onstyle='success' data-offstyle='danger' data-size='mini'>"
							+ "</div>"
						+ "</div>";
	
		// when add poi >> add poi(tr) to last row in selected day(tbody) NOT COMPLETE YET!!
		if (action == "add-poi") $( tr_id + day_index +".poi-list" ).last().after(data);	
		// when 1st run >> append to this day(tbody)
		else $( tr_id).append(data);
		
		<!-- START: add button group for current poi -->
		$("#poi-action-button_"+day_index+"_"+poi_index).append(poi_button);
		
		if (action == "add-poi") {
			// Update onclick event for NEW added POI
			updateEvent();
			// Update show empty hint for this day (remove empty hint when new POI added)
	    	updatePoiEmpty ("day-group" + day_index);
			// Update close POI list for this day
			updatePoiHidden("day-group" + day_index);
		}
}// END print POI

// START updatePoiEmpty - make hint show up when day-group empty
function updatePoiEmpty (day_group_id) {
	// get SELECTOR for current day-group >> .poi-empty is the class for the hint tr (normally hidden)
	var is_empty = $("#"+day_group_id).children(".poi-empty");
	// when current day-group doesnt have POI >> show hint, "can-toggle" make hint can affected by POI toggle button 
	if ($("#"+day_group_id).children(".poi-list").length < 1 ) {
	is_empty.show("slow");
	is_empty.addClass("can-toggle");
	}
	// When current day-group have POI >> hide hint, make hint always hidden and cannot affected by POI toggle button
	else {
	is_empty.hide("slow");
	is_empty.removeClass("can-toggle");
	}
}// END updatePoiEmpty

// START updatePoiHidden - check this day-group poi-list hidden status and update
function updatePoiHidden (day_group_id) {
	// get SELECTOR for current day-group
	var is_hidden = $("#"+day_group_id).children(".poi-list, .can-toggle");
	// when current day-group is hidden >> hide poi-list, make sure toggle button is correct.
	if ($("#"+day_group_id).hasClass("poi-hidden") ) {
	is_hidden.hide("slow");
	$("#"+ day_group_id +" .fa-chevron-circle-down" ).removeClass("fa-flip-vertical").fadeIn("slow");
	}
	// when current day-group is visible >> show poi-list, make sure toggle button is correct.
	else {
	is_hidden.show("slow");
	$("#"+ day_group_id +" .fa-chevron-circle-down" ).addClass("fa-flip-vertical").fadeIn("slow");
	}
}//Empty updatePoiHidden

// START runModal - Activate Modal Dialog (get event data) 
function runModal(event) {	
	if ( event.data.action == "remove") {
		var this_id;
		if ($(this).parents("tr").hasClass("day-list")) 	this_id = $(this).closest("tbody").attr("id");
		else this_id = $(this).closest(".poi-list").attr("id");
		$(".modal-body").html("Remove current POI "+ this_id +"?");
		$("#modal-confirm").data( "data", {target_id: this_id, action: event.data.action} );	
	}
	
	else if ( event.data.action == "add-day") {
		$(".modal-body").html("Add new day?");
		$("#modal-confirm").data( "data", {target_id: this_id, action: event.data.action} );	
	}
	$("#myModal").modal();
}// END Activate Modal Dialog

// START responseModal - Remove Row Function (DAY or POI) ->Add day
function responseModal() {
	if ($(this).data("data").action == "remove") {
		var remove_id = $(this).data("data").target_id;
		$( "#" + remove_id ).fadeOut( "slow", function() {
		$( "#" + remove_id ).remove()
		;});
	}
	
	else if ($(this).data("data").action == "add-day") {
	var count = $(".day-group").length;
	var i = count ;
	// IMPORTANT to ask database add new row then get the latest day-id
	printDay( "#planner-table", i, "after", 0 ,"add-day");
	} 
	
}// END responceModal


// START Toggle hide/show POI in Day function
function clickTogglePoi() {
	// get SELECTOR for current day-group
	var this_class = $(this).closest("tbody").attr("id");
	// get SELECTOR for previous shown day-group, if have
	var pre_hidden = $(".day-group").not(".poi-hidden").attr("id");
	// add/remove Poi-list hidden status for current day-group
	$("#" + this_class).toggleClass("poi-hidden");
	// add Poi-list hidden status for previous shown day-group (when open this day, close all other day)
	$("#" + pre_hidden).addClass("poi-hidden");
	
	updatePoiHidden (this_class);
	updatePoiHidden (pre_hidden);
	
}// END Toggle hide/show POI in Day function

// START Set Day Sorting Function
function setDaySort () {	
	var from_day_group_index;
	var from_day_group_id;
	var to_day_group_id;
	$("#planner-table").sortable({	
	revert: true,
	axis: "y",
	start: function(e, ui){
        $(ui.helper).addClass("ui-draggable-helper");
		$(ui.placeholder).addClass("ui-draggable-placeholder-day");
		$(ui.helper).html($(ui.item).find(".day").html());
		from_day_group_index = $(ui.item).index();
		from_day_group_id = ui.item.attr("id");
			},
    items: ">.day-group:not(:last-child)", 
	cancel: ">.poi-list" ,
    appendTo: "parent",
	handle: "tr .handle-icon",
    helper: function(event, ui) {
		var drag_day = $(this).attr("id");
    	return $('<div style="white-space:nowrap; height:80px;"/>');},
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
	sort: function(event, ui) {
		if (from_day_group_index > $(ui.placeholder).index()) to_day_group_id = $(ui.placeholder).next("tbody").attr("id");
		else to_day_group_id = $(ui.placeholder).prev("tbody").attr("id");
		this_day = $("#" + to_day_group_id +" .d-day").html();
		$(ui.placeholder).children("td").html("Reschedule to "+this_day);
	},	
	cursorAt: {top: 15},
	stop: function( event, ui ) {
		updateIndexDate();
		updatePoiHidden(from_day_group_id);
}
}).disableSelection();
}// End Day Sorting Function



// START Set POI Sorting Function
function setPoiSort () {
	var from_day_group_id;
	var to_day_group_id;
		$(".day-group").sortable({
	//delay: 100,
	axis: "y",
	start: function(e, ui){
        $(ui.helper).addClass("ui-draggable-helper");
		$(ui.helper).html($(ui.item).find(".poi-info").html());
		$(ui.placeholder).addClass("ui-draggable-placeholder");
		from_day_group_id = ui.item.parent().attr("id");
			},
    items: ">.poi-list",
    appendTo: "parent",
	connectWith: ".day-group",
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
	sort: function(event, ui) {
		var p_onday = $(ui.placeholder).closest("tbody").attr("id");
		p_onday = $("#" + p_onday +" .day").html();
		$(ui.placeholder).children("td").html("Move to "+ p_onday);
	},	
	cursorAt: { top: 15  },
    helper: function(event, ui) {
    return $('<div style="white-space:nowrap; height:30px;"/>');},
	update: function( event, ui ) {
		var this_day = $(this).closest("tbody").attr("id");
		//if (( $("#" + this_day).children(".poi-list:hidden").length >0 ))  $("#" + this_day +" tr:not(:first-child):visible").fadeToggle();
		to_day_group_id = this_day;
	},
	stop: function( event, ui ) {
		updatePoiEmpty (from_day_group_id);
		updatePoiEmpty (to_day_group_id);
		updatePoiHidden (to_day_group_id);
}
	
}).disableSelection();
}// End POI Sorting Function

// START get date list
function getDateList ()
{	var first_date = new Date("2016-02-09");
	//var no_of_days = 4;
	var no_of_days = $(".day-group").length;
	var monthNames = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
	var day_list = [];
	for (i = 0; i < no_of_days; i++) {
  		myDate = new Date(first_date.setDate(first_date.getDate() + 1));
  		day_list[i] = myDate.getDate() + "&nbsp;" + monthNames[(myDate.getMonth())] ;
			// Add year? -->  + "-" + myDate.getFullYear()
}

	return day_list;
}// End get date list

// START Update Day Index and Date
function updateIndexDate(){
		var date_list = getDateList ();
		
		$('.day-list').each(function(){
     	var index= $(this).parent('.day-group').index();
		$(this).find(".d-day").fadeOut(300, function() {
        $(this).html("D" +index).fadeIn(300);
		});
		$(this).find(".d-date").fadeOut(300, function() {
        $(this).html(date_list[index-1]).fadeIn(300);
		});
	})	
}// END Update Day Index and Date




</script>


 <!-- Modal -->
 <!--
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                	<button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
            <div class="modal-body">
            	<p>Some text in the modal.</p>
            </div>
            <div class="modal-footer">
                <button type="button" id="modal-confirm" class="btn btn-default" data-dismiss="modal">Confirm</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>




<div id="section-content-itinerary-debug" class="hidden col-sm-3">
    <p>This is for the trip data</p>
    <p id="trip">Trip Name</p>
    <p>No.of Day: <?php echo $maxday; ?> </p>
    <p id="debug">Debug: </p>
    <p id="debug2">Debug: </p>
    <p id="debug3">Debug: </p>
    <a tabindex="0" class="btn btn-lg btn-danger" role="button" data-toggle="confirmation" data-trigger="focus" title="Dismissible popover" data-content="		
    	<button>123 </button>">Dismissible popover
    </a>
    <button class="btn btn-default" data-toggle="confirmation">Confirmation</button>
	<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>
</div>
</div>
-->