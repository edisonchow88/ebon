<!DOCTYPE html><head>

<!-- Latest compiled and minified CSS (Jquery UI)-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js"></script>

<script type="text/javascript">
// Change JQueryUI plugin names to fix name collision with Bootstrap.
//$.widget.bridge('uitooltip', $.ui.tooltip);
//$.widget.bridge('uibutton', $.ui.button);
</script>

<!-- Latest compiled and minified CSS (Bootstrap)-->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<!-- Latest compiled and minified JavaScript (Bootstrap)-->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<!-- Bootstrap Local
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
-->
<!-- Local bootstrape confirmation plugin
</script type="text/javascript" src="js/bootstrap-confirmation.min.js"></script>-->

<!-- Bootstrap Toggle button-->
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
<script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

<script src="https://use.fontawesome.com/f41e5f8a73.js"></script>



<link rel="stylesheet" type="text/css" href="managerstyle.css">

<!--CSS Style-->
<style>
#table-title-bar {
	width: 100%;
	height: 35px;
	text-align:center;
	font-size: 1.50em;
	margin-bottom: 5px;	
	border-radius: 8px;
	border-bottom:  double #CCC;
	color:#999;
}

.center {
	display:table-cell;
	vertical-align:middle;
	text-align:center;
}

.poi {
	width: 100%;
	padding: 0; 
	margin: 0;
	border: 0;
	
}

.ui-draggable-placeholder-day {
	
	background-color: #CCC;
	height: 150px !important;
	opacity: 0.3;
}

.ui-draggable-placeholder {
	
	background-color: #CCC;
	height: 30px;
	opacity: 0.3;
}

.ui-draggable-helper {
	height: 30px;
	background-color: white;
	opacity: 0.5;
	font-size: 1.5em;
	text-align:center;
	border: medium dotted #666;
}

.poi-list {
	background-color: #FFC;
	height: 30px;
	font-size: 0.8em;
}

.add-poi td {
	text-align:right;
	border:0 !important;
}

.day-list {
	height: 50px;
	font-style:italic;	
}

.icon-center span{
	font-size: 0.8em !important;
}

#pocket td{
	text-align:left;	

}

#pocket span{
	font-size: 0.5em !important;
}

.backup-activated {
	opacity:0.5; !important;
}

<!-- Override Bootstrap Nav -->
.menu1 ul.nav {
	border-bottom-color:#F90;
}

.menu1 ul.nav-tabs {
	border-bottom-color:#F90;
}

.custom-nav li a  {
	text-align: center;
	color:#333;
	border-color: #F90;
}

.custom-nav li a.active {
	border-color: #F90;
	background-color:#F90;
	color:#FFF;
}

/*		Border	*/
.custom-table {
	border-collapse: separate; 
	
	
}

.custom-table thead tr { 
background-color:#CCC;
}
		
.custom-table tbody td{
	border:solid #CCC;
	border-width: 0.1em 0 0.1em 0;	
}

.custom-table tbody th{
	border:solid #CCC;
	border-width: 0.1em 0 0.1em 0;	
}

.custom-table tbody td:first-child {
	border-top-left-radius: 8px;
	border-bottom-left-radius: 8px;
	border-left: 0.1em solid #CCC;
}

.custom-table tbody td:last-child {
	border-top-right-radius: 8px;
	border-bottom-right-radius: 8px;
	border-right: 0.1em solid #CCC;
}




/*     	Box		
.custom-table {
	border-collapse: separate; 
}

.custom-table tbody tr {
	background-color:  #FC6 ;
	border-collapse:separate;
}

.custom-table thead tr{
	background-color:#FCEAD6;
	border-bottom: 0.3em solid #FFF;
}

.custom-table tbody td{
	border-bottom: 0.3em solid #FFF;	
}


.custom-table tbody th{
	border-bottom: 0.3em solid #FFF;
}

.custom-table tbody th:first-child {
	border-top-left-radius: 8px;
	border-bottom-left-radius: 8px;
}

.custom-table tbody td:last-child {
	border-top-right-radius: 8px;
	border-bottom-right-radius: 8px;
}
*/

.planner-container {
	margin: 0;
	padding:0;

}

.trip-detail-container {
	border:1px solid #999;
	height: 100vh;
	padding:10px;
	
}

.menu1 .menu2 {
	position:absolute;
	border: 0;
	margin: 0;
	padding:0;
}

.menu1 li {
	width:150px;
}

.menu2 li {
	width:80px;
	height:80px;

}

.menu1 ul {
    background-color: #FFF;
}

.menu2 ul {
    background-color: #FFF;
	
}

.add-pointer {
	color:#FFF;
	width: 100px;
}

.button-name {
	font-size:0.6em;
}

.planner-list {
	padding-left:0.5em;
	padding-right:0.5em;
	height: 80vh;
	overflow-y: scroll;	
}

table {
    border-collapse:collapse;
}

#tabs ul li.drophover {
    color:green;
}

.poi tr td {
	border: 0;
}

.poi tbody td:first-child, .poi tbody td:last-child {
	border-radius:0;

}

.poi tr td{
	background-color:#CCC;
	padding:5px;
	border-bottom:#FFF solid 1px;
	}
	

</style>

<script>
$(document).ready(function(){

// Read From JSON File and Print it to screen with loop	
// 1st loop for Day loop (tbody)
$.getJSON("<?php echo $ajax_itinerary; ?>", function(result){
            $.each(result.day, function(i, field){
                $("#planner-table").append( "<tbody class='day-group' id='day-group"+ i +"'><tr class='day-list poi-fixed'><td class='index' id='day" + i +"'> Line" + this.line_id + "</td><td class='day'>"+ this.day_id + " (Date)</td><td>8h</td><td></td><td></td><td></td><td class='icon-center'></td></tr>" );
// 2nd loop for POI loop (tr)			
						$.each(this.poi, function(x, poi){
						$("#day-group" + i  ).append( "<tr class='poi-list poi-of-day"+i+"' id='day"+i+"poi"+x+"'><td></td><td class='order' >" + poi.poi_sort_order + "</td><td>" + poi.poi_id + "</td><td class='poi-info'>" + poi.info + "</td><td></td><td></td><td class='poi-icon-center'></td></tr>" );})

// Add add-poi button at last tr of each day (tbody)
			$("#day-group" + i).append("<tr class='add-poi poi-fixed'><td colspan='7'><button type='button' class='btn btn-warning btn-sm toggle-content"+i+"'>Add Point of Interest</button></td></tr></tbody>");
						
            });


// Add button group for day to MOVE, HIDE/SHOW POI,DELETE
$(".icon-center").append("<div class='btn-group' role='group' aria-label='Basic example'><button type='button' class='btn btn-default btn-sm handle-icon'><i class='fa fa-arrows-alt'  aria-hidden='true' ></i><br/><span>Move</span></button><button  class='btn btn-default btn-sm remove-icon' data-toggle='confirmation-delete'><i class='fa fa-trash'  aria-hidden='true' ></i><br/><span>Remove</span></button><button type='button' class='btn btn-default btn-sm toggle-icon'><i class='fa fa-chevron-circle-down '  aria-hidden='true' ></i><br/><span>Show</span></button></div>");

// Add button group for POI ACTIVATE-BACKUP, DELETE
$(".poi-icon-center").append("<div class='btn-group' role='group' aria-label='Basic example' style='float:left;width:50%;'><span></span><button type='button' class='btn btn-default btn-sm remove-poi-icon' data-toggle='confirmation-delete'><i class='fa fa-trash'  aria-hidden='true' ></i><br/><span></span></button><span></span></div><div style='float:right;width:50%;'><input class='backup-toggle' type='checkbox' checked data-toggle='toggle' data-on='Ready' data-off='Backup' data-onstyle='success' data-offstyle='danger' data-size='mini' ></div>");

//<input type="checkbox" checked data-toggle="toggle" data-on="Ready" data-off="Not Ready" data-onstyle="success" data-offstyle="danger">
//<button type='button' class='btn btn-default btn-sm backup-icon'><i class='fa fa-lightbulb-o' aria-hidden='true' ></i><br/>

// Add pocket at the end of table
$("#planner-table").append( "<tbody class='day-group' id='pocket'><tr class='day-list poi-fixed'><td colspan='7' class='index'><div class='btn-group' role='group' aria-label='Basic example'><button type='button' class='btn btn-default btn-lg toggle-icon'><i class='fa fa-shopping-basket fa-lg' aria-hidden='true'></br><span>Pocket</span></i></button><button type='button' class='btn btn-default btn-lg'><i class='fa fa-plus-square fa-lg add-day-icon' aria-hidden='true'></br><span>Add Day</span></i></button></div></td></tr>" );

//Initialize: All bootstrap toggle
$('.backup-toggle').bootstrapToggle();
//Initialize: Set All POI Hidden
$(".day-group tr:not(:first-child)").hide();
//Initialize: Setting up Sorting for Day (tbody)
setDaySort();
//Initialize: Setting up Sorting for POI (tr) 
setPoiSort();
//Initialize: Enable Bootstrape Popover Confirmation - POI & DAY DELETE
/*$('[data-toggle="-confirmation-delete"]').confirmation( { title: "Delete DAY 1?", btnOkClass: "btn-xs btn-danger ",singleton: true, popout: true, 
onConfirm: function() {
    //delete row function
	 var this_id = $(this).attr("id");
	 document.getElementById('debug3').innerHTML = this_id;
	 
	;}
	
	 });
*/
//OnClick Event: Toggle Button Fade Hide Event 
$('.toggle-icon').on('click', clickToggle);
//OnClick Event: Toggle ready/backup for POI 
$('.backup-toggle').change(function() {
      $(this).closest('.poi-list').toggleClass('backup-activated');
	  /// !!!!!need to add function to remove total time calculation in a day.
    })
	
$('.index').each(function(){
    var index= $(this).parent('tr').index();
    $(this).html(index+1);
  })
		
// OnClick Event: Run modal - Delete POI, Delete Day
$('.remove-poi-icon').on('click' , runModal);
//OnClick Event: Remove Row
$('#modal-confirm').on('click' , removeRow);
		
		}); //////////// END of getJason Fuction, function must load before this for sequence


});

// START Activate Modal Dialog
function runModal() {
$("#myModal").modal();

 var this_id = $(this).closest(".poi-list").attr("id");
$(".modal-body").html("Remove current POI "+ this_id +"?");
$("#modal-confirm").data( "test", {target_id: this_id, target_action: "remove"} );

}// END Activate Modal Dialog

// START Remove Row
function removeRow() {
var remove_id = $(this).data("test").target_id;
$( "#" + remove_id ).remove( );
document.getElementById('debug3').innerHTML = remove_id;
 
}// END Remove Row


// START Toggle hide/show POI in Day function
function clickToggle() {
	 var this_class = $(this).closest("tbody").attr("id");
	        // toggle the stuff right after it
	  $("#" + this_class +" tr:not(:first-child)").fadeToggle();
	  		
			
			document.getElementById('debug').innerHTML = this_day;
}// END Toggle hide/show POI in Day function

// START Set Day Sorting Function
function setDaySort () {
		$("#planner-table").sortable({	
	revert: true,
	start: function(e, ui){
        $(ui.helper).addClass("ui-draggable-helper");
			},
    items: ">.day-group:not(:last-child)", 
	cancel: ">.poi-list" ,
    appendTo: "parent",
	handle: "tr .handle-icon",
	placeholder: "ui-draggable-placeholder-day",
    helper: function(event, ui) {
    return $('<div style="white-space:nowrap; height:80px;"/>').text($(jQuery(this).find(".day")).html());},
	//cursorAt: {left: ($(".day-group").width()/2)},
	stop: function( event, ui ) {
		
	//$('.index').each(function(){
   //  var index= $(this).parent('tr').index();
     //$(this).html(index+1);
	 // })		
		 }
}).disableSelection();
}// End Day Sorting Function

// START Set POI Sorting Function
function setPoiSort () {
		$(".day-group").sortable({
	delay: 100,
	start: function(e, ui){
        $(ui.helper).addClass("ui-draggable-helper");
		$(ui.placeholder).children().append("<span>Move here</span>");
			},
    items: ">.poi-list",
	//cancel:".poi-list:nth-child(2)",
    appendTo: "parent",
	connectWith: ".day-group",
	placeholder: "ui-draggable-placeholder",
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


</head>
<body>
<!-- /////////////////////////////////////HEADER : TITLE AND BUTTON////////////////////////////////////-->
<div class="planner-container col-sm-9">



<!-- //////////////////////////////////TRIP PLANNER LIST ////////////////////////////////////////////////-->
<div class="planner-list" >
<div id="table-title-bar"> My Trip </div>
<table class="table custom-table" id="planner-table">
<thead> <th>#</th><th>Day/Time</th><th>Duration</th><th>City</th><th>Activity</th><th>Fee</th><th></th>

<!--THE PLANNER LIST IS PRINT HERE-->

</table>

  </div> <!--Planner list End-->
</div><!--Planner End-->


<div class="trip-detail-container col-sm-3">
<p>This is for the trip data</p>
<p id="trip">Trip Name</p>
<p>No.of Day: <?php echo $maxday; ?> </p>
<p id="debug">Debug: </p>
<p id="debug2">Debug: </p>
<p id="debug3">Debug: </p>
<a tabindex="0" class="btn btn-lg btn-danger" role="button" data-toggle="confirmation" data-trigger="focus" title="Dismissible popover" data-content="<button>123 </button>">Dismissible popover</a>
<button class="btn btn-default" data-toggle="confirmation">Confirmation</button>
<!-- Trigger the modal with a button -->
<button type="button" class="btn btn-info btn-lg" data-toggle="modal" data-target="#myModal">Open Modal</button>

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
</div>
 
</body>  




 
</html>
