<!-- START: Modal -->
<div class="modal fade" id="modal-add-wikipedia" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Add Destination Wikipedia</h4>
            </div>
        <div class="modal-body">
        	<div id="modal-add-wikipedia-form-alert"></div>
        	<form id="modal-add-wikipedia-form-search">
                <div class="form-group">
                    <div class="input-group">
                    	<span class="input-group-btn">
                        	<a class="btn btn-default" href="<?php echo $modal_link['wikipedia']; ?>" target="_blank"><i class="fa fa-fw fa-wikipedia-w"></i></a>
                        </span>
                        <input id="modal-add-wikipedia-input-search-wiki" class="form-control" type="text" placeholder="Search Wikipedia (key in the title)">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" onclick="searchWikipedia();">Auto Complete</button>
                        </span>
                    </div>
                </div>
            </form>
            <div id="modal-add-wikipedia-form-demo"></div>
            <br />
            
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
            
            <form id="modal-add-wikipedia-form">
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
                                    echo 'id="modal-add-wikipedia-form-input-'.$i['id'].'" ';
                                    echo 'name="'.$i['name'].'" ';
                                    echo 'placeholder="'.$i['placeholder'].'" ';
                                    echo '>';
                                    echo $i['value'];
                                    echo '</textarea>';
                                }
                                else if($i['type'] == 'select') {
                                    echo '<select ';
                                    echo 'class="form-control" ';
                                    echo 'id="modal-add-wikipedia-form-input-'.$i['id'].'" ';
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
                                    echo 'id="modal-add-wikipedia-form-input-'.$i['id'].'" ';
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
                                    echo '<span id="modal-add-wikipedia-form-text-'.$i['id'].'">';
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
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="addWikipedia();">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function addWikipedia() {
		var form_element = document.querySelector("#modal-add-wikipedia-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_destination_wikipedia']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-add-wikipedia-form-alert').innerHTML = "";
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
					document.getElementById('modal-add-wikipedia-form-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-add-wikipedia-form-alert').innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	/*
	function updateAddWikipediaDemo() {
		var name = document.getElementById('modal-add-wikipedia-form-input-name').value;
		document.getElementById('modal-add-wikipedia-form-demo').innerHTML = "<span style='text-transform:capitalize;'>"+name+"</span>";
	}
	
	$("#modal-add-wikipedia-form").change(function(e) {
		updateAddWikipediaDemo();
	});
	
	updateAddWikipediaDemo();
	*/
</script>

<!-- Search Wikipedia -->
	<script>
        function searchWikipedia() {
			var url = '<?php echo $modal_ajax["wikipedia"]; ?>';
			var title = toTitleCase(document.getElementById('modal-add-wikipedia-input-search-wiki').value);
			title = title.replace(/ /g,'_');
			var search_wikipedia_url = url + title;
			$.getJSON(search_wikipedia_url ,function(data) {
				$.each(data.query.pages, function(i, item) {
					document.getElementById('modal-add-wikipedia-form-alert').innerHTML = '';
					if(typeof item.missing != 'undefined') {
						<!-- if error -->
						<!-- START: post alert -->
						var content;
						content = "<div class='alert alert-warning'>Location cannot be found via Wikipedia. You may key in the info manually.</div>";
						document.getElementById('modal-add-wikipedia-form-alert').innerHTML = content;
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
						document.getElementById('modal-add-wikipedia-form-input-w-title').value = title;
						document.getElementById('modal-add-wikipedia-form-input-w-extract').value = str;
						
						document.getElementById('modal-add-wikipedia-form-text-w-title').innerHTML = title;
						document.getElementById('modal-add-wikipedia-form-text-w-extract').innerHTML = str;
						<!-- END -->
						
						<!-- START: post alert -->
						var content;
						content = "<div class='alert alert-success'>Input has been autocompleted.</div>";
						document.getElementById('modal-add-wikipedia-form-alert').innerHTML = content;
						<!-- END -->
					}
				});
			});
        }
		
		$('#modal-add-wikipedia-input-search-wiki').on('keyup', function(e) {
            var keyCode = e.keyCode || e.which;
            if (keyCode === 13) { 
				searchWikipedia();
            }
        });
		
		function toTitleCase(str) {
			return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
		}
		
		 //IMPORATNT: Disable form submit by enter key
        $('#modal-add-wikipedia-form-search').on('keyup keypress', function(e) {
            var keyCode = e.keyCode || e.which;
            if (keyCode === 13) { 
                e.preventDefault();
                return false;
            }
        });
    </script>
<!-- END -->