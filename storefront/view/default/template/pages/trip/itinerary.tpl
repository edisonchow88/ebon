<style>
	#section-view-button {
		position:absolute;
		top:10px;
		right:-1px;
	}
	
	#section-view-button > .btn {
		font-size:9px;
		padding:10px;
		border:solid thin #EEE;
		border-radius:5px 0 0 5px;
	}
</style>

<div id="section-body">
	<div id="section-view-xs" class="hidden-md hidden-lg">
    	<ul>
        	<li id="section-view-xs-list-guide" class="active"><a onclick="open_section_content('guide');">Guide</a></li>
            <li id="section-view-xs-list-itinerary"><a onclick="open_section_content('itinerary');">Itinerary</a></li>
            <li id="section-view-xs-list-map"><a onclick="open_section_content('map');">Map</a></li>
        </ul>
    </div>
    <div id="section-view-md" class="box-shadow hidden-xs hidden-sm hidden-lg">
        <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-fw fa-eye"></i></span>
            <select id='section-view-md-select' class="form-control" onchange="change_section_content(this.value);">
                <option value="guide">Guide</option>
                <option value="itinerary">Itinerary</option>
                <option value="map">Map</option>
                <option disabled>──────────</option>
                <option value="guide+itinerary">Guide + Itinerary</option>
                <option value="guide+map">Guide + Map</option>
                <option value="itinerary+map">Itinerary + Map</option>
            </select>
        </div>
    </div>
	<div id="section-view" class="box-shadow hidden-xs hidden-sm hidden-md hidden-lg">
    	<ul>
        	<li><i class="fa fa-fw fa-eye"></i></li>
        	<li id="section-view-list-guide" class="active">
                <a 
                	id="section-view-guide-button" 
                	data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Close Guide' 
                    onclick="toggle_section_content('guide');"
                >
                	Guide
                </a>
            </li>
            <li id="section-view-list-itinerary" class="active">
            	<a 
                	id="section-view-itinerary-button" 
                	data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Close Itinerary' 
                    onclick="toggle_section_content('itinerary');"
                >
                	Itinerary
                </a>
            </li>
            <li id="section-view-list-map" class="active">
            	<a 
                	id="section-view-map-button" 
                	data-toggle='tooltip' 
                    data-placement='bottom' 
                    title='Close Map' 
                    onclick="toggle_section_content('map');"
                >
                	Map
                </a>
            </li>
        </ul>
    </div>
    <div id="section-content" class="box-shadow">
        <div id="section-left">
            <?php echo $content_section_guide; ?>
        </div>
        <div id="section-center">
            <?php echo $content_section_table; ?>
        </div>
        <div id="section-right">
            <?php echo $content_section_map; ?>
        </div>
    </div>
</div>
<div id="section-footer box-shadow" class="hidden-xs hidden-sm">
	<?php echo $content_section_footer; ?>
</div>

<script>
	function convert_to_title_case(str) {
		return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
	}
	

</script>

<script>
	var max_section_content_window = 3;
	var section_content_window = 3;
	var section_content_window_guide = false;
	var section_content_window_itinerary = true;
	var section_content_window_map = true;
	
	window.onresize = function(event) {
		update_section_content();
	};
	
	function open_section_content(view) {
		if(view == 'guide') {
			section_content_window_guide = true;
			section_content_window_itinerary = false;
			section_content_window_map = false;
		}
		else if(view == 'itinerary') {
			section_content_window_guide = false;
			section_content_window_itinerary = true;
			section_content_window_map = false;
		}
		else if(view == 'map') {
			section_content_window_guide = false;
			section_content_window_itinerary = false;
			section_content_window_map = true;
		}
		update_section_content();
	}
	
	function close_section_content(view) {
		if(view == 'guide') {
			section_content_window_guide = false;
		}
		else if(view == 'itinerary') {
			section_content_window_itinerary = false;
		}
		else if(view == 'map') {
			section_content_window_map = false;
		}
		update_section_content();
	}
	
	function change_section_content(view) {
		if(view == 'guide') {
			section_content_window_guide = true;
			section_content_window_itinerary = false;
			section_content_window_map = false;
		}
		else if(view == 'itinerary') {
			section_content_window_guide = false;
			section_content_window_itinerary = true;
			section_content_window_map = false;
		}
		else if(view == 'map') {
			section_content_window_guide = false;
			section_content_window_itinerary = false;
			section_content_window_map = true;
		}
		else if(view == 'guide+itinerary') {
			section_content_window_guide = true;
			section_content_window_itinerary = true;
			section_content_window_map = false;
		}
		else if(view == 'guide+map') {
			section_content_window_guide = true;
			section_content_window_itinerary = false;
			section_content_window_map = true;
		}
		else if(view == 'itinerary+map') {
			section_content_window_guide = false;
			section_content_window_itinerary = true;
			section_content_window_map = true;
		}
		update_section_content();
	}
	
	function toggle_section_content(view) {
		if(view == 'guide') {
			if(section_content_window_guide == true) {
				section_content_window_guide = false;
			}
			else {
				if(section_content_window < max_section_content_window) {
					section_content_window_guide = true;
				}
			}
		}
		else if(view == 'itinerary') {
			if(section_content_window_itinerary == true) {
				section_content_window_itinerary = false;
			}
			else {
				if(section_content_window < max_section_content_window) {
					section_content_window_itinerary = true;
				}
			}
		}
		else if(view == 'map') {
			if(section_content_window_map == true) {
				section_content_window_map = false;
			}
			else {
				if(section_content_window < max_section_content_window) {
					section_content_window_map = true;
				}
			}
		}
		update_section_content();
	}
	
	function update_section_content() {
		update_max_section_content_window();
		update_section_content_window();
		verify_max_section_content_window();
		verify_min_section_content_window();
		resize_section_content();
		
		if(section_content_window_guide == true) { 
			show_section_content('left','guide'); 
		} 
		else { 
			hide_section_content('left','guide'); 
		}
		
		if(section_content_window_itinerary == true) { 
			show_section_content('center','itinerary'); 
		} 
		else { 
			hide_section_content('center','itinerary'); 
		}
		
		if(section_content_window_map == true) { 
			show_section_content('right','map'); 
		}
		else {
			hide_section_content('right','map'); 
		}
		update_section_view_md_select();
	}
	
	function update_max_section_content_window() {
		var w = Math.max(document.documentElement.clientWidth, window.innerWidth || 0);
		if(w < 640) {
			max_section_content_window = 1;
			document.getElementById('section-content').style.width = '100%';
			
			var body_height = 'calc(100vh - 48px - 2px)';
			var height = 'calc(100vh - 48px - 2px - 30px)';
			var content_height = 'calc(100vh - 48px - 2px - 40px - 49px)';
			var itinerary_height = 'calc(100vh - 48px - 2px - 40px - 49px + 70px)';
			document.getElementById('section-body').style.height = body_height;
			document.getElementById('section-content').style.height = height;
			document.getElementById('section-left').style.height = height;
			document.getElementById('section-center').style.height = height;
			document.getElementById('section-right').style.height = height;
			document.getElementById('section-content-guide-content').style.height = content_height;
			document.getElementById('section-content-itinerary-content').style.height = itinerary_height;
			document.getElementById('section-content-map-content').style.height = content_height;
		}
		else if(w < 960) {
			max_section_content_window = 2;
			document.getElementById('section-content').style.width = '640px';
			
			var body_height = 'calc(100vh - 48px - 2px - 40px)';
			var height = 'calc(100vh - 48px - 2px - 30px - 40px)';
			var content_height = 'calc(100vh - 48px - 2px - 30px - 70px - 40px)';
			var itinerary_height = 'calc(100vh - 48px - 2px - 30px - 70px - 40px + 70px)';
			document.getElementById('section-body').style.height = body_height;
			document.getElementById('section-content').style.height = height;
			document.getElementById('section-left').style.height = height;
			document.getElementById('section-center').style.height = height;
			document.getElementById('section-right').style.height = height;
			document.getElementById('section-content-guide-content').style.height = content_height;
			document.getElementById('section-content-itinerary-content').style.height = itinerary_height;
			document.getElementById('section-content-map-content').style.height =height;
		}
		else {
			max_section_content_window = 3;
			document.getElementById('section-content').style.width = '960px';
			
			var body_height = 'calc(100vh - 48px - 2px - 40px)';
			var height = 'calc(100vh - 48px - 2px - 30px - 40px)';
			var content_height = 'calc(100vh - 48px - 2px - 30px - 49px - 40px)';
			var itinerary_height = 'calc(100vh - 48px - 2px - 30px - 40px - 50px)';
			document.getElementById('section-body').style.height = body_height;
			document.getElementById('section-content').style.height = height;
			document.getElementById('section-left').style.height = height;
			document.getElementById('section-center').style.height = height;
			document.getElementById('section-right').style.height = height;
			document.getElementById('section-content-guide-content').style.height = content_height;
			document.getElementById('section-content-itinerary-content').style.height = itinerary_height;
			document.getElementById('section-content-map-content').style.height = height;
			
			section_content_window_itinerary = true;
			section_content_window_map = true;
		}
	}
	
	function update_section_content_window() {
		section_content_window = 0;
		if(section_content_window_guide == true) { section_content_window += 1; }
		if(section_content_window_itinerary == true) { section_content_window += 1; }
		if(section_content_window_map == true) { section_content_window += 1; }
	}
	
	function verify_max_section_content_window() {
		if(section_content_window > max_section_content_window) {
			if(section_content_window_map == true) { 
				section_content_window_map = false;
				section_content_window -= 1; 
				if(section_content_window > max_section_content_window) {
					section_content_window_itinerary = false;
					section_content_window -= 1; 
				}
			}
			else if(section_content_window_itinerary == true) { 
				section_content_window_itinerary = false;
				section_content_window -= 1; 
			}
		}
	}
	
	function verify_min_section_content_window() {
		if(max_section_content_window < 3 && section_content_window == 0) {
			section_content_window_guide = true;
		}
	}
	
	function resize_section_content() {
		if(section_content_window == 0) {
			document.getElementById('section-content').style.display = 'none';
		}
		else if(section_content_window == 1) {
			var width = '100%';
			document.getElementById('section-content').style.display = 'block';
			document.getElementById('section-left').style.width = width;
			document.getElementById('section-center').style.width = width;
			document.getElementById('section-right').style.width = width;
		}
		else if(section_content_window == 2) {
			if(max_section_content_window == 2) {
				var width = '50%';
				document.getElementById('section-left').style.width = width;
				document.getElementById('section-center').style.width = width;
				document.getElementById('section-right').style.width = width;
			}
			else {
				document.getElementById('section-center').style.width = '75%';
				document.getElementById('section-right').style.width = '25%';
			}
		}
		else if(section_content_window ==3) {
			document.getElementById('section-left').style.width = '60%';
			document.getElementById('section-center').style.width = '15%';
			document.getElementById('section-right').style.width = '25%';
		}
	}
	
	function show_section_content(position,view) {
		show_section_content_window(position);
		show_section_view_button(view);
		
		var text = convert_to_title_case(view);
		update_section_view_button_tooltip(view, 'Close '+text);
	}
	
	function hide_section_content(position,view) {
		hide_section_content_window(position);
		hide_section_view_button(view);
		
		var text = convert_to_title_case(view);
		update_section_view_button_tooltip(view, 'Open '+text);
	}
	
	function show_section_content_window(position) {
		document.getElementById('section-'+position).style.display = 'block';
	}
	
	function hide_section_content_window(position) {
		document.getElementById('section-'+position).style.display = 'none';
	}
	
	function show_section_view_button(view) {
		document.getElementById('section-view-xs-list-'+view).className = 'active';
		document.getElementById('section-view-list-'+view).className = 'active';
	}
	
	function hide_section_view_button(view) {
		document.getElementById('section-view-xs-list-'+view).className = '';
		document.getElementById('section-view-list-'+view).className = '';
	}
	
	function update_section_view_button_tooltip(view,text) {
		var button = document.getElementById('section-view-'+view+'-button');
		if(typeof $('#'+button.id).attr('aria-describedby') != 'undefined') {
			var tooltip_id = $('#'+button.id).attr('aria-describedby');
			$('#'+tooltip_id).hide();
		}
		$('#'+button.id).attr('data-original-title',text);
	}
	
	function update_section_view_md_select() {
		if(section_content_window_guide == true && section_content_window_itinerary == true) {
			document.getElementById('section-view-md-select').value = 'guide+itinerary';
		}
		else if(section_content_window_guide == true && section_content_window_map == true) {
			document.getElementById('section-view-md-select').value = 'guide+map';
		}
		else if(section_content_window_itinerary == true && section_content_window_map == true) {
			document.getElementById('section-view-md-select').value = 'itinerary+map';
		}
		else if(section_content_window_guide == true) {
			document.getElementById('section-view-md-select').value = 'guide';
		}
		else if(section_content_window_itinerary == true) {
			document.getElementById('section-view-md-select').value = 'itinerary';
		}
		else if(section_content_window_map == true) {
			document.getElementById('section-view-md-select').value = 'map';
		}
	}
	
	update_section_content();
	
var testing_map= "testlo";	
</script>