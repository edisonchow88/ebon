<style>
	#explore-map {
		height:calc(100vh - 40px);
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-line-map" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-line-map-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-map">Back</a>
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
                    	<div id="explore-map"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-line-map").on( "shown.bs.modal", function() {
		initExploreMap();
	});
</script>

<script>
	function startLoadExplore() {
		$(window).scrollTop(0);
		$('#wrapper-explore-current').hide();
		$('#wrapper-explore-child').hide();
		$('#wrapper-explore-loading').show();
	}
	
	function initExploreMap() {
		startLoadExplore();
		
		var map = new google.maps.Map(document.getElementById('explore-map'), {
			center: {lat: -3.1385059, lng: 101.6869895},
			zoom: 0,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			disableDefaultUI: true
        });
		
		<!-- START: link searchBox to UI element -->
			var input = document.getElementById('modal-line-search-input-keyword');
			var option = {};
			
			var filter = {};
			filter.country = $('#modal-line-filter-form select[name=country]').val();
			if(isset(filter.country) && filter.country != 'all') {
				option.componentRestrictions = {'country':filter.country};
			}
			
			var searchBox = new google.maps.places.Autocomplete(input, option);
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
			if(isset(getPlace())) {
				service.getDetails({
					placeId: getPlace()
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
			searchBox.addListener('place_changed', function() {
				var place = searchBox.getPlace();
				
				if(isset(place.place_id) == false) {
					showAlert('No search result');
					return;
				}
				
				explorePlace(place.place_id);
				
				//updateWrapperExploreResult(place);
				$('#modal-line-explore').modal('show');
				$('#modal-line-search').modal('hide');
				$('#modal-line-add').modal('hide');
			});
		<!-- END -->
		
		<!-- START: set filter trigger -->
			$('#modal-line-filter-form select[name=country]').on('change',function() {
				var country = $(this).val();
				if(country == 'all') {
					searchBox.setComponentRestrictions([]);
				}
				else {
					searchBox.setComponentRestrictions({'country':country});
				}
			});
		<!-- END -->
	}
	
	/*
	function initExploreMap() {
		startLoadExplore();
		
		var map = new google.maps.Map(document.getElementById('explore-map'), {
			center: {lat: -3.1385059, lng: 101.6869895},
			zoom: 0,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			disableDefaultUI: true
        });
		
		<!-- START: link searchBox to UI element -->
			var input = document.getElementById('modal-line-search-input-keyword');
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
			if(isset(getPlace())) {
				service.getDetails({
					placeId: getPlace()
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
				$('#modal-line-explore').modal('show');
				$('#modal-line-search').modal('hide');
				$('#modal-line-add').modal('hide');
			});
		<!-- END -->
	}
	*/
</script>