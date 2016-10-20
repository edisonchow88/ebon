<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-account-login" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
            	<div class="fixed-bar">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-account-login"><i class="fa fa-fw fa-lg fa-times-circle"></i><span class="sr-only">Cancel</span></a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span class="btn-header modal-title">Log In</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-dialog fixed-bar">
            <div class="modal-header-shadow"></div>
            <div class="modal-content">
                <div class="modal-body">
                    <div id="modal-account-login-form-alert"></div>
                    <?php echo $modal_component['form']; ?>
                    <button type="button" class="btn btn-block btn-primary modal-button" onclick="login();">Log In</button>
                    <div class="modal-body-footnote">
                        <span>New to Trevol? </span>
                        <a data-dismiss="modal" data-toggle='modal' data-target="#modal-account-signup" >Sign up</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<!-- START: Script -->
<script>
	function login() {
		var form_element = document.querySelector("#modal-account-login-form");
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
					ga('send', 'event','account', 'main-login');
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
	
		$("#modal-account-login").on( "show.bs.modal", function() { 
			//Google Analytics Event
			ga('send', 'event','account', 'open-modal-main-login');
		});
	
	$(".modal").on("show", function () {
		$("body").addClass("modal-open");
	}).on("hidden", function () {
		$("body").removeClass("modal-open");
	});
</script>
<!-- END -->