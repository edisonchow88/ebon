<style>
	#map {
		height:calc(100vh - 40px);
	}
	
	.map-selected, .route-selected {
		background-color: #CCC !important;
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
		bottom: 105px;
		left:50%;
		transform: translate(-50%);
		background-color:#FFF;
	}
	
	.map-day-line-no {
		font-size: 0.7em;
		position: absolute;
		z-index: 99;
		bottom: 80px;
		left:50%;
		transform: translate(-50%);
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

	.map-setting {
		position: absolute;
		z-index: 99;
		padding: 5px;
		width: 200px;
	}

	.map-setting .list-group {
		margin: 0px !important;
		
	}
		
	.map-setting .list-group .list-group-item{
		margin: 0px !important;
		padding: 5px !important;
	}
	
	.map-option {
		float:right;	
	}
	
	.list-group-item {
		height: 40px;
	}
	
	.list-group-item button {
		width: 50px;
	}
	
	div.map-font-icon {
		width: 21px;
   	 	height: 21px;
		text-align:center;
		font-size:1.3em;

	}
	
	div.map-seq-icon {
		background:  #FF0;
		border-radius: 50%;
		width: 15px;
   	 	height: 15px;	
		text-align:center;
	}
	
	.marker-label-active .fa-flag {
		color: #FF0;
		z-index: 100 !important;	
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
                      <!--
                       	<div class="btn-group map-option-option-group " role="group" aria-label="...">
                            <button type="button" class="btn btn-default map-option-option map-selected" value="all">All</button>
                            <button type="button" class="btn btn-default map-option-option" value="day">Day</button>
                        </div>  
                         --> 							 
                         <div class="map-setting">
                   			<ul class="list-group">
                                <button class="btn btn-default map-setting-button" type="button">
                                    <i class="fa fa-cog" aria-hidden="true"></i> 
                                </button> 
                                <div class="map-setting-list hidden">
                                    <li class="list-group-item"><span>Markers</span> 
                                    	<div class="btn-group map-option map-option-option-group" role="group" aria-label="...">
                            				<button type="button" class="btn btn-sm btn-default map-option-option map-selected option-default" value="all">All</button>
                            				<button type="button" class="btn btn-sm btn-default map-option-option" value="day">Day</button>
                       					 </div>
                                    </li>
                                    <li class="list-group-item"><span>Routes</span>
                                   		 <div class="btn-group map-option map-option-route-group" role="group" aria-label="...">
                                         	<button type="button" class="btn btn-sm btn-default map-route-option route-selected" value="routes"><i class="icon-curve-route"></i></button> 
                                            <button type="button" class="btn btn-sm btn-default map-route-option" value="routesP"><i class="icon-straight-route"></i></button>                            
                       					 </div> 
                                    </li >
                                    <li class="list-group-item"><span>Refresh Map</span> 
                                    	<div class="btn-group map-option map-option-refresh-map" role="group" aria-label="...">
                                            <button type="button" class="btn btn-sm btn-default map-refresh-option" value=""><i class="fa fa-refresh" aria-hidden="true"></i></button>                                  
                                        </div> 
                                    </li>              
                                </div>
      						</ul> 
                      	</div>     
     
                        <div class="btn-group map-day-group box-shadow" role="group" aria-label="...">
                             <button type="button" class="btn btn-default day-control map-day-left"><i class="fa fa-fw fa-chevron-left"></i></button>
                             <button type="button" class="btn btn-default nohover  disabled map-day-show">Day <span></span></button>
                             <button type="button" class="btn btn-default day-control map-day-right"><i class="fa fa-fw fa-chevron-right"></i></button>
                        </div>
                        <div class="map-day-line-no"></div>
                    	<div id="map"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->
<script>
 function MarkerIconOverlay(pos, txt, map, cls, stt) {

      // Now initialize all properties.
      this.pos = pos;
      this.txt_ = txt;
      this.map_ = map;
	  this.class_ = cls;
	  this.state_ = stt;
      // We define a property to hold the image's
      // div. We'll actually create this div
      // upon receipt of the add() method so we'll
      // leave it null for now.
      this.div_ = null;

      // Explicitly call setMap() on this overlay
      this.setMap(map);
    }

function initOverlayPrototype () { // must be after or inside initMap()
    MarkerIconOverlay.prototype = new google.maps.OverlayView();

    MarkerIconOverlay.prototype.onAdd = function() {

      // Note: an overlay's receipt of onAdd() indicates that
      // the map's panes are now available for attaching
      // the overlay to the map via the DOM.

      // Create the DIV and set some basic attributes.
      var div = document.createElement('DIV');
      if (this.state_ == "active") div.className = "marker-label-active map-font-icon";
	  else  div.className = "map-font-icon ";
	 	
      div.innerHTML = "<span class='fa-stack'>"
	  				+ "<i class='fa fa-circle fa-stack-2x'></i>"
  					+ "<i class='fa fa-flag fa-stack-1x fa-inverse'></i>"
					+ "</span>";
		
	 /* var div_seq = document.createElement('DIV');
	 	div_seq.className = "map-seq-icon ";
	  	div_seq.innerHTML = this.txt_;
	  	this.div_seq_ = div_seq;
	  */
      // Set the overlay's div_ property to this DIV
      this.div_ = div;
      var overlayProjection = this.getProjection();
      var position = overlayProjection.fromLatLngToDivPixel(this.pos);
      div.style.left = position.x + 'px';
      div.style.top = position.y + 'px';
	 
      // We add an overlay to a map via one of the map's panes.

      var panes = this.getPanes();

     // panes.floatPane.appendChild(div);
	panes.overlayMouseTarget.appendChild(div);
	 /// panes.floatPane.appendChild(div_seq);
    }
    MarkerIconOverlay.prototype.draw = function() {
        var overlayProjection = this.getProjection();

        // Retrieve the southwest and northeast coordinates of this overlay
        // in latlngs and convert them to pixels coordinates.
        // We'll use these coordinates to resize the DIV.
        var position = overlayProjection.fromLatLngToDivPixel(this.pos);

	    var div = this.div_;
        div.style.left = position.x - 14 + 'px' ;
        div.style.top = position.y - 40 + 'px';
		div.style.position = 'absolute';
		/*
		var div_seq = this.div_seq_;
        div_seq.style.left = position.x + 8  + 'px' ;
        div_seq.style.top = position.y - 42 + 'px';
		div_seq.style.position = 'absolute';
		*/

      }
      //Optional: helper methods for removing and toggling the text overlay.  
    MarkerIconOverlay.prototype.onRemove = function() {
      this.div_.parentNode.removeChild(this.div_);
      this.div_ = null;
    }
	
    MarkerIconOverlay.prototype.hide = function() {
      if (this.div_) {
        this.div_.style.visibility = "hidden";
      }
	  if (this.div_seq_) {
        this.div_seq_.style.visibility = "hidden";
      }
    }

    MarkerIconOverlay.prototype.show = function() {
      if (this.div_) {
        this.div_.style.visibility = "visible";
      }
	   if (this.div_seq_) {
        this.div_seq_.style.visibility = "visible";
      }
    }
	
	 MarkerIconOverlay.prototype.activate = function() {
		if (this.div_) {
			this.div_.className = "marker-label-active map-font-icon";
      }
	}
	
	MarkerIconOverlay.prototype.onc = function(label) {
		google.maps.event.addDomListener(this.div_, 'click', function () {
			alert();
		});
	}
};
	
	


	// Update the MAP 
	function runMapUpdate() {
		initMap();
		initOverlayPrototype();
		// create day select control panel on the Map with event listener
		createMapSelectDay();
		
		$(".map-option-option").removeClass("map-selected");
		$(".map-option-option.option-default").addClass("map-selected");
		
		// create marker and hide them
		var markersData = createDrawMarkerList();
		var markers = markersData [0];
		var positions = markersData [1];
		var marker_labels = markersData [2];
		
		createInfoWindow(markers, marker_labels);	
		
		//create route from path or markers and hide them
		var routesData = makeRoutebyPath(markers, positions);
		var routes = routesData[0];
		var routesP = routesData[1];
		
		// process markers and routes to show/hide, fit bound
		
		var bounds = showMarkerRoute(markers, marker_labels, positions, routes, routesP);
		
		// 1st run fit bound
		map.fitBounds(bounds);
		
		// map event listener	
		mapEventListenResponse(markers, marker_labels, positions, bounds, routes, routesP);

	}
	
	$("#modal-trip-map").on( "shown.bs.modal", function() {
		if ($(".plan-line").length <1) {
			showHint("Trip itinerary is empty. Please add place or activity.");	
		}
			
		var count_active_transport_box = $(".transport:not(:hidden)").length;
		var transport_box_not_empty  =  $(".transport:not(:hidden) .path:not(:empty), .transport:not(:hidden) .orindes:not(:empty)").length;
		if (transport_box_not_empty == count_active_transport_box) {
			runMapUpdate();	
		}else {
			var timer = setInterval(loopLoadMap, 1000);
			var i = 0;
					
			function loopLoadMap() {
				count_active_transport_box = $(".transport:not(:hidden)").length;
				transport_box_not_empty  =  $(".transport:not(:hidden) .path:not(:empty)").length;
			  
				if(transport_box_not_empty == count_active_transport_box) {
					runMapUpdate();	
					clearInterval(timer);
					return;
				}
				if (i > 10) {
					showHint("Error Loading Map. Please Refresh");
					clearInterval(timer);
				}
				i++;
			}
		}
	});
	
	$(".map-refresh-option").off().on("click",function(){
		runMapUpdate();		
	});
	
</script>

<script>
var map;
	$(document).ready(function(){
		updateTransportBox();
	});


	function initMap() {
		var map_style = getMapStyle();
		var myLatlng = new google.maps.LatLng(3.139003, 101.686852); //Malaysia
		map = new google.maps.Map(document.getElementById('map'), {
			center: myLatlng,
			zoom: 4,
			minZoom: 1,
			maxZoom: 12,
			disableDefaultUI: true,
			styles: map_style
		});
		
		getDistanceTime();
		initExploreMap();
		
		
		////callback to refresh route after action (delete, add, move ,modify)
		$(document).off("refreshRoute").on("refreshRoute",function(){
			updateTransportBox();
			getDistanceTime();	
		});
		
	}
	
	function mapEventListenResponse(markers, marker_labels, positions, bounds, routes ,routesP) {
		//// Map Event : Map toggle show Day or All Markers. 
		$(".map-option-option").off().on('click',function() {
			$(".map-option-option").removeClass("map-selected");
			$(this).addClass("map-selected");
			showMarkerRoute(markers, marker_labels, positions, routes, routesP);
		});
		
		//// Map Event : Map routes or routesP. 
		$(".map-route-option").off().on('click',function() {
			$(".map-route-option").removeClass("route-selected");
			$(this).addClass("route-selected");
			showMarkerRoute(markers, marker_labels, positions, routes, routesP);
		});
		
		//// Map Event : Map change day listener ////
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
				showMarkerRoute(markers, marker_labels, positions, routes, routesP);
			}
			
			
		});
		
		// marker icon when zoom change
		map.addListener('zoom_changed', function() {
			updateIconZoom (markers);	
		});
	}
	
	function updateMapLineNo( selected_day_id) {
		//update icon for each line for the day
			$(".map-day-line-no").html("");
			// get icon 1st, now all use flag icon
			if ($("#"+selected_day_id +" .plan-line").length > 0) {
				$("#"+selected_day_id +" .plan-line").each(function(i) {
						lat = $(this).find('.plan-line-form-hidden input[name=lat]').val();
					if ( lat){
						var output = "<span class='fa-stack'>"
							+ "<i class='fa fa-circle fa-stack-2x'></i>"
							+ "<i class='fa fa-flag fa-stack-1x fa-inverse'></i>"
							+ "</span>";
					}else {
						var output = "<span class='fa-stack'>"
							+ "<i class='fa fa-circle fa-stack-2x'></i>"
							+ "<i class='fa fa-minus fa-stack-1x fa-inverse' aria-hidden='true'></i>"
							+ "</span>";
					}
					$(".map-day-line-no").append(output);
				});
			}else {
				$(".map-day-line-no").append("Empty Day!");
			}
	}
	
	function updateIconZoom (markers){
		//var black_icon = getMarkerIcon("black","black");
		var zoom = map.getZoom();
		if (zoom > 8) {
			$.each(markers,function(i) {
				var icon = markers[i].getIcon();
				icon.scale =  0.11;
				markers[i].setIcon(icon);
			});
		}else {
			$.each(markers,function(i) {
				var icon = markers[i].getIcon();
				icon.scale =  0.11;
				markers[i].setIcon(icon);
			});
		}
		
	}
	
	function getMarkerIcon (f_color,s_color, icon_scale) {
		if (!icon_scale) var icon_scale = 0.03;
		var myIcon = {
			path: 'M 364.85742 32.71875 C 279.2041 32.71875 209.5 102.42285 209.5 188.07617 C 209.5 254.70468 251.68216 311.67528 310.73633 333.69922 L 323.56445 355.91797 L 364.85742 427.43945 L 406.15039 355.91797 L 418.97852 333.69922 C 478.03268 311.67528 520.21484 254.70468 520.21484 188.07617 C 520.21484 102.42285 450.51075 32.71875 364.85742 32.71875 z M 366.69727 154.86914 C 367.38633 154.86348 368.04071 154.90196 368.65625 154.98633 C 381.6564 156.7682 398.80043 174.50391 400.19141 188.04883 C 400.73111 193.30422 400.76816 193.09959 398.67578 199.98828 C 396.3737 207.56737 397.82341 205.07274 390.30469 213.04297 C 379.3985 224.6041 378.83377 224.87261 365.82812 225.52148 C 358.92523 225.86589 355.16307 224.97145 355.74023 225.18945 C 348.76882 222.58073 335.73645 210.81217 332 203.21094 C 329.26394 197.64484 329.99966 200.90328 329.99219 190.36133 C 329.98419 179.44002 329.00651 183.63023 332.23633 177.19531 C 338.3999 164.91533 356.36125 154.95401 366.69727 154.86914 z ',
			fillColor: f_color,
			strokeColor: s_color,
			fillOpacity: 1,
			scale: icon_scale,
			anchor: new google.maps.Point(360, 430),
			strokeWeight: 0.5
		};
		return myIcon;	
	}
	
	function createDrawMarkerList () {
		
		var markers = []; //array for location marker color active and non-active
		var positions = []; // array for latlng
		var marker_labels =[];
		var marker_index = 0;
		$(".plan-line").each(function(i) {
			var lat, lng, position, marker, title, imarker;
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
				
				if (day_id == $(".swiper-slide-active").closest(".plan-day").attr("id")) {
					var txt = new MarkerIconOverlay(position, marker_index + 1 , map, "", "active");
				}
				//else if (day_id == $(".swiper-slide-active").closest(".plan-day").prev().attr("id")) {}
				else {
				var txt = new MarkerIconOverlay(position, marker_index + 1 , map, "");
				}
				
				marker_labels.push(txt);
				marker.set("day", day_id);
				marker.set("line", line_id);
				marker.setMap(map);
				marker.setVisible(false);
				markers.push(marker);
				positions.push(position);
				marker_index ++;
			}
		});
		/*var testmarker = new google.maps.Marker({
					position: positions[0],
					map: map
				});*/
				
		return [markers, positions, marker_labels];
	}
	
	function showMarkerRoute (markers, marker_labels, positions,routes, routesP) {
		var red_icon = getMarkerIcon("#F70303","#51000");
		var grey_icon = getMarkerIcon("grey","grey");
				
		var selected_day_id = $(".swiper-slide-active").closest(".plan-day").attr("id");
		
		//// Selected day using map change day control
		var day_no = $(".map-day-show").val();	// show on bottom
		selected_day_id	= $(".plan-day").eq(day_no -1).attr("id"); //day id
	
		var prev_last_line_id =  $("#"+ selected_day_id).prevAll(".plan-day").has(".plan-line").first().find(".plan-line").last().attr("id");

		var bounds = new google.maps.LatLngBounds(); 
		
		updateMapLineNo(selected_day_id); // show line number icon on map below day select
		
		$(".map-font-icon").removeClass("marker-label-active");
		if (markers) {
			// show markers onto map
			$.each(markers,function(i) {				
				markers[i].setVisible(false);
				markers[i].setZIndex(10);
				if (marker_labels[i]) marker_labels[i].hide();
			
				///set color for marker
				if (markers[i].day == selected_day_id || markers[i].line == prev_last_line_id) {
					markers[i].set("viewstatus", "red");
					markers[i].setIcon(red_icon);	
					markers[i].setZIndex(11);
					if (marker_labels[i]) marker_labels[i].activate();
				}else {
					markers[i].setIcon(grey_icon);	
					markers[i].set("viewstatus", "grey");
				}
				
				if ( $(".map-selected").val() == "day") {
					if ( markers[i].viewstatus == "red") {	
						markers[i].setVisible(true);
						bounds.extend(positions[i]);
						map.fitBounds(bounds);
						if (marker_labels[i]) marker_labels[i].show();
					}else return;
				}else {
					markers[i].setVisible(true);					
					bounds.extend(positions[i]);
					map.fitBounds(bounds);
					if (marker_labels[i]) marker_labels[i].show();
				}
			});
		}
		
		if ($(".route-selected").val() == "routesP") var show_routes = routesP;
		else var show_routes = routes;
	
		if (show_routes) {
			//show routes onto map
			$.each(show_routes,function(i) {
				routes[i].setVisible(false);
				routesP[i].setVisible(false);
				show_routes[i].setOptions( {zIndex: 8});
				
				///set color for route
				if (markers[i].viewstatus == "red" && markers[i+1].viewstatus == "red" ) {
					show_routes[i].setOptions( {strokeColor: "red", zIndex: 9});
					show_routes[i].set("viewstatus", "red");
				}else {
					show_routes[i].setOptions( {strokeColor: "grey"});
					show_routes[i].set("viewstatus", "grey");	
				}
											
				if ( $(".map-selected").val() == "day") {
					if (show_routes[i].viewstatus == "red") {
						show_routes[i].setVisible(true);	
					}else return;	
				}else {	
					show_routes[i].setVisible(true);
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
		//// Map Event : Return to center		
		$("#go-center").off().on('click', function() {
			map.fitBounds(bounds);
		});	

		updateIconZoom (markers);
		return boundsAll;	
	}
	
	function createInfoWindow(markers,marker_labels) {
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
				marker_labels[i].onc();
			});
						
			infowindows.push(infowindow);	
		});
		
		google.maps.event.addListener(map, 'click', function() {
			$.each(infowindows,function(i) {infowindows[i].close();});
  		});
		
		/*if (marker_labels[1].div) {
		google.maps.event.addDomListener(marker_labels[1].div, 'click', function () {
					alert();
				});	
		}*/
	}
	
	function updateTransportBox() {
		// REFRESH: show all transport, delete all twins, clear all path 
		$(".transport").show();
		$(".transport .path").html("");
		$(".orindes").remove(); //maybe change the output code in itinerary later
		$(".transport").append('<span class="orindes hidden"></span>');
		$(".transport .orindes").html("");
		$(".plan-line-twins").remove();
		$(this).removeAttr('id');
		$(".has-route").removeClass("has-route mode-flight mode-drive no-reach");

		
		// add class to line with lat lng	
		$(".plan-line").each(function(i) {
			if ($(this).find('.plan-line-form-hidden input[name=lat]').val()) $(this).addClass("haslatlng"); 
		});	
		
		// make twins && hide all transport box not used
		$(".plan-day").each(function(i) {
			
			// make twins
			//if ( $(this).prevAll(".plan-day").has(".plan-line.haslatlng").length > 0 && $(this).find(".plan-line").length > 0){
			if ( $(this).prevAll(".plan-day").has(".plan-line.haslatlng").length > 0 ){	
			
				var twins_master_id = $(this).prevAll(".plan-day").has(".plan-line.haslatlng").first().find(".plan-line.haslatlng").last().attr("id");
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
							+ '<span class="orindes hidden"></span>'
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
	
	
	Number.prototype.toRad = function() {
		return this * Math.PI / 180;
	}
	
	function getDistanceTime() {
		
		$(".transport").each(function(i){
			var this_haslatlng = $(this).parents().hasClass("haslatlng");
			var next_haslatlng = $(this).parents().next(".plan-line").hasClass("haslatlng");
			var is_twins = $(this).parents().hasClass("plan-line-twins");
			var prev_is_twins = $(this).parents().prevAll(".haslatlng").first().hasClass("plan-line-twins");
			
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
			}else if (!this_haslatlng && !prev_is_twins){
				ori_lat = parseFloat($(this).parents(parent_class).prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
				ori_lng = parseFloat($(this).parents(parent_class).prevAll(".haslatlng").first().find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);
			}else if (!this_haslatlng && prev_is_twins){
				ori_lat = $(this).parents(parent_class).prevAll(".haslatlng").first().find(".plan-line-twins-lat").html();
				ori_lng = $(this).parents(parent_class).prevAll(".haslatlng").first().find(".plan-line-twins-lng").html();
			}
			
			if (next_haslatlng) {
				des_lat = parseFloat($(this).parents(parent_class).next().find('.plan-line-form-hidden input[name=lat]').val()).toFixed(6);
				des_lng = parseFloat($(this).parents(parent_class).next().find('.plan-line-form-hidden input[name=lng]').val()).toFixed(6);
			}
			
			
			if ( ori_lat && ori_lng && des_lat && des_lng && ori_lat !="NaN" && ori_lng !="NaN" && des_lat !="NaN" && des_lng !="NaN" ) {
				var origin = ori_lat+","+ori_lng;
				var destination = des_lat+","+des_lng;
				var transport_id = $(this).attr("id");	
				var service = new google.maps.DistanceMatrixService();
		
				if ( origin == destination) {
					$("#"+ transport_id).hide();
				}else {
					service.getDistanceMatrix({
							origins: [origin],
							destinations:  [destination],
							travelMode: 'DRIVING',
							unitSystem: google.maps.UnitSystem.METRIC,
							avoidHighways: false,
							avoidTolls: false
						}, function(response, status) {
							var R = 6371; // km
							var dLat = (des_lat - ori_lat).toRad();
							var dLon = (des_lng - ori_lng).toRad();
							var lat1 = parseFloat(ori_lat).toRad();
							var lat2 = parseFloat(des_lat).toRad();
							var a = Math.sin(dLat/2) * Math.sin(dLat/2) +
									Math.sin(dLon/2) * Math.sin(dLon/2) * Math.cos(lat1) * Math.cos(lat2); 
							var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)); 
							var d = parseInt(R * c);
							
							if (status !== 'OK') {
								alert('Error was: ' + status);
							} else {
								if (response.rows[0].elements[0].status !== 'OK') {
									var speed = 600;
									if(d > 7200) {
										speed = 870;
									}
									else if(d > 4800) {
										speed = 770;
									}
									else if(d > 2400) {
										speed = 720;
									}
									else if(d > 1600) {
										speed = 650;
									}
									
									var duration_number = parseInt(d / speed * 60);
									var t = convertLineDurationFormat(duration_number);
									var mode = "flight";
									$("#"+ transport_id).addClass("mode-"+mode);
									$("#"+ transport_id +" .icon").html("<i class='fa fa-fw fa-plane'></i><i class='fa fa-fw'></i>");
									$("#"+ transport_id +" .text").html('about ' + d + ' km , ' + t);								
								}
								else {
									var distance = response.rows[0].elements[0].distance.text;
									var duration = response.rows[0].elements[0].duration.text;
									
									var distance_number = parseInt(distance.substring(0, distance.length-3).replace(',',''));
									var speed = 600;
									
									if(distance_number > 800) {
										if(d > 7200) {
											speed = 870;
										}
										else if(d > 4800) {
											speed = 770;
										}
										else if(d > 2400) {
											speed = 720;
										}
										else if(d > 1600) {
											speed = 650;
										}
										var duration_number = parseInt(d / speed * 60);
										var t = convertLineDurationFormat(duration_number);
										var mode = "flight";
										$("#"+ transport_id).addClass("mode-"+mode);
										$("#"+ transport_id +" .icon").html("<i class='fa fa-fw fa-plane'></i><i class='fa fa-fw'></i>");
										$("#"+ transport_id +" .text").html('about ' + d + ' km , ' + t);	
									}
									else {
										var mode = "drive";
										$("#"+ transport_id).addClass("mode-"+mode);
										$("#"+ transport_id +" .icon").html("<i class='fa fa-fw fa-car'></i><i class='fa fa-fw'></i>");
										$("#"+ transport_id +" .text").html(distance + " , " + duration);
									}
								}
						}
					});
				}
			}else {
				var transport_id = $(this).attr("id");
				$("#"+ transport_id).hide();
			}
		
			if ( ori_lat && ori_lng && des_lat && des_lng && ori_lat !="NaN" && ori_lng !="NaN" && des_lat !="NaN" && des_lng !="NaN" &&  !$("#"+ transport_id +" .path").html()) {
				
				$("#"+ transport_id).addClass("has-route");
				var ori = new google.maps.LatLng(ori_lat, ori_lng)
				var des = new google.maps.LatLng(des_lat, des_lng)
				
				var request = {
								origin: ori,
								destination: des,
								travelMode: 'DRIVING'
					};	
				
				var coordinates = new Array();
						coordinates [0] = ori;
						coordinates [1] = des;
						
						var orindesString = JSON.stringify (coordinates);
						
						$("#"+ transport_id +" .orindes").html(orindesString);
				
				var directionsService = new google.maps.DirectionsService();			
				directionsService.route(request, function(response, status) {
					if (status == 'OK') {
						var routePath = response.routes[0].overview_path;
						var routeString = JSON.stringify (routePath);
						$("#"+ transport_id +" .path").html(routeString);				
					}else if (status == 'ZERO_RESULTS'){
					/*	var coordinates = new Array();
						coordinates [0] = ori;
						coordinates [1] = des;
						
						var routeString = JSON.stringify (coordinates);
						
						$("#"+ transport_id +" .path").html(routeString);*/
						$("#"+ transport_id).addClass("no-reach");	
							
					}					
				})
			}
		});
	}
	
	
	function makeRoutebyPath (markers, positions) {
		var lineSymbol = {
          path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
		  scale : 1.5,
		  strokeWeight: 3.5
        };		
		
		var dashlineSymbol = {
          path: 'M 0,-1 0,1',
          strokeOpacity: 1.5,
          scale: 2
        };
		
		var routes = [];
		var routesP = [];
		$(".transport.has-route").each(function(i) {
			
			if ( $(this).hasClass("no-reach") ||  $(this).hasClass("mode-flight")  ) {				
				var icon_sequence = [{
						icon: lineSymbol,
						offset: '60%'
					},	{
						icon: dashlineSymbol,
						offset: '0',
            			repeat: '15px'
					}];
				var route_opacity = 0;
				var routePath = JSON.parse($(this).find(".orindes").html());
			}else {
				var icon_sequence = [{
						icon: lineSymbol,
						offset: '60%'
					}];	
				var route_opacity = 1;	
				var routePath = JSON.parse($(this).find(".path").html());					
			}
			if (routePath){
			
				var route = new google.maps.Polyline({
					path: routePath,
					icons: icon_sequence,
					geodesic: true,
					strokeColor: '#000',
					strokeOpacity: route_opacity,
					strokeWeight: 1.5
				});		
				
				route.setMap(map);
				route.setVisible(false);
				routes.push(route);	
			}
			
		/**/		// polyline route
			//for (var i = 0, n = positions.length; i < n; i++) {	
				// set origin & destination for this loop only
				var coordinates = new Array();
				coordinates [0] = positions[i];
				coordinates [1] = positions[i+1];
			//};
			
			var routeP = new google.maps.Polyline({
				path: coordinates,
				icons: icon_sequence,
				geodesic: true,
				strokeColor: '#000',
				strokeOpacity: route_opacity,
				strokeWeight: 1.5
			});		
				
				routeP.setMap(map);
				routeP.setVisible(false);
				routesP.push(routeP);	
		});
		
		return [routes,routesP];
		
	}
	
	function createMapSelectDay () {
		$(".day-control").removeClass("disabled");		
		var selected_day_id = $(".swiper-slide-active").closest(".plan-day").attr("id");
		var selected_sort_order = $('.swiper-slide-active .plan-day-form-hidden input[name=sort_order]').val();
		var day_no =  parseInt(selected_sort_order.match(/\d+/));
		$(".map-day-group .map-day-show span").html(day_no);
		$(".map-day-group .map-day-show").val(day_no);
		
		
		if (day_no < 2 )  $(".map-day-left").addClass("disabled");
		if (day_no > $(".plan-day").length -1 )  $(".map-day-right").addClass("disabled");
		
		$(".map-setting-button").off().on("click", function(){
			$(".map-setting-list").toggleClass("hidden");
		});
		
		google.maps.event.addListener(map, 'click', function() {
			$(".map-setting-list").addClass("hidden");
  		});
		
	}
	
	/// Additional Map Style
	function getMapStyle () {
	var map_style = [
  {
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#aef7a6"
      }
    ]
  },
  {
    "featureType": "administrative",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#1115b0"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#21b011"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#1eb55a"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#1ba722"
      }
    ]
  },
  {
    "featureType": "administrative.country",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "weight": 1
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#004010"
      }
    ]
  },
  {
    "featureType": "administrative.locality",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#84ffa3"
      }
    ]
  },
  {
    "featureType": "administrative.province",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#054b1e"
      },
      {
        "weight": 1
      }
    ]
  },
  {
    "featureType": "administrative.province",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#004010"
      }
    ]
  },
  {
    "featureType": "administrative.province",
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#75ff98"
      },
      {
        "weight": 3
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "poi.business",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#A3E4D7"
      },
      {
        "lightness": 30
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#A3E4D7"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry.stroke",
    "stylers": [
      {
        "color": "#A3E4D7"
      },
      {
        "weight": 0.5
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#BB8FCE "
      }
    ]
  },
  {
    "featureType": "transit",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry.fill",
    "stylers": [
      {
        "color": "#bce2fe"
      }
    ]
  }
];
	
	return map_style;
		
	}

</script>
