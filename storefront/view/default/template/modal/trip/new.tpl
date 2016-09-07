<!-- START: Modal -->
    <div class="modal fade" id="modal-trip-new" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">New Trip</h4>
                </div>
            <div class="modal-body">
                <div id="modal-trip-new-form-alert"></div>
                <?php echo $modal_component['form']; ?>
            </div>
                <div class="modal-footer">
                	<div class="row">
                        <div class="col-xs-12 col-sm-3 col-md-2 pull-right">
                            <button type="button" class="btn btn-block btn-primary">Create</button>
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
	function newTrip() {
		var form_element = document.querySelector("#modal-trip-new-form");
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
		setCookie('trip','{"name":"Untitled Trip"}',7);
		setCookie('plan','{"name":"Plan 1","travel_date":"","day":[{"day_id":1,"sort_order":1}]}',7);
		window.location.reload();
	}
	
	function verify_new_trip_condition() {
		var cookie = getCookie('plan');
		var trip_name = $('#wrapper-title-input').val();
		
		<?php if($this->user->isLogged() == false) { ?>
			<!-- START: [not logged] -->
				if(typeof cookie != 'undefined' && cookie != null && cookie != '') {
					<!-- START: [has cookie] -->
						$('#modal-trip-new').modal('show');
						$('#modal-trip-new-form-alert').html("<div class='alert alert-warning'><b>NOTE: "+trip_name+" is not saved.</b><br/>It will be deleted permanently. Do you like to proceed?</div>");
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
						$('#modal-trip-new-form-alert').html("<div class='alert alert-warning'><b>NOTE: "+trip_name+" is not saved.</b><br/>It will be deleted permanently. Do you like to proceed?</div>");
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
	}
	
	$("#modal-trip-new").on( "hidden.bs.modal", function() { 
		$('#modal-trip-new-form-alert').html('');
	});
</script>
<!-- END -->