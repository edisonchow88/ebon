<!-- START: Modal -->
<div class="modal fade" id="modal-delete-poi" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Delete Poi</h4>
            </div>
        <div class="modal-body">
            <div class="alert alert-danger" role="alert">
                Are you sure you want to delete <b>Poi #<span id="modal-delete-poi-form-text-poi-id"></span></b> ?
            </div>
            <form id="modal-delete-poi-form">
            	<div id="modal-delete-poi-form-alert"></div>
                <input 
                    type="hidden" 
                    id="modal-delete-poi-form-input-poi-id" 
                    name="poi_id" 
                />
                <input 
                    type="hidden" 
                    name="action"
                    value="delete" 
                />
            </form>
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="deletePoi();">Delete</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function deletePoi() {
		var form_element = document.querySelector("#modal-delete-poi-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_poi']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-delete-poi-form-alert').innerHTML = "";
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				
				if(typeof json.warning != 'undefined') {
					<!-- if error -->
					var content;
					content = "<div class='alert alert-danger'>Error:<br/><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					document.getElementById('modal-delete-poi-form-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-delete-poi-form-alert').innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
</script>