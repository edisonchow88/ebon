<style>
	.spacer-bar {
		min-height:20px;
	}
	
	#section-content-guide {
		text-align:left;
	}
	
	#section-content-guide-header {
		padding:7px;
		border-bottom:solid thin #EEE;
	}
	
	#section-content-guide-header .input-group {
		border-radius:10px;
	}
	
	#section-content-guide-header .form-control {
		border-radius:10px;
	}
	
	#section-content-guide-header .btn-simple {
		padding-right:0;
		padding-left:0;
	}
	
	#section-content-guide-header-close {
		font-size:24px;
		line-height:14px;
	}
	
	#section-content-guide-search-form input{
		border-radius:0 !important;
	}
	
	#section-content-guide-search-form-suggestion {
		display:none;
		width:100%;
		position:absolute;
		top:35px;
		z-index:15000;
	}
	
	#section-content-guide-form {
		display:none;
	}
	
	#section-content-guide-content {
		position:relative;
		overflow-y:auto;
		overflow-x:hidden;
		height:calc(100vh - 48px - 2px - 30px - 49px - 40px);
		direction:rtl;
	}
	
	#section-content-guide-content div {
		direction:ltr;
	}
	
	#section-content-guide-image-wrapper {
		overflow:hidden;
		background-color:#333;
		height:220px;
	}
	
	#section-content-guide-image {
		margin-top:-150px;
	}
	
	#section-content-guide-button-add {
		position:absolute;
		top:118px;
		right:0;
		padding:15px;
		z-index:5;
		text-align:center;
		font-size:36px;
	}
	
	#section-content-guide-button-add a {
		display:block;
		width:52px;
		height:52px;
		border:solid thin #CCC;
		border-radius:26px;
		background-color:#FFF;
		color:#e93578;
		box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.2), 0 2px 4px 0 rgba(0, 0, 0, 0.19);
	}
	
	#section-content-guide-button-add a:hover {
		box-shadow: 0 6px 10px 0 rgba(0, 0, 0, 0.2), 0 10px 26px 0 rgba(0, 0, 0, 0.19);
	}
	
	#section-content-guide-button-add-text {
		position:absolute;
		top:194px;
		right:7px;
		width:68px;
		color:#fff;
		text-align:center;
		z-index:5;
	}
	
	#section-content-guide-button-add-text a {
		color:#fff;
		text-decoration:none;
	}
	
	#section-content-guide-top {
		position:relative;
		width:100%;
		background-color:#666;
	}
	
	#section-content-guide-title {
		position:absolute;
		bottom:0;
		left:0;
		width:100%;
		background-color:rgba(0, 0, 0, 0.5);;
		color:#FFF;
	}
	
	#section-content-guide-parent {
		padding:7px 7px 0 7px;
	}
	
	#section-content-guide-parent a {
		color:#FFF;
	}
	
	#section-content-guide-name {
		width:calc(100% - 82px);
		padding:7px;
		font-size:18px;
	}
	
	#section-content-guide-tag {
		padding:7px 7px 0 7px;
	}
	
	#section-content-guide-blurb {
		padding:7px 7px 0 7px;
		color:#333;
	}
	
	#section-content-guide-description {
		margin-top:12px;
		margin-bottom:15px;
		padding:7px 7px 0 7px;
		display:none;
		color:#333;
	}
	
	#section-content-guide-button-read {
		padding:7px 7px 0 7px;
		text-align:center;
	}
	
	#section-content-guide-result-summary {
		padding:7px;
		border-bottom:solid thin #EEE;
	}
	
	#section-content-guide-result-list {
		margin-top:15px;
		border-top:solid thin #EEE;
	}
	
	.result {
		display:block;
		width:100%;
		height:120px;
		padding-right:7px;
		border-bottom:solid thin #EEE;
		cursor:pointer;
	}
	
	.result:hover {
		background-color:#EEE;
	}
	
	.result-image-wrapper {
		position:relative;
	}
	
	.result-image {
		display:block;
		float:left;
		width:120px;
		height:120px;
	}
	
	.result-ranking {
		position:absolute;
		top:5px;
		left:5px;
		width:20px;
		height:20px;
		border-radius:3px;
		background-color:#000;
		color:#FFF;
		text-align:center;
		padding:0;
		opacity:.7;
	}
	
	.result-description {
		position:relative;
		height:120px;
		display:block;
		float:left;
		padding-top:7px;
		padding-left:7px;
		width:calc(100% - 120px - 7px - 10px - 7px);
		color:#333;
	}
	
	.result-name {
		color:#e93578;
		font-weight:bold;
		height:20px;
		overflow:hidden;
		margin-bottom:7px;
	}
	
	.result-rating {
		color:#000;
		margin-bottom:7px;
	}
	
	
	.result-blurb {
		width:100%;
		height:34px;
		overflow:hidden;
		margin-bottom:7px;
	}
	
	.line-clamp-1 {
		display: -webkit-box;
		-webkit-line-clamp: 1;
		-webkit-box-orient: vertical;  
	}
	
	.line-clamp-2 {
		display: -webkit-box;
		-webkit-line-clamp: 2;
		-webkit-box-orient: vertical;  
	}
	
	.result-tag {
		padding: 3px 0;
	}
	
	.tag {
		position:absolute;
		bottom: 15px;
	}
	
	.result-child-button-add {
		position:absolute;
		bottom:15px;
		right:0;
	}
	
	.result-child-button-add a {
		margin-left:15px;
		color:#999;
	}
	
	.result-child-button-add a:hover {
		margin-left:15px;
		color:#333;
	}
	
	.result-button {
		height:120px;
		display:block;
		float:right;
		padding-top:50px;
		text-align:center;
		font-weight:bold;
	}
</style>
<div id="section-content-guide">
    <div id="section-content-guide-header">
    	<!--
        <div class="row">
            <div class="spacer-bar hidden-xs hidden-sm col-md-12 col-lg-12"></div>
        </div>
        -->
        <div class="row">
            <div class="input-group pull-left inline col-xs-12 col-sm-12 col-md-12 col-lg-8" style="position:relative;">
            	<form id="section-content-guide-search-form">
                	<input class="form-control" type="text" name="input" placeholder='Search ...'  />
                    <input type="hidden" name="keyword" />
                    <input type="hidden" name="type_id"/>
                    <input type="hidden" name="type"/>
                    <input type="hidden" name="name"/>
                </form>
                <div id="section-content-guide-search-form-suggestion"></div>
            </div>
            <!--
            <div class="inline pull-right col-md-12 col-lg-2">
                <a 
                	class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                	onclick="close_section_content('guide');"
                    data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Close Guide' 
                >
                	<i class="fa fa-fw" id="section-content-guide-header-close">&times;</i>
                </a>
                <a 
                	class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                	onclick="open_section_content('guide');"
                    data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Expand Guide' 
                >
                	<i class="fa fa-fw fa-arrows-alt"></i>
                </a>
            </div>
            -->
        </div>
    </div>
    <div>
    	<form id="section-content-guide-form">
            <input 
                type="hidden" 
                id="section-content-guide-form-input-destination-id" 
                name="destination_id" 
                value="<?php echo $result['current']['destination_id']; ?>"
            />
            <input 
                type="hidden" 
                id="section-content-guide-form-input-poi-id" 
                name="poi_id" 
                value="<?php echo $result['current']['poi_id']; ?>"
            />
            <input 
                type="hidden" 
                name="action"
                value="view" 
            />
            <input type="hidden" name="type_id"/>
            <input type="hidden" name="type"/>
            <input type="hidden" name="name"/>
            <input type="hidden" name="lat"/>
            <input type="hidden" name="lng"/>
        </form>
    </div>
    <div id="section-content-guide-content">
        <div id="section-content-guide-top">
        	<div id="section-content-guide-button-add" onclick="addActivityFromGuide();"><a>&#43;</a></div>
        	<div id="section-content-guide-button-add-text" onclick="addActivityFromGuide();"><small><a>Add to Trip</a></small></div>
            <div id="section-content-guide-image-wrapper"><div id="section-content-guide-image"></div></div>
            <div id="section-content-guide-title">
                <div id="section-content-guide-parent"><a><small><span id="section-content-guide-parent-text"></span></small></a></div>
                <div id="section-content-guide-name"></div>
            </div>
        </div>
        <div id="section-content-guide-tag"></div>
        <div id="section-content-guide-blurb"></div>
        <div id="section-content-guide-description"></div>
        <div id="section-content-guide-button-read"><a class="btn btn-default btn-block" onclick="toggle_guide_description();"><span id="section-content-guide-button-read-text">Read More</span></a></div>
        <div id="section-content-guide-result-summary" class="hidden">Total <span id="section-content-guide-result-count"><?php echo $result['count']; ?></span> results</div>
        <div id="section-content-guide-result-list">
        </div>
        
        <!--
        <?php foreach($result['child'] as $i) { ?>
        <div class="result row">
                <div class="result-image"><?php echo $i['image']; ?></div>
                <div class="result-description">
                    <div class="result-name"><?php echo $i['name']; ?></div>
                    <small><span class="result-blurb line-clamp-2"><?php echo $i['blurb']; ?></span></small>
                    <div class="result-tag"><a class="label label-pill" data-row-name="<?php echo $i['tag']['name']; ?>" style="background-color:<?php echo $i['tag']['type_color']; ?>;"><?php echo $i['tag']['name']; ?></a></div>
                </div>
                <div class="result-button">&gt;</div>
        </div>
        <?php } ?>
        -->
    </div>
</div>

<script>
	function toggle_guide_description() {
		if(document.getElementById('section-content-guide-description').style.display == 'block') {
			document.getElementById('section-content-guide-description').style.display = 'none';
			document.getElementById('section-content-guide-button-read-text').innerHTML = 'Read More';
		}
		else {
			document.getElementById('section-content-guide-description').style.display = 'block';
			document.getElementById('section-content-guide-button-read-text').innerHTML = 'Hide Description';
		}
	}
</script>

<script>
	function refresh_guide() {
		var form_element = document.querySelector("#section-content-guide-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $ajax['trip/ajax_guide']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			document.getElementById('wrapper-alert').innerHTML = '';
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				
				if(typeof json.warning != 'undefined') {
					<!-- if error -->
					var content;
					content = "<div class='alert alert-danger'><i class='fa fa-fw fa-exclamation-triangle'></i>&nbsp;";
					content += json.warning;
					content += "</div>";
					document.getElementById('wrapper-alert').innerHTML = content;
					body.scrollTop(0);
				}
				else if(typeof json.success != 'undefined') {
					<!-- START: if success -->
						<!-- START: set form -->
							$('#section-content-guide-form input[name=name]').val(json.current.name);
							if($('#section-content-guide-form-input-destination-id').val() != '') {
								$('#section-content-guide-form input[name=type]').val('destination');
								$('#section-content-guide-form input[name=type_id]').val(json.current.destination_id);
							}
							else if($('#section-content-guide-form-input-poi-id').val() != '') {
								$('#section-content-guide-form input[name=type]').val('poi');
								$('#section-content-guide-form input[name=type_id]').val(json.current.poi_id);
							}
							$('#section-content-guide-form input[name=lat]').val(json.current.lat);
							$('#section-content-guide-form input[name=lng]').val(json.current.lng);
						<!-- END -->
						
						<!-- START: set parent -->
							if(typeof json.current.parent != 'undefined') {
								document.getElementById('section-content-guide-parent-text').innerHTML = json.current.parent.name+' >';
								$('#section-content-guide-parent').off("click"); //remove all existing click event
								$('#section-content-guide-parent').click(function() { navigate_guide_by_destination_id(json.current.parent.destination_id); });
							}
							else {
								document.getElementById('section-content-guide-parent-text').innerHTML = '&nbsp;';
							}
						<!-- END -->
						
						<!-- START: set destination -->
							if(typeof json.current.destination != 'undefined') {
								document.getElementById('section-content-guide-parent-text').innerHTML = json.current.destination.name+' >';
								$('#section-content-guide-parent').off("click"); //remove all existing click event
								$('#section-content-guide-parent').click(function() { navigate_guide_by_destination_id(json.current.destination.destination_id); });
							}
						<!-- END -->
						
						if(typeof json.current.name != 'undefined') {
							document.getElementById('section-content-guide-name').innerHTML = json.current.name;
						}
						
						if(typeof json.current.blurb != 'undefined') {
							document.getElementById('section-content-guide-blurb').innerHTML = json.current.blurb;
						}
						
						if(typeof json.current.description != 'undefined' && json.current.description != null && json.current.description != '') {
							$('#section-content-guide-description').css('display','none');
							$('#section-content-guide-button-read').css('display','block');
							$('#section-content-guide-button-read-text').html('Read More');
							var text = decodeHtml(json.current.description);
							document.getElementById('section-content-guide-description').innerHTML = text.replace(/\n/g, '<br />');
						}
						else {
							$('#section-content-guide-description').css('display','none');
							$('#section-content-guide-button-read').css('display','none');
						}
					
						<!-- START: set image -->
							document.getElementById('section-content-guide-image').innerHTML = '';
							if(typeof json.current.image != 'undefined') {
								for(i=0;i<json.current.image.length;i++) {
									var image = json.current.image[i].image;
									content = image;
									document.getElementById('section-content-guide-image').innerHTML += content; 
								}
							}
						<!-- END -->
						
						<!-- START: set tag -->
							document.getElementById('section-content-guide-tag').innerHTML = '';
							if(typeof json.current.tag != 'undefined') {
								for(i=0;i<json.current.tag.length;i++) {
									var name = json.current.tag[i].name;
									var color = json.current.tag[i].type_color;
									content = '<a class="label label-pill" data-row-name="'+name+'" style="background-color:'+color+'; margin-right:5px;">'+name+'</a>';
									document.getElementById('section-content-guide-tag').innerHTML += content; 
								}
							}
						<!-- END -->
						
						<!-- START: reset result -->
							var count = 0;
							document.getElementById('section-content-guide-result-count').innerHTML = count;
							document.getElementById('section-content-guide-result-list').innerHTML = '';
						<!-- END -->
						
						<!-- START: set result of destination child -->
							if(typeof json.child != 'undefined') {
								count = parseFloat(count) + parseFloat(json.count.destination);
								document.getElementById('section-content-guide-result-count').innerHTML = count;
								for(i=0;i<json.count.destination;i++) {
									var ranking = i+1;
									content = '';
									content += '<div class="result row" ';
									content += 'onclick="navigate_guide_by_destination_id('+json.child[i].destination_id+')"';
									content += '>';
										content += '<div class="result-image-wrapper">';
											content += '<div class="result-image">';
												content += json.child[i].image;
											content += '</div>';
											content += '<div class="result-ranking">';
												content += ranking;
											content += '</div>';
										content += '</div>';
										content += '<div class="result-description">';
											content += '<div class="result-name line-clamp-1">';
												content += json.child[i].name;
											content += '</div>';
											content += '<small><div class="result-blurb line-clamp-2">';
												content += json.child[i].blurb;
											content += '</div></small>';
											content += '<div class="tag">';
												if(typeof json.child[i].tag != 'undefined') {
													for(t=0;t<Math.min(json.child[i].tag.length,3);t++) {
														var name = json.child[i].tag[t].name;
														var color = json.child[i].tag[t].type_color;
														content += '<a class="label label-pill" data-row-name="'+name+'" style="background-color:'+color+'; margin-right:5px;">'+name+'</a>';
													}
												}
											content += '</div>';
											content += '<div class="result-child-button-add hidden-xs pull-right">';
												content += '<a class="small">Add to Itinerary</a>';
												content += '<a class="small">Read More</a>';
											content += '</div>';
										content += '</div>';
										content += '<div class="result-button">';
											content += '&gt;';
										content += '</div>';
									content += '</div>';
									document.getElementById('section-content-guide-result-list').innerHTML += content; 
								}
							}
						<!-- END -->
						
						<!-- START: set result of poi child -->
							if(typeof json.poi != 'undefined') {
								count = parseFloat(count) + parseFloat(json.count.poi);
								document.getElementById('section-content-guide-result-count').innerHTML = count;
								for(i=0;i<json.count.poi;i++) {
									content = '';
									content += '<div class="result row" ';
									content += 'onclick="navigate_guide_by_poi_id('+json.poi[i].poi_id+')"';
									content += '>';
										content += '<div class="result-image">';
											content += json.poi[i].image;
										content += '</div>';
										content += '<div class="result-description">';
											content += '<div class="result-name line-clamp-1">';
												content += json.poi[i].name;
											content += '</div>';
											content += '<div class="result-rating"><i class="fa fa-fw fa-star"></i><i class="fa fa-fw fa-star-o"></i></div>';
											content += '<small><div class="result-blurb line-clamp-2">';
												content += json.poi[i].blurb;
											content += '</div></small>';
											content += '<div class="tag">';
												if(typeof json.poi[i].tag != 'undefined') {
													for(t=0;t<Math.min(json.poi[i].tag.length,3);t++) {
														var name = json.poi[i].tag[t].name;
														var color = json.poi[i].tag[t].type_color;
														content += '<a class="label label-pill" data-row-name="'+name+'" style="background-color:'+color+'; margin-right:5px;">'+name+'</a>';
													}
												}
											content += '</div>';
										content += '</div>';
										content += '<div class="result-button">';
											content += '&gt;';
										content += '</div>';
									content += '</div>';
									document.getElementById('section-content-guide-result-list').innerHTML += content; 
								}
							}
						<!-- END -->
					<!-- END -->
				}
				
				return;
			} 
			else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function navigate_guide(type, type_id) {
		if(type == 'destination') {
			document.getElementById('section-content-guide-form-input-destination-id').value = type_id;
			document.getElementById('section-content-guide-form-input-poi-id').value = '';
			window.location.hash = '#destination_id-'+type_id;
			<!-- START: reset search -->
				$('#section-content-guide-search-form').trigger('reset');
			<!-- END -->
		}
		else if(type == 'poi') {
			document.getElementById('section-content-guide-form-input-destination-id').value = '';
			document.getElementById('section-content-guide-form-input-poi-id').value = type_id;
			window.location.hash = '#poi_id-'+type_id;
			<!-- START: reset search -->
				$('#section-content-guide-search-form').trigger('reset');
			<!-- END -->
		}
	}
	
	function navigate_guide_by_destination_id(destination_id) {
		document.getElementById('section-content-guide-form-input-destination-id').value = destination_id;
		document.getElementById('section-content-guide-form-input-poi-id').value = '';
		window.location.hash = '#destination_id-'+destination_id;
		<!-- START: reset search -->
			$('#section-content-guide-search-form').trigger('reset');
		<!-- END -->
	}
	
	function navigate_guide_by_poi_id(poi_id) {
		document.getElementById('section-content-guide-form-input-destination-id').value = '';
		document.getElementById('section-content-guide-form-input-poi-id').value = poi_id;
		window.location.hash = '#poi_id-'+poi_id;
		<!-- START: reset search -->
			$('#section-content-guide-search-form').trigger('reset');
		<!-- END -->
	}
	
	function reset_guide() {
		var hash = location.hash;
		if(hash.indexOf('destination_id') > 0) {
			hash = hash.replace('#destination_id-','');
			document.getElementById('section-content-guide-form-input-destination-id').value = hash;
			document.getElementById('section-content-guide-form-input-poi-id').value = '';
		}
		else if(hash.indexOf('poi_id') > 0) {
			hash = hash.replace('#poi_id-','');
			document.getElementById('section-content-guide-form-input-destination-id').value = '';
			document.getElementById('section-content-guide-form-input-poi-id').value = hash;
		}
		else {
			window.location.hash = '#destination_id-1';
		}
	}
	
	window.onhashchange = function() {
		reset_guide();
		refresh_guide();
	}
	
	reset_guide();
	refresh_guide();
</script>

<script>
	//[NO LONGER IN USAGE BUT CAN BE USEFUL IN FUTURE]
	<!-- START: verify if need to refresh page -->
		function getParameterByName(name, url) {
			if (!url) url = window.location.href;
			name = name.replace(/[\[\]]/g, "\\$&");
			var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
				results = regex.exec(url);
			if (!results) return null;
			if (!results[2]) return '';
			return decodeURIComponent(results[2].replace(/\+/g, " "));
		}
		
		function updateUrlParameter(uri, key, value) {
			// remove the hash part before operating on the uri
			var i = uri.indexOf('#');
			var hash = i === -1 ? ''  : uri.substr(i);
				 uri = i === -1 ? uri : uri.substr(0, i);
		
			var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
			var separator = uri.indexOf('?') !== -1 ? "&" : "?";
			if (uri.match(re)) {
				uri = uri.replace(re, '$1' + key + "=" + value + '$2');
			} else {
				uri = uri + separator + key + "=" + value;
			}
			return uri + hash;  // finally append the hash as well
		}
	<!-- END -->
</script>

<!-- START: search -->
	<script>
        function update_section_content_guide_search_input_event() {
			var form = 'section-content-guide-search-form';
			var input = {
				suggestion	: form + '-suggestion',
				input		: form + ' input[name=input]',
				hidden		: form + ' input[name=name]',
				type		: form + ' input[name=type]',
				type_id		: form + ' input[name=type_id]'
			};
            
            $('#'+input.input).off();
            $('#'+input.input).on('click',function() {
				auto_suggest_section_content_guide_search(form, input, event);
            });
            $('#'+input.input).on('keyup',function() {
                auto_suggest_section_content_guide_search(form, input, event);
            });
            $('#'+input.input).on('focus',function() {
                show_suggestion_section_content_guide_search(input.suggestion);
            });
            $('#'+input.input).on('blur',function() {
                setTimeout(function() { hide_suggestion_section_content_guide_search(input.suggestion); }, 100);
            });
        }
        
        function auto_suggest_section_content_guide_search(form, input, e) {
			
            var keyword = $('#'+input.input).val();
			$('#'+form+' input[name=keyword]').val(keyword);
            
            show_suggestion_section_content_guide_search(input.suggestion);
			
            var key_code;
        
            if(window.event) { // IE                    
                key_code = e.keyCode;
            } else if(e.which){ // Netscape/Firefox/Opera                   
                key_code = e.which;
            }
            
            if(key_code == 40) { //if press down arrow
                if(document.getElementById(input.suggestion).innerHTML == '') { 
                    search_all_section_content_guide_search(input, keyword);
                    show_suggestion_section_content_guide_search(input.suggestion); 
                }
                select_next_suggestion_section_content_guide_search();
                return;
            }
            else if(key_code == 38) { //if press up arrow
                if(document.getElementById(input.suggestion).innerHTML == '') { 
                    search_all_section_content_guide_search(input, keyword);
                    show_suggestion_section_content_guide_search(input.suggestion); 
                }
                select_previous_suggestion_section_content_guide_search();
                return;
            }
            else if(key_code == 13) { //if press enter
                hide_suggestion_section_content_guide_search(input.suggestion);
				$('#'+input.hidden).val(this.suggestion[this.selected_suggestion].name);
				
				
				<!-- START: navigate guide -->
					if(this.suggestion[this.selected_suggestion].type == 'destination') {
						navigate_guide_by_destination_id(this.suggestion[this.selected_suggestion].type_id);
					}
					else if(this.suggestion[this.selected_suggestion].type == 'poi') {
						navigate_guide_by_poi_id(this.suggestion[this.selected_suggestion].type_id);
					}
				<!-- END -->
				
                return;
            }
            else if(key_code == 37 || key_code == 39) { //if press left or right arrow
            }
            else if(key_code != '' && key_code != 'undefined' && key_code != null) {
				$('#'+input.type).val('');
				$('#'+input.type_id).val('');
            }
			
			$('#'+input.hidden).val($('#'+input.input).val());
            search_all_section_content_guide_search(input, keyword);
        }
        
        
        function search_all_section_content_guide_search(input, keyword) {
			var suggestion_id = input.suggestion;
            <!-- START: set data -->
                var data = { action:'search',keyword:keyword }
            <!-- END -->
            <!-- START: send POST -->
                $.post("<?php echo $ajax['trip/ajax_guide']; ?>", data, function(result) {
                    auto_list_section_content_guide_search(suggestion_id, keyword, result);
                }, "json");
            <!-- END -->
        }
        
        function auto_list_section_content_guide_search(suggestion_id, keyword, result) {
			if(typeof result != 'undefined' && result != null) {
				var output = '';
				output += "<ul class='list-group' style='margin-top:-1px;'>";
				for(i = 0; i < result.length; i++) {
					output += "<a id='suggestion-"+i+"' class='suggestion btn list-group-item' style='border-top-right-radius:0; border-top-left-radius:0;' onclick='select_suggestion_section_content_guide_search(\""+result[i].type_id+"\", \""+result[i].type+"\", \""+result[i].name+"\")')'>";
						output += "<div class='text-left' style='width:100%;'>";
							output += "<div class='text-left text-success' style='display:inline-block; width:50px;'>";
							if(result[i].type == 'destination') {
								output += "<i class='fa fa-map-marker fa-fw fa-2x'></i>";
							}
							else if(result[i].type == 'poi') {
								output += "<i class='fa fa-camera-retro fa-fw fa-2x'></i>";
							}
							output += "</div>";
							output += "<div style='display:inline-block;'>";
								output += "<span class='text-left' style='display:block;'><b>";
									output += highlight_keyword_with_any_cases(result[i].name, keyword);
								output += "</b></span>";
								if(typeof result[i].parent != 'undefined') {
									output += "<span class='text-left small' style='display:block;'>";
										output += result[i].parent.name;
									output += "</span>";
								}
							output += "</div>";
						output += "</div>";
					output += "</a>";
				}
				output += "</ul>";
				this.suggestion = result;
				this.selected_suggestion = -1;
				$('#'+suggestion_id).html(output);
			}
			else {
				$('#'+suggestion_id).html('');
			}
        }
		
        function reset_suggestion_section_content_guide_search() {
            for(i=0;i<this.suggestion.length;i++) {
				$('#suggestion-'+i).css('background-color','');
            }
        }
        
        function select_next_suggestion_section_content_guide_search() {
            reset_suggestion_section_content_guide_search();
            
            if(this.selected_suggestion < this.suggestion.length) {
                this.selected_suggestion += 1;
            }
            else {
                this.selected_suggestion = 0;
            }
            
            highlight_suggestion_section_content_guide_search();
        }
        
        function select_previous_suggestion_section_content_guide_search() {
            reset_suggestion_section_content_guide_search();
            
            if(this.selected_suggestion > 0) {
                this.selected_suggestion -= 1;
            }
            else {
                this.selected_suggestion = this.suggestion.length;
            }
            
            highlight_suggestion_section_content_guide_search();
        }
        
        function highlight_suggestion_section_content_guide_search() {
			var form = 'section-content-guide-search-form';
			var input = {
				suggestion	: form + '-suggestion',
				input		: form + ' input[name=input]',
				hidden		: form + ' input[name=name]',
				type		: form + ' input[name=type]',
				type_id		: form + ' input[name=type_id]'
			};
            
            if(this.selected_suggestion != this.suggestion.length) {
                var suggestion_id = 'suggestion-'+this.selected_suggestion;
				$('#'+suggestion_id).css('background-color','#EEEEEE');
				$('#'+input.input).val(this.suggestion[this.selected_suggestion].name);
				$('#'+input.type).val(this.suggestion[this.selected_suggestion].type);
				$('#'+input.type_id).val(this.suggestion[this.selected_suggestion].type_id);
            }
            else {
				$('#'+input.input).val($('#'+input.hidden).val());
				$('#'+input.type).val('');
				$('#'+input.type_id).val('');
            }
        }
        
        function select_suggestion_section_content_guide_search(type_id, type, name) {
			var form = 'section-content-guide-search-form';
			var input = {
				suggestion	: form + '-suggestion',
				input		: form + ' input[name=input]',
				hidden		: form + ' input[name=name]',
				type		: form + ' input[name=type]',
				type_id		: form + ' input[name=type_id]'
			};
			$('#'+input.input).val(name);
			$('#'+input.hidden).val(name);
			$('#'+input.type).val(type);
			$('#'+input.type_id).val(type_id);
			
			<!-- START: navigate guide -->
				if(type == 'destination') {
					navigate_guide_by_destination_id(type_id);
				}
				else if(type == 'poi') {
					navigate_guide_by_poi_id(type_id);
				}
			<!-- END -->
        }
        
        function show_suggestion_section_content_guide_search(suggestion_id) {
			$('#'+suggestion_id).show();
        }
        
        function hide_suggestion_section_content_guide_search(suggestion_id) {
            $('#'+suggestion_id).hide();
			$('#'+suggestion_id).html('');
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
		
		$('#section-content-guide-search-form').on('keyup keypress', function(e) {
			var keyCode = e.keyCode || e.which;
			if (keyCode === 13) { 
				e.preventDefault();
				return false;
			}
		});
		
		function decodeHtml(html) {
			var txt = document.createElement("textarea");
			txt.innerHTML = html;
			return txt.value;
		}
		
		update_section_content_guide_search_input_event();
    </script>
<!-- END -->