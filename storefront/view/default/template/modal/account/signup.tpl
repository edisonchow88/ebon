<!-- START: Modal -->
    <div class="modal fade" id="modal-account-signup" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Sign Up</h4>
                </div>
            <div class="modal-body">
                <div id="modal-account-signup-form-alert"></div>
                <?php echo $modal_component['form']; ?>
                <div class="modal-body-footnote">
                	<span>Own an account? </span>
                    <a data-dismiss="modal" data-toggle='modal' data-target="#modal-account-login" >Log in now</a>
                </div>
            </div>
                <div class="modal-footer">
                	<div class="row">
                        <div class="col-xs-12 col-sm-3 col-md-2 pull-right">
                    		<button type="button" class="btn btn-block btn-primary" onclick="signup();">Sign Up</button>
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
	function signup() {
		var form_element = document.querySelector("#modal-account-signup-form");
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
					var content;
					content = "<div class='alert alert-success'><ul>";
					content += "<li><b>Success! Your account has been created.</b></li>";
					content += "<li>You may save and load your plan anytime anywhere.</li>";
					content += "</ul></div>";
					alert_text = content;
					
					button = '<button type="button" class="btn btn-default" data-dismiss="modal">Continue</button>';
					$('#modal-account-signup-form').hide();
					$('#modal-account-signup .modal-footer').html(button);
					$("#modal-account-signup").on( "hidden.bs.modal", function() { window.location.reload(true); } );
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
</script>
<!-- END -->