<div>
    <!-- <form id="search_form"> Replaced THIS with normal form without id tO disable the press "Enter" submit function -->
    <form>
        <div class="form-group">
            <div class="input-group" style="width:100%;">
                <input  type="hidden" name="filter_category_id" id="filter_category_id" value="0"/>
                <input class="form-control atext" type="text" id="filter_keyword" name="filter_keyword" autocomplete="on" placeholder="<?php echo $text_keyword; ?>" value="<?php echo $text_filter_keyword; ?>" href="#" onkeyup="auto_search()" onfocus="show_suggestion()" onblur="setTimeout(function() { hide_suggestion(); }, 100);" />
                <!--
                <span class="input-group-btn"><a class="btn btn-info" onclick="$(this).closest('form').submit();" >Go</a></span>
                
                <span class="input-group-btn"><a class="btn" href="<?php echo $anchor_itinerary; ?>" title="itinerary"><i class="fa fa-file-text"></i></a></span>
                <span class="input-group-btn"><a class="btn" href="<?php echo $anchor_map; ?>" title="map"><i class="fa fa-map"></i></a></span>
                <span class="input-group-btn"><a class="btn" href="<?php echo $anchor_destination; ?>" title="destination"><i class="fa fa-map-marker"></i></a></span>
                <span class="input-group-btn"><a class="btn" href="<?php echo $anchor_activity; ?>" title="activity"><i class="fa fa-camera"></i></a></span>
                -->
            </div>
        </div>
    </form>
</div>
<div style="position:relative; top:-25px; width:100%;">
	<div id="search_suggestion" style="position:absolute; z-index:500; width:100%; display:none;">
	</div>
</div>

<script>
	/* DETECT KEYDOWN FUNCTION, DISABLED by TREVOL 2016/03/29
	$(function () {
		$(document).on('keyup', function (event) {
			if (event.keyCode == 40) {
				alert('foo');
			}
		});
	});
	*/
	
	function show_suggestion() {
		document.getElementById("search_suggestion").style.display = "block";
	}
	
	function hide_suggestion() {
		document.getElementById("search_suggestion").style.display = "none";
	}
	
	function auto_search() {
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $ajax_url; ?>";
		var data = "&keyword=" + document.getElementById("filter_keyword").value;
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				auto_listing(xmlhttp.responseText);
				document.getElementById("input_conn").value = 'Done';
			}
		};
		xmlhttp.open("GET", query, true);
		xmlhttp.send();
		document.getElementById("input_conn").value = 'Connecting';
		document.getElementById("input_action").value = 'auto_search';
	}
	
	
	function auto_listing(responseText) {
		var result = JSON.parse(responseText);
		var output = '';
		output += "<ul class='list-group'>";
		for(i = 0; i < result.category.length; i++) {
			output += "<a class='btn list-group-item' tabindex='-1' href='"+result.category[i].link+"'>";
			output += "<div class='text-left' style='width:100%;'>";
					output += "<div class='text-left text-primary' style='display:inline-block; width:50px;'><i class='fa fa-map-marker fa-fw fa-2x'></i></div>";
					output += "<div style='display:inline-block;'>";
						output += "<span class='text-left' style='display:block;'><b>";
							output += highlight_keyword_with_any_cases(result.category[i].name, document.getElementById("filter_keyword").value);
						output += "</b></span>";
						output += "<span class='text-left small' style='display:block;'>";
							output += result.category[i].parent;
						output += "</span>";
					output += "</div>";
				output += "</div>";
			output += "</a>";
		}
		for(i = 0; i < result.product.length; i++) {
			output += "<a class='btn list-group-item' href='"+result.product[i].link+"'>";
				output += "<div class='text-left' style='width:100%;'>";
					output += "<div class='text-left text-primary' style='display:inline-block; width:50px;'><i class='fa fa-camera fa-fw fa-2x'></i></div>";
					output += "<div style='display:inline-block;'>";
						output += "<span class='text-left' style='display:block;'><b>";
							output += highlight_keyword_with_any_cases(result.product[i].name, document.getElementById("filter_keyword").value);
						output += "</b></span>";
						output += "<span class='text-left small' style='display:block;'>";
							output += result.product[i].parent;
						output += "</span>";
					output += "</div>";
				output += "</div>";
			output += "</a>";
		}
		output += "</ul>";
		document.getElementById("search_suggestion").innerHTML = output;
		
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