<!-- Latest compiled and minified CSS (Jquery UI)-->
<!--
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">
// Change JQueryUI plugin names to fix name collision with Bootstrap.
//$.widget.bridge('uitooltip', $.ui.tooltip);
//$.widget.bridge('uibutton', $.ui.button);
</script>

<!-- Latest compiled and minified JavaScript (Bootstrap)-->
<!--
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<!-- Bootstrap Toggle button-->
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-confirmation/1.0.5/bootstrap-confirmation.js"></script>

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
			width:100px;
			height:10px;
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

<script>
<!-- START: load table -->
	$(document).ready(function(){
		<!-- START: 1st loop for tbody -->
		$.getJSON("<?php echo $ajax_itinerary; ?>", function(result) {
			$.each(result.day, function(i, field) {
				$("#planner-table").append(""
					+ "<tbody class='day-group' id='day-group"+ i +"'>"
					+ "<tr class='day-list poi-fixed'>"
						+ "<td class='index hidden' id='day" + i +"'> Line" + this.line_id + "</td>"
						+ "<td class='day'>D"+ this.sort_order + "</td>"
						+ "<td class='hidden'>8h</td>"
						+ "<td class='hidden'></td>"
						+ "<td>"
							+ "<div class='progress'>"
								+ "<div class='progress-bar progress-bar-success' role='progressbar' aria-valuenow='"+this.percentage+"' aria-valuemin='0' aria-valuemax='100' style='width:"+this.percentage+"%'>"
								+ "</div>"
							+ "</div>"
						+ "</td>"
						+ "<td class='hidden'></td>"
						+ "<td class='action-button' id='action-button-id" + i +"'></td>"
					+ "</tr>"
				);
			
			
			<!-- START: add button group for day -->
				$("#action-button-id" + i ).append(""
					+ "<div>"
						+ "<a type='button' class='btn btn-simple pull-right remove-icon' data-toggle='confirmation-delete' data-on-confirm='day-group"+ i +"'>"
							+ "<i class='fa fa-fw fa-trash' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='btn btn-simple pull-right handle-icon'>"
							+ "<i class='fa fa-fw fa-arrows' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='btn btn-simple pull-right toggle-icon'>"
							+ "<i class='fa fa-fw fa-chevron-circle-down' aria-hidden='true'></i>"
						+ "</a>"
					+ "</div>"
				);
			<!-- END -->
			
			
				<!-- START: 2nd loop for row (poi) -->		
					$.each(this.poi, function(x, poi) {
						$("#day-group" + i  ).append(""
							+ "<tr class='poi-list poi-of-day"+i+"' id='day"+i+"poi"+x+"'>"
								+ "<td class='hidden'></td>"
								+ "<td class='order' >" + poi.poi_sort_order + "</td>"
								+ "<td class='hidden'>" + poi.poi_id + "</td>"
								+ "<td class='hidden poi-info'>" + poi.info + "</td>"
								+ "<td>" + poi.name + "</td>"
								+ "<td class='hidden'></td>"
								+ "<td class='poi-action-button text-right'></td>"
							+ "</tr>" 
						);
					})
				<!-- END -->
				
				<!-- START: Add-POI button at last row of each day -->
				/* [DISABLED]
					$("#day-group" + i).append(""
							+ "<tr class='add-poi poi-fixed'>"
								+ "<td colspan='7'>"
									+ "<button type='button' class='btn btn-warning btn-sm toggle-content"+i+"'>"
										+ "Add Point of Interest"
									+ "</button>"
								+ "</td>"
							+ "</tr>"
						+ "</tbody>"
					);
				*/
				<!-- END -->
			});
		
			
			
			<!-- START: add button group for poi -->
				$(".poi-action-button").append(""
					+ "<div>"
						+ "<a type='button' class='btn btn-simple pull-right remove-icon' data-toggle='confirmation-delete' data-on-confirm=''>"
							+ "<i class='fa fa-fw fa-trash' aria-hidden='true'></i>"
						+ "</a>"
						+ "<a type='button' class='btn btn-simple pull-right handle-icon'>"
							+ "<i class='fa fa-fw fa-arrows' aria-hidden='true'></i>"
						+ "</a>"
						+ "<div class='pull-right'>"
							+ "<input class='backup-toggle' type='checkbox' checked data-toggle='toggle' data-on='ON' data-off='OFF' data-onstyle='success' data-offstyle='danger' data-size='mini'>"
						+ "</div>"
					+ "</div>"
				);
			<!-- END -->
		
		<!-- START: add pocket at end of table -->
		$("#planner-table").append(""
			+ "<tbody class='day-group' id='pocket'>"
				+ "<tr class='day-list poi-fixed'>"
					+ "<td colspan='7' class='index'>"
						+ "<div class='btn-group' role='group' aria-label='Basic example'>"
							+ "<button type='button' class='btn btn-default btn-lg toggle-icon'>"
								+ "<i class='fa fa-shopping-basket fa-lg' aria-hidden='true'></br><span>Pocket</span></i>"
							+ "</button>"
							+ "<button type='button' class='btn btn-default btn-lg'>"
								+ "<i class='fa fa-plus-square fa-lg add-day-icon' aria-hidden='true'></br><span>Add Day</span></i>"
							+ "</button>"
						+ "</div>"
					+ "</td>"
				+ "</tr>" 
		);
		<!-- END -->
		
		//Initialize: All bootstrap toggle for Backup
		$('.backup-toggle').bootstrapToggle();
		//Initialize: Set All POI Hidden
		$(".day-group tr:not(:first-child)").hide();
		//Initialize: Setting up Sorting for Day (tbody)
		setDaySort();
		//Initialize: Setting up Sorting for POI (tr) 
		setPoiSort();
		
		//OnClick Event: Toggle Button Fade Hide Event 
		$('.toggle-icon').on('click', clickToggle);
		//OnClick Event: Toggle ready/backup for POI 
		$('.backup-toggle').change(function() {
		$(this).closest('.poi-list').toggleClass('backup');
		// !!!!!need to add function to remove total time calculation in a day.
		})		
		// OnClick Event: Run modal - Delete POI, Delete Day
		$('.remove-icon').on('click' ,{action:"remove"}, runModal);
		//OnClick Event: Remove Row
		$('#modal-confirm').on('click' , removeRow );
		
		}); //////////// END of getJason Fuction, function must load before this for sequence
	});
<!-- END -->

// START Activate Modal Dialog
function runModal(event) {
	
	if ( event.data.action == "remove") {
		var this_id;
		if ($(this).parents("tr").hasClass("day-list")) 	this_id = $(this).closest("tbody").attr("id");
		else this_id = $(this).closest(".poi-list").attr("id");
		$(".modal-body").html("Remove current POI "+ this_id +"?");
		$("#modal-confirm").data( "data", {target_id: this_id} );
	}
	$("#myModal").modal();
}// END Activate Modal Dialog

// START Remove Row Function (DAY or POI)
function removeRow() {
var remove_id = $(this).data("data").target_id;
$( "#" + remove_id ).fadeOut( "slow", function() {
    $( "#" + remove_id ).remove( );
  });
}// END Remove Row

// START Toggle hide/show POI in Day function
function clickToggle() {
	 var this_class = $(this).closest("tbody").attr("id");
	$("#" + this_class +" tr:not(:first-child)").fadeToggle();
	$("#" + this_class +" .fa-chevron-circle-down").fadeOut(200, function() {
		var opacity_value = (!$(this).hasClass("fa-flip-vertical"))? '0.5' :'1';
		$(this).toggleClass("fa-flip-vertical").fadeTo(200, opacity_value);
	});	  
}// END Toggle hide/show POI in Day function

// START Set Day Sorting Function
function setDaySort () {
		$("#planner-table").sortable({	
	revert: true,
	start: function(e, ui){
        $(ui.helper).addClass("ui-draggable-helper");
		$(ui.placeholder).addClass("ui-draggable-placeholder-day");
			},
    items: ">.day-group:not(:last-child)", 
	cancel: ">.poi-list" ,
    appendTo: "parent",
	handle: "tr .handle-icon",
    helper: function(event, ui) {
    return $('<div style="white-space:nowrap; height:80px;"/>').text($(jQuery(this).find(".day")).html());},
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
		var this_day = $(ui.placeholder).prev("tbody").attr("id");
		this_day = $("#" + this_day +" .day").html();
		if (!this_day) this_day ="D1"; 
		$(ui.placeholder).children("td").html("Reschedule to "+this_day);
	},	
	cursorAt: {top: 15},
	stop: function( event, ui ) {
		$('.day-list').each(function(){
     	var index= $(this).parent('.day-group').index();
		$(this).find(".day").fadeOut(300, function() {
        $(this).html("D" +index).fadeIn(300);
    	});
	})		
}
}).disableSelection();
}// End Day Sorting Function



// START Set POI Sorting Function
function setPoiSort () {
		$(".day-group").sortable({
	delay: 100,
	start: function(e, ui){
        $(ui.helper).addClass("ui-draggable-helper");
		$(ui.placeholder).addClass("ui-draggable-placeholder");
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
		var this_day = $(ui.placeholder).closest("tbody").attr("id");
		this_day = $("#" + this_day +" .day").html();
		$(ui.placeholder).children("td").html("Move to "+this_day);
	},	
	cursorAt: { top: 15  },
    helper: function(event, ui) {
    return $('<div style="white-space:nowrap; height:30px;"/>').text($(jQuery(this).find(".poi-info")).html());},
	update: function( event, ui ) {
	
	var this_day = $(this).closest("tbody").attr("id");
	if (( $("#" + this_day).children(".poi-list:hidden").length >0 ))  $("#" + this_day +" tr:not(:first-child):visible").fadeToggle();
	
	
	// update to move add-poi button to the end of row  
		var n = $("#" + this_day +" .add-poi:first").clone();
		$("#" + this_day +" .add-poi").remove();
		n.appendTo("#" + this_day );
			
	//$('.index').each(function(){
    // var index= $(this).parent('tr').index();
    // $(this).html(index+1);
	//  })		
		 }
}).disableSelection();
}// End POI Sorting Function
</script>

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
                <th class="hidden">Duration</th>
                <th class="hidden">City</th>
                <th>Activity</th>
                <th class="hidden">Fee</th>
                <th></th>
            </thead>
        </table>
    </div>    

    <div id="section-content-itinerary-footer">
    	<a class="btn btn-primary">Add Day</a>
        <a class="btn btn-default">Add Note</a>
    </div>
</div>

 <!-- Modal -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content-->
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
	<!-- Trigger the modal with a button -->
	<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>

   
</div>
</div>