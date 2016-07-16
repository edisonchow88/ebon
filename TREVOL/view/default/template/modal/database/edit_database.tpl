<!-- START: Modal -->
<div class="modal fade" id="modal-edit-database" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Edit Database</h4>
            </div>
        <div class="modal-body">
        	<div id="modal-form-edit-database-alert"></div>
            <form id="modal-form-edit-database">
                <input 
                    type="hidden" 
                    name="action"
                    value="edit" 
                />
                <div class="form-group">
                    <label class="control-label col-sm-3 col-xs-12">
                        Id
                    </label>
                    <div class="control-label col-sm-1 col-xs-2">
                    </div>
                    <div class="input-group col-sm-8 col-xs-10">
                        <input
                            type="hidden"
                            class="form-control"
                            id="modal-form-edit-database-input-database-id" 
                            name="database_id" 
                        />
                        <span id="modal-form-edit-database-text-database-id"></span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3 col-xs-12">
                        Name
                    </label>
                    <div class="control-label col-sm-1 col-xs-2">
                    	<i class="fa fa-asterisk fa-fw text-warning" data-toggle="tooltip" data-replacement="right" title="Required"></i>
                    </div>
                    <div class="input-group col-sm-8 col-xs-10">
                        <input
                            type="text"
                            class="form-control"
                            id="modal-form-edit-database-input-name" 
                            name="name" 
                        />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3 col-xs-12">
                        Folder
                    </label>
                    <div class="control-label col-sm-1 col-xs-2">
                    </div>
                    <div class="input-group col-sm-8 col-xs-10">
                        <input
                            type="text"
                            class="form-control"
                            id="modal-form-edit-database-input-folder" 
                            name="folder" 
                        />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3 col-xs-12">
                        Filename
                    </label>
                    <div class="control-label col-sm-1 col-xs-2">
                    </div>
                    <div class="input-group col-sm-8 col-xs-10">
                        <input
                            type="text"
                            class="form-control"
                            id="modal-form-edit-database-input-filename" 
                            name="filename" 
                        />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3 col-xs-12">
                        Sort
                    </label>
                    <div class="control-label col-sm-1 col-xs-2">
                    </div>
                    <div class="input-group col-sm-8 col-xs-10">
                        <input
                            type="text"
                            class="form-control"
                            id="modal-form-edit-database-input-sort-order" 
                            name="sort_order" 
                            value="0" 
                        />
                    </div>
                </div>
            </form>
            <form id="modal-form-get-database">
                <input 
                    type="hidden" 
                    name="action"
                    value="get" 
                />
                <input
                    type="hidden"
                    id="modal-form-get-database-input-database-id" 
                    name="database_id" 
                />
            </form>
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="editDatabase();">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function editDatabase() {
		var form_element = document.querySelector("#modal-form-edit-database");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['database/ajax_database']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-form-edit-database-alert').innerHTML = "";
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
					document.getElementById('modal-form-edit-database-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-form-edit-database-alert').innerHTML = json.alert;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function getDatabase() {
		var form_element = document.querySelector("#modal-form-get-database");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['database/ajax_database']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-form-edit-database-alert').innerHTML = "";
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				document.getElementById("modal-form-edit-database-text-database-id").innerHTML = json.database_id;
				document.getElementById("modal-form-edit-database-input-database-id").value = json.database_id;
				document.getElementById("modal-form-edit-database-input-name").value = json.name;
				document.getElementById("modal-form-edit-database-input-folder").value = json.folder;
				document.getElementById("modal-form-edit-database-input-filename").value = json.filename;
				document.getElementById("modal-form-edit-database-input-sort-order").value = json.sort_order;
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-form-edit-database-alert').innerHTML = json.alert;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
</script>