<style>
	#modal-trip-save .tab {
		display:none;
	}
	
	#modal-trip-save .tab.active {
		display:block;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-trip-save" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-trip-save-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-trip-save">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Save Trip</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div id="modal-trip-save-form-alert"></div>
                    <div class="modal-body">
                    	<div class="tab tab-trip <?php if($this->user->isLogged() != false) { echo 'active'; } ?>">
                    		<?php echo $component['form']; ?>
                            <a class="btn btn-block btn-primary modal-button" data-dismiss="modal" onclick="saveTrip();">Save Trip</a>
                        </div>
                        <div class="tab tab-account <?php if($this->user->isLogged() == false) { echo 'active'; } ?>">
                        	<div>Log in or sign up to save trip.</div>
                            <br />
                            <a class="btn btn-block btn-primary modal-button"data-dismiss="modal" data-toggle='modal' data-target="#modal-account-login">Log In</a>
                            <a class="btn btn-block btn-default modal-button" data-dismiss="modal" data-toggle='modal' data-target="#modal-account-signup">Sign Up</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->


<!-- START: Script -->
<script>
	function showModalTripSaveTab(tab) {
		$('#modal-trip-save .tab').removeClass('active');
		$('#modal-trip-save .'+tab).addClass('active');
	}
	
	function saveTrip() {
		//Google Analytics Event
		ga('send', 'event','trip','save-trip');
		var form_element = document.querySelector("#modal-trip-save-form");
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
					$('#modal-trip-quota-alert-text').html('Trip cannot be saved.');
					$('#modal-trip-quota').modal('show');
					$('#modal-trip-save').modal('hide');
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
				document.getElementById('modal-trip-save-form-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	<!-- START: clear alert when closed -->
		$("#modal-trip-save").on( "show.bs.modal", function() { 
			//Google Analytics Event
			ga('send', 'event','trip','open-modal-save-trip');
			$('#modal-trip-save-form input[name=name]').val($('#wrapper-title-input').val());
			$('#modal-trip-save-form input[name=name]').trigger('change');
			$('#modal-trip-save-form input[name=plan]').val(getCookie('plan'));
		});
		$("#modal-trip-save").on( "hidden.bs.modal", function() { 
			$('#modal-trip-save-form-alert').html('');
		});
	<!-- END -->
</script>
<!-- END -->