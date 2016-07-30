<!-- START: Modal -->
<div class="modal fade" id="modal-add-google" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Add Destination Google</h4>
            </div>
        <div class="modal-body">
        	<div id="modal-add-google-form-alert"></div>
        	<form id="modal-add-google-form-search">
            	<div class="form-group">
                    <div class="input-group">
                        <input id="modal-add-google-input-search-google" class="form-control" type="text" placeholder="Search Google">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button">Auto Complete</button>
                        </span>
                    </div>
                </div>
            </form>
            <br />
            <div id="modal-add-google-form-demo" class="row" style="margin:0 !important;">
            	<div id="modal-add-google-form-demo-map" class="col-xs-8" style="height:150px;"></div>
            	<div id="modal-add-google-form-demo-photo" class="col-xs-4 text-right nopadding"></div>
            </div>
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
            
            <form id="modal-add-google-form">
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
                                    echo 'id="modal-add-google-form-input-'.$i['id'].'" ';
                                    echo 'name="'.$i['name'].'" ';
                                    echo 'placeholder="'.$i['placeholder'].'" ';
                                    echo '>';
                                    echo $i['value'];
                                    echo '</textarea>';
                                }
                                else if($i['type'] == 'select') {
                                    echo '<select ';
                                    echo 'class="form-control" ';
                                    echo 'id="modal-add-google-form-input-'.$i['id'].'" ';
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
                                    echo 'id="modal-add-google-form-input-'.$i['id'].'" ';
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
                                    echo '<span id="modal-add-google-form-text-'.$i['id'].'">';
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
                <button type="button" class="btn btn-danger" onclick="addGoogle();">Save</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	function addGoogle() {
		var form_element = document.querySelector("#modal-add-google-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax['guide/ajax_destination_google']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('modal-add-google-form-alert').innerHTML = "";
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
					document.getElementById('modal-add-google-form-alert').innerHTML = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
			} else {
				<!-- if connection failed -->
				document.getElementById('modal-add-google-form-alert').innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	/*
	function updateAddGoogleDemo() {
		var name = document.getElementById('modal-add-google-form-input-name').value;
		document.getElementById('modal-add-google-form-demo').innerHTML = "<span style='text-transform:capitalize;'>"+name+"</span>";
	}
	
	$("#modal-add-google-form").change(function(e) {
		updateAddGoogleDemo();
	});
	
	updateAddGoogleDemo();
	*/
</script>

<!-- START: Google Places API -->
	<style>
    .pac-container { 
        z-index: 10000 !important; 
    }
    </style>
    
    <script>
		function initPlaceFinder() {
			var map = new google.maps.Map(document.getElementById('modal-add-google-form-demo-map'), {
				zoom: 0,
				mapTypeId: google.maps.MapTypeId.ROADMAP
			});
			
			// Create the search box and link it to the UI element.
			var input = document.getElementById('modal-add-google-input-search-google');
			var searchBox = new google.maps.places.SearchBox(input);
			
			// Bias the SearchBox results towards current map's viewport.
			map.addListener('bounds_changed', function() {
				searchBox.setBounds(map.getBounds());
			});
			
			<!-- START: [IMPORTANT] Render Google Map else it will not appear in Bootstrap Modal -->
			$('#modal-add-google').on('shown.bs.modal', function () {
				google.maps.event.trigger(map, 'resize');
				map.setCenter(new google.maps.LatLng(5, 100));
			});
			<!-- END -->
			
			var markers = [];
			// Listen for the event fired when the user selects a prediction and retrieve
			// more details for that place.
			searchBox.addListener('places_changed', function() {
				document.getElementById('modal-add-google-form-alert').innerHTML = "";
				
				var places = searchBox.getPlaces();
				
				if (places.length == 0) {
					var content;
                    content = "<div class='alert alert-warning'>Location cannot be found via Google. You may key in the info manually.</div>";
                    document.getElementById('modal-add-google-form-alert').innerHTML = content;
                    return;
				}
				else if(places.length > 1) {
					var content;
                    content = "<div class='alert alert-warning'>There is more than one result in Google. Please be specific.</div>";
                    document.getElementById('modal-add-google-form-alert').innerHTML = content;
                    return;
				}
				
				// Clear out the old markers.
				markers.forEach(function(marker) {
					marker.setMap(null);
				});
				markers = [];
				
				// For each place, get the icon, name and location.
				var bounds = new google.maps.LatLngBounds();
				places.forEach(function(place) {
					if (!place.geometry) {
						var content;
						content = "<div class='alert alert-warning'>Location cannot be found via Google. You may key in the info manually.</div>";
						document.getElementById('modal-add-google-form-alert').innerHTML = content;
						return;
					}
					
					var icon = {
						url: place.icon,
						size: new google.maps.Size(71, 71),
						origin: new google.maps.Point(0, 0),
						anchor: new google.maps.Point(17, 34),
						scaledSize: new google.maps.Size(25, 25)
					};
					
					// Create a marker for each place.
					markers.push(new google.maps.Marker({
						map: map,
						icon: icon,
						title: place.name,
						position: place.geometry.location
					}));
					
					autocompleteAddDestinationForm(place);
					
					if (place.geometry.viewport) {
						// Only geocodes have viewport.
						bounds.union(place.geometry.viewport);
					} else {
						bounds.extend(place.geometry.location);
					}
				});
				map.fitBounds(bounds);
			});
		}
        
        function autocompleteAddDestinationForm(place) {
			<!-- START: reset form -->
			document.getElementById('modal-add-google-form').reset();
			<!-- END -->
			
			<!-- START: filter empty string -->
			var place_id = place.place_id;
			var name = place.name;
			if (typeof place.url != 'undefined') { var url = place.url; } else { var url = ''; }
			if (typeof place.address_components != 'undefined') { var address_component  = place.address_components; } else { var address_component  = ''; }
			if (typeof place.formatted_address != 'undefined') { var address  = place.formatted_address; } else { var address  = ''; }
			var lat = place.geometry.location.lat().toFixed(7);
            var lng = place.geometry.location.lng().toFixed(7);
			if (typeof place.types != 'undefined') { var type = place.types; } else { var type = ''; }
			if (typeof place.types != 'undefined') { var type = place.types; } else { var type = ''; }
			if (typeof place.website != 'undefined') { var website = place.website; } else { var website = ''; }
			if (typeof place.vicinity != 'undefined') { var vicinity = place.vicinity; } else { var vicinity = ''; }
			if (typeof place.international_phone_number != 'undefined') { var phone = place.international_phone_number; } else { var phone = ''; }
			if (typeof place.opening_hours != 'undefined') { var hour = place.opening_hours; } else { var hour = ''; }
			if (typeof place.photos != 'undefined') {
				var photo = new Array();
				for(i=0;i<place.photos.length;i++) {
					photo[i] = place.photos[i];
					photo[i].url = place.photos[i].getUrl({'maxWidth': 300, 'maxHeight': 300});
				}
			}
			else {
				var photo = '';
			}
			if (typeof place.rating != 'undefined') { var rating = place.rating; } else { var rating = ''; }
			if (typeof place.reviews != 'undefined') { var review = place.reviews; } else { var review = ''; }
			if (typeof place.utc_offset != 'undefined') { var utc_offset = place.utc_offset; } else { var utc_offset = ''; }
			if (typeof place.permenantly_closed != 'undefined') { var bankrupt = place.permenantly_closed; } else { var bankrupt = ''; }
			<!-- END -->
			
			<!-- START: fill the form -->
            document.getElementById('modal-add-google-form-input-g-place-id').value = place_id;
			document.getElementById('modal-add-google-form-input-g-name').value = name;
            document.getElementById('modal-add-google-form-input-g-website').value = website;
            document.getElementById('modal-add-google-form-input-g-vicinity').value = vicinity;
			document.getElementById('modal-add-google-form-input-g-url').value = url;
			document.getElementById('modal-add-google-form-input-g-type').value = JSON.stringify(type);
			document.getElementById('modal-add-google-form-input-g-address-component').value = JSON.stringify(address_component);
			document.getElementById('modal-add-google-form-input-g-address').value = address;
			document.getElementById('modal-add-google-form-input-g-phone').value = phone;
            document.getElementById('modal-add-google-form-input-g-lat').value = lat;
            document.getElementById('modal-add-google-form-input-g-lng').value = lng;
			document.getElementById('modal-add-google-form-input-g-hour').value = JSON.stringify(hour);
			document.getElementById('modal-add-google-form-input-g-photo').value = JSON.stringify(photo);
			document.getElementById('modal-add-google-form-input-g-rating').value = rating;
			document.getElementById('modal-add-google-form-input-g-review').value = JSON.stringify(review);
			document.getElementById('modal-add-google-form-input-g-utc-offset').value = utc_offset;
			document.getElementById('modal-add-google-form-input-g-bankrupt').value = bankrupt;
            
            document.getElementById('modal-add-google-form-text-g-place-id').innerHTML = place_id;
			document.getElementById('modal-add-google-form-text-g-name').innerHTML = name;
            document.getElementById('modal-add-google-form-text-g-website').innerHTML = website;
            document.getElementById('modal-add-google-form-text-g-vicinity').innerHTML = vicinity;
			if(url != '') { document.getElementById('modal-add-google-form-text-g-url').innerHTML = '<a href="'+url+'" target="_blank">Link</a>'; }
			var display_type = JSON.stringify(type).replace(/\,/g,', ').replace(/\[/g,'').replace(/\]/g,'').replace(/\"/g,'');
			document.getElementById('modal-add-google-form-text-g-type').innerHTML = display_type;
			document.getElementById('modal-add-google-form-text-g-address-component').innerHTML = address_component;
			document.getElementById('modal-add-google-form-text-g-address').innerHTML = address;
			document.getElementById('modal-add-google-form-text-g-phone').innerHTML = phone;
            document.getElementById('modal-add-google-form-text-g-lat').innerHTML = lat;
            document.getElementById('modal-add-google-form-text-g-lng').innerHTML = lng;
			document.getElementById('modal-add-google-form-text-g-hour').innerHTML = hour;
			document.getElementById('modal-add-google-form-text-g-photo').innerHTML = photo;
			document.getElementById('modal-add-google-form-text-g-rating').innerHTML = rating;
			document.getElementById('modal-add-google-form-text-g-review').innerHTML = review;
			document.getElementById('modal-add-google-form-text-g-utc-offset').innerHTML = utc_offset;
			document.getElementById('modal-add-google-form-text-g-bankrupt').innerHTML = bankrupt;
			<!-- END -->
			
			<!-- START: Demo Photo -->
			if (typeof place.photos != 'undefined') { document.getElementById('modal-add-google-form-demo-photo').innerHTML = "<img src='"+photo[0].url+"' width='150' height='150'>"; }
			<!-- END -->
        }
        
        //IMPORATNT: Disable form submit by enter key
        $('#modal-add-google-form-search').on('keyup keypress', function(e) {
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