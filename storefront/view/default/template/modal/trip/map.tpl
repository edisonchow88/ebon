<style>
	#map {
		height:calc(100vh - 40px);
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-trip-map" role="dialog">
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
	});
</script>

<script>
	function initMap() {
		var map = new google.maps.Map(document.getElementById('map'), {
			center: {lat: -3.1385059, lng: 101.6869895},
			zoom: 0,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			disableDefaultUI: true
        });
		
		var markersData = createDrawMarkerList();
		
		var markers = markersData [0];
		var positions = markersData [1];
			
		createInfoWindow(markers);
			
		var bounds = showMarkerRoute(markers, positions, route_type, routes);
		
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
						alert (day_id+ line_id);			
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
	
	function showMarkerRoute (markers, positions, route_type, routes) {
		
		var red_icon = getMarkerIcon("red","red");
		var grey_icon = getMarkerIcon("grey","grey");
				
		var selected_day_id = $(".selected").closest(".plan-day").attr("id");
		var prev_last_line_id =  $("#"+ selected_day_id).prev(".plan-day").find(".plan-line").last().attr("id");

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
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initMap" async defer></script>