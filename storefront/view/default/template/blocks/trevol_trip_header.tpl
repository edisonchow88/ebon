<div id="wrapper-header" class="box-shadow">
	<div id="wrapper-menu-icon" data-toggle='tooltip' data-placement='bottom' title='Open Menu'>
    	<a class="btn btn-primary" onclick="toggle_wrapper_menu(); hide_wrapper_account();"><i class="fa fa-fw fa-bars fa-lg"></i></a>
    </div>
    <div id="wrapper-title" data-toggle='tooltip' data-placement='bottom' title='Rename Trip'>
        <input id="wrapper-title-input" class="form-control" type="text" value="Trip 1"></input>
    </div>
    <!-- START: float right -->
        <div id="wrapper-account-icon" class="dropdown" data-toggle='tooltip' data-placement='bottom' title='Open Account Menu'>
        	<a onclick="toggle_wrapper_account(); hide_wrapper_menu();">
            	<?php if($logged == true) { ?>
                    <span class="fa-stack fa-lg">
                        <i class="fa fa-circle-thin fa-stack-2x"></i>
                        <i class="fa fa-smile-o fa-stack-1x"></i>
                    </span>
                <?php } else { ?>
                	<span class="fa-stack fa-lg">
                        <i class="fa fa-circle fa-stack-2x"></i>
                        <i class="fa fa-user fa-stack-1x fa-inverse"></i>
                	</span>
                <?php } ?>
            </a>
        </div>
        <div id="wrapper-button" class="hidden-xs hidden-sm">
            <a class="btn btn-default">Share</a>
            <a class="btn btn-primary">Save</a>
        </div>
        <div id="wrapper-alert">
        	<!-- [SAMPLE]
            <div class="alert alert-success alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <span><strong>Irrashaimase!</strong> welcome (＾▽＾)</span>
            </div>
            -->
        </div>
    <!-- END -->
</div>

<script>
	function setCookie(cname, cvalue, exdays) {
		var d = new Date();
		d.setTime(d.getTime() + (exdays*24*60*60*1000));
		var expires = "expires="+ d.toUTCString();
		document.cookie = cname + "=" + cvalue + "; " + expires;
	}
	
	function getCookie(cname) {
		var name = cname + "=";
		var ca = document.cookie.split(';');
		for(var i = 0; i <ca.length; i++) {
			var c = ca[i];
			while (c.charAt(0)==' ') {
				c = c.substring(1);
			}
			if (c.indexOf(name) == 0) {
				return c.substring(name.length,c.length);
			}
		}
		return "";
	}
</script>

<script>
	function refreshTrip() {
		<?php if($this->user->isLogged() != '') { ?>
			<!-- START: set POST data -->
				var data = {
					"action":"refresh_trip"
				};
			<!-- END -->
			
			<!-- START: send POST -->
				$.post("<?php echo $ajax_itinerary; ?>", data, function(trip) {
					$("#wrapper-title-input").val(trip.name);
				}, "json");
			<!-- END -->
		<?php } else { ?>
			<!-- START: get data from cookie without login -->
				var trip = getCookie('trip');
				if(trip == '') {
					<!-- START: [first time] -->
						var trip = {
							name:"Trip 1"
						};
						trip = JSON.stringify(trip);
						setCookie('trip',trip,1)
					<!-- END -->
				}
				trip = JSON.parse(trip);
				$("#wrapper-title-input").val(trip.name);
			<!-- END -->
		<?php } ?>
	}
	
	$("#wrapper-title-input").change(function() {
		<?php if($this->user->isLogged() != '') { ?>
			<!-- START: set POST data -->
				var data = {
					"action":"edit_trip_name",
					"name":$("#wrapper-title-input").val()
				};
			<!-- END -->
			
			<!-- START: send POST -->
				$.post("<?php echo $ajax_itinerary; ?>", data, function(trip) {
				}, "json");
			<!-- END -->
		<?php } else { ?>
			var trip = {
				name:$("#wrapper-title-input").val()
			};
			trip = JSON.stringify(trip);
			setCookie('trip',trip,1);
		<?php } ?>
	});
	
	refreshTrip();
</script>