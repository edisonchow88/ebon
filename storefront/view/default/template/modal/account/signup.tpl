<!-- START: Modal -->
    <div class="modal" id="modal-account-signup" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-header fixed-width">
            	<div class="navbar navbar-primary navbar-modal">
                    <div class="col-xs-2 text-left">
                        <a class="btn" data-dismiss="modal"><i class="fa fa-fw fa-lg fa-times-circle"></i></a>
                    </div>
                    <div class="col-xs-8 text-center">
                    	<span class="modal-title">Sign Up</span>
                    </div>
                    <div class="col-xs-2 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-body fixed-width padding">
            	<div class="navbar navbar-shadow"></div>
            	<div id="modal-account-signup-form-alert"></div>
                    <?php echo $modal_component['form']; ?>
                    <button type="button" class="btn btn-block btn-primary modal-button" onclick="signup();">Sign Up</button>
                    <div class="text-center">
                        <span>Own an account? </span>
                    	<a data-dismiss="modal" data-toggle='modal' data-target="#modal-account-login" >Log in</a>
                    </div>
                    <div class="modal-response">
               		</div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<!-- START: Script -->
<script>
	function signup() {
		<!-- START: show loading -->
			var loading = setTimeout(function() { showLoad('Signing Up'); }, 1000);
		<!-- END -->
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
					//Google Analytics Event
					ga('send', 'event','account', 'main-signup');
					var content;
					content = "<div class='alert alert-success'><ul>";
					content += "<li><b>Success! Your account has been created.</b></li>";
					content += "<li>You may save and load your plan anytime anywhere.</li>";
					content += "</ul></div>";
					alert_text = content;

					button = '<button type="button" class="btn btn-default" data-dismiss="modal">Continue</button>';
					$('#modal-account-signup-form').hide();
					$('#modal-account-signup .modal-body-footnote').hide();
					$('.modal-button').hide();
					$('#modal-account-signup .modal-response').html(button);
					$("#modal-account-signup").on( "hidden.bs.modal", function() { window.location.reload(true); } );
				}
				document.getElementById('modal-account-signup-form-alert').innerHTML = alert_text;
				clearTimeout(loading);
				hideLoad();
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
			ga('send', 'event','account', 'open-modal-main-signup');
		});
</script>
<!-- END -->