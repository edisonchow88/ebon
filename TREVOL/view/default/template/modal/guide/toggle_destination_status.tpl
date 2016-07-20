<!-- START: Show Modal -->
    <form id="modal-toggle-destination-status-form">
        <input 
            type="hidden" 
            name="action"
            value="toggle_status" 
        />
        <input
            type="hidden"
            id="modal-toggle-destination-status-form-input-destination-id" 
            name="destination_id" 
        />
    </form>
<!-- END -->

<script>
	function toggleDestinationStatus() {
		var form_element = document.querySelector("#modal-toggle-destination-status-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_destination']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				destination_id = document.getElementById("modal-toggle-destination-status-form-input-destination-id").value;
				element_id = "destination-status-"+destination_id;
				if(xmlhttp.responseText == 1) {
					document.getElementById(element_id).innerHTML = "<i class='fa fa-fw fa-toggle-on'></i> <span class='small'>ON</span>";
				}
				else if(xmlhttp.responseText == 0) {
					document.getElementById(element_id).innerHTML = "<i class='fa fa-fw fa-toggle-off'></i> <span class='small'>OFF</span>";
				}
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
</script>