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
    <div id="section-content-map-content">

  <!--  	<button onclick="initMap()"></button>--> 
        <div class="btn-group map-option-group" role="group" aria-label="...">
  			<button type="button" class="btn btn-default map-option map-selected" value="day">Day</button>
  			<button type="button" class="btn btn-default map-option" value="all">All</button>
		</div>
       <div id="map"></div>
    </div>
</div>


<script>
	function toggleMapOption() {
		$(".map-option").removeClass("map-selected");
		$(this).addClass("map-selected");
		initMap();		
	}
	
	
	var map;
	function initMap() {
		var myLatlng = new google.maps.LatLng(3.139003, 101.686852); //Malaysia
		map = new google.maps.Map(document.getElementById('map'), {
			center: myLatlng,
			zoom: 4,
			minZoom: 1,
			maxZoom: 8,
			disableDefaultUI: true
		});
		
		
		updateMap();
	}
		
	function updateMap() {
		
		var selected_day_id = $(".selected").closest(".plan-day-tr").attr("id");
		
		var map_option_selector;
		if ( $(".map-selected").val() == "day") map_option_selector = "#"+selected_day_id + " .plan-line-tr";
		else map_option_selector = ".plan-line-tr";
		
		//get all selected day activities
		var bounds = new google.maps.LatLngBounds();
		var lat, lng, position, marker,title;
		var infowindow = new google.maps.InfoWindow();
		var markers = [];
		var positions =[];
			
			//<div>Icons made by <a href="http://www.flaticon.com/authors/arthur-shlain" title="Arthur Shlain">Arthur Shlain</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>//
		var myIcon = {
			path: 'M245,0C157.687,0,86.905,70.781,86.905,158.094c0,14.641,1.999,28.812,5.724,42.266c1.491,5.388,3.252,10.663,5.283,15.803   l4.794,10.894L245,490l142.481-263.316l4.321-9.818c2.149-5.363,4.011-10.871,5.57-16.505c3.724-13.455,5.724-27.626,5.724-42.266   C403.095,70.781,332.313,0,245,0z M245,234.271c-42.797,0-77.609-34.812-77.609-77.609c0-42.79,34.812-77.602,77.609-77.602   s77.609,34.812,77.609,77.602C322.609,199.459,287.797,234.271,245,234.271z',
			fillColor: 'red',
			fillOpacity: 0.8,
			scale: 0.03,
			anchor: new google.maps.Point(250, 450),
			strokeColor: 'red',
			strokeWeight: 1
		};
			
		//	setting to day view only for now
		// map_option_selector = "#"+selected_day_id + " .plan-line-tr";
		//				
		$(map_option_selector).each(function(i) {
			lat = $(this).find('.plan-line-form-hidden input[name=lat]').val();
			lng = $(this).find('.plan-line-form-hidden input[name=lng]').val();	
			title =	$(this).find('.plan-line-form-hidden input[name=place]').val();
			var marker_id = $(this).attr("id");
		
			// color check
			if ($(this).closest(".plan-day-tr").hasClass("selected")) {
				myIcon.fillColor = 'red'; 
				myIcon.strokeColor = 'red';
			}
			else { 
				myIcon.fillColor = 'grey'; 
				myIcon.strokeColor = 'black';
			}
			
			if(lat && lng) {
				position = new google.maps.LatLng(lat, lng); 
				bounds.extend(position);
				marker = new google.maps.Marker({
					position: position,
					map: map,
					icon : myIcon,
					title: title
					})
				marker.set("id", marker_id);
				markers.push(marker);
				positions.push(position);
			}
		});
		
		
		// Define a symbol using a predefined path (an arrow)
        // supplied by the Google Maps JavaScript API.
        var lineSymbol = {
          path: google.maps.SymbolPath.FORWARD_CLOSED_ARROW
        };
			
		
		if (markers.length < 1) { 
			map.setCenter(new google.maps.LatLng(3.139003, 101.686852)); //Malaysia
		}
		
		else if (markers.length > 1 ) {
		var routes = [];	
			for (var i = 0, n = positions.length; i < n; i++) {	
				var coordinates = new Array();
				coordinates [0] = positions[i];
				coordinates [1] = positions[i+1];
				
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
				routes.push(route);	
			}
			map.fitBounds(bounds);
		}
		
		else map.fitBounds(bounds);
		
	}
</script>

<!-- START: refresh map if map is shown [IMPORTANT] -->
	<script>
    	
		$(".plan-table").ready(function() {
 			var observer = new MutationObserver(function(mutations) {
            initMap();
			});
		
			//$("#plan-table").on("update-map",initMap);
			//OBSERVE CONDITIONS : ALWAYS RUNNING, except when sorting
			//var target = document.getElementById('section-center');
			var target = document.getElementById('plan-table');
			var config = { childList:true,subtree: true, attributes : true, attributeFilter : ['style'] };
			observer.observe(target, config);
			/**/
			//close when sort, open back when stop
			$(document).on( "sortStart", function( event, ui ) {
				observer.disconnect();
				} )
			$(document).on( "sortStop", function( event, ui ) {
				updateMap();
				observer.observe(target, config);
				} )
			
			$(".plan-day-tr").on('selectedDayChanged',function(){ 
			initMap();		
			});
			
			// EVENT LISTENER: Map Options
			$(".map-option").on('click',toggleMapOption);
			
		});
	   
		
		
		
	
    </script>
<!-- END -->

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initMap" async defer>
</script>