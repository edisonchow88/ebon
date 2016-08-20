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
	
	#section-content-guide-form {
		display:none;
	}
	
	#section-content-guide-content {
		position:relative;
		overflow-y:auto;
		overflow-x:hidden;
		height:calc(100vh - 48px - 2px - 30px - 70px - 40px);
	}
	
	#section-content-guide-image {
		overflow:hidden;
		max-height:160px;
	}
	
	#section-content-guide-button-add {
		position:absolute;
		top:118px;
		right:0;
		padding:15px;
		z-index:10;
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
		top:193px;
		right:7px;
		width:68px;
		color:#fff;
		text-align:center;
	}
	
	#section-content-guide-button-add-text a {
		color:#fff;
		text-decoration:none;
	}
	
	#section-content-guide-title {
		background-color:#e93578;
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
	}
	
	#section-content-guide-description {
		padding:7px 7px 0 7px;
		display:none;
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
		height:100px;
		padding-right:7px;
		border-bottom:solid thin #EEE;
		cursor:pointer;
	}
	
	.result:hover {
		background-color:#EEE;
	}
	
	.result-image {
		display:block;
		float:left;
		width:100px;
	}
	
	.result-description {
		display:block;
		float:left;
		padding-top:7px;
		padding-left:7px;
		width:calc(100% - 100px - 7px - 10px - 7px);
	}
	
	.result-name {
		color:#333;
		height:20px;
		overflow:hidden;
	}
	
	.result-blurb {
		width:100%;
		height:34px;
		overflow:hidden;
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
	
	.result-button {
		display:block;
		float:right;
		padding:30px 7px;
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
            <div class="input-group pull-left inline col-xs-12 col-sm-12 col-md-12 col-lg-10">
                <input class="form-control" type="text" placeholder='Search ...'  />
            </div>
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
                <!--
                <a 
                	class="btn btn-simple hidden-xs hidden-sm hidden-md pull-right" 
                	onclick="open_section_content('guide');"
                    data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Expand Guide' 
                >
                	<i class="fa fa-fw fa-arrows-alt"></i>
                </a>
                -->
            </div>
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
        </form>
    </div>
    <div id="section-content-guide-content">
    	<div id="section-content-guide-button-add"><a>&#43;</a></div>
        <div id="section-content-guide-button-add-text"><small><a>Add to Trip</a></small></div>
        <div id="section-content-guide-image"></div>
        <div id="section-content-guide-title">
            <div id="section-content-guide-parent"><a><small><span id="section-content-guide-parent-text"></span></small></a></div>
            <div id="section-content-guide-name"></div>
        </div>
        <div id="section-content-guide-tag"></div>
        <div id="section-content-guide-blurb"></div>
        <div id="section-content-guide-description" class="hidden"></div>
        <div id="section-content-guide-button-read" class="hidden"><a class="btn btn-default btn-block" onclick="toggle_guide_description();"><span id="section-content-guide-button-read-text">Read More</span></a></div>
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
						
						if(typeof json.current.description != 'undefined') {
							document.getElementById('section-content-guide-description').innerHTML = json.current.description;
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
						
						<!-- START: set result -->
							if(typeof json.child != 'undefined') {
								count = parseFloat(count) + parseFloat(json.count.destination);
								document.getElementById('section-content-guide-result-count').innerHTML = count;
								for(i=0;i<json.count.destination;i++) {
									content = '';
									content += '<div class="result row" ';
									content += 'onclick="navigate_guide_by_destination_id('+json.child[i].destination_id+')"';
									content += '>';
										content += '<div class="result-image">';
											content += json.child[i].image;
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
										content += '</div>';
										content += '<div class="result-button">';
											content += '&gt;';
										content += '</div>';
									content += '</div>';
									document.getElementById('section-content-guide-result-list').innerHTML += content; 
								}
							}
						<!-- END -->
						
						<!-- START: set result -->
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
	
	function navigate_guide_by_destination_id(destination_id) {
		document.getElementById('section-content-guide-form-input-destination-id').value = destination_id;
		document.getElementById('section-content-guide-form-input-poi-id').value = '';
		window.location.hash = '#destination_id-'+destination_id;
	}
	
	function navigate_guide_by_poi_id(poi_id) {
		document.getElementById('section-content-guide-form-input-destination-id').value = '';
		document.getElementById('section-content-guide-form-input-poi-id').value = poi_id;
		window.location.hash = '#poi_id-'+poi_id;
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