<style>
	#map {
		height:calc(100vh - 40px);
	}
	
	#modal-explore-map .modal-body {
		padding:0;
	}
</style>

<!-- START: Modal -->
    <div class="modal" id="modal-explore-map" role="dialog" data-backdrop="false">
        <div class="modal-dialog fixed-bar">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-explore-map">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                    	<span class="btn-header modal-title">Map</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
                <div class="modal-body">
                    <div id="map">
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-explore-map").on( "shown.bs.modal", function() {
		//Google Analytics Event
		ga('send', 'event','explore-map', 'open-map');
		initMap();
	});
</script>

<script>
	function initMap() {
		startLoadExplore();
		
		var map = new google.maps.Map(document.getElementById('map'), {
			center: {lat: -3.1385059, lng: 101.6869895},
			zoom: 0,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			disableDefaultUI: true
        });
		
		<!-- START: link searchBox to UI element -->
			var input = document.getElementById('modal-explore-search-input-keyword');
			var searchBox = new google.maps.places.SearchBox(input);
		<!-- END -->
		
		<!-- START: bias searchBox results towards current map's viewport -->
			map.addListener('bounds_changed', function() {
				searchBox.setBounds(map.getBounds());
			});
		<!-- END -->
		
		<!-- START: clear existing markers -->
			var markers = [];
			markers.forEach(function(marker) {
				marker.setMap(null);
			});
			markers = [];
		<!-- END -->
		
		<!-- START: set init place based on hash -->
			var bounds = new google.maps.LatLngBounds();
			var service = new google.maps.places.PlacesService(map);
			if(getHash() != null && getHash() != '') {
				service.getDetails({
					placeId: getHash()
					}, 
					function(place, status) {
					if (status === google.maps.places.PlacesServiceStatus.OK) {
						<!-- START: update current data -->
							updateWrapperExploreResult(place);
						<!-- END -->
						
						<!-- START: set marker -->
							markers.push(new google.maps.Marker({
								map: map,
								position: place.geometry.location
							}));
						<!-- END -->
						
						<!-- START: set viewport -->
							if (place.geometry.viewport) {
								bounds.union(place.geometry.viewport);
							} else {
								bounds.extend(place.geometry.location);
							}
						<!-- END -->
						
						<!-- START: set bound -->
							map.fitBounds(bounds);
							if($.inArray('political',place.types) != -1) {
								map.setZoom(map.getZoom());
							}
							else {
								map.setZoom(map.getZoom() - 8);
							}
						<!-- END -->
					}
				});
			}
			else {
				initExplore();
			}
		<!-- END -->
		
		<!-- START: select a result -->
			searchBox.addListener('places_changed', function() {
				var places = searchBox.getPlaces();
				var place = places[0];
				
				if (places.length == 0) {
					return;
				}
				
				explorePlace(place.place_id);
				
				//updateWrapperExploreResult(place);
				$('#modal-explore-search').modal('hide');
			});
		<!-- END -->
	}
	
	function updateMap() {
	}
</script>