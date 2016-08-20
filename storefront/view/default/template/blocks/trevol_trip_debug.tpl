<!-- START: [button] -->
    <?php if($role_id == 1) { ?>
        <div id="wrapper-debug-button" class="btn btn-default" onclick="toggle_wrapper_debug();">
            Debug
        </div>
    <?php } ?>
<!-- END -->

<!-- START: [modal] -->
    <div id="wrapper-debug">
        <div id="wrapper-debug-modal-background" onclick="hide_wrapper_debug();">
        </div>
        <div id="wrapper-debug-modal-body" class="col-xs-12 col-sm-6 col-md-3">
            <div id="wrapper-debug-modal-shadow" class="box-shadow">
            </div>
            <div id="wrapper-debug-modal-content">
            	<div id="wrapper-debug-modal-alert"></div>
                <?php echo $modal_component['form']; ?>
                <a class="btn btn-warning btn-block" onclick="getTrip(); debug();">Test</a>
            </div>
        </div>
    </div>
<!-- END -->

<!-- START: [script] -->
	<script>
        function toggle_wrapper_debug() {
            if(document.getElementById('wrapper-debug-modal-background').style.display == 'block') {
                hide_wrapper_debug();
            }
            else {
                show_wrapper_debug();
            }
        }
        
        function show_wrapper_debug() {
            $('#wrapper-debug').show();
            $('#wrapper-debug-modal-background').fadeIn();
            $('#wrapper-debug-modal-shadow').slideDown('fast');
            $('#wrapper-debug-modal-content').slideDown('fast');
            
            <!-- START: Hide tooltip -->
                var id = $('#wrapper-debug-icon').attr('aria-describedby');
                $('#'+id).hide();
                $('#wrapper-debug-icon').attr('data-original-title', 'Close Debug Menu');
            <!-- END -->
        }
        
        function hide_wrapper_debug() {
            $('#wrapper-debug-modal-background').fadeOut();
            $('#wrapper-debug-modal-shadow').slideUp('fast');
            $('#wrapper-debug-modal-content').slideUp('fast');
            
            <!-- START: Hide tooltip -->
                var id = $('#wrapper-debug-icon').attr('aria-describedby');
                $('#'+id).hide();
                $('#wrapper-debug-icon').attr('data-original-title', 'Open Debug Menu');
            <!-- END -->
        }
    </script>
<!-- END -->

<!-- START: refresh trip -->
<script>
	function getTrip() {
		var send = {"action":"get_trip","user_id":"1","plan_id":"4"};
		var myJsonString = JSON.stringify(send);
		document.getElementById('hidden-itinerary-form-input-send').value = myJsonString;
	}
</script>
<!-- END -->

<!-- START: Script -->
<script>
	function debug() {
		var form_element = document.querySelector("#hidden-itinerary-form");
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
					document.getElementById('hidden-itinerary-form-input-return').value = json.plan[1].line_id;
				}
				document.getElementById('wrapper-debug-modal-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
</script>
<!-- END -->