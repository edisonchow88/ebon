<style>
	#modal-member-view input:disabled {
		color:#000;
	}
	
	.modal-transport-custom-info{
		font-size:1em;
		font-weight:bold;
	}
	
	.modal-transport-custom-list .transport-custom {
		height: 80px;
		border-bottom:thin solid #999;		
	}
	
	.short-text {
		width: 50px;
		text-align:right;
		border:0;
		border-bottom:thin solid #DDD;	
	}
	
	.med-text {
		width: 200px;
		text-align:right;
	}
	
	.small-unit {
		font-size: 1em;	
	}
	
	.input-row {
		height: 50px;
		border-bottom:thin solid #DDD;	
		padding: 15px;
	}
	
	.border-bottom {
		border:0;
		border-bottom:thin solid #DDD;	
	}
	
	.no-border {
		border:0;
	}
	
	.modal-body {
		padding: 0;	
		
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-transport-custom" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-account-login-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-transport-custom">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Custom Transport
                        </div>
                    </div>
                    <div class="col-xs-3 text-right">
                    	<a class="btn btn-header" onclick="savePathCustom()">Save</a>  <!---->
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body">
                    	<!-- modal info here -->
                       	<div class="modal-transport-custom-info">
                            <div  class="input-row row">
                            	<span class="col-xs-3">Origin </span>
                                <span class="col-xs-9 origin"></span>
                            </div>
                            <div  class="input-row row">
                            	<span class="col-xs-3">Destination </span>
                                <span class="col-xs-9 destination"></span>
                            </div>
                            <div  class="input-row row">
                            	<span class="col-xs-3">Link </span>
                                <span class="col-xs-9 link"><a target="_blank">Google Direction</a></span>
                            </div>
                        </div>

                        <div class="modal-transport-custom-add">
                            <form id="modal-transport-custom-form">
                                <div class="input-row row custom-input-distance">
                                   	<div class="col-xs-11">
                                        <span class="col-xs-3">Distance </span>
                                        <input type="number" class="short-text" min="0" name="custom-input-distance-km" value=""/>
                                        <span class="small-unit">km</span>
                                        <input type="number" class="short-text" min="0" name="custom-input-distance-m" value=""/>
                                        <span class="small-unit">m</span>                                       
                                    </div>                         	 	
                                </div>
                                <div class="input-row row  custom-input-duration">
                                    <div class="col-xs-11"> 
                                        <span class="col-xs-3">Duration </span>
                                       <!--  
                                        <input type="text" class="med-text" name="raw-custom-duration" value=""/>
                                         
                                        
                                        <input type="number" class="short-text" max="60" min="0" name="custom-input-duration-day" value=""/>
                                        <span class="small-unit">days</span>--> 
                                        <input type="number" class="short-text" max="60" min="0" name="custom-input-duration-hour" value=""/>
                                        <span class="small-unit">hrs</span>
                                        <input type="number" class="short-text" max="60" min="0" name="custom-input-duration-minute" value=""/>
                                        <span class="small-unit">mins</span>
                                    </div>    
                                </div>
     							<div class="hidden-form">
                                	<input type="hidden" name="custom-path-id" value="" />
                                    <input type="hidden" name="custom-line-id" value="" />
                                    <input type="hidden" name="custom-path-custom-id" value="" />
                                    <input type="hidden" name="custom-saved-distance" value="" />
                                    <input type="hidden" name="custom-saved-duration" value="" />
                               	</div>
                            </form>
                         <!--   <a class="btn btn-primary box-shadow " onclick="savePathCustom()">Save</a>
                            <a class="btn btn-primary box-shadow " onclick="$('.modal-transport-custom-add').hide();
">Cancel</a>
                         modal custom transport list -->
                        		
                        </div>              
     	        	</div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>

	function setOriginDestination(origin, destination,g_link) {
		var origin_title = $("#plan-line-"+origin).find('.plan-line-form-hidden input[name=title]').val();
		var destination_title = $("#plan-line-"+destination).find('.plan-line-form-hidden input[name=title]').val();
		$(".modal-transport-custom-info .origin").html(origin_title);
		$(".modal-transport-custom-info .destination").html(destination_title);	
		$(".modal-transport-custom-info .destination").html(destination_title);	
		$(".modal-transport-custom-info .link a").attr("href",g_link);	
		initCustomTransportList(origin);
	}

	function initCustomTransportList(line_id) {
		
		var path_id = $("#plan-line-"+line_id+" .mode-option-display .path-id").html();	
		
		$( "input[name='custom-path-id']").val(path_id);	
		$( "input[name='custom-line-id']").val(line_id);	
		
		var data = {
			"action":"get_path_custom",
			"path_id": path_id
		};
		<!-- END -->

		<!-- START: send POST -->
		$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
			//alert (JSON.stringify(json));
			if (json) {
				// if have print to the input
				$( "input[name='custom-path-custom-id']").val(json.path_custom_id);
				$( "input[name='custom-saved-duration']").val(json.duration);
				$( "input[name='custom-saved-distance']").val(json.distance);
				
				var return_value = convertValueToUnit(json.distance, json.duration);
				var d_data = return_value[2];
				if (d_data.distance_km) $( "input[name='custom-input-distance-km']").val(d_data.distance_km);
				if (d_data.distance_m) $( "input[name='custom-input-distance-m']").val(d_data.distance_m);
				if (d_data.duration_day) $( "input[name='custom-input-duration-day']").val(d_data.duration_day);
				if (d_data.duration_hour) $( "input[name='custom-input-duration-hour']").val(d_data.duration_hour);
				if (d_data.duration_minute) $( "input[name='custom-input-duration-minute']").val(d_data.duration_minute);	
			}
		}, "json");
	}
	
	function savePathCustom() {
		
		var input_value = convertInputToValue();
		
			var input_distance = input_value[0]; //change to m
			var input_duration = input_value[1]; //change to sec
		
			var path_id = $( "input[name='custom-path-id']").val();
			var path_custom_id = $( "input[name='custom-path-custom-id']").val();
			
			if (path_custom_id) {
				//edit 
				editPathCustom(path_custom_id,path_id,input_distance,input_duration);
			}else {
				if (!input_distance && !input_duration) {	
					showHint('Please Input Data.');	
				}else {
					addPathCustom(path_id,input_distance,input_duration);	
				}
			}
	}
	
	function editPathCustom(path_custom_id,path_id,input_distance,input_duration) {
		var saved_duration = $( "input[name='custom-saved-duration']").val();
		var saved_distance = $( "input[name='custom-saved-distance']").val();
		
		if (input_distance == saved_distance && input_duration == saved_duration) {
			//showHint('No changes were made.');
			$("#modal-transport-custom").modal('hide');
		}else {
			var data = {
				"action":"edit_path_custom",
				"distance": input_distance,
				"duration": input_duration,
				"path_id": path_id,
				"path_custom_id": path_custom_id
			};
			
			<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				//alert (JSON.stringify(json));
				if (json.success) {
					showHint('Custom Path Saved.');	
					$("#modal-transport-custom").modal('hide');
					refreshLineTransportModeMain();				
				}else {
					showHint(json.warning);	
				}
			}, "json");		
	
		}
	}
	
	function addPathCustom(path_id,input_distance,input_duration) {				
		var data = {
			"action":"add_path_custom",
			"distance": input_distance,
			"duration": input_duration,
			"path_id": path_id
		};
	
		<!-- START: send POST -->
		$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
			if (json.success) {
				showHint('Custom Path Added.');
				$("#modal-transport-custom").modal('hide');
				refreshLineTransportModeMain();
			}else {
				showHint(json.warning);	
			}
		}, "json");		
	}
	
	function convertInputToValue() {
		var input_km_value = ($( "input[name='custom-input-distance-km']").val())*1000;
		var input_m_value = $( "input[name='custom-input-distance-m']").val();
		//var input_day_value = ($( "input[name='custom-input-duration-day']").val())*24*60*60;
		input_day_value = 0;
		var input_hr_value = ($( "input[name='custom-input-duration-hour']").val())*60*60;
		var input_min_value = ($( "input[name='custom-input-duration-minute']").val())*60;
		
		var input_distance_value = Number(input_km_value) + Number(input_m_value);
		var input_duration_value = Number(input_day_value) + Number(input_hr_value) + Number(input_min_value);
		
		return [input_distance_value,input_duration_value];
	}
	
	function convertValueToUnit (distance, duration) {
		// for distance
		if ($.isNumeric(distance) && distance > 99) {
			var distance_km =  (distance/1000);
			var distance_text = (distance_km).toFixed(1) +" km";
 		}else if (distance == 0) {
			distance_text = "";
		}else {
			var distance_m =  (distance%1000);
			distance_text = distance_m +" m";
		}
		
		if ($.isNumeric(duration)) {
			var duration_sec = parseInt(duration%60);
			var duration_minute = parseInt((duration/60)%60);
			var duration_hour = parseInt((duration/3600)%24);
			var duration_day = parseInt(duration/3600/24);
			
			if (duration_sec > 30) min_round = 1;
			if (duration_hour > 30) hour_round = 1;
			
			var duration_text = "";
			var format_limit = 1;
			
			if ( format_limit <= 2 )	{
				if ( duration_day == 1 ) {duration_text += duration_day+" day "; format_limit++;}
				else if ( duration_day > 1 ) {duration_text += duration_day+" days "; format_limit++;}				
			}
					
			if ( format_limit <= 2 ) {
				if ( format_limit == 2 && duration_minute > 30) duration_hour= duration_hour+1;
				if ( duration_hour == 1 ) {duration_text += duration_hour+" hour "; format_limit++;}
				else if ( duration_hour > 1 ) {duration_text += duration_hour+" hours "; format_limit++;}
			}
			
			if ( format_limit <= 2 ) {
				if (format_limit == 2 && duration_sec > 1) duration_minute= duration_minute+1;
				if ( duration_minute == 1 ) {duration_text += duration_minute+" min "; format_limit++;}
				else if ( duration_minute > 1 ) {duration_text += duration_minute+" mins "; format_limit++;}
			}
			
			//if (!$duration_text) { $duration_text .= "1 min "; }
		}
		
		// edit: remove day input. 
		duration_hour = duration_hour + (duration_day*24);
		
		var data = {
			"distance_km" : parseInt(distance_km),
			"distance_m" : parseInt(distance_m),
			//"duration_day" : parseInt(duration_day),
			"duration_hour" : parseInt(duration_hour),
			"duration_minute" : parseInt(duration_minute)
			}
		return [distance_text,duration_text,data];
	}
/*//*********************DORMANT ****** SPEED INPUT FOR ADMIN**********	
	// Change raw insert data into duration value to "sec" and distance value to "m" 
	function verifyInput() {
		var duration_raw = $( "input[name='raw-custom-duration']").val().replace(/\s/g,'');
		if (duration_raw !="") {
			//process raw data : day
			var start_slice = 0;
			var keyword = ["day","d"];
			var raw_day_position = parseFloat(searchKeywordPos(duration_raw,keyword));
			var processed_day = parseFloat(duration_raw.slice(0,raw_day_position).replace( /^\D+/g, '')).toFixed(1);
			if (processed_day > 0 && processed_day !="NaN") processed_day = processed_day*24*60*60;
			else processed_day = 0;
			if (raw_day_position) start_slice = raw_day_position;
					
			//process raw data : hour
			var keyword = ["hour","hr","h"];
			var raw_hour_position = parseFloat(searchKeywordPos(duration_raw,keyword));
			var processed_hour = parseFloat(duration_raw.slice(start_slice,raw_hour_position).replace( /^\D+/g, '')).toFixed(1);
			if (processed_hour > 0  && processed_hour !="NaN") processed_hour = processed_hour*60*60;
			else processed_hour = 0;
			if (raw_hour_position) start_slice = raw_hour_position;
			
			//process raw data : minute
			var keyword = ["minute","min","ms","m"];
			var raw_minute_position = parseFloat(searchKeywordPos(duration_raw,keyword));
			var processed_minute = parseFloat(duration_raw.slice(start_slice,raw_minute_position).replace( /^\D+/g, '')).toFixed(1);
			if (processed_minute > 0 && processed_minute !="NaN") processed_minute = processed_minute*60;
			else processed_minute = 0;
			if (raw_minute_position) start_slice = raw_minute_position;
			
			//process raw data : second
			var keyword = ["second","sec","s"];
			var raw_second_position = parseFloat(searchKeywordPos(duration_raw,keyword));
			var processed_second = parseFloat(duration_raw.slice(start_slice,raw_second_position).replace( /^\D+/g, '')).toFixed(1);
			if (processed_second > 0 && processed_second !="NaN") processed_second = processed_second;
			else processed_second = 0;
			
			var custom_duration_value = Number(processed_day) + Number(processed_hour) + Number(processed_minute) + Number(processed_second);
		//alert (parseInt(custom_duration_value)) ;
		}else var custom_duration_value = 0;
		
		//process raw data : distance km
		var distance_raw = $( "input[name='raw-custom-distance']").val().replace(/\s/g,'');
		if (distance_raw != "") {
			var keyword = ["kilometer","kilometre","km"];
			var raw_km_position = parseFloat(searchKeywordPos(distance_raw,keyword));
			var processed_km = parseFloat(distance_raw.slice(0,raw_km_position).replace( /^\D+/g, '')).toFixed(1);
			if (processed_km > 0 && processed_km !="NaN") processed_km = processed_km*1000;
			else processed_km = 0;
			if (raw_km_position) start_slice = raw_km_position;
			else start_slice = 0
			
			//process raw data : distance m
			var keyword = ["meter","metre","m"];
			var raw_m_position = parseFloat(searchKeywordPos(distance_raw,keyword));
			var processed_m = parseFloat(distance_raw.slice(start_slice,raw_m_position).replace( /^\D+/g, '')).toFixed(1);
			if (processed_m > 0 && processed_m !="NaN") processed_m = processed_m;
			else processed_m = 0;
			
			custom_distance_value = Number(processed_km) +  Number(processed_m);	
		}else var custom_distance_value = 0;
		
		// fill in the custome distance and duration value 
		
		//$( "input[name='custom-selected-distance']").val(custom_distance_value);	
		//$( "input[name='custom-selected-duration']").val(custom_duration_value);
		if (custom_distance_value != "" || custom_duration_value !="") {
			return [custom_distance_value, custom_duration_value];
		}else {
			return false;
		}		
		
		 //convertRawToUnit (custom_distance_value, custom_duration_value);
		//fill back in the value 
		//$( "input[name='raw-custom-duration']").val();
		//$( "input[name='raw-custom-distance']").val();
		alert (custom_distance_value+","+custom_duration_value) ;
		//var duration_day = $( "input[name='custom-travel-duration-day']").val();
		//var duration_hour = $( "input[name='custom-travel-duration-hour']").val();
		//var duration_minute = $( "input[name='custom-travel-duration-minute']").val();
		//var duration = (duration_minute*60)+(duration_hour*60*60)+(duration_day*60*60*24);
		
		//if (duration == 0 || duration =="" ) {
		//	alert ("inprer");
		//	return false
		//}//
		
	}
	
	function searchKeywordPos(string,keyword) {
		var key_position;
		$.each(keyword,function(i){
			var this_keyword = keyword[i];
			var this_string = string;
			
			var j = string.match(new RegExp(this_keyword,"g"));
			j = j? j.length:0;
			var deleted_index = 0;
			for (x = 0; x < j; x++) { 
   				var keyword_exist = this_string.search(this_keyword);
	
				if  (keyword_exist != -1 && $.isNumeric(this_string.charAt(keyword_exist-1))) {
					key_position = Number(keyword_exist) +  Number(deleted_index);
					
					break;
				}else if(keyword_exist != -1 && !$.isNumeric(this_string.charAt(keyword_exist-1))) {
					this_string = this_string.slice(keyword_exist+1);
					deleted_index = deleted_index+keyword_exist+1;					
				}	
											
			}
		});
		
		if (key_position == -1) return false;
		else return key_position;
	}
	
	function toggleSpeedInput(type) {
		if (type == "distance") { 
			$( "input[name='raw-custom-distance']").val("");
							
			$(".custom-input-distance").hide();
			$(".speed-input-distance").show();
			$(".custom-input-duration").show();
			$(".speed-input-duration").hide();
			$( "input[name='raw-custom-distance']").focus();
		}
		
		if (type == "xdistance") { 
			$( "input[name='raw-custom-distance']").val("");
							
			$(".custom-input-distance").show();
			$(".speed-input-distance").hide();
			$( "input[name='raw-custom-distance']").focus();
		}
		
		if (type == "duration") { 
			$( "input[name='raw-custom-duration']").val("");
			
			$(".custom-input-duration").hide();
			$(".speed-input-duration").show();
			$(".custom-input-distance").show();
			$(".speed-input-distance").hide();
			$( "input[name='raw-custom-duration']").focus();
		}
		
		if (type == "xduration") { 
			$( "input[name='raw-custom-duration']").val("");
							
			$(".custom-input-duration").show();
			$(".speed-input-duration").hide();
			$( "input[name='raw-custom-duration']").focus();
		}
	}
	
	function processInput (type) {
		input_verified = verifyInput();
		var input_distance = input_verified[0]; //change to m
		var input_duration = input_verified[1]; //change to sec
		
		var distance_km = parseInt(input_distance/1000);
		var distance_m = parseInt(input_distance%1000);
		
	}
	*/
</script>
<script>
	$("#modal-transport-custom").on( "show.bs.modal", function() {
		
	
	});
</script>