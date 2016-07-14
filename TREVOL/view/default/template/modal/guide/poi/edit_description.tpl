<!-- START: Modal -->
<div class="modal fade" id="modal-edit-description" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Edit Poi Description</h4>
            </div>
        <div class="modal-body">
        	<div id="modal-edit-description-form-alert"></div>
            <div id="modal-edit-description-form-demo" class="text-center"></div>
            <form id="modal-edit-description-form">
                <input 
                    type="hidden" 
                    name="action"
                    value="edit" 
                />
                <?php
                    foreach($modal_input as $i) {
                    	if(isset($i['section'])) {
                        	echo '<section>';
                            echo $i['section'];
                            echo '</section>';
                        }
                        else {
                            echo '<div class="form-group">';
                            echo '<label class="control-label col-sm-3 col-xs-10">';
                            echo $i['label'];
                            echo '</label>';
                            echo '<div class="control-label col-sm-1 col-xs-2 text-right">';
                            if($i['required'] == true) {
                                echo '<i class="fa fa-asterisk fa-fw text-warning" data-toggle="tooltip" data-replacement="right" title="Required"></i>';
                            }
                            echo '</div>';
                            echo '<div class="input-group col-sm-8 col-xs-12">';
                            if($i['type'] == 'textarea') {
                                echo '<textarea ';
                                echo 'class="form-control" ';
                                if(isset($i['row'])) { $r = $i['row']; } else { $r = 5; }
                                echo 'rows="'.$r.'" ';
                                echo 'id="modal-edit-description-form-input-'.$i['id'].'" ';
                                echo 'name="'.$i['name'].'" ';
                                echo 'placeholder="'.$i['placeholder'].'" ';
                                echo '>';
                                echo $i['value'];
                                echo '</textarea>';
                            }
                            else if($i['type'] == 'select') {
                            	echo '<select ';
                                echo 'class="form-control" ';
                                echo 'id="modal-edit-description-form-input-'.$i['id'].'" ';
                                echo 'name="'.$i['name'].'" ';
                                echo '>';
                                foreach($i['option'] as $o) {
                                	echo '<option ';
                                    echo 'value="'.$o[$i['name']].'"';
                                    echo '>';
                                    if(isset($o['name'])) { echo $o['name']; } else { echo $o[$i['name']]; }
                                    echo '</option>';
                                }
                                echo '</select>';
                            }
                            else {
                                echo '<input ';
                                echo 'type="'.$i['type'].'" ';
                                echo 'class="form-control" ';
                                echo 'id="modal-edit-description-form-input-'.$i['id'].'" ';
                                echo 'name="'.$i['name'].'" ';
                                echo 'value="'.$i['value'].'" ';
                                echo 'placeholder="'.$i['placeholder'].'" ';
                                echo '/>';
                                if(isset($i['help'])) {
                                    echo '<span class="input-group-btn">';
                                    echo '<a class="btn btn-default" target="_blank" href="'.$i['link'].'" data-toggle="tooltip" data-replacement="top" title="'.$i['help'].'">';
                                    echo '<i class="fa fa-fw fa-question-circle">';
                                    echo '</i>';
                                    echo '</a>';
                                    echo '</span>';
                                }
                                echo '<span id="modal-edit-description-form-text-'.$i['id'].'">';
                                if($i['type'] == 'hidden') {
                                    echo $i['text'];
                                }
                                echo '</span>';
                            }
                            echo '</div>';
                            echo '</div>';
                        }
                    }
                ?>
            </form>
            <form id="modal-get-description-form">
                <input 
                    type="hidden" 
                    name="action"
                    value="get" 
                />
                <input
                    type="hidden"
                    id="modal-get-description-form-input-description-id" 
                    name="description_id" 
                />
            </form>
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="editDescription();">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function editDescription() {
		var form_element = document.querySelector("#modal-edit-description-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_poi_description']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-edit-description-form-alert').innerHTML = "";
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
					document.getElementById('modal-edit-description-form-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-edit-description-form-alert').innerHTML = xmlhttp.statusText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function getDescription() {
		var form_element = document.querySelector("#modal-get-description-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_poi_description']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-edit-description-form-alert').innerHTML = "";
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				<?php
                    foreach($modal_input as $i) {
						if(!isset($i['section'])) { 
							echo "document.getElementById('modal-edit-description-form-input-".$i['id']."').value = json.".$i['name'].";";
							if(isset($i['json'])) {
								echo "document.getElementById('modal-edit-description-form-text-".$i['id']."').innerHTML = json.".$i['json'].";";
							}
						}
					}
				?>
				/* updateEditDescriptionDemo(); */
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-edit-description-form-alert').innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	/*
	function updateEditDescriptionDemo() {
		var name = document.getElementById('modal-edit-description-form-input-name').value;
		document.getElementById('modal-edit-description-form-demo').innerHTML = "<span style='text-transform:capitalize;'>"+name+"</span>";
	}
	
	$("#modal-edit-description-form").change(function(e) {
		updateEditDescriptionDemo();
	});
	*/
</script>