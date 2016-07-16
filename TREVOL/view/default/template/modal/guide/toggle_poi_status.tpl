<!-- START: Show Modal -->
    <form id="modal-toggle-poi-status-form">
        <input 
            type="hidden" 
            name="action"
            value="toggle_status" 
        />
        <input
            type="hidden"
            id="modal-toggle-poi-status-form-input-poi-id" 
            name="poi_id" 
        />
    </form>
<!-- END -->

<script>
	function togglePoiStatus() {
		var form_element = document.querySelector("#modal-toggle-poi-status-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_poi']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				poi_id = document.getElementById("modal-toggle-poi-status-form-input-poi-id").value;
				element_id = "poi-status-"+poi_id;
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