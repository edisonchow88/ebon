<!-- START: [modal] -->
    <div class="modal fade" id="modal-edit-user" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Edit User</h4>
                </div>
                <div class="modal-body">
                    <div id="modal-edit-user-form-alert"></div>
                    <div id="modal-edit-user-form-demo" class="text-center"></div>
                    
                    <!-- START: [form] -->
                        <?php echo $modal_component['modal-edit-user-form']; ?>
                    <!-- END -->
                    
                    <!-- START: [form] -->
                        <?php echo $modal_component['modal-get-user-form']; ?>
                    <!-- END -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-danger" onclick="editUser();">Save</button>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function editUser() {
		var form_element = document.querySelector("#modal-edit-user-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['account/ajax_user']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-edit-user-form-alert').innerHTML = "";
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
					document.getElementById('modal-edit-user-form-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-edit-user-form-alert').innerHTML = xmlhttp.statusText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function getUser() {
		var form_element = document.querySelector("#modal-get-user-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['account/ajax_user']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-edit-user-form-alert').innerHTML = "";
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				<?php
                    foreach($modal_input as $i) {
						if(!isset($i['section'])) { 
							echo "document.getElementById('modal-edit-user-form-input-".$i['id']."').value = json.".$i['name'].";";
							if(isset($i['json'])) {
								echo "document.getElementById('modal-edit-user-form-text-".$i['id']."').innerHTML = json.".$i['json'].";";
							}
						}
					}
				?>
				/* updateEditUserDemo(); */
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-edit-user-form-alert').innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	/*
	function updateEditUserDemo() {
		var name = document.getElementById('modal-edit-user-form-input-name').value;
		document.getElementById('modal-edit-user-form-demo').innerHTML = "<span style='text-transform:capitalize;'>"+name+"</span>";
	}
	
	$("#modal-edit-user-form").change(function(e) {
		updateEditUserDemo();
	});
	*/
</script>