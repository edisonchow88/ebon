<!-- START: Modal -->
<div class="modal fade" id="modal-add-database" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Add Database</h4>
            </div>
        <div class="modal-body">
        	<div id="modal-form-add-database-alert"></div>
            <form id="modal-form-add-database">
                <input 
                    type="hidden" 
                    name="action"
                    value="add" 
                />
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
                            id="modal-form-add-database-name" 
                            name="name" 
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
                            id="modal-form-add-database-sort-order" 
                            name="sort_order" 
                            value="0" 
                        />
                    </div>
                </div>
            </form>
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="addDatabase();">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function addDatabase() {
		var form_element = document.querySelector("#modal-form-add-database");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['database/ajax_database']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-form-add-database-alert').innerHTML = "";
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
					document.getElementById('modal-form-add-database-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-form-add-database-alert').innerHTML = json.alert;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
</script>