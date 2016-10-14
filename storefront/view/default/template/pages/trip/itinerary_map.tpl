<style>
	.spacer-bar {
		min-height:20px;
	}
	
	#section-content-map {
		text-align:left;
	}
	
	#section-content-map-header {
		padding:7px;
		border-bottom:solid thin #EEE;
	}
	
	#section-content-map-header .input-group {
		border-radius:10px;
	}
	
	#section-content-map-header .form-control {
		border-radius:10px;
	}
	
	#section-content-map-header .btn-simple {
		padding-right:0;
		padding-left:0;
	}
	
	#section-content-map-header-close {
		font-size:24px;
		line-height:14px;
	}
	
	#section-content-map-content {
		overflow-y:hidden;
		overflow-x:hidden;
	}
	
	#map {
		width: 100%;
	}
	
	.map-selected {
		background-color: #CCC !important;
	}
	
	.map-option-group {
		position: absolute;
		z-index: 10;
		padding: 5px;
	}
	
	.map-center-group {
		position: absolute;
		z-index: 10;
		padding: 5px;
		right:0;
	}
	
	.temp-data-board {
		position: absolute;
		z-index: 10;
		padding: 5px;
		bottom: 0px;
		height : 100px;
		width: 100%;
		background-color:#FFF;
	}
	
	.traveltrans {
		display:block;
		text-align:center;
	}
	
	.line-twins {
		display: block;
		height: 40px;
		width: 100%;	
		background: #6F9;
		text-align:center;
	}
</style>

<div id="section-content-map">
	<!--
	<div style="position:relative; z-index:3;">
        <div id="section-view-button" class="hidden-xs hidden-sm hidden-md">
            <a id='button-discover' class="btn btn-primary" data-toggle='tooltip' data-placement='bottom' title='Discover'>
                <i class="fa fa-search fa-2x" aria-hidden="true"></i>
            </a>
        </div>
    </div>
    -->
    <!--
    <div id="section-content-map-header" class="hidden-sm hidden-md hidden-lg">
        <div class="row">
            <div class="spacer-bar hidden-xs hidden-sm col-md-12 col-lg-12"></div>
        </div>
        <div class="row">
            <div class="input-group pull-left inline col-xs-12">
                <input class="form-control" type="text" placeholder='Search ...'  />
            </div>
            <div class="inline pull-right col-md-12 col-lg-3">
                <a 
                	class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                	onclick="close_section_content('map');"
                    data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Close Map' 
                >
                	<i class="fa fa-fw" id="section-content-map-header-close">&times;</i>
                </a>
                <a 
                	class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                	onclick="open_section_content('map');"
                    data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Expand Map' 
                >
                	<i class="fa fa-fw fa-arrows-alt"></i>
                </a>
            </div>
        </div>
    </div>
    -->
    <script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-85225229-1', {
  'cookieDomain': 'none'
	});
 // ga('create', 'UA-85225229-1', 'auto');
  ga('send', 'pageview');

</script>
    
    
    <div id="section-content-map-content">
		 <div class="btn-group map-center-group" role="group" aria-label="...">
            <button type="button" class="btn btn-default" id="go-center"><i class="fa fa-bullseye" aria-hidden="true"></i></button>        </div>
       	<div class="btn-group map-option-group" role="group" aria-label="...">
  			<button type="button" class="btn btn-default map-option map-selected" value="day">Day</button>
  			<button type="button" class="btn btn-default map-option" value="all">All</button>
        </div>
        <div class="temp-data-board"><span>Data:</span><br /><span id="write"></span><br />
        <button type="button" class="btn btn-default markertest" value="0">m0</button>
        <button type="button" class="btn btn-default markertest" value="1">m1</button>
        <button type="button" class="btn btn-default markertest" value="2">m2</button>
        <button type="button" class="btn btn-default markertest" value="3">m3</button>
        <br />
        <button type="button" class="btn btn-default routetest" value="0">r0</button>
        <button type="button" class="btn btn-default routetest" value="1">r1</button>
        <button type="button" class="btn btn-default routetest" value="2">r2</button>
        <button type="button" class="btn btn-default routetest" value="3">r3</button>
        </div>
       <div id="map"></div>
    </div>
</div>







<script>
	var map;
	
	// Run code once only
	$(document).ready(function(){
		duplicateLast();
		
	});
	
	function initMap() {
			
		var route_type = 2;
		// Duplicate last line into Nex day 1st line.
		addTransportBox();
		
		$(".plan-table").ready(function() {
			
			/// INIT : CREATE NEW MAP
			var myLatlng = new google.maps.LatLng(3.139003, 101.686852); //Malaysia
			map = new google.maps.Map(document.getElementById('map'), {
				center: myLatlng,
				zoom: 4,
				minZoom: 1,
				maxZoom: 15,
				disableDefaultUI: true
			});
			/// END CREATE NEW MAP		
				
			/// INIT : CREATE & DRAW MARKER + ROUTE
			var markersData = createDrawMarkerList();
			
			var markers = markersData [0];
			var positions = markersData [1];
			
			createInfoWindow(markers);
			
			var bounds = showMarkerRoute(markers, positions, route_type, routes);
			//////// !! choose route type/// 1 for straight, 2 for dierection. !!
			if (route_type == 1) {			
				var routes = createDrawRouteList(markers, positions);
				mapEventListenResponse(markers, positions, bounds, route_type, routes);
			}else if (route_type == 2) {
				$(document). on("runroute", function( event, ui ) {
					var routes = makeRouteTest();
					showMarkerRoute(markers, positions, route_type, routes);
					mapEventListenResponse(markers, positions, bounds, route_type, routes);
				});
			}
			
			showData ();		
		////////////// DISTANCE MATRIX //////////////////		
			getDistanceTime();
			
			$(document).on("sortStart", function( event, ui ) {
				$(".traveltrans").remove();
				$(".line-twins").remove();
				
			});
			
			$(document).on("tableActionEnd", function( event, ui ) {
				duplicateLast(1);
				addTransportBox (1);
				getDistanceTime();	
			});
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
	/*	
	function mapEventListenResponse(markers, positions, bounds, route_type, routes ) {
		//// Event : Toggle show Day or All Markers. 
		$(".map-option").off().on('click',function() {
			$(".map-option").removeClass("map-selected");
			$(this).addClass("map-selected");
			showMarkerRoute(markers, positions, route_type, routes);
		});
		
		//// Event : Change selected day		
		$(".plan-day-tr").off().on('selectedDayChanged',function(){ 
			showMarkerRoute(markers, positions, route_type, routes);
			showData();	
		});
		
		//// Event : Return to center		
		$("#go-center").off().on('click', function() {
			map.fitBounds(bounds);
			ga('send', 'event', 'map','center');
		});		
		
		
		//////////TESTING???
		
		$(".markertest").off().on('click', function() {
			var i =  $(this).val();
			if (markers[i].getVisible() == true) markers[i].setVisible(false);	
			else markers[i].setVisible(true);
		});		
		
		$(".routetest").off().on('click', function() {
			var i =  $(this).val();
			if (routes[i].getVisible() == true) routes[i].setVisible(false);	
			else routes[i].setVisible(true);
		});	
	}
	
	function createDrawMarkerList () {
		var lat, lng, position, marker, title;
		var markers = [];
		var positions =[];
		
		$(".plan-line-tr").each(function(i) {
			lat = parseFloat($(this).find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
			lng = parseFloat($(this).find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);	
			title =	$(this).find('.plan-line-form-hidden input[name=place]').val();
			var day_id = $(this).closest(".plan-day-tr").attr("id");
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
	*/
	function createDrawRouteList (markers, positions) {
		var routes = [];
		var lineSymbol = {
          path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW
        };		
		
		for (var i = 0, n = positions.length; i < n-1; i++) {	
			// set origin & destination for this loop only
			var coordinates = new Array();
			coordinates [0] = positions[i];
			coordinates [1] = positions[i+1];
		
		 //OPTION 1 : Straight Polyline Display	
			if (coordinates [0] && coordinates [1]) {
				var route = new google.maps.Polyline({
					path: coordinates,
					icons: [{
						icon: lineSymbol,
						offset: '60%'
					}],
					geodesic: true,
					strokeColor: '#000',
					strokeOpacity: 1.0,
					strokeWeight: 1.5
				});	
				
				route.setMap(map);
				route.setVisible(false);
				routes.push(route);	
				
			}
		}
		return routes;	
	}
/*	
	function showMarkerRoute (markers, positions, route_type, routes) {
		
		var red_icon = getMarkerIcon("red","red");
		var grey_icon = getMarkerIcon("grey","grey");
				
		var selected_day_id = $(".selected").closest(".plan-day-tr").attr("id");
		var prev_last_line_id =  $("#"+ selected_day_id).prev(".plan-day-tr").find(".plan-line-tr").last().attr("id");

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
		
		map.fitBounds(bounds);
		return boundsAll;	
	}

	function addTransportBox (clearbox) {
		if (clearbox)  $(".traveltrans").remove();
		var j=0;
		
		$(".haslatlng").each(function(i) {	
			if ($(this).prev().hasClass("haslatlng")) {
				$(this).before("<div class='traveltrans' id='trans"+j+"'><i class='fa fa-car' aria-hidden='true'></i>&nbsp;&nbsp;<span class='text'>-</span><span class='path hidden'></span></div>");	
				j++;	
			}
			else return;		
		});	
	}
	
	function duplicateLast (clearbox) {
		$(".plan-line-tr").each(function(i) {
			if ($(this).find('.plan-line-form-hidden input[name=lat]').val()) $(this).addClass("haslatlng"); 
			else return;		
		});	
		
		if (clearbox)	$(".line-twins").remove();
		$(".plan-day-tr").each(function(i) {
			var info_name = $(this).find(".plan-line-tr").last().find(".plan-col-title a").html();
			var info_lat = parseFloat($(this).find(".plan-line-tr.haslatlng").last().find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
			var info_lng = parseFloat($(this).find(".plan-line-tr.haslatlng").last().find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);
			
			var info = "<div class='line-twins haslatlng'>"
							+"From previous day: " 
								+ info_name
							+"<span class='line-twins-lat hidden'>"+info_lat +"</span>"
							+"<span class='line-twins-lng hidden'>"+info_lng +"</span>"	
						+ "</div>"
					;
				
			if (info) {
				$(this).next(".plan-day-tr").find(".plan-line-tr").first().before(info);
				//alert (info);
				//$(this).next(".plan-day-tr").find(".plan-line-tr").first().before("<div class='line-twins'><div class='plan-line-form plan-form box-shadow'><div class='plan-line-td plan-td plan-col-title'>"+info+"</div></div></div>");
			}
						
		
		});
		
		
		
	}*/
</script>


<!--<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCVMRYZoGCRmLUQj77L0cwZUcmvXcSjcEM&libraries=places&callback=initMap" async defer>
</script>-->

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initMap" async defer>
</script>
	<script>
// Get distance and time 
/*
	function getDistanceTime() {
		
		$(".traveltrans").each(function(i){
			
			if ($(this).prevAll(".haslatlng").first().hasClass("line-twins")) {
				var ori_lat = $(this).prevAll(".haslatlng").first().find(".line-twins-lat").text();
				var ori_lng = $(this).prevAll(".haslatlng").first().find(".line-twins-lng").text();
			}else {
				var ori_lat = parseFloat($(this).prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
				var ori_lng = parseFloat($(this).prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);	
			}
			
			var des_lat = parseFloat($(this).next(".haslatlng").find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
			var des_lng = parseFloat($(this).next(".haslatlng").find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);	
			var origin = ori_lat+","+ori_lng;
			var destination = des_lat+","+des_lng;
		
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
							$("#trans"+i +" .text").html(distance + " , " + duration);
					}
			});
			
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
					$("#trans"+i).find(".path").html(routeString);	
							
				}
			})
		
		});
		
		$(document).trigger("runroute");
		//$(".haslatlng").removeClass("haslatlng");
	}
	*/
	/*
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
	
	
	*/
	
	
	function showData () {
		var day, act_no;
		day = parseInt($(".plan-day-tr.selected").attr("id").replace( /^\D+/g, ''));
		act_no = $(".plan-day-tr.selected .plan-line-tr").length;
		if (act_no == 0) act_no = "no activity";
		else if (act_no == 1) act_no = "an activity";
		else act_no = act_no +" activities";
		
		$("#write").html("Day "+day+" have "+act_no+".");
	}
	
	
	
	/**/
	////////////////////// DIrection Matrix route ///////////////////////
	function createRouteListR (markers, positions) {
		// Define a symbol using a predefined path (an arrow), supplied by the Google Maps JavaScript API.
        var lineSymbol = {
          	path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW
        };
		var routePaths = [];
		var routes = [];
		
		for (var i = 0, n = positions.length; i < n-1; i++) {	
			// set origin & destination for this loop only
			var coordinates = new Array();
			
			coordinates [0] = positions[i];
			coordinates [1] = positions[i+1];
			
			if (coordinates [0] && coordinates [1]) {
				var request = {
							origin: coordinates [0],
							destination: coordinates [1],
							travelMode: 'DRIVING'
				};	
				
				var directionsService = new google.maps.DirectionsService();			
				directionsService.route(request, function(response, status) {
					if (status == 'OK') {
						var routePath = response.routes[0].overview_path;
						
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
						alert (response.routes[0].legs[0].start_address);
						route.setMap(map);
						route.setVisible(false);
						routes.push(route);
					
					
					}else alert(status);
				})
			}
		}	
	}
	
	function makeRouteTest () {
		var lineSymbol = {
          path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW
        };		
		
		var routes = [];

		$(".traveltrans").each(function(i) {
			if ($(this).find(".path").html()) {
				var routePath = JSON.parse($(this).find(".path").html());
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
		});
		
		return routes;
		
	}
	
	
	
</script>