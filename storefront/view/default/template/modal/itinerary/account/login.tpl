<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-account-login" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-account-login-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-account-login">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Log In</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                	<div id="modal-account-login-form-alert"></div>
                    <div class="modal-body">
                        <?php echo $component['form']; ?>
                        <a class="btn btn-block btn-primary modal-button" onclick="login();">Log In</a>
                        <div class="modal-body-footnote">
                            <span>New to Trevol? </span>
                            <a data-dismiss="modal" data-toggle='modal' data-target="#modal-account-signup">Sign up</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function login() {
		var form_element = document.querySelector("#modal-account-login-form");
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
					window.location.reload(true);
				}
				document.getElementById('modal-account-login-form-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	<!-- START: clear alert when closed -->
		$("#modal-account-login").on( "hidden.bs.modal", function() { 
			$('#modal-account-login-form-alert').html('');
		});
	<!-- END -->
</script>