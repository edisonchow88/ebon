<!-- START: Modal -->
    <div class="modal fade" id="modal-trip-remove" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Remove Trip</h4>
                </div>
            <div class="modal-body">
                <div id="modal-trip-remove-form-alert">
                	<div class="alert alert-danger">Are you sure you want to remove <b><span id="modal-trip-remove-form-trip-name"></span></b> to Archive?</div>
                </div>
                <?php echo $modal_component['form']; ?>
            </div>
                <div class="modal-footer">
                	<div class="row">
                        <div class="col-xs-12 col-sm-3 col-md-2 pull-right">
                            <button type="button" class="btn btn-block btn-primary" onclick="removeTrip();">Remove</button>
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
	function removeTrip() {
		var form_element = document.querySelector("#modal-trip-remove-form");
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
					content += "<li><b>SUCCESS: Your trip has been removed to archive.</b></li>";
					content += "</ul></div>";
					alert_text = content;
					
					button = ''
						+'<div class="col-xs-12 col-sm-4 col-md-3 pull-right">'
						+'<button type="button" class="btn btn-default" data-dismiss="modal">Back to Home</button>'
						+'</div>'
					;
					$('#modal-trip-remove-form').hide();
					$('#modal-trip-remove .modal-footer .row').html(button);
					$("#modal-trip-remove").on( "hidden.bs.modal", function() { window.location = json.redirect; } );
				}
				document.getElementById('modal-trip-remove-form-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function verify_remove_trip_condition() {
		$('#modal-trip-remove').modal('show');
	}
	
	<!-- START: clear alert when closed -->
		$("#modal-trip-remove").on( "show.bs.modal", function() { 
			$('#modal-trip-remove-form-trip-name').html($('#wrapper-title-input').val());
		});
	<!-- END -->
</script>
<!-- END -->