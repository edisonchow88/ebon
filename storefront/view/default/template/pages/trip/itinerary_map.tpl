<style>
	.spacer-bar {
		min-height:20px;
	}
	
	#section-itinerary-map {
		text-align:left;
	}
	
	#section-itinerary-map-header {
		padding:7px;
		border-bottom:solid thin #EEE;
	}
	
	#section-itinerary-map-header .input-group {
		border-radius:10px;
	}
	
	#section-itinerary-map-header .form-control {
		border-radius:10px;
	}
	
	#section-itinerary-map-header .btn-simple {
		padding-right:0;
		padding-left:0;
	}
	
	#section-itinerary-map-header-close {
		font-size:24px;
		line-height:14px;
	}
	
	#section-itinerary-map-content {
		overflow-y:hidden;
		overflow-x:hidden;
	}
	
	#map {
        height:100%;
	}
</style>

<div id="section-itinerary-map">
    <div id="section-itinerary-map-header">
        <div class="row">
            <div class="spacer-bar hidden-xs hidden-sm col-md-12 col-lg-12"></div>
        </div>
        <div class="row">
            <div class="input-group pull-left inline col-xs-12 col-sm-12 col-md-12 col-lg-9">
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
                	<i class="fa fa-fw" id="section-itinerary-map-header-close">&times;</i>
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
    <div id="section-itinerary-map-content">
    	<div id="map"></div>
    </div>
</div>


<script>
	var map;
	function initMap() {
		map = new google.maps.Map(document.getElementById('map'), {
			center: {lat: 0, lng: 0},
			zoom: 1,
			minZoom: 1,
			disableDefaultUI: true
		});
		
		/* START: set max world boundary */
			google.maps.event.addListener(map, 'center_changed', function() {
				checkBounds(map);
			});
			
			function checkBounds(map) {
				var latNorth = map.getBounds().getNorthEast().lat();
				var latSouth = map.getBounds().getSouthWest().lat();
				var newLat;
				
				if(latNorth<85 && latSouth>-85) {
					return;
				}
				else {
					if(latNorth>85 && latSouth<-85) {   /* out both side -> it's ok */
						return;
					}
					else {
						if(latNorth>85)   
							newLat =  map.getCenter().lat() - (latNorth-85);   /* too north, centering */
						if(latSouth<-85) 
							newLat =  map.getCenter().lat() - (latSouth+85);   /* too south, centering */
					}   
				}
				if(newLat) {
					var newCenter= new google.maps.LatLng( newLat ,map.getCenter().lng() );
					map.setCenter(newCenter);
				}   
			}
		/* END */
	}
	
</script>

<!-- START: refresh map if map is shown [IMPORTANT] -->
	<script>
        var observer = new MutationObserver(function(mutations) {
            initMap();
        });
        
        var target = document.getElementById('section-right');
        observer.observe(target, { attributes : true, attributeFilter : ['style'] });
    </script>
<!-- END -->

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initMap" async defer>
</script>