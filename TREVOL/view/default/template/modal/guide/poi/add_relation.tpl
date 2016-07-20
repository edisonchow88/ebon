<!-- START: Modal -->
<div class="modal fade" id="modal-add-relation" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Add Poi Relation</h4>
            </div>
        <div class="modal-body">
        	<div id="modal-add-relation-form-alert"></div>
            <div id="modal-add-relation-form-demo" class="text-center"></div>
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
            
            <form id="modal-add-relation-form">
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
                                    echo 'id="modal-add-relation-form-input-'.$i['id'].'" ';
                                    echo 'name="'.$i['name'].'" ';
                                    echo 'placeholder="'.$i['placeholder'].'" ';
                                    echo '>';
                                    echo $i['value'];
                                    echo '</textarea>';
                                }
                                else if($i['type'] == 'search') {
                                	$search_id = "modal-add-relation-form-input-".$i['id']."-suggestion";
                                	echo '<input ';
                                    echo 'class="form-control" ';
                                    echo 'id="modal-add-relation-form-input-'.$i['id'].'" ';
                                    echo 'name="'.$i['name'].'" ';
                                    echo 'type="text" ';
                                    echo 'autocomplete="on" ';
                                    echo 'placeholder="'.$i['placeholder'].'" ';
                                    echo 'valuer="'.$i['value'].'" ';
                                    echo 'onkeyup="auto_suggest(this.id, event)" ';
                                    echo 'onfocus="show_suggestion(\''.$search_id.'\')" ';
                                    echo 'onclick="show_suggestion(\''.$search_id.'\')" ';
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
                                    echo 'id="modal-add-relation-form-input-'.$i['id'].'" ';
                                    echo 'name="'.$i['name'].'" ';
                                    echo '>';
                                    foreach($i['option'] as $o) {
                                        echo '<option ';
                                        echo 'value="'.$o[$i['name']].'"';
                                        if($i['value'] == $o[$i['name']]) { echo 'selected=seletected '; }
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
                                    echo 'id="modal-add-relation-form-input-'.$i['id'].'" ';
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
                                    echo '<span id="modal-add-relation-form-text-'.$i['id'].'">';
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
                        if($tab == 1) { echo '</div>'; }
                    ?>
            	</div>
            </form>
            <form id="modal-search-poi-form">
                <input 
                    type="hidden" 
                    name="action"
                    value="search_poi" 
                />
                <input
                    type="hidden"
                    id="modal-search-poi-form-input-keyword" 
                    name="keyword" 
                />
            </form>
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="addRelation();">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function addRelation() {
		var form_element = document.querySelector("#modal-add-relation-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_poi_relation']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-add-relation-form-alert').innerHTML = "";
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
					document.getElementById('modal-add-relation-form-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-add-relation-form-alert').innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	/*
	function updateAddRelationDemo() {
		var name = document.getElementById('modal-add-relation-form-input-name').value;
		document.getElementById('modal-add-relation-form-demo').innerHTML = "<span style='text-transform:capitalize;'>"+name+"</span>";
	}
	
	$("#modal-add-relation-form").change(function(e) {
		updateAddRelationDemo();
	});
	
	updateAddRelationDemo();
	*/
	
</script>

<script>
	function search_poi(input_id, suggestion_id, keyword) {
		var form_element = document.querySelector("#modal-search-poi-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_poi_relation']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				auto_list(input_id, suggestion_id, keyword, xmlhttp.responseText);
			} else {
				<!-- if connection failed -->
				/* alert(xmlhttp.responseText); */
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function auto_list(input_id, suggestion_id, keyword, response) {
		var result = JSON.parse(response);
		var output = '';
		output += "<ul class='list-group'>";
		for(i = 0; i < result.length; i++) {
			output += "<a id='suggestion-"+i+"' tabindex='"+i+"' class='suggestion btn list-group-item' onkeyup='detect_key(\""+input_id+"\", \""+suggestion_id+"\", \""+result[i].name+"\", event)' onclick='select_suggestion(\""+input_id+"\", \""+suggestion_id+"\", \""+result[i].name+"\")'>";
				output += "<div class='text-left' style='width:100%;'>";
					output += "<div class='text-left text-primary' style='display:inline-block; width:50px;'><i class='fa fa-camera-retro fa-fw fa-2x'></i></div>";
					output += "<div style='display:inline-block;'>";
						output += "<span class='text-left' style='display:block;'><b>";
							output += highlight_keyword_with_any_cases(result[i].name, keyword);
						output += "</b></span>";
						output += "<span class='text-left small' style='display:block;'>";
							output += result[i].name;
						output += "</span>";
					output += "</div>";
				output += "</div>";
			output += "</a>";
		}
		output += "</ul>";
		document.getElementById(suggestion_id).innerHTML = output;
	}
	
	function auto_suggest(input_id, e) {
		
		var suggestion_id = input_id + "-suggestion";
		var keyword = document.getElementById(input_id).value;
		
		if(keyword.length < 1) {
			hide_suggestion(suggestion_id);
		}
		else {
			show_suggestion(suggestion_id);
		}
		
		var key_code;
	
		if(window.event) { // IE                    
			key_code = e.keyCode;
		} else if(e.which){ // Netscape/Firefox/Opera                   
			key_code = e.which;
		}
		
		if(key_code == 40) { //if press down arrow
			select_next_suggestion();
			return;
		}
		else if(key_code == 38) { //if press up arrow
			select_previous_suggestion();
			return;
		}
		
		
		document.getElementById('modal-search-poi-form-input-keyword').value = keyword;
		
		search_poi(input_id, suggestion_id, keyword);
	}
	
	function detect_key(input_id, suggestion_id, name, e) {
		var key_code;
	
		if(window.event) { // IE                    
			key_code = e.keyCode;
		} else if(e.which){ // Netscape/Firefox/Opera                   
			key_code = e.which;
		}
		
		if(key_code == 40) { //if press down arrow
			select_next_suggestion();
			return;
		}
		else if(key_code == 38) { //if press up arrow
			select_previous_suggestion();
			return;
		}
		else if(key_code == 13) { //if press enter
			select_suggestion(input_id, suggestion_id, name);
			return;
		}
	}
	
	function select_next_suggestion() {
		var num_suggestion = $('.suggestion').length;
		var n = num_suggestion - 1;
		var selected_id = document.activeElement.id;
		var selected_i = parseInt(selected_id.substring(11));
		if(document.activeElement.className === 'suggestion btn list-group-item') {
			if(selected_i < n) {
				selected_i += 1;
				var new_active_id = 'suggestion-'+selected_i;
				document.getElementById(new_active_id).focus();
			}
			else {
				document.getElementById('suggestion-0').focus();
			}
		}
		else {
			if(num_suggestion > 0) {
				document.getElementById('suggestion-0').focus();
			}
		}
	}
	
	function select_previous_suggestion() {
		var num_suggestion = $('.suggestion').length;
		var n = num_suggestion - 1;
		var selected_id = document.activeElement.id;
		var selected_i = parseInt(selected_id.substring(11));
		if(document.activeElement.className === 'suggestion btn list-group-item') {
			if(selected_i > 0 ) {
				selected_i -= 1;
				var new_active_id = 'suggestion-'+selected_i;
				document.getElementById(new_active_id).focus();
			}
			else {
				document.getElementById('suggestion-'+n).focus();
			}
		}
		else {
			if(num_suggestion > 0) {
				document.getElementById('suggestion-'+n).focus();
			}
		}
	}
	
	function select_suggestion(input_id, suggestion_id, name) {
		document.getElementById(input_id).value = name;
		document.getElementById(input_id).focus();
		document.getElementById(suggestion_id).style.display = "none";
		
		var keyword = document.getElementById(input_id).value;
		document.getElementById('modal-search-poi-form-input-keyword').value = keyword;
		search_poi(input_id, suggestion_id, keyword);
	}
	
	function show_suggestion(suggestion_id) {
		document.getElementById(suggestion_id).style.display = "block";
	}
	
	function hide_suggestion(suggestion_id) {
		if(document.activeElement.className === 'suggestion btn list-group-item') { return; }
		document.getElementById(suggestion_id).style.display = "none";
	}
	
	RegExp.escape = function(str) 
	{
	  var specials = /[.*+?|()\[\]{}\\$^]/g; // .*+?|()[]{}\$^
	  return str.replace(specials, "\\$&");
	}
	
	function highlight_keyword_with_any_cases(text, keyword)
	{
	  var regex = new RegExp("(" + RegExp.escape(keyword) + ")", "gi");
	  return text.replace(regex, "<span style='background-color:yellow;'>$1</span>");
	}
</script>