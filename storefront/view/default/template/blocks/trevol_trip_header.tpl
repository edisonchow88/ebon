<style>
	/* START: wrapper-title */
		#wrapper-title {
			display:inline-block;
			float:left;
			margin-left:15px;
		}
		
		#wrapper-title input {
			box-shadow:none;
			border:none;
			min-width:150px;
		}
	/* END */
	
	#wrapper-title-input:disabled {
		-webkit-text-fill-color:#FFF;
		color:#FFF;
		border:none;
		cursor:default;
	}
	
	#wrapper-title-input:hover:disabled {
		border:none;
	}
	
	#wrapper-header.view-mode {
		background-color:#e93578;
		color:#FFF;
	}
	
	#wrapper-header.view-mode #wrapper-title-input {
		background-color:#e93578;
		color:#FFF;
	}
	
	/* START: wrapper-hint */
		#wrapper-hint {
			position:absolute;
			top:12.5px;
			left:60px;
			height:23px;
			border-radius:3px;
			padding:3px 10px;
			background-color:#F69;
			display:none;
		}
	/* END */
	
	/* START: wrapper-button-search */
		#wrapper-button-search {
			display:inline-block;
			float:right;
		}
		
		#wrapper-button-search a {
			margin:-7px 0;
			padding:14px;
			border:none;
		}
	/* END */
	
	/* START: wrapper-button-save */
		#wrapper-button-save {
			display:inline-block;
			float:right;
		}
		
		#wrapper-button-save a {
			margin:-7px 0;
			padding:14px;
			border:none;
			color:#FFF;
			font-weight:bold;
		}
	/* END */
</style>

<div id="wrapper-header" class="view-mode">
	<div id="wrapper-menu-icon">
    <!-- <div id="wrapper-menu-icon" data-toggle='tooltip' data-placement='bottom' title='Open Menu'> -->
    	<a class="btn btn-primary" onclick="toggle_wrapper_menu(); hide_wrapper_account();"><i class="fa fa-fw fa-bars fa-lg"></i></a>
    </div>
    <!-- START: [trip name] -->
    	<?php if($this->session->data['mode'] == 'edit') { ?>
        	<div id="wrapper-title" class="hidden">
        	<!-- <div id="wrapper-title" class="hidden" data-toggle='tooltip' data-placement='bottom' title='Rename Trip'> -->
        		<input id="wrapper-title-input" class="form-control" type="text"></input>
            </div>
        <?php } else { ?>
            <div id="wrapper-title" class="hidden">
                <input id="wrapper-title-input" class="form-control" type="text" disabled></input>
            </div>
        <?php } ?>
    <!-- END -->
    <!-- START: [hint] -->
    	<div id="wrapper-hint" class="small">
        	<b>HINT:</b> <span>Add your favourite place</span>
        </div>
    <!-- END -->
    <!-- START: float right -->
        <div id="wrapper-account-icon" class="hidden dropdown">
        <!-- <div id="wrapper-account-icon" class="hidden dropdown" data-toggle='tooltip' data-placement='bottom' title='Open Account Menu'> -->
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
        <!-- START: [button] -->
        	<div id="wrapper-button-search" class="hidden">
                <a class="btn btn-primary"><i class="fa fa-fw fa-search fa-lg"></i></a>
            </div>
            <?php if($this->session->data['mode'] == 'view') { ?>
                <div id="wrapper-button" class="hidden">
                    <a class="btn btn-default disabled" style="width:120px !important;"><i class="fa fa-fw fa-eye"></i> View Only</a>
                </div>
            <?php } else { ?>
            	<div id="wrapper-button-share">
                	<a class="btn btn-default hidden" data-toggle="modal" data-target="#modal-trip-share">Share</a>
                </div>
                <div id="wrapper-button-save" class="hidden">
                	<!--
                    <?php if($this->session->data['memory'] == 'server') { ?>
                        <span class="label label-success">Auto Saved</span>
                    <?php } ?>
                    -->
                    <?php if($this->session->data['memory'] == 'cookie') { ?>
                    	<a class="btn btn-primary" onclick="verify_save_trip_condition();">Save</a>
                    <?php } ?>
                </div>
            <?php } ?>
        <!-- END -->
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
		<?php if(isset($trip_id)) { ?>
			<!-- START: set POST data -->
				var data = {
					"action":"refresh_trip",
					"trip_id":"<?php echo $trip_id; ?>"
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
		<?php if($this->user->isLogged() == false) { ?>
			var trip = {
				name:$("#wrapper-title-input").val()
			};
			trip = JSON.stringify(trip);
			setCookie('trip',trip,1);
			showHint('Title updated');
		<?php } else { ?>
			<!-- START: set POST data -->
				var data = {
					"action"	: "edit_trip_name",
					"trip_id"	: "<?php echo $this->trip->getTripId(); ?>",
					"name"		: $("#wrapper-title-input").val()
				};
			<!-- END -->
			
			<!-- START: send POST -->
				$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
					showHint('Title updated');
				}, "json");
			<!-- END -->
		<?php } ?>
	});
	
	refreshTrip();
</script>