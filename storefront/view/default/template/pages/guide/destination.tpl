<style type="text/css">
	.google-map-label {
		color: black;
		font-family: "Lucida Grande", "Arial", sans-serif;
		font-size: 14px;
		font-weight: bold;
		text-align: center;
		white-space: nowrap;
	}
</style>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?v=3&sensor=false"></script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/google-map-marker-with-label.js'); ?>"></script> 
<script>
var marker;
var markers = []; //declare as array
var gm_markers = [];
var pulse;
var pulse2;
var map;


var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
var icon1 = iconBase + 'parking_lot_maps.png';
var icon2 = iconBase + 'library_maps.png';
var iconG = 'http://maps.google.com/mapfiles/ms/icons/green.png';
var iconR = 'http://maps.google.com/mapfiles/ms/icons/red.png';

var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 
var labelIndex = 0;

var getMarkerUniqueId= function(lat, lng) {
    return lat + '_' + lng;
}

var getLatLng = function(lat, lng) {
    return new google.maps.LatLng(lat, lng);
};

function initMap() {
	var mapDiv = document.getElementById('builder-wrapper-map');
	var map_zoom = <?php echo $map_zoom;?>;
	
	var my_direction_service = new google.maps.DirectionsService;
    var my_direction_display = new google.maps.DirectionsRenderer({
		polylineOptions: {
			strokeColor: "white",
			strokeWeight: 1,
			icons: [{
    icon: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
    offset: '50%'
  }],
		},
		suppressMarkers: true,
	});
		
	map = new google.maps.Map(mapDiv, {
		center: {lat: <?php echo $map_lat;?>, lng: <?php echo $map_lng;?>},
		zoom: map_zoom,
		draggable: false,
		disableDefaultUI: true,
	});
	my_direction_display.setMap(map);
	
	//setMapZoom(map_zoom);
	
	//style for country
	if(map_zoom < 8) {
		map.set('styles', [
			{
			"featureType": "all",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "water",
			"stylers": [
			{ "visibility": "on" }
			]
			},{
			"featureType": "water",
			"elementType": "labels.text",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "landscape",
			"stylers": [
			{ "visibility": "on" },
			{ "color": "#fff4dd" }
			]
			}
		]);
	}
	//style for region
	else if(map_zoom >= 8 && map_zoom < 10 ) {
		map.set('styles', [
			{
			"featureType": "road",
			"stylers": [
			{ "visibility": "simplified" },
			{ "color": "#FFFFFF" }
			]
			},{
			"featureType": "transit",
			"stylers": [
			{ "visibility": "simplified" },
			{ "weight": 1 },
			]
			},{
			"featureType": "road",
			"elementType": "labels.icon",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "poi",
			"elementType": "labels",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "landscape.natural.terrain",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "poi.attraction",
			"elementType": "labels",
			"stylers": [
			{ "visibility": "on" }
			]
			},{
			"featureType": "poi.park",
			"stylers": [
			{ "visibility": "on" }
			]
			},{
			"featureType": "administrative",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "water",
			"elementType": "labels.text",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "landscape",
			"stylers": [
			{ "color": "#EEEEEE" }
			]
			}
		]);
	}
	//style for city
	else if(map_zoom >= 10) {
		map.set('styles', [
			{
			"featureType": "road",
			"stylers": [
			{ "visibility": "simplified" },
			{ "weight": 1 }
			]
			},{
			"featureType": "transit",
			"stylers": [
			{ "visibility": "on" },
			{ "weight": .5 }
			]
			},{
			"featureType": "transit.station",
			"elementType": "labels.text",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "road",
			"elementType": "labels.icon",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "poi",
			"elementType": "labels",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "landscape.natural.terrain",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "poi.attraction",
			"elementType": "labels",
			"stylers": [
			{ "visibility": "on" }
			]
			},{
			"featureType": "poi.park",
			"stylers": [
			{ "visibility": "on" }
			]
			},{
			"featureType": "administrative",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "water",
			"elementType": "labels.text",
			"stylers": [
			{ "visibility": "off" }
			]
			},{
			"featureType": "landscape",
			"stylers": [
			{ "color": "#EEEEEE" }
			]
			}
		]);
	}
/*
	var markerId = getMarkerUniqueId(<?php echo $map_lat;?>, <?php echo $map_lng;?>);
	marker = new google.maps.Marker({
		position: {lat: <?php echo $map_lat;?>, lng: <?php echo $map_lng;?>},
		map: map,
    	animation: google.maps.Animation.DROP,
		title: 'Kansai',
		label: labels[labelIndex++ % labels.length],
		url: "<?php echo $parent; ?>",
		icon: {
			path: fontawesome.markers.CARET_DOWN,
			scale: 0.5,
			strokeWeight: 0.2,
			strokeColor: 'black',
			strokeOpacity: 1,
			fillColor: '#d9534f',
			fillOpacity: 1,
			anchor: new google.maps.Point(30,-30),
			labelOrigin:new google.maps.Point(17, -60)
		},
		id: markerId
	});*/
	
	unpack_marker_icons();
	
	add_marker("airport", 1,"Shin-chitose","",42.792563, 141.670704);
	add_marker("main-city", 1,"Noboribetsu","",42.518681, 141.106202);
	add_marker("sub-city", 1,"Toya","",42.566018, 140.825298);
	add_marker("main-city", 1,"Sapporo","",43.068719, 141.351276);
	add_marker("sub-city", 1,"Otaru","",43.196861, 140.997950);
	add_marker("main-city", 1,"Sapporo","",43.068719, 141.351276);
	add_marker("main-city", 1,"Furano","",43.342846, 142.382683);
	add_marker("sub-city", 1,"Asahikawa","",43.772459, 142.363799);
	//add_marker("main-city", 1,"Sounkyo","",43.728305, 142.945336);
	//add_marker("sub-city", 1,"Abashiri","",44.022883, 144.276906);
	//add_marker("main-city", 1,"Akan","",43.434151, 144.092924);
	//add_marker("sub-city", 1,"Kushiro","",42.984889, 144.377100);
	add_marker("main-city", 1,"Sapporo","",43.068719, 141.351276);
	
	//display_route({lat: 42.792563, lng: 141.670704},{lat: 42.792563, lng: 141.670704}, my_direction_service, my_direction_display);
	display_path(my_paths);
	
	setMapMarkers();
	set_markers();
	set_labels();
	alert("success");
}

//limit zoom
function setMapZoom(map_zoom) {
	var minZoomLevel = map_zoom;
	var maxZoomLevel = map_zoom;
	google.maps.event.addListener(map, 'zoom_changed', function() {
		if (map.getZoom() < minZoomLevel) map.setZoom(minZoomLevel);
		if (map.getZoom() > maxZoomLevel) map.setZoom(maxZoomLevel);
	});
}

var bindMarkerEvents = function(marker) {
    google.maps.event.addListener(marker, "mouseover", function (point) {
		this.setIcon({ url:iconG, labelOrigin:new google.maps.Point(15, 9)});
		document.getElementById('builder-wrapper-guide-item-'+this.id).className = "col-xs-12 builder-wrapper-guide-item-row-active";
		document.getElementById('builder-wrapper-guide-content').scrollTop = document.getElementById('builder-wrapper-guide-item-'+this.id).offsetTop-80;
    });
	
	google.maps.event.addListener(marker, "mouseout", function (point) {
		this.setIcon({ url:iconR, labelOrigin:new google.maps.Point(15, 9)});
		document.getElementById('builder-wrapper-guide-item-'+this.id).className = "col-xs-12 builder-wrapper-guide-item-row";
    });
	
	google.maps.event.addListener(marker, "click", function (point) {
        window.location.href = this.url;
    });
};

var addMapMarker = function(marker_id, marker_name, marker_url, marker_lat, marker_lng) {
	markers.push({
		id: marker_id,
		name: marker_name,
		url: marker_url,
		lat: marker_lat,
		lng: marker_lng
		});
};

var focusMapMarker = function(marker_id) {
    gm_markers[marker_id].setIcon({ url:iconG, labelOrigin:new google.maps.Point(15, 9)});
}

var defocusMapMarker = function(marker_id) {
    gm_markers[marker_id].setIcon({ url:iconR, labelOrigin:new google.maps.Point(15, 9)});
}

var setMapMarkers = function() {
	for(i=0; i<markers.length; i++) {
		gm_markers[markers[i].id] = new google.maps.Marker({
			position: {lat: markers[i].lat, lng: markers[i].lng},
			map: map,
			title: markers[i].name,
			label: labels[labelIndex++ % labels.length],
			url: markers[i].url,
			icon: { url:iconR, labelOrigin:new google.maps.Point(15, 9)},
			id: markers[i].id
		});
		bindMarkerEvents(gm_markers[markers[i].id]); 
	}
};

var my_markers = [];
var my_labels = [];
var my_google_map_markers = [];
var my_waypoints = [];
var my_paths = [];
var marker_icons = [];
var highlighted_marker_icons = [];

var unpack_marker_icons = function() {
	marker_icons['airport'] = { 
		path: 'M49.536-58.679q1.584 1.872.432 5.328t-3.888 6.192l-5.796 5.796 5.76 25.056q.18.684-.432 1.188l-4.608 3.456q-.252.216-.684.216-.144 0-.252-.036-.54-.108-.756-.576l-10.044-18.288-9.324 9.324 1.908 6.984q.18.612-.288 1.116l-3.456 3.456q-.324.324-.828.324h-.072q-.54-.072-.864-.468l-6.804-9.072-9.072-6.804q-.396-.252-.468-.828-.036-.468.324-.9l3.456-3.492q.324-.324.828-.324.216 0 .288.036l6.984 1.908 9.324-9.324-18.288-10.044q-.504-.288-.612-.864-.072-.576.324-.972l4.608-4.608q.504-.468 1.08-.288l23.94 5.724 5.76-5.76q2.736-2.736 6.192-3.888t5.328.432z', 
		anchor: new google.maps.Point(25,-40),
		scale: .3, 
		strokeWeight: 2, 
		fillColor: '#FFFFFF',
		fillOpacity: 1,
	};
	
	highlighted_marker_icons['airport'] = { 
		path: 'M49.536-58.679q1.584 1.872.432 5.328t-3.888 6.192l-5.796 5.796 5.76 25.056q.18.684-.432 1.188l-4.608 3.456q-.252.216-.684.216-.144 0-.252-.036-.54-.108-.756-.576l-10.044-18.288-9.324 9.324 1.908 6.984q.18.612-.288 1.116l-3.456 3.456q-.324.324-.828.324h-.072q-.54-.072-.864-.468l-6.804-9.072-9.072-6.804q-.396-.252-.468-.828-.036-.468.324-.9l3.456-3.492q.324-.324.828-.324.216 0 .288.036l6.984 1.908 9.324-9.324-18.288-10.044q-.504-.288-.612-.864-.072-.576.324-.972l4.608-4.608q.504-.468 1.08-.288l23.94 5.724 5.76-5.76q2.736-2.736 6.192-3.888t5.328.432z', 
		anchor: new google.maps.Point(25,-40),
		scale: .3, 
		strokeWeight: 1, 
		fillColor: 'blue',
		fillOpacity: 1,
	};

	marker_icons['main-city'] = { 
		path: google.maps.SymbolPath.CIRCLE, 
		scale: 6, 
		strokeWeight: 1, 
		fillColor: 'black',
		fillOpacity: 1,
	};
	
	highlighted_marker_icons['main-city'] = { 
		path: google.maps.SymbolPath.CIRCLE, 
		scale: 10, 
		strokeWeight: 1, 
		fillColor: 'blue',
		fillOpacity: 1,
	};
	
	marker_icons['sub-city'] = { 
		path: google.maps.SymbolPath.CIRCLE, 
		scale: 4, 
		strokeWeight: 1, 
		fillColor: 'black',
		fillOpacity: 1,
	};
	
	highlighted_marker_icons['sub-city'] = { 
		path: google.maps.SymbolPath.CIRCLE, 
		scale: 3, 
		strokeWeight: 1, 
		fillColor: 'blue',
		fillOpacity: 1,
	};
}

var add_marker = function(marker_type, marker_id, marker_name, marker_url, marker_lat, marker_lng) {
	my_markers.push({
		type: marker_type,
		id: marker_id,
		name: marker_name,
		url: marker_url,
		lat: marker_lat,
		lng: marker_lng,
		icon: marker_icons[marker_type],
	});
	add_label(marker_id, marker_name, marker_lat, marker_lng);
	add_path(marker_lat,marker_lng);
	if(my_markers.length > 1) { 
		add_waypoint(marker_lat,marker_lng);
	}
};

var set_markers = function() {
	for(i=0; i<my_markers.length; i++) {
		my_google_map_markers[my_markers[i].id] = new google.maps.Marker({
			position: {lat: my_markers[i].lat, lng: my_markers[i].lng},
			map: map,
			title: my_markers[i].name,
			label: my_markers[i].stay,
			url: my_markers[i].url,
			icon: my_markers[i].icon,
			id: my_markers[i].id,
		});
		set_marker_events(my_markers[i].type, my_google_map_markers[my_markers[i].id]); 
	}
};

var set_labels = function() {
	for(i=0; i<my_labels.length; i++) {
		my_google_map_markers[my_labels[i].id] = new MarkerWithLabel({
			position: new google.maps.LatLng(42.792563, 141.670704),
			map: map,
			zIndex: 1,
			labelText: my_labels[i].name,
			labelClass: "google-map-label", // the CSS class for the label
			labelStyle: {bottom: my_labels[i].height, right: my_labels[i].width},
			labelZIndex: 2
		});
	}
};

/**
var set_labels = function() {
	for(i=0; i<my_labels.length; i++) {
		my_google_map_markers[my_labels[i].id] = new MarkerWithLabel({
			position: {lat: my_labels[i].lat, lng: my_labels[i].lng},
			map: map,
			labelContent: my_labels[i].name,
			labelAnchor: new google.maps.Point(my_labels[i].width, my_labels[i].height),
			labelClass: "google-map-label", // the CSS class for the label
			icon: {}
		});
	}
};
**/

var set_marker_events = function(type, marker) {
    google.maps.event.addListener(marker, "mouseover", function (point) {
		this.setIcon(highlighted_marker_icons[type]);
		document.getElementById('builder-wrapper-guide-item-'+this.id).className = "col-xs-12 builder-wrapper-guide-item-row-active";
		document.getElementById('builder-wrapper-guide-content').scrollTop = document.getElementById('builder-wrapper-guide-item-'+this.id).offsetTop-80;
    });
	
	google.maps.event.addListener(marker, "mouseout", function (point) {
		this.setIcon(marker_icons[type]);
		document.getElementById('builder-wrapper-guide-item-'+this.id).className = "col-xs-12 builder-wrapper-guide-item-row";
    });
	
	google.maps.event.addListener(marker, "click", function (point) {
        window.location.href = this.url;
    });
};

var display_route = function(route_origin, route_destination, my_direction_service, my_direction_display) {
	my_direction_service.route({
		origin: route_origin,
		destination: route_destination,
		waypoints: my_waypoints,
		travelMode: google.maps.TravelMode.DRIVING
	}, function(response, status) {
		if (status === google.maps.DirectionsStatus.OK) {
			my_direction_display.setDirections(response);
		} else {
			window.alert('Directions request failed due to ' + status);
		}
	});
};

var add_waypoint = function(marker_lat, marker_lng) {
	my_waypoints.push({ location: new google.maps.LatLng(marker_lat,marker_lng) });
};

var add_path = function(marker_lat, marker_lng) {
	my_paths.push({ lat:marker_lat, lng:marker_lng });
};

var display_path = function(my_paths) {
	var line = new google.maps.Polyline({
		path: my_paths,
		strokeWeight: 3,
		strokeOpacity: 0.5,
		strokeColor: 'red',
		icons: [{
			icon: {
				path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
				scale:2,
				strokeOpacity: 1,
				strokeColor: 'blue',
			},
			offset: '100%',
		},{
			icon: {
				path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
				scale:1.3,
				strokeColor: 'red',
			},
			repeat: '10%',
		}],
		map: map
	});
	
	animate_transport(line);
};

function animate_transport(line) {
    var count = 0;
    window.setInterval(function() {
      count = (count + 1) % 600; //interval to restart the animation

      var icons = line.get('icons');
      icons[0].offset = (count / 2) + '%';
      line.set('icons', icons);
  }, 20);
}

var add_label = function(marker_id, marker_name, marker_lat, marker_lng) {
	document.getElementById("text-width-measurement-container").style.display = 'block';
	document.getElementById("text-width-measurement-container").innerHTML = marker_name;
	my_labels.push({
		id: marker_id,
		name: marker_name,
		lat: marker_lat,
		lng: marker_lng,
		width: document.getElementById("text-width-measurement-container").offsetWidth+"px",
		height: document.getElementById("text-width-measurement-container").offsetHeight+"px",
	});
	document.getElementById("text-width-measurement-container").innerHTML = '';
	document.getElementById("text-width-measurement-container").style.display = 'none';
};

</script>

<div id="builder-wrapper-map">
</div>
<span id="text-width-measurement-container" class="google-map-label"></span>

<!--
<div id="builder-wrapper-map-cover">
</div>
-->

<?php if ($description) { ?>
<div id="builder-wrapper-description">
	<?php echo $description; ?>
</div>
<?php } ?>