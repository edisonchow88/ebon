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
	}
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initMap" async defer></script>