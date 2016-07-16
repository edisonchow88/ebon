<!-- START: Modal -->
<div class="modal fade" id="modal-edit-wikipedia" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Edit Poi Wikipedia</h4>
            </div>
        <div class="modal-body">
        	<div id="modal-edit-wikipedia-form-alert"></div>
        	<form id="modal-edit-wikipedia-form-search">
                <div class="form-group">
                    <div class="input-group">
                    	<span class="input-group-btn">
                        	<a class="btn btn-default" href="<?php echo $modal_link['wikipedia']; ?>" target="_blank"><i class="fa fa-fw fa-wikipedia-w"></i></a>
                        </span>
                        <input id="modal-edit-wikipedia-input-search-wiki" class="form-control" type="text" placeholder="Search Wikipedia (key in the title)">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" onclick="SearchWikipediaByModalEditWikipedia();">Auto Complete</button>
                        </span>
                    </div>
                </div>
            </form>
            <div id="modal-edit-wikipedia-form-demo"></div>
            <br />
            
            <form id="modal-edit-wikipedia-form">
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
                                echo 'rows="5" ';
                                echo 'id="modal-edit-wikipedia-form-input-'.$i['id'].'" ';
                                echo 'name="'.$i['name'].'" ';
                                echo 'placeholder="'.$i['placeholder'].'" ';
                                echo '>';
                                echo $i['value'];
                                echo '</textarea>';
                            }
                            else if($i['type'] == 'select') {
                            	echo '<select ';
                                echo 'class="form-control" ';
                                echo 'id="modal-edit-wikipedia-form-input-'.$i['id'].'" ';
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
                                echo 'id="modal-edit-wikipedia-form-input-'.$i['id'].'" ';
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
                                echo '<span id="modal-edit-wikipedia-form-text-'.$i['id'].'">';
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
            <form id="modal-get-wikipedia-form">
                <input 
                    type="hidden" 
                    name="action"
                    value="get" 
                />
                <input
                    type="hidden"
                    id="modal-get-wikipedia-form-input-wikipedia-id" 
                    name="wikipedia_id" 
                />
            </form>
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="editWikipedia();">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function editWikipedia() {
		var form_element = document.querySelector("#modal-edit-wikipedia-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_poi_wikipedia']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-edit-wikipedia-form-alert').innerHTML = "";
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
					document.getElementById('modal-edit-wikipedia-form-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-edit-wikipedia-form-alert').innerHTML = xmlhttp.statusText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function getWikipedia() {
		var form_element = document.querySelector("#modal-get-wikipedia-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_poi_wikipedia']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-edit-wikipedia-form-alert').innerHTML = "";
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				<?php
                    foreach($modal_input as $i) {
						if(!isset($i['section'])) { 
							echo "document.getElementById('modal-edit-wikipedia-form-input-".$i['id']."').value = json.".$i['name'].";";
							if(isset($i['json'])) {
								echo "document.getElementById('modal-edit-wikipedia-form-text-".$i['id']."').innerHTML = json.".$i['json'].";";
							}
						}
					}
				?>
				/* updateEditWikipediaDemo(); */
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-edit-wikipedia-form-alert').innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	/*
	function updateEditWikipediaDemo() {
		var name = document.getElementById('modal-edit-wikipedia-form-input-name').value;
		document.getElementById('modal-edit-wikipedia-form-demo').innerHTML = "<span style='text-transform:capitalize;'>"+name+"</span>";
	}
	
	$("#modal-edit-wikipedia-form").change(function(e) {
		updateEditWikipediaDemo();
	});
	*/
</script>

<!-- Search Wikipedia -->
	<script>
        function SearchWikipediaByModalEditWikipedia() {
			var url = '<?php echo $modal_ajax["wikipedia"]; ?>';
			var title = toTitleCase(document.getElementById('modal-edit-wikipedia-input-search-wiki').value);
			title = title.replace(/ /g,'_');
			var search_wikipedia_url = url + title;
			$.getJSON(search_wikipedia_url ,function(data) {
				$.each(data.query.pages, function(i, item) {
					document.getElementById('modal-edit-wikipedia-form-alert').innerHTML = '';
					if(typeof item.missing != 'undefined') {
						<!-- if error -->
						<!-- START: post alert -->
						var content;
						content = "<div class='alert alert-warning'>Location cannot be found via Wikipedia. You may key in the info manually.</div>";
						document.getElementById('modal-edit-wikipedia-form-alert').innerHTML = content;
						<!-- END -->
					}
					else {
						<!-- if success -->
						<!-- START: get value -->
						var str = item.extract;
						var title = item.title;
						<!-- END -->
						
						<!-- START: process value -->
						str = str.replace(/ *\([^)]*\) */g, " "); //remove any text between ()
						str = str.replace(/\n/g, '\n\n'); //add additional new line for each paragraph
						<!-- END -->
						
						<!-- START: input value -->
						document.getElementById('modal-edit-wikipedia-form-input-w-title').value = title;
						document.getElementById('modal-edit-wikipedia-form-input-w-extract').value = str;
						
						document.getElementById('modal-edit-wikipedia-form-text-w-title').innerHTML = title;
						document.getElementById('modal-edit-wikipedia-form-text-w-extract').innerHTML = str;
						<!-- END -->
						
						<!-- START: post alert -->
						var content;
						content = "<div class='alert alert-success'>Input has been autocompleted.</div>";
						document.getElementById('modal-edit-wikipedia-form-alert').innerHTML = content;
						<!-- END -->
					}
				});
			});
        }
		
		$('#modal-edit-wikipedia-input-search-wiki').on('keyup', function(e) {
            var keyCode = e.keyCode || e.which;
            if (keyCode === 13) { 
				SearchWikipediaByModalEditWikipedia();
            }
        });
		
		function toTitleCase(str) {
			return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
		}
		
		 //IMPORATNT: Disable form submit by enter key
        $('#modal-edit-wikipedia-form-search').on('keyup keypress', function(e) {
            var keyCode = e.keyCode || e.which;
            if (keyCode === 13) { 
                e.preventDefault();
                return false;
            }
        });
    </script>
<!-- END -->