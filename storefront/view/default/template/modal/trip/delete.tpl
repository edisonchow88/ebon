<!-- START: Modal -->
    <div class="modal fade" id="modal-trip-delete" role="dialog" data-backdrop="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Delete Trip</h4>
                </div>
            <div class="modal-body">
                <div id="modal-trip-delete-form-alert">
                	<div class="alert alert-danger">Are you sure you want to delete <b><span id="modal-trip-delete-form-trip-name"></span></b> ?</div>
                </div>
                <?php echo $modal_component['form']; ?>
            </div>
                <div class="modal-footer">
                	<div class="row">
                        <div class="col-xs-12 col-sm-3 col-md-2 pull-right">
                            <button type="button" class="btn btn-block btn-primary" onclick="deleteTrip();">Delete</button>
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
	function deleteTrip() {
		var form_element = document.querySelector("#modal-trip-delete-form");
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
					window.location.reload(true);
				}
				document.getElementById('modal-trip-delete-form-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	<!-- START: clear alert when closed -->
		$("#modal-trip-delete").on( "show.bs.modal", function() { 
			$('#modal-trip-delete-form-trip-name').html($('#wrapper-title-input').val());
		});
	<!-- END -->
</script>
<!-- END -->