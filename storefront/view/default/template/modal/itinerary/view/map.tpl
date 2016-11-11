<style>
	#map {
		height:calc(100vh - 40px);
	}
	
	#modal-itinerary-map .modal-body {
		position:relative;
	}
	
	.button-recenter {
		position:absolute;
		top:0;
		right:0;
		z-index:5;
		padding:15px;
	}
	
	.btn-group.button-recenter .btn {
		padding:10px;
		border-radius:5px;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-itinerary-map" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-itinerary-map-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-itinerary-map">Back</a>
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
                        <div class="btn-group button-recenter">
                            <div class="btn btn-default">
                                <i class="fa fa-fw fa-bullseye"></i>
                            </div>
                        </div>
                    	<div id="map"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-itinerary-map").on( "shown.bs.modal", function() {
		initMap();
	});
</script>

<script>
	function initMap() {
		<!-- START -->
			var map_style = getMapStyle();
			var map = new google.maps.Map(document.getElementById('map'), {
				center: {lat: -3.1385059, lng: 101.6869895},
				zoom: 0,
				mapTypeId: google.maps.MapTypeId.ROADMAP,
				disableDefaultUI: true,
				styles: map_style
			});
		<!-- END -->
		<!-- START -->
			var bounds = new google.maps.LatLngBounds();
		<!-- END -->
		<!-- START -->
			var myLatLng, exLatLng;
			var infowindows = [];
			$(".plan-line-form-hidden").each(function(i) {
				var lat, lng, position, title, activity, marker;
				lat = parseFloat($(this).find('input[name=lat]').val()).toFixed(6);
				lng = parseFloat($(this).find('input[name=lng]').val()).toFixed(6);
				if(isset(lat) && isset(lng) && isNaN(lat) != true && isNaN(lng) != true) {
					myLatLng = new google.maps.LatLng(lat,lng);
					title = $(this).find('input[name=title]').val();
					activity = $(this).find('input[name=activity]').val();
					
					var infowindow = new google.maps.InfoWindow({
						content: title
					});
					
					if(activity != 'fly_out' && activity != 'fly_in') {
						marker = new google.maps.Marker({
							position: myLatLng,
							map: map,
							title: title,
							icon:getMarkerIcon('#FFF','#000')
						});
					}
					else {
						marker = new google.maps.Marker({
							position: myLatLng,
							map: map,
							title: title,
							icon:getMarkerIcon('#000','#000',.3)
						});
						marker = new google.maps.Marker({
							position: myLatLng,
							map: map,
							title: title,
							icon: {
								path: fontawesome.markers.PLANE,
								fillColor:'#FFF',
								strokeColor: '#333',
								fillOpacity: 1,
								scale: .2,
								anchor: new google.maps.Point(30, -30),
								strokeWeight: 1
							}
						});
					}
					
					marker.addListener('click', function() {
						$.each(infowindows,function(i) {infowindows[i].close();});
						infowindow.open(map, marker);
					});
					
					infowindows.push(infowindow);
					
					if(activity != 'fly_out' && activity != 'fly_in') {
						bounds.extend(myLatLng);
					}
					
					<!-- START: draw path -->
						var lineSymbol = {
							path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW,
							scale:1.5
						};
						
						var linePlane = {
							path: fontawesome.markers.PLANE,
							strokeColor: '#F00',
							fillColor: '#900',
							fillOpacity: 1,
							rotation: -45,
							scale:0.5,
							anchor: new google.maps.Point(-5, -5),
						};
						
						var lineDotted = {
							path: 'M 0,-1 0,1',
							strokeOpacity: 1,
							strokeWeight: 2,
							strokeColor:'red'
						};
						
						if(isset(exLatLng)) {
							if(activity != 'fly_in') {
								var line = new google.maps.Polyline({
									path: [exLatLng,myLatLng],
									strokeOpacity: 1,
									strokeWeight: 2,
									strokeColor:'red',
									map: map,
									icons: [{
										icon: lineSymbol,
										offset: '60%',
									}],
								});
							}
							else {
								var line = new google.maps.Polyline({
									path: [exLatLng,myLatLng],
									strokeOpacity: 0,
									map: map,
									icons: [
										{
											icon: lineDotted,
											offset: '0',
											repeat: '20px'
										},
										{
											icon: linePlane,
											offset: '60%'
										}
									]
								});
							}
						}
					<!-- END -->
					
					exLatLng = myLatLng;
				}
			});
		<!-- END -->
		<!-- START -->
			
		<!-- END -->
		<!-- START -->
			map.fitBounds(bounds);
			var map_center = map.getCenter();
			var map_zoom = map.getZoom();
		<!-- END -->
		<!-- START-->
			$(".button-recenter").off().on('click', function() {
				map.setZoom(map_zoom);
				map.setCenter(map_center);
			});
		<!-- END -->
	}
	
	/*
	function getIcon(glyph, color) {
		var canvas, ctx;
		canvas = document.createElement('canvas');
		canvas.width = canvas.height = 20;
		ctx = canvas.getContext('2d');
		if (color) {
		  ctx.strokeStyle = color;
		}
		ctx.font = '20px FontAwesome';
		ctx.fillText(glyph, 0, 16);
		return canvas.toDataURL();
	  }
	  */
	  
	function getMarkerIcon(f_color,s_color, icon_scale) {
		if (!icon_scale) var icon_scale = 0.2;
		var myIcon = {
			path: fontawesome.markers.CIRCLE,
			fillColor: f_color,
			strokeColor: s_color,
			fillOpacity: 1,
			scale: icon_scale,
			anchor: new google.maps.Point(30, -30),
			strokeWeight: 1
		};
		return myIcon;	
	}
	
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