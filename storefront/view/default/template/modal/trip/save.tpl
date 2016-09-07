<!-- START: Modal -->
    <div class="modal fade" id="modal-trip-save" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Save Trip</h4>
                </div>
            <div class="modal-body">
                <div id="modal-trip-save-form-alert"></div>
                <?php echo $modal_component['form']; ?>
            </div>
                <div class="modal-footer">
                	<div class="row">
                        <div class="col-xs-12 col-sm-3 col-md-2 pull-right">
                            <button type="button" class="btn btn-block btn-primary" onclick="saveTrip();">Save</button>
                        </div>
                        <div class="pull-right line-spacer">
                        	<i class="fa fa-fw"></i>
                        </div>
                        <div class="col-xs-12 col-sm-3 col-md-2 pull-right">
                            <button type="button" class="btn btn-block btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<!-- START: Script -->
<script>
	function saveTrip() {
		var form_element = document.querySelector("#modal-trip-save-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax; ?>";
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
					
					var content;
					content = "<div class='alert alert-success'><ul>";
					content += "<li><b>Success! Your trip has been saved.</b></li>";
					content += "</ul></div>";
					alert_text = content;
					
					button = ''
						+'<div class="col-xs-12 col-sm-3 col-md-2 pull-right">'
						+'<button type="button" class="btn btn-default" data-dismiss="modal">Continue</button>'
						+'</div>'
					;
					$('#modal-trip-save-form').hide();
					$('#modal-trip-save .modal-footer .row').html(button);
					$("#modal-trip-save").on( "hidden.bs.modal", function() { window.location = json.redirect; } );
				}
				document.getElementById('modal-trip-save-form-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function verify_save_trip_condition() {
		<?php if($this->user->isLogged() == false) { ?>
			$('#modal-account-login').modal('show');
			$('#modal-account-login-form-alert').html('<div class="alert alert-info">You need to log in to perform this action.</div>');
		<?php } else { ?>
			$('#modal-trip-save').modal('show');
			$('#modal-trip-save-form input[name=name]').val($('#wrapper-title-input').val());
		<?php } ?>
	}
	
	$("#modal-trip-save").on( "show.bs.modal", function() { 
		$('#modal-trip-save-form input[name=plan]').val(getCookie('plan'));
	});
	
	$("#modal-trip-save").on( "hidden.bs.modal", function() { 
		$('#modal-trip-save-form-alert').html('');
	});
</script>
<!-- END -->