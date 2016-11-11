<style>
	.alert {
		border-radius:0;
	}
	
	.padding {
		padding:15px;
	}
	
	.rounded {
		border-radius:5px;
	}
	
	.fixed-height-5 {
		height:50px;
	}
	
	.fixed-height-5.btn {
		line-height:36px;
	}
	
	.border-bottom {
		border-bottom: solid thin #DDD;
	}
	
	.mobile-form label {
		background-color:#FFF;
		color:#999;
		height:50px;
		width:100%;
		margin:0;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
		font-weight:normal;
	}
	.mobile-form input, .mobile-form select {
		background-color:#FFF;
		color:#000;
		height:50px;
		width:100%;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
		-webkit-appearance: none;
	}
	.mobile-form input:disabled {
		color:#999;
	}
	.mobile-form select {
		-webkit-appearance: none;
		-webkit-border-radius: 0px;
	}
</style>

<!-- START: Modal -->
	<div class="modal modal-fixed-top" id="modal-trip-new" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div class="fixed-bar">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-trip-new">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span class="btn-header modal-title">New Trip</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-bar">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                        <div id="modal-trip-new-form-alert"></div>
                    	<form class="mobile-form" id="modal-trip-new-form">
                        	<input type="hidden" name="action" value="new_trip" />
                            <input type="hidden" name="user_id" value="<?php echo $this->user->getUserId(); ?>" />
                            <input type="hidden" name="role_id" value="<?php echo $this->user->getRoleId(); ?>" />
                            <input type="hidden" name="language_id" value="<?php echo $this->language->getLanguageId(); ?>" />
                        	<div class="row">
                                <div class="col-xs-4"><label for="name" selected>Title</label></div>
                                <div class="col-xs-8">
                                	<input type="text" name="name" value="My Trip" />
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4"><label for="country_id" selected>Destination</label></div>
                                <div class="col-xs-8">
                                    <select name="country_id">
                                        <?php
                                        	foreach($country as $key => $value) {
                                            	if($value['iso_code_2'] == 'MY') { $selected = 'selected'; } else { $selected = ''; }
                                            	echo '<option value="'.$value['country_id'].'" '.$selected.'>'.$value['name'].'</option>';
                                                
                                            }
                                        ?>
                                    </select>
                                </div>
                            </div>
                            <div class="row text-center padding border-bottom">
                            	<a class="btn btn-block btn-primary box-shadow rounded fixed-height-5" onclick="verify_new_trip_condition();">Create My Own</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<!-- START: Script -->
<script>
	function newTrip() {
		var form_element = document.querySelector("#modal-trip-new-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $ajax['trip/ajax_itinerary']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			var alert_text = "";
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				
				if(typeof json.exceeded_quota != 'undefined') {
					$('#modal-trip-quota-alert-text').html('New trip cannot be created.');
					$('#modal-trip-quota').modal('show');
					$('#modal-trip-new').modal('hide');
				}
				else if(typeof json.warning != 'undefined') {
					<!-- if error -->
					var content;
					content = "<div class='alert alert-danger'><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					alert_text = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					setCookie('trip','',0);
					setCookie('plan','',0);
					window.location = json.redirect;
				}
				document.getElementById('modal-trip-new-form-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function newTripViaCookie() {
		var title = $('#modal-trip-new-form input[name=name]').val();
		var trip = '{"name":"'+title+'"}';
		var plan = '{"name":"Plan 1","travel_date":"","day":[{"day_id":1,"sort_order":1}]}';
		setCookie('trip',trip,7);
		setCookie('plan',plan,7);
		window.location = '<?php echo $redirect; ?>';
	}
	
	function verify_new_trip_condition() {
		//Google Analytics Event
		ga('send', 'event','trip','create-new-trip');
		<?php if($this->user->isLogged() == false) { ?>
			<!-- START: [not logged] -->
				newTripViaCookie();
			<!-- END -->
		<?php } else { ?>
			<!-- START: [logged] -->
				newTrip();
			<!-- END -->
		<?php } ?>
		
		/*
		var cookie = getCookie('plan');
		var trip = JSON.parse(getCookie('trip'));
		
		<?php if($this->user->isLogged() == false) { ?>
			<!-- START: [not logged] -->
				if(typeof cookie != 'undefined' && cookie != null && cookie != '') {
					<!-- START: [has cookie] -->
						$('#modal-trip-new').modal('show');
						$('#modal-trip-new-form-alert').html("<div class='alert alert-warning'><b>NOTE: "+trip.name+" is not saved.</b><br/>It will be deleted permanently. Do you like to proceed?</div>");
						$('#modal-trip-new .btn-primary').off().on('click',function() {
							newTripViaCookie();
						});
					<!-- END -->
				}
				else {
					<!-- START: [no cookie] -->
						newTripViaCookie();
					<!-- END -->
				}
			<!-- END -->
		<?php } else { ?>
			<!-- START: [logged] -->
				if(typeof cookie != 'undefined' && cookie != null && cookie != '') {
					<!-- START: [has cookie] -->
						$('#modal-trip-new').modal('show');
						$('#modal-trip-new-form-alert').html("<div class='alert alert-warning'><b>NOTE: "+trip.name+" is not saved.</b><br/>It will be deleted permanently. Do you like to proceed?</div>");
						$('#modal-trip-new .btn-primary').off().on('click',function() {
							newTrip();
						});
					<!-- END -->
				}
				else {
					<!-- START: [no cookie] -->
						newTrip();
					<!-- END -->
				}
			<!-- END -->
		<?php } ?>
		*/
	}
	
	$("#modal-trip-new").on( "hidden.bs.modal", function() { 
		$('#modal-trip-new-form-alert').html('');
	});
</script>
<!-- END -->