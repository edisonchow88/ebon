<style>
	#map {
		height:calc(100vh - 40px);
	}
	
	.map-selected {
		background-color: #CCC !important;
	}
	
	.map-option-option-group {
		position: absolute;
		z-index: 99;
		padding: 5px;
	}
	
	.map-center-group {
		position: absolute;
		z-index: 99;
		padding: 5px;
		right:0;
	}
	
	.map-day-group {
		position: absolute;
		z-index: 99;
		bottom: 80px;
		left:50%;
		transform: translate(-50%);
		background-color:#FFF;
	}
	
	.map-day-show {
		color:#000 !important;	
	}
	
	.plan-line-twins {
		padding: 0px 0px;
	}
	
	.plan-line-twins .title {
		left: 10px;
		color: #999;
		position:relative;
		height: 30px;
	}
	
	.plan-line-twins .line {
		height: 2px;
		width: 95px;
		background-color:#000;
		position:absolute;
		left: -100px;
		top: 15px;
		z-index:99;
	}
	
	.plan-line-twins .transport-row{
		width: 100%;
		padding: 0px 15px;
		margin-top: 0px;
	}	
	
	.btn.nohover:hover {
    /* here copy default .btn class styles */
    cursor:default !important;
    /* or something like that */
}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-trip-map" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-trip-map-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-trip-map">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Map</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                         <div class="btn-group map-center-group" role="group" aria-label="...">
                            <button type="button" class="btn btn-default" id="go-center"><i class="fa fa-bullseye" aria-hidden="true"></i></button>        		</div>
                        <div class="btn-group map-option-option-group" role="group" aria-label="...">
                            <button type="button" class="btn btn-default map-option-option map-selected" value="all">All</button>
                            <button type="button" class="btn btn-default map-option-option" value="day">Day</button>
                        </div>
                        <div class="btn-group map-day-group" role="group" aria-label="...">
                             <button type="button" class="btn btn-default day-control map-day-left"><i class="fa fa-fw fa-chevron-left"></i></button>
                             <button type="button" class="btn btn-default nohover  disabled map-day-show">Day <span></span></button>
                             <button type="button" class="btn btn-default day-control map-day-right"><i class="fa fa-fw fa-chevron-right"></i></button>
                        </div>
                    	<div id="map"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-trip-map").on( "shown.bs.modal", function() {
		initMap();
		
		//create day select
		createMapSelectDay ();
			
		var markersData = createDrawMarkerList();
			
		var markers = markersData [0];
		var positions = markersData [1];
			
		createInfoWindow(markers);
		var routes = makeRouteTest ();	
		var bounds = showMarkerRoute(markers, positions, routes);
		
			
		mapEventListenResponse(markers, positions, bounds, routes);
		
	});
</script>

<script>
var map;
	$(document).ready(function(){
		updateTransportBox();	
	});
	
	function initMap() {
		var myLatlng = new google.maps.LatLng(3.139003, 101.686852); //Malaysia
		map = new google.maps.Map(document.getElementById('map'), {
			center: myLatlng,
			zoom: 4,
			minZoom: 1,
			maxZoom: 12,
			disableDefaultUI: true
		});

		getDistanceTime();
	}
	
	function mapEventListenResponse(markers, positions, bounds, routes ) {
		//// Map Event : Toggle show Day or All Markers. 
		$(".map-option-option").off().on('click',function() {
			$(".map-option-option").removeClass("map-selected");
			$(this).addClass("map-selected");
			showMarkerRoute(markers, positions, routes);
		});
		
		//// Event : Change selected day temporary no use 
		/*	
		$(".plan-day-tr").off().on('selectedDayChanged',function(){ 
			showMarkerRoute(markers, positions, routes);
		});
		*/
		
		//// Outstanding Event : refresh route,marker
		
		///////////////// Map Event : testing event Day option ////
		$(".map-day-group .day-control").off().on('click',function() {
			var current_day_no = parseInt($(".map-day-group .map-day-show").val())
			var new_day_no;
			if ( $(this).hasClass("map-day-left")) {
				new_day_no = current_day_no - 1;
			}else {
				new_day_no = current_day_no + 1;
				};
						
			if (current_day_no > 0 && current_day_no < $(".plan-day").length + 1 && !$(this).hasClass("disabled")) {
				$(".map-day-group .map-day-show span").html(new_day_no);
				$(".map-day-group .map-day-show").val(new_day_no);					
				$(".map-day-group .day-control").removeClass("disabled");
				if (new_day_no == 1 )  $(".map-day-left").addClass("disabled");
				else if (new_day_no == $(".plan-day").length ) $(".map-day-right").addClass("disabled");
				showMarkerRoute(markers, positions, routes);
			}
		});
		
	}
	
	function getMarkerIcon (f_color,s_color) {
		var myIcon = {
			path: 'M245,0C157.687,0,86.905,70.781,86.905,158.094c0,14.641,1.999,28.812,5.724,42.266c1.491,5.388,3.252,10.663,5.283,15.803   l4.794,10.894L245,490l142.481-263.316l4.321-9.818c2.149-5.363,4.011-10.871,5.57-16.505c3.724-13.455,5.724-27.626,5.724-42.266   C403.095,70.781,332.313,0,245,0z M245,234.271c-42.797,0-77.609-34.812-77.609-77.609c0-42.79,34.812-77.602,77.609-77.602   s77.609,34.812,77.609,77.602C322.609,199.459,287.797,234.271,245,234.271z',
			fillColor: f_color,
			strokeColor: s_color,
			fillOpacity: 0.8,
			scale: 0.03,
			anchor: new google.maps.Point(250, 450),
			strokeWeight: 1
		};
		return myIcon;	
	}
	
	function createDrawMarkerList () {
		var lat, lng, position, marker, title;
		var markers = [];
		var positions =[];
		
		$(".plan-line").each(function(i) {
			lat = parseFloat($(this).find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
			lng = parseFloat($(this).find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);				
			title =	$(this).find('.plan-line-form-hidden input[name=place]').val();
			var day_id = $(this).closest(".plan-day").attr("id");
			var line_id = $(this).attr("id");
			
			if(typeof lat != 'undefined' && lat != null && lat != '' && typeof lng != 'undefined' && lng != null && lng != '' && lat != "NaN" && lng != "NaN" ) {
				position = new google.maps.LatLng(lat,lng);
				marker = new google.maps.Marker({
					position: position,
					icon : getMarkerIcon(),
					title: title
				});
				marker.set("day", day_id);
				marker.set("line", line_id);
				marker.setMap(map);
				marker.setVisible(false);
				markers.push(marker);
				positions.push(position);
			}
		});
		
		return [markers, positions];
	}
	
	function showMarkerRoute (markers, positions,routes) {

		var red_icon = getMarkerIcon("red","red");
		var grey_icon = getMarkerIcon("grey","grey");
				
		var selected_day_id = $(".swiper-slide-active").closest(".plan-day").attr("id");
		
		///////////////////////for map select day option TESTING ////////////////////////////////////////////////////////
		
		selected_day_id = "plan-day-"+ $(".map-day-show").val();
		
		
		
		
				
		var prev_last_line_id =  $("#"+ selected_day_id).prevAll(".plan-day").has(".plan-line").first().find(".plan-line").last().attr("id");

		var bounds = new google.maps.LatLngBounds(); 
		
		if (markers) {
			// show markers
			$.each(markers,function(i) {
				markers[i].setVisible(false);
				markers[i].setZIndex(10);

				///set color
				if (markers[i].day == selected_day_id || markers[i].line == prev_last_line_id) {
					markers[i].set("viewstatus", "red");
					markers[i].setIcon(red_icon);	
					markers[i].setZIndex(11);
				}else {
					markers[i].setIcon(grey_icon);	
					markers[i].set("viewstatus", "grey");
				}
				
				if ( $(".map-selected").val() == "day") {
					if ( markers[i].viewstatus == "red") {
						markers[i].setVisible(true);
						bounds.extend(positions[i]);
					}else return;
				}else {
					markers[i].setVisible(true);
					bounds.extend(positions[i]);
				}
			});
		}
		
		if (routes) {
			//alert ("route loaded");
			//show routes
			$.each(routes,function(i) {
				routes[i].setVisible(false);
				routes[i].setOptions( {zIndex: 8});
				
				///set color
				if (markers[i].viewstatus == "red" && markers[i+1].viewstatus == "red" ) {
					routes[i].setOptions( {strokeColor: "red", zIndex: 9});
					routes[i].set("viewstatus", "red");
				}else {
					routes[i].setOptions( {strokeColor: "grey"});
					routes[i].set("viewstatus", "grey");	
				}
											
				if ( $(".map-selected").val() == "day") {
					if (routes[i].viewstatus == "red") {
						routes[i].setVisible(true);	
					}else return;	
				}else {	
					routes[i].setVisible(true);
				}
			});
		}

		var boundsAll = new google.maps.LatLngBounds(); 
		// set bounds if no marker is shown
		$.each(positions,function(i) {
			boundsAll.extend(positions[i]);
		});
			
		if (bounds.isEmpty()) {
			bounds = boundsAll;
		}
			//// Event : Return to center		
		$("#go-center").off().on('click', function() {
			map.fitBounds(bounds);
			ga('send', 'event', 'map','center');
		});	
		
		
		map.fitBounds(bounds);
		return boundsAll;	
	}
	
	function createInfoWindow(markers) {
		var infowindows = [];	
		$.each(markers, function(i) {
		
			var day_id = markers[i].day;
			var line_id = markers[i].line;
			var poi_name =	$("#"+ line_id).find('.plan-line-form-hidden input[name=place]').val();
					
			var infowindow = new google.maps.InfoWindow({
			  content: poi_name,
			});
	
			markers[i].addListener('click', function() {
				$.each(infowindows,function(i) {infowindows[i].close();});
				infowindow.open(map, markers[i]);
			});
						
			infowindows.push(infowindow);	
		});
		
		google.maps.event.addListener(map, 'click', function() {
			$.each(infowindows,function(i) {infowindows[i].close();});
  		});
	}
	
	function updateTransportBox() {
		
		$(".transport").show();
		$(".transport .path").html("");
		
		// add class to line with lat lng	
		$(".plan-line").each(function(i) {
			if ($(this).find('.plan-line-form-hidden input[name=lat]').val()) $(this).addClass("haslatlng"); 
		});	
		
		// make twins && hide all transport box not used
		$(".plan-day").each(function(i) {
			
			// make twins
			//if ( $(this).prevAll(".plan-day").has(".plan-line.haslatlng").length > 0 && $(this).find(".plan-line").length > 0){
			if ( $(this).prevAll(".plan-day").has(".plan-line.haslatlng").length > 0 ){	
			
				var twins_master_id = $(this).prevAll(".plan-day").has(".plan-line.haslatlng").first().find(".plan-line").last().attr("id");
				var info_name = $("#"+twins_master_id).find(".title span").html();
				var info_lat = parseFloat($("#"+twins_master_id).find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
				var info_lng = parseFloat($("#"+twins_master_id).find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);
				var info_img = $("#"+twins_master_id).find(".image img").attr("src");

				var twins_content = ''
				+ '<div class="plan-line-twins haslatlng">'
					+ '<div class="row">'
						//+ '<div class="image">'
						//	+ '<img class="noselect" src="'+info_img+'" />'
						//+ '</div>'
						+ '<div class="description">'
							+ '<div class="title">'
								+'<span>'+info_name+' (previous day)</span>'
								+'<span class="plan-line-twins-lat hidden">'+info_lat+'</span>'
								+'<span class="plan-line-twins-lng hidden">'+info_lng+'</span>'
								+ '<div class="line"></div>'
							+ '</div>'
						+ '</div>'
					+ '</div>' 
					+ '<div class="transport-row row">'
						+ '<div class="transport">'
							+ '<span>'
								+ '<i class="fa fa-fw fa-car"></i><i class="fa fa-fw"></i>'
							+ '</span>'
							+ '<span class="text">'
								+ '3.7 km / 45 mins'
							+ '</span>'
							+ '<span class="path hidden"></span>'
						+ '</div>'
					+ '</div>' 
				+ '</div>'
				;
				if (twins_content) {
					//$(this).find(".plan-line").first().before(twins_content);
					$(this).find(".plan-day-line").prepend(twins_content);
				}
			}
			// hide last plan-line transport box
			$(this).find(".plan-line, .plan-line-twins").last().find(".transport" ).hide();	
		});	
		
		$(".transport").each(function(i){
			$(this).attr('id', 'transport_'+i);	
		});
	}
	
	function getDistanceTime() {
		
		$(".transport:not(:hidden)").each(function(i){
			var this_haslatlng = $(this).parents().hasClass("haslatlng");
			var next_haslatlng = $(this).parents().next(".plan-line").hasClass("haslatlng");
			var is_twins = $(this).parents().hasClass("plan-line-twins");
			
			var ori_lat, ori_lng, des_lat, des_lng;
			// get original latlng (must have)
			if (is_twins) var parent_class = ".plan-line-twins";
			else  var parent_class = ".plan-line";		
			
			if (this_haslatlng && is_twins) {
				ori_lat = $(this).parents(parent_class).find(".plan-line-twins-lat").html();
				ori_lng = $(this).parents(parent_class).find(".plan-line-twins-lng").html();
			}else if (this_haslatlng && !is_twins) {
				ori_lat = parseFloat($(this).parents(parent_class).find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
				ori_lng = parseFloat($(this).parents(parent_class).find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);
			}else {
				ori_lat = parseFloat($(this).parents(parent_class).prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
				ori_lng = parseFloat($(this).parents(parent_class).prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);
			}
			
			if (next_haslatlng) {
				des_lat = parseFloat($(this).parents(parent_class).next().find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
				des_lng = parseFloat($(this).parents(parent_class).next().find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);
			}
			
			if ( ori_lat && ori_lng && des_lat && des_lng) {
				var origin = ori_lat+","+ori_lng;
				var destination = des_lat+","+des_lng;
				var transport_id = $(this).attr("id");				
				var service = new google.maps.DistanceMatrixService();
			
				service.getDistanceMatrix({
						origins: [origin],
						destinations:  [destination],
						travelMode: 'DRIVING',
						unitSystem: google.maps.UnitSystem.METRIC,
						avoidHighways: false,
						avoidTolls: false
					}, function(response, status) {
						if (status !== 'OK') {
							alert('Error was: ' + status);
						} else {
							var distance = response.rows[0].elements[0].distance.text;
							var duration = response.rows[0].elements[0].duration.text;
							$("#"+ transport_id +" .text").html(distance + " , " + duration);
							
					}
				});
			}else {
				var transport_id = $(this).attr("id");
				$("#"+ transport_id).html("");
			}
		
			if ( !$("#"+ transport_id +" .path").html()) {
				/////////////////////!!!!!!!!!!!!!!!!!!!!!!!!!! TESTING !!!!!!!!!!!!!!!!!!!!!!////////////////////////////////
				var ori = new google.maps.LatLng(ori_lat, ori_lng)
				var des = new google.maps.LatLng(des_lat, des_lng)
				var request = {
								origin: ori,
								destination: des,
								travelMode: 'DRIVING'
					};	
				
				var directionsService = new google.maps.DirectionsService();			
				directionsService.route(request, function(response, status) {
					if (status == 'OK') {
						var routePath = response.routes[0].overview_path;
						var routeString = JSON.stringify (routePath);
						$("#"+ transport_id +" .path").html(routeString);	
								
					}
				})
			}
		});
	}
	

	function makeRouteTest () {
		var lineSymbol = {
          path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
		  scale : 1.5
        };		
		
		var routes = [];

		$(".transport:not(:hidden)").each(function(i) {
			if ($(this).find(".path").html()) {
				var routePath = JSON.parse($(this).find(".path").html());
				 if (routePath){
					var route = new google.maps.Polyline({
						path: routePath,
						icons: [{
							icon: lineSymbol,
							offset: '60%'
						}],
						strokeColor: '#000',
						strokeOpacity: 1.0,
						strokeWeight: 1.5
					});		
					
					route.setMap(map);
					route.setVisible(false);
					routes.push(route);	
				}
			}
		});
		
		return routes;
		
	}
	
	function createMapSelectDay () {
		var selected_day_id = $(".swiper-slide-active").closest(".plan-day").attr("id");
		var day_no =  parseInt(selected_day_id.match(/\d+/));
		$(".map-day-group .map-day-show span").html(day_no);
		$(".map-day-group .map-day-show").val(day_no);
		
		if (day_no == 1 )  $(".map-day-left").addClass("disabled");
		if (day_no == $(".plan-day").length )  $(".map-day-right").addClass("disabled");
		
		
	}
</script>