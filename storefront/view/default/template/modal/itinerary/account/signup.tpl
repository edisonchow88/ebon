<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-account-signup" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-account-signup-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-account-signup">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Sign Up</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                	<div id="modal-account-signup-form-alert"></div>
                    <div class="modal-body">
                        <?php echo $component['form']; ?>
                        <a class="btn btn-block btn-primary modal-button" onclick="signup();">Sign Up</a>
                        <div class="modal-body-footnote">
                            <span>Own an account? </span>
                            <a data-dismiss="modal" data-toggle='modal' data-target="#modal-account-login">Log in</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function signup() {
		var form_element = document.querySelector("#modal-account-signup-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $ajax['account/ajax_user']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			var alert_text = "";
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				
				if(typeof json.warning != 'undefined') {
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
					//Google Analytics Event
					ga('send', 'event','account', 'trip-signup');
					window.location.reload(true);
				}
				document.getElementById('modal-account-signup-form-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	<!-- START: clear alert when closed -->
		$("#modal-account-signup").on( "hidden.bs.modal", function() { 
			$('#modal-account-signup-form-alert').html('');
		});
	<!-- END -->
		$("#modal-account-signup").on( "show.bs.modal", function() { 
			//Google Analytics Event
			ga('send', 'event','account', 'open-modal-trip-signup');
		});
</script>