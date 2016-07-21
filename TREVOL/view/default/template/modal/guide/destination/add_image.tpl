<style>
	.form-file {
		position:absolute;
		top:0;
		left:0;
		opacity:0;
		width:300px;
		height:300px;
		padding-top:130px;
		padding-left:60px;
	}
	
	.demo {
		margin:auto;
		position:relative;
		width:300px;
		height:300px;
	}
	
	.demo-image-background {
		position:absolute; 
		top:0; 
		left:0;
		background-color:#CCC; 
		outline: thin dashed #999;
		outline-offset: -10px;
		width:100%; 
		height:100%;
	}
	
	.demo-image {
		position:absolute; 
		top:0; 
		left:0;
		width:100%;
		height:100%;
	}
	
	.demo-image-button {
		position:absolute; 
		top:0; 
		left:0; 
		opacity:0; 
		width:100%; 
		height:100%; 
		background-color:#000;
		cursor:pointer;
	}
	
	.demo-image-button:hover {
		opacity:.9;
	}
</style>

<!-- START: Modal -->
<div class="modal fade" id="modal-add-image" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Add Destination Image</h4>
            </div>
        <div class="modal-body">
        	<div id="modal-add-image-form-alert"></div>
            <div id="modal-add-image-form-demo" class="text-center"></div>
            <!-- START: Nav tabs -->
            <?php
                $tab = 0;
                foreach($modal_input as $i) {
                    if(isset($i['tab'])) {
                        if($tab == 0) { 
                        	echo '<ul class="nav nav-pills" role="tablist">';
                            $tab = 1;
                        }
                        echo '<li role="presentation"';
                        if($i['tab']['active'] == true) { echo ' class="active"'; }
                        echo '>';
                        echo '<a href="#'.$i['tab']['id'].'"';
                        echo ' aria-controls="'.$i['tab']['id'].'"';
                        echo ' role="tab" data-toggle="pill">';
                        echo $i['tab']['name'];
                        echo '</a>';
                        echo '</li>';
                    }
                }
                if($tab == 1) { echo '</ul>'; }
            ?>
            <!-- END -->
            
            <form id="modal-add-image-form" method="post" enctype="multipart/form-data">
                <input 
                    type="hidden" 
                    name="action"
                    value="add" 
                />
            	<div class="tab-content">
                    <?php
                    	$tab = 0;
                        foreach($modal_input as $i) {
                            if(isset($i['tab'])) {
                            	if($tab == 1) {
                                	echo '</div>';
                                    $tab = 0;
                                }
                                if($tab == 0) {
                                    echo '<div role="tabpanel" class="tab-pane';
                                    if($i['tab']['active'] == true) { echo ' active'; }
                                    echo '"'; 
                                    echo 'id="'.$i['tab']['id'].'"';
                                    echo '>';
                                    $tab = 1;
                                }
                            }
                            else if(isset($i['section'])) {
                                echo '<section>';
                                echo $i['section'];
                                echo '</section>';
                            }
                            else {
                                if($i['type'] == 'upload_image') {
                                	echo '<div class="form-group">';
                                        echo '<div class="input-group col-xs-12">';
                                            echo '<div id="modal-add-image-form-input-'.$i['id'].'-demo" class="demo" >';
                                                echo '<div id="modal-add-image-form-input-'.$i['id'].'-demo-image-background" class="demo-image-background" >';
                                                    echo '<div style="margin:auto; padding-top:100px; text-align:center;">';
                                                        echo '<i class="fa fa-upload fa-5x"></i>';
                                                        echo '<br /><br />Select image to upload';
                                                    echo '</div>';
                                                echo '</div>';
                                                echo '<img id="modal-add-image-form-input-'.$i['id'].'-demo-image" class="demo-image" />';
                                                echo '<input ';
                                                    echo 'type="file" ';
                                                    echo 'class="form-file" ';
                                                    echo 'id="modal-add-image-form-input-'.$i['id'].'-file"';
                                                    echo 'name="'.$i['name'].'" ';
                                                echo '/>';
                                                 echo '<input ';
                                                    echo 'type="hidden" ';
                                                    echo 'id="modal-add-image-form-input-'.$i['id'].'-size"';
                                                    echo 'name="size" ';
                                                    echo 'style="display:none;"';
                                                echo '/>';
                                                echo '<div id="modal-add-image-form-input-'.$i['id'].'-demo-image-button" class="demo-image-button" ';
                                                echo 'onclick="$(\'#modal-add-image-form-input-'.$i['id'].'-file\').trigger(\'click\'); "';
                                                echo '>';
                                                    echo '<div style="margin:auto; padding-top:100px; text-align:center;">';
                                                        echo '<i class="fa fa-upload fa-5x"></i>';
                                                        echo '<br /><br />Select image to upload';
                                                    echo '</div>';
                                                echo '</div>';
                                            echo '</div>';
                                        echo '</div>';
                                    echo '</div>';
                                    echo '<div class="form-group">';
                                    	echo '<div class="input-group col-xs-12">';
                                            echo '<div class="text-center">';
                                                echo '<span id="modal-add-image-form-input-'.$i['id'].'-text-filename"></span>';
                                                echo '<span id="modal-add-image-form-input-'.$i['id'].'-text-size"></span>';
                                            echo '</div>';
                                        echo '</div>';
                                    echo '</div>';
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
                                        echo 'id="modal-add-image-form-input-'.$i['id'].'" ';
                                        echo 'name="'.$i['name'].'" ';
                                        echo 'placeholder="'.$i['placeholder'].'" ';
                                        echo '>';
                                        echo $i['value'];
                                        echo '</textarea>';
                                     }
                                     else if($i['type'] == 'search') {
                                        $search_id = "modal-add-image-form-input-".$i['id']."-suggestion";
                                        $value_id = "modal-add-image-form-input-".$i['id']."-value";
                                        $hidden_id = "modal-add-image-form-input-".$i['id']."-hidden";
                                        echo '<input ';
                                            echo 'id="'.$hidden_id.'"';
                                            echo 'type="hidden"';
                                        echo '/>';
                                        echo '<input ';
                                            echo 'id="'.$value_id.'"';
                                            echo 'name="'.$i['name'].'" ';
                                            echo 'value="'.$i['value'].'" ';
                                            echo 'type="hidden"';
                                        echo '/>';
                                        echo '<input ';
                                            echo 'class="form-control" ';
                                            echo 'id="modal-add-image-form-input-'.$i['id'].'"';
                                            echo 'type="text" ';
                                            echo 'autocomplete="on" ';
                                            echo 'placeholder="'.$i['placeholder'].'" ';
                                            echo 'onkeyup="auto_suggest(this.id, event)" ';
                                            echo 'onfocus="show_suggestion(\''.$search_id.'\')" ';
                                            echo 'onclick="auto_suggest(this.id, event)" ';
                                            echo 'onblur="setTimeout(function() { hide_suggestion(\''.$search_id.'\'); }, 100);" ';
                                        echo '/>';
                                        echo '<div style="position:relative; top:34px; width:100%;">';
                                        echo '<div id="'.$search_id.'" style="position:absolute; z-index:15000; width:100%; display:none;"';
                                        echo '</div>';
                                        echo '</div>';
                                        echo '</div>';
                                    }
                                    else if($i['type'] == 'select') {
                                        echo '<select ';
                                        echo 'class="form-control" ';
                                        echo 'id="modal-add-image-form-input-'.$i['id'].'" ';
                                        echo 'name="'.$i['name'].'" ';
                                        echo '>';
                                        echo '<option value="0" ';
                                        echo '>';
                                        if($i['value'] == $o[$i['name']]) { echo 'selected=seletected '; }
                                        echo '-- Select '.$i['label'].' --';
                                        echo '</option>';
                                        foreach($i['option'] as $o) {
                                            echo '<option ';
                                            echo 'value="'.$o[$i['name']].'"';
                                            if($i['value'] == $o[$i['name']]) { echo 'selected=seletected '; }
                                            echo '>';
                                            if(isset($o['name'])) { echo $o['name']; } else { echo $o[$i['name']]; }
                                            echo '</option>';
                                        }
                                        echo '</select>';
                                        if(isset($i['help'])) {
                                            echo '<span class="input-group-btn">';
                                            echo '<a class="btn btn-default" target="_blank" href="'.$i['link'].'" data-toggle="tooltip" data-replacement="top" title="'.$i['help'].'">';
                                            echo '<i class="fa fa-fw fa-question-circle">';
                                            echo '</i>';
                                            echo '</a>';
                                            echo '</span>';
                                        }
                                    }
                                    else {
                                        echo '<input ';
                                        echo 'type="'.$i['type'].'" ';
                                        echo 'class="form-control" ';
                                        echo 'id="modal-add-image-form-input-'.$i['id'].'" ';
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
                                        echo '<span id="modal-add-image-form-text-'.$i['id'].'">';
                                        if($i['type'] == 'hidden') {
                                            if (strpos($i['text'], 'http') !== false) {
                                                echo '<a href="'.$i['text'].'" target="_blank">Link</a>';
                                            }
                                            else {
                                                echo $i['text'];
                                            }
                                        }
                                        echo '</span>';
                                    }
                                    echo '</div>';
                                    echo '</div>';
                                }
                            }
                        }
                        if($tab == 1) { echo '</div>'; }
                    ?>
            	</div>
            </form>
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="addImage();">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function addImage() {
		var form_element = document.querySelector("#modal-add-image-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_destination_image']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-add-image-form-alert').innerHTML = "";
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
					document.getElementById('modal-add-image-form-alert').innerHTML = content;
					$('#modal-add-image').animate({ scrollTop: top }, 0);
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-add-image-form-alert').innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	/*
	function updateAddImageDemo() {
		var name = document.getElementById('modal-add-image-form-input-name').value;
		document.getElementById('modal-add-image-form-demo').innerHTML = "<span style='text-transform:capitalize;'>"+name+"</span>";
	}
	
	$("#modal-add-image-form").change(function(e) {
		updateAddImageDemo();
	});
	
	updateAddImageDemo();
	*/
</script>

<script>
	$("#modal-add-image-form-input-image-file").change(function(e) {
		var form = "modal-add-image-form";
		var input = "modal-add-image-form-input-image";
		var file = e.originalEvent.srcElement.files[0];
		var img = document.getElementById(input+'-demo-image');
		var reader = new FileReader();
        	reader.onloadend = function() {
             img.src = reader.result;
        }
        reader.readAsDataURL(file);
		
		var form_element = document.querySelector("#modal-add-image-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['resource/upload_image']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById(input+'-size').value = '';
				document.getElementById(form+'-input-name').value = '';
				document.getElementById(input+'-text-size').innerHTML = '';
				document.getElementById(input+'-text-filename').innerHTML = '';
				
				var json = JSON.parse(xmlhttp.responseText);
				document.getElementById('modal-add-image-form-alert').innerHTML = "";
				if(json.warning.length > 0) {
					var content;
					content = "<div class='alert alert-danger'>Error:<br/><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					document.getElementById('modal-add-image-form-alert').innerHTML = content;
					$('#modal-add-image').animate({ scrollTop: top }, 0);
				}
				else {
					document.getElementById(input+'-size').value = json.size;
					document.getElementById(form+'-input-name').value = toTitleCase(json.name.split('.')[0]);
					document.getElementById(input+'-text-size').innerHTML = ' ( '+formatBytes(json.size,0)+' )';
					document.getElementById(input+'-text-filename').innerHTML = json.name;
				}
			} else {
				document.getElementById('modal-add-image-form-alert').innerHTML = json.alert;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	});
	
	function formatBytes(bytes,decimals) {
	   if(bytes == 0) return '0 Byte';
	   var k = 1000; // or 1024 for binary
	   var dm = decimals + 1 || 3;
	   var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
	   var i = Math.floor(Math.log(bytes) / Math.log(k));
	   return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
	}
	
	function toTitleCase(str) {
		return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
	}
</script>