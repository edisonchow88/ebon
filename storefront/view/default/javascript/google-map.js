
function initMap() {
		  var minZoomLevel = 5;
		  var maxZoomLevel = 5;
		  
        var mapDiv = document.getElementById('builder-wrapper-map');
        var map = new google.maps.Map(mapDiv, {
          center: {lat: <?php echo $map_lat;?>, lng: <?php echo $map_lng;?>},
          zoom: <?php echo $map_zoom;?>,
		  disableDefaultUI: true,
        });
		
		//Disable draggable movement
		map.setOptions({draggable: false});
		
		// Set Boundary
		   var strictBounds = new google.maps.LatLngBounds(
			 new google.maps.LatLng(23.80, 122.80), 
			 new google.maps.LatLng(46.00, 147.00)
		   );
		   
		   // Listen for the dragend event
		   google.maps.event.addListener(map, 'dragend', function() {
			 if (strictBounds.contains(map.getCenter())) return;
		
			 // We're out of bounds - Move the map back within the bounds
		
			 var c = map.getCenter(),
				 x = c.lng(),
				 y = c.lat(),
				 maxX = strictBounds.getNorthEast().lng(),
				 maxY = strictBounds.getNorthEast().lat(),
				 minX = strictBounds.getSouthWest().lng(),
				 minY = strictBounds.getSouthWest().lat();
		
			 if (x < minX) x = minX;
			 if (x > maxX) x = maxX;
			 if (y < minY) y = minY;
			 if (y > maxY) y = maxY;
		
			 map.setCenter(new google.maps.LatLng(y, x));
		   });
		   
		   // Limit the zoom level
   google.maps.event.addListener(map, 'zoom_changed', function() {
     if (map.getZoom() < minZoomLevel) map.setZoom(minZoomLevel);
	 if (map.getZoom() > maxZoomLevel) map.setZoom(maxZoomLevel);
   });
   
		map.set('styles', [
  {
    "featureType": "road",
    "stylers": [
      { "visibility": "simplified" },
      { "weight": 0.3 }
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
    "featureType": "administrative.country",
    "stylers": [
      { "visibility": "simplified" },
      { "lightness": 28 }
    ]
  },{
    "featureType": "water",
    "elementType": "labels.text",
    "stylers": [
      { "visibility": "off" }
    ]
  },{
    "featureType": "transit",
    "stylers": [
      { "visibility": "off" }
    ]
  },{
    "featureType": "road",
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
	  
	  var iconBase = 'https://maps.google.com/mapfiles/kml/shapes/';
var icons = {
  parking: {
    icon: iconBase + 'parking_lot_maps.png'
  },
  library: {
    icon: iconBase + 'library_maps.png'
  },
  info: {
    icon: iconBase + 'info-i_maps.png'
  }
};



function addMarker(feature) {
  var marker = new google.maps.Marker({
    position: feature.position,
    icon: icons[feature.type].icon,
    map: map
  });
}

var legend = document.getElementById('legend');
for (var style in styles) {
  var name = style.name;
  var icon = style.icon;
  var div = document.createElement('div');
  div.innerHTML = '<img src="' + icon + '"> ' + name;
  legend.appendChild(div);
}