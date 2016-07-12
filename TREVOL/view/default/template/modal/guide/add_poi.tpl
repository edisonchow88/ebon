<!-- START: Modal -->
<div class="modal fade" id="modal-add-poi" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Add Poi</h4>
            </div>
        <div class="modal-body">
        	<div id="modal-add-poi-form-alert"></div>
            <div id="modal-add-poi-form-demo" class="text-center"></div>
        	<form id="modal-add-poi-form-search">
            	<div class="form-group">
                    <div class="input-group">
                        <input id="modal-add-poi-input-search-google" class="form-control" type="text" placeholder="Search Google">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button">Auto Complete</button>
                        </span>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                    	<span class="input-group-btn">
                        	<a class="btn btn-default" href="<?php echo $modal_link['wikipedia']; ?>" target="_blank"><i class="fa fa-fw fa-wikipedia-w"></i></a>
                        </span>
                        <input id="modal-add-poi-input-search-wiki" class="form-control" type="text" placeholder="( Paste wikipedia link here and press Auto Complete)">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button" onclick="searchWikipedia();">Auto Complete</button>
                        </span>
                    </div>
                </div>
                <div id="result"></div>
            </form>
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
            
            <form id="modal-add-poi-form">
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
                                    echo 'id="modal-add-poi-form-input-'.$i['id'].'" ';
                                    echo 'name="'.$i['name'].'" ';
                                    echo 'placeholder="'.$i['placeholder'].'" ';
                                    echo '>';
                                    echo $i['value'];
                                    echo '</textarea>';
                                }
                                else if($i['type'] == 'select') {
                                    echo '<select ';
                                    echo 'class="form-control" ';
                                    echo 'id="modal-add-poi-form-input-'.$i['id'].'" ';
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
                                    echo 'id="modal-add-poi-form-input-'.$i['id'].'" ';
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
                                    echo '<span id="modal-add-poi-form-text-'.$i['id'].'">';
                                    if($i['type'] == 'hidden') {
                                        echo $i['text'];
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
                <button type="button" class="btn btn-danger" onclick="addPoi();">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function addPoi() {
		var form_element = document.querySelector("#modal-add-poi-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_poi']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-add-poi-form-alert').innerHTML = "";
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
					document.getElementById('modal-add-poi-form-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-add-poi-form-alert').innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function updateAddPoiDemo() {
		var name = document.getElementById('modal-add-poi-form-input-name').value;
		document.getElementById('modal-add-poi-form-demo').innerHTML = "<span style='text-transform:capitalize;'>"+name+"</span>";
	}
	
	$("#modal-add-poi-form").change(function(e) {
		updateAddPoiDemo();
	});
	
	updateAddPoiDemo();
</script>

<!-- Search Wikipedia -->
	<script>
        function searchWikipedia() {
			var url = '<?php echo $modal_ajax["wikipedia"]; ?>';
			var title = document.getElementById('modal-add-poi-input-search-wiki').value.replace(/ /g,'_');
			var search_wikipedia_url = url + title;
			$.getJSON(search_wikipedia_url ,function(data) {
				$.each(data.query.pages, function(i, item) {
					document.getElementById('modal-add-poi-form-alert').innerHTML = '';
					if(typeof item.missing != 'undefined') {
						<!-- if error -->
						var content;
						content = "<div class='alert alert-warning'>Location cannot be found via Wikipedia. You may key in the info manually.</div>";
						document.getElementById('modal-add-poi-form-alert').innerHTML = content;
					}
					else {
						var content;
						content = "<div class='alert alert-success'>Input has been autocompleted.</div>";
						document.getElementById('modal-add-poi-form-alert').innerHTML = content;
						var str = item.extract;
						str = str.replace(/ *\([^)]*\) */g, " "); //remove any text between ()
						str = str.replace(/\n/g, '\n\n'); //add additional new line for each paragraph
						document.getElementById('modal-add-poi-form-input-blurb').value = str.split('\.')[0] + '.';
						document.getElementById('modal-add-poi-form-input-description').value = str;
					}
		
				});
			});
        }
		
		$('#modal-add-poi-input-search-wiki').on('keyup', function(e) {
            var keyCode = e.keyCode || e.which;
            if (keyCode === 13) { 
				searchWikipedia();
            }
        });
    </script>
<!-- END -->

<!-- START: Google Places API -->
	<style>
    .pac-container { 
        z-index: 10000 !important; 
    }
    </style>
    
    <script>
        function initPlaceFinder() {
        
            var input = document.getElementById('modal-add-poi-input-search-google');
            
            var autocomplete = new google.maps.places.Autocomplete(input);
            
            autocomplete.addListener('place_changed', function() {
                document.getElementById('modal-add-poi-form-alert').innerHTML = "";
                
                var place = autocomplete.getPlace();
                if (!place.geometry) {
					var content;
                    content = "<div class='alert alert-warning'>Location cannot be found via Google. You may key in the info manually.</div>";
                    document.getElementById('modal-add-poi-form-alert').innerHTML = content;
                    return;
                }
                
                autocompleteAddPoiForm(place);
            });
        }
        
        function autocompleteAddPoiForm(place) {
			<!-- START: wikipedia autocomplete -->
			var title = place.name.replace(/ /g,'_');
			document.getElementById('modal-add-poi-input-search-wiki').value = title;
			searchWikipedia();
			<!-- END -->
			
            var lat = place.geometry.location.lat().toFixed(7);
            var lng = place.geometry.location.lng().toFixed(7);
            if (typeof place.website != 'undefined') { var website = place.website; } else { var website = ''; }
            if (typeof place.opening_hours != 'undefined') { var hour = place.opening_hours; } else { var hour = ''; }
            
            document.getElementById('modal-add-poi-form-input-name').value = place.name;
            document.getElementById('modal-add-poi-form-input-lat').value = lat;
            document.getElementById('modal-add-poi-form-input-lng').value = lng;
            
            document.getElementById('modal-add-poi-form-input-g-place-id').value = place.place_id;
            document.getElementById('modal-add-poi-form-input-g-lat').value = lat;
            document.getElementById('modal-add-poi-form-input-g-lng').value = lng;
            document.getElementById('modal-add-poi-form-input-g-website').value = website;
            
            document.getElementById('modal-add-poi-form-text-g-place-id').innerHTML = place.place_id;
            document.getElementById('modal-add-poi-form-text-g-lat').innerHTML = lat;
            document.getElementById('modal-add-poi-form-text-g-lng').innerHTML = lng;
            document.getElementById('modal-add-poi-form-text-g-website').innerHTML = website;
        }
        
        //IMPORATNT: Disable form submit by enter key
        $('#modal-add-poi-form-search').on('keyup keypress', function(e) {
            var keyCode = e.keyCode || e.which;
            if (keyCode === 13) { 
                e.preventDefault();
                return false;
            }
        });
    </script>
    
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initPlaceFinder" async defer>
    </script>
<!-- END -->