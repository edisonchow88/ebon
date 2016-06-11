function setCookie(cname, cvalue, exdays) {
	var d = new Date();
	d.setTime(d.getTime() + (exdays*24*60*60*1000));
	var expires = "expires="+d.toUTCString();
	document.cookie = cname + "=" + cvalue + "; " + expires;
}

function getURLParameter(name) {
	return decodeURIComponent((new RegExp('[?|&]' + name + '=' + '([^&;]+?)(&|#|;|$)').exec(location.search)||[,""])[1].replace(/\+/g, '%20'))||null;
}

function reset_alert() {
	document.getElementById("alert_container").innerHTML = '';
}

function post_alert(type, msg, action) {
	var output = '';
	if(type == 'success') { output += "<div class='alert alert-success'>"; }
	if(type == 'warning') { output += "<div class='alert alert-warning'>"; }
	if(type == 'error') { output += "<div class='alert alert-danger'>"; }
		output += "<button type='button' class='close' data-dismiss='alert'>&times;</button>";
		output += "<div class='row'>";
			output += "<div class='col-xs-3 col-sm-2'>";
				output += "<span class='fa-stack fa-2x'>";
					output += "<i class='fa fa-stack-2x fa-circle'></i>";
					if(type == 'success') { output += "<i class='fa fa-stack-1x fa-inverse fa-check'></i>"; }
					if(type == 'warning') { output += "<i class='fa fa-stack-1x fa-inverse fa-exclamation'></i>"; }
					if(type == 'error') { output += "<i class='fa fa-stack-1x fa-inverse fa-exclamation-triangle'></i>"; }
				output += "</span>";
			output += "</div>";
			output += "<div class='col-xs-8 col-sm-9'>";
				if(type == 'success') { output += "<b style='font-size:16px;'>SUCCESS!</b><br/>"; }
				if(type == 'warning') { output += "<b style='font-size:16px;'>WARNING!</b><br/>"; }
				if(type == 'error') { output += "<b style='font-size:16px;'>ERROR!</b><br/>"; }
				output += "<div class='row'>";
					if(type == 'warning') { output += "<div class='col-xs-12 col-sm-8 col-md-10'>"; }
					else { output += "<div class='col-xs-12'>"; }
						output += msg;
					output += "</div>";
					if(type == 'warning') { 
					output += "<div class='col-xs-12 col-sm-4 col-md-2'>";
						output += "<a class='btn btn-warning' onclick='"+action+"; reset_alert();'>Yes</a>";
					output += "</div>";
					}
				output += "</div>";
			output += "</div>";
		output += "</div>";
	output += "</div>";
	document.getElementById("alert_container").innerHTML = output;
}

function copy_itinerary_link() {
	var copyTextarea = document.querySelector('.js-copytextarea');
	copyTextarea.select();
  
	try {
		var successful = document.execCommand('copy');
		var msg = successful ? 'successful' : 'unsuccessful';
		console.log('Copying text command was ' + msg);
	} catch (err) {
		console.log('Failed to copy the link');
	}
	
	var msg ="Link is copied";
	post_alert("success",msg);
};

function setup_data() {
	var data = "&view=" + document.getElementById("input_view").value;
	data += "&draft=" + document.getElementById("input_draft_id").value;
	data += "&trip=" + document.getElementById("input_trip_id").value;
	data += "&day=" + document.getElementById("input_day_id").value;
	data += "&trip_name=" + document.getElementById("input_trip_name").value;
	data += "&draft_name=" + document.getElementById("input_trip_name").value;
	data += "&travel_date=" + document.getElementById("input_travel_date").value;
	return data;
}

function confirm_restart_trial() {
	post_alert('warning','Itinerary Number: <b>'+document.getElementById('input_itinerary_code').value+'</b><br />You are leaving your current itinerary.<br/>Do you want to proceed?','restart_trial()');
}

function restart_trial() {
	setCookie('draft','',-1);
	setCookie('customer','',-1);
	location.reload();
}

function load_trip(source) {
	if(source.value.length == 8) {
		var xmlhttp = new XMLHttpRequest();
		var url = document.getElementById("input_ajax_url").value;
		var data = "&action=" + "load_trip";
		data += setup_data();
		data += "&itinerary_code=" + source.value;
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("input_conn").value = 'Done';
				if(xmlhttp.responseText == false) {
					var msg ="Itinerary is missing. Please check your itinerary number.";
					post_alert("error",msg);
				}
				else {
					refresh_trip(xmlhttp.responseText);
					hide('welcome_screen');
					hide('load_trip_screen');
					hide_all_view();
					show('itinerary_screen');
					select_view('day');
					var msg = document.getElementById("input_trip_name").value + " is loaded";
					post_alert("success",msg);
				}
			}
		};
		xmlhttp.open("GET", query, true);
		xmlhttp.send();
		document.getElementById("input_conn").value = 'Connecting';
		document.getElementById("input_action").value = 'load_trip';
	}
	else {
		var msg ="Itinerary code must be 8 characters.";
		post_alert("error",msg);
	}
}

function add_trip_then_set_template() {
	var xmlhttp = new XMLHttpRequest();
	var url = document.getElementById("input_ajax_url").value;
	var data = "&action=" + "add_trip";
	var query = url + data;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			refresh_trip(xmlhttp.responseText);
			hide("welcome_screen");
			show("itinerary_screen");
			select_view('day');
			document.getElementById("input_conn").value = 'Done';
			var msg ="New trip is created";
			post_alert("success",msg);
			set_template();
		}
	};
	xmlhttp.open("GET", query, true);
	xmlhttp.send();
	document.getElementById("input_conn").value = 'Connecting';
	document.getElementById("input_action").value = 'add_trip';
}

function confirm_set_template() {
	if(document.getElementById('input_itinerary_code').value == 0) {
		add_trip_then_set_template();
	}
	else {
		post_alert('warning','Your itinerary will be reset.<br />Do you want to proceed?','set_template()');
	}
}

function set_template() {
	if(document.getElementById('input_itinerary_code').value == 0) {
		add_trip_then_set_template();
		return;
	}
	var xmlhttp = new XMLHttpRequest();
	var url = document.getElementById("input_ajax_url").value;
	var data = "&action=" + "set_template";
	data += setup_data();
	data += "&template_code=" + getURLParameter('template_code');
	var query = url + data;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			document.getElementById("input_conn").value = 'Done';
			document.getElementById("input_day_id").value = xmlhttp.responseText;
			hide('welcome_screen');
			hide('load_trip_screen');
			show('itinerary_screen');
			select_view('day');
			var msg = "Trip itinerary is updated";
			post_alert("success",msg);
		}
	};
	xmlhttp.open("GET", query, true);
	xmlhttp.send();
	document.getElementById("input_conn").value = 'Connecting';
	document.getElementById("input_action").value = 'set_template';
}

function refresh_trip(responseText) {
	document.getElementById("log").innerHTML += '<br/>BOC display_trip';
	var result = JSON.parse(responseText);
	document.getElementById("input_itinerary_code").value = result.itinerary_code;	
	document.getElementById("input_trip_name").value = result.draft_name;	
	document.getElementById("input_travel_date").value = result.draft_date;	
	document.getElementById("input_draft_id").value = result.draft_id;	
	document.getElementById("input_day_id").value = result.day_id;
	document.getElementById("text_title").innerHTML = result.draft_name;
	var cookie = window.btoa(result.draft_id);
	setCookie('draft',cookie,3);
	document.getElementById("log").innerHTML += '<br/>--- display_trip';
}

function display_day_list(responseText) {
	document.getElementById("log").innerHTML += '<br/>BOC display_day_list';
	var result = JSON.parse(responseText);
	var output = '';	
	document.getElementById("text_days_count").innerHTML = result.length;
	
	output = '';
	output += "<ul id='sortable_day' class='sortable ui-sortable'>";
	for(i = 0; i < result.length; i++) {
		output += "<li id='sort_day_id-" + result[i].day_id + "' class='ui-sortable-handle'";
		if(result[i].day_id == document.getElementById("input_day_id").value) { 
			output += "style='border-left:solid 2px #3c763d;'";
		}
		output += ">";
		output += "<a class='btn' onclick='select_day(" + result[i].day_id + ");'  style='width:100%;'>";
		if(result[i].date != "0000-00-00") {
			output += "<span class='sort_tr sort_col2 align_left'>" + "D" + result[i].sortable + "</span>";
			output += "<span class='sort_tr sort_col5 align_left'>" + result[i].date + "&nbsp;";
				output += "<span style='font-size:8px;'>(" + result[i].day + ")</span>";
			output += "</span>";
		}
		else {
			output += "<span class='sort_tr sort_col7 align_left'>" + "Day " + result[i].sortable + "</span>";
		}
		output += "<span class='sort_tr sort_col2' style='font-size:10px;'>";
		output += "<span class='fa-stack'>" + "<i class='fa fa-square fa-stack-2x'></i>";
		output += "<span class='fa-stack-1x' style='color:#FFF;'>" + result[i].total_activities + "</span>";
		output += "</span>";
		output += "</span>";
		output += "<span class='sort_tr sort_col1'>" + "<i class='fa fa-chevron-right'></i>" + "</span>";
		output += "</a>";
		output += "</li>";
	}
	output += "</ul>";
	document.getElementById("day_list").innerHTML = output;	
	enable_sort_day();
	document.getElementById("log").innerHTML += '<br/>--- display_day_list';
}


function display_activity_list(responseText) {
	document.getElementById("log").innerHTML += '<br/>BOC display_activity_list';
	var result = JSON.parse(responseText);
	var output = '';
	
	//rewrite Day Bar
	if(result.day_selected.date != "0000-00-00") {
		output += "<span>" + result.day_selected.date + "&nbsp;";
		output += "<span style='font-size:8px;'>(" +result.day_selected.day + ")</span>";
	}
	else {
		output += "<span>Day " + result.day_selected.sortable + "</span>";
	}
	output += "&nbsp; <i class='fa fa-pencil' style='color:#CCC;'></i>";
	output += "</span>";
	document.getElementById("day_selected").innerHTML = output;
	
	//rewrite Previous Day Button
	output = '';
	if(result.day_selected.prev_day_id != false) {
		output += "<a class='btn' onclick='other_day(" + result.day_selected.prev_day_id + ")'><i class='fa fa-chevron-left'></i></a>";
	}
	document.getElementById("day_previous").innerHTML = output;
	
	//rewrite Next Day Button
	output = '';
	if(result.day_selected.next_day_id != false) {
		output += "<a class='btn' onclick='other_day(" + result.day_selected.next_day_id + ")'><i class='fa fa-chevron-right'></i></a>";
	}
	document.getElementById("day_next").innerHTML = output;
	
	//rewrite Activity List
	output = '';
	if(result.activity == "empty") {
		output = "No Activity";
	}
	else {
		output += "<ul id='sortable_activity' class='sortable'>";
		for(i = 0; i < result.activity.length; i++) {
			if(document.getElementById("input_draft_id") != '') {
				output += "<li id='sort_activity_id-" + result.activity[i].draft_activity_id + "' class='ui-sortable-handle'>";
					output += "<a class='btn' onclick='open_activity_toolbar(" + result.activity[i].draft_activity_id + ")' style='width:100%;'>";
						output += "<span class='sort_tr sort_col2 align_left'><img src='" + result.activity[i].thumb_url + "' width='32px' alt>" + "</span>";
						output += "<span class='sort_tr sort_col7 align_left' style='font-size:11px;'>" + result.activity[i].name + "</span>";
						output += "<span class='sort_tr sort_col1' id='activity_toolbar_button" + result.activity[i].draft_activity_id + "' name='activity_toolbar_button'>" + "<i class='fa fa-caret-down'></i>" + "</span>";
					output += "</a>";
					output += "<div id='activity_toolbar" + result.activity[i].draft_activity_id + "' name='activity_toolbar' class='btn-group' style='width:100%; display:none;'>";
						output += "<a class='btn btn-danger btn-sm' onclick='delete_activity(" + result.activity[i].draft_activity_id + ")' style='width:33.33%'>Delete</a>";
						output += "<a class='btn btn-default btn-sm' style='width:33.33%'>Comment</a>";
						output += "<a class='btn btn-default btn-sm' href='" + result.activity[i].link + "' style='width:33.33%'>View</a>";
					output += "</div>";
				output += "</li>";
			}
			else if(document.getElementById("input_trip_id") != '') {
				output += "<li id='sort_activity_id-" + result.activity[i].trip_activity_id + "' class='ui-sortable-handle'>";
					output += "<a class='btn' onclick='open_activity_toolbar(" + result.activity[i].trip_activity_id + ")' style='width:100%;'>";
						output += "<span class='sort_tr sort_col2 align_left'><img src='" + result.activity[i].thumb_url + "' width='32px' alt>" + "</span>";
						output += "<span class='sort_tr sort_col7 align_left' style='font-size:11px;'>" + result.activity[i].name + "</span>";
						output += "<span class='sort_tr sort_col1' id='activity_toolbar_button" + result.activity[i].trip_activity_id + "' name='activity_toolbar_button'>" + "<i class='fa fa-caret-down'></i>" + "</span>";
					output += "</a>";
					output += "<div id='activity_toolbar" + result.activity[i].trip_activity_id + "' name='activity_toolbar' class='btn-group' style='width:100%; display:none;'>";
						output += "<a class='btn btn-danger btn-sm' onclick='delete_activity(" + result.activity[i].trip_activity_id + ")' style='width:33.33%'>Delete</a>";
						output += "<a class='btn btn-default btn-sm' style='width:33.33%'>Comment</a>";
						output += "<a class='btn btn-default btn-sm' href='" + result.activity[i].link + "' style='width:33.33%'>View</a>";
					output += "</div>";
				output += "</li>";
			}
		}
		output += "<ul>";
	}
	document.getElementById("activity_list").innerHTML = output;
	enable_sort_activity();
	document.getElementById("log").innerHTML += '<br/>--- display_activity_list';
}

function refresh_day_list() {
	document.getElementById("log").innerHTML += '<br/>BOC refresh_day_list';
	var xmlhttp = new XMLHttpRequest();
	var url = document.getElementById("input_ajax_url").value;
	var data = "&action=" + "refresh_day_list";
	data += setup_data();
	var query = url + data;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			display_day_list(xmlhttp.responseText);
			document.getElementById("input_conn").value = 'Done';
			document.getElementById("log").innerHTML += '<br/>--- refresh_day_list';
		}
	};
	xmlhttp.open("GET", query, true);
	xmlhttp.send();
	document.getElementById("input_conn").value = 'Connecting';
	document.getElementById("log").innerHTML += '<br/>C-- refresh_day_list';
}

function refresh_activity_list() {
	document.getElementById("log").innerHTML += '<br/>BOC refresh_activity_list';
	var xmlhttp = new XMLHttpRequest();
	var url = document.getElementById("input_ajax_url").value;
	var data = "&action=" + "refresh_activity_list";
	data += setup_data();
	var query = url + data;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			display_activity_list(xmlhttp.responseText);
			document.getElementById("input_conn").value = 'Done';
			if(document.getElementById("input_view").value == 'activity') {
				document.getElementById("loading_view").style.display = 'none';
				document.getElementById("activity_view").style.display = 'block';
			}
			document.getElementById("log").innerHTML += '<br/>--- refresh_activity_list';
		}
	};
	xmlhttp.open("GET", query, true);
	xmlhttp.send();
	document.getElementById("input_conn").value = 'Connecting';
	document.getElementById("input_action").value = 'refresh_activity_list';
	document.getElementById("log").innerHTML += '<br/>C-- refresh_activity_list';
}

function add_trip() {
	var xmlhttp = new XMLHttpRequest();
	var url = document.getElementById("input_ajax_url").value;
	var data = "&action=" + "add_trip";
	var query = url + data;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			refresh_trip(xmlhttp.responseText);
			hide("welcome_screen");
			show("itinerary_screen");
			select_view('day');
			document.getElementById("input_conn").value = 'Done';
			var msg ="New trip is created";
			post_alert("success",msg);
		}
	};
	xmlhttp.open("GET", query, true);
	xmlhttp.send();
	document.getElementById("input_conn").value = 'Connecting';
	document.getElementById("input_action").value = 'add_trip';
}

function add_day() {
	var xmlhttp = new XMLHttpRequest();
	var url = document.getElementById("input_ajax_url").value;
	var data = "&action=" + "add_day";
	data += setup_data();
	var query = url + data;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			refresh_day_list();
			document.getElementById("input_conn").value = 'Done';
			var days_count = Number(document.getElementById("text_days_count").innerHTML) + 1;
			var msg ="<b>Day " + days_count + "</b> is added";
			post_alert("success",msg);
		}
	};
	xmlhttp.open("GET", query, true);
	xmlhttp.send();
	document.getElementById("input_conn").value = 'Connecting';
	document.getElementById("input_action").value = 'add_day';
}

function delete_day() {
	var days_count = Number(document.getElementById("text_days_count").innerHTML);
	if(days_count > 1) {
		var xmlhttp = new XMLHttpRequest();
		var url = document.getElementById("input_ajax_url").value;
		var data = "&action=" + "delete_day";
		data += setup_data();
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				other_day(xmlhttp.responseText);
				document.getElementById("input_conn").value = 'Done';
				var msg ="Day is deleted";
				post_alert("success",msg);
			}
		};
		xmlhttp.open("GET", query, true);
		xmlhttp.send();
		document.getElementById("input_conn").value = 'Connecting';
		document.getElementById("input_action").value = 'delete_day';
	}
	else {
		var msg ="Minimum number of travelling day has to be 1";
		post_alert("error",msg);
	}
}

function add_trip_then_activity(activity_id) {
	var xmlhttp = new XMLHttpRequest();
	var url = document.getElementById("input_ajax_url").value;
	var data = "&action=" + "add_trip";
	var query = url + data;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			refresh_trip(xmlhttp.responseText);
			hide("welcome_screen");
			show("itinerary_screen");
			select_view('day');
			document.getElementById("input_conn").value = 'Done';
			var msg ="New trip is created";
			post_alert("success",msg);
			add_activity(activity_id);
		}
	};
	xmlhttp.open("GET", query, true);
	xmlhttp.send();
	document.getElementById("input_conn").value = 'Connecting';
	document.getElementById("input_action").value = 'add_trip';
}

function add_activity(activity_id) {
	if(document.getElementById('input_itinerary_code').value == 0) {
		add_trip_then_activity(activity_id);
		return;
	}
	if(document.getElementById('input_day_id').value != 0) {
		var xmlhttp = new XMLHttpRequest();
		var url = document.getElementById("input_ajax_url").value;
		var data = "&action=" + "add_activity";
		data += setup_data();
		data += "&activity_id=" + activity_id;
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				refresh_day_list();
				refresh_activity_list();
				document.getElementById("input_conn").value = 'Done';
				var msg ="Activity is added";
				post_alert("success",msg);
				$("html, body").animate({
					scrollTop: 0
				}, 200); 
			}
		};
		xmlhttp.open("GET", query, true);
		xmlhttp.send();
		document.getElementById("input_conn").value = 'Connecting';
		document.getElementById("input_action").value = 'add_activity';
	}
	else {
		var msg ="Please select the day to add activity";
		post_alert("error",msg);
	}
}

function delete_activity(trip_activity_id) {
	var xmlhttp = new XMLHttpRequest();
	var url = document.getElementById("input_ajax_url").value;
	var data = "&action=" + "delete_activity";
	data += setup_data();
	if(document.getElementById("input_draft_id") != '') {
		data += "&draft_activity_id=" + trip_activity_id;
	}
	else if(document.getElementById("input_trip_id") != '') {
		data += "&trip_activity_id=" + trip_activity_id;
	}
	else {
		var msg ="No trip is selected";
		post_alert("error",msg);
	}
	var query = url + data;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			refresh_activity_list();
			document.getElementById("input_conn").value = 'Done';
			var msg ="Activity is deleted";
			post_alert("success",msg);
		}
	};
	xmlhttp.open("GET", query, true);
	xmlhttp.send();
	document.getElementById("input_conn").value = 'Connecting';
	document.getElementById("input_action").value = 'delete_activity';
}

function select_view(view) {
	if(view=="day") {
		document.getElementById("day_view").style.display = 'block';
		document.getElementById("activity_view").style.display = 'none';
		document.getElementById("input_view").value = 'day';
		refresh_day_list();
	}
	else if(view=="activity") {
		document.getElementById("loading_view").style.display = 'block'; //needed as it is not fast enough to load activity
		document.getElementById("day_view").style.display = 'none';
		document.getElementById("activity_view").style.display = 'none';
		document.getElementById("input_view").value = 'activity';
		refresh_activity_list();
		refresh_day_list();
	}
}

function select_trip(trip_id) {
	document.getElementById("input_trip_id").value = trip_id;
	open_trip_list();
	select_view(document.getElementById("input_view").value);
	reset_alert();
}

function select_day(day_id) {
	document.getElementById("input_day_id").value = day_id;
	select_view('activity');
	hide_day_second_toolbar();
	reset_alert();
}

function other_day(day_id) {
	document.getElementById("input_day_id").value = day_id;
	refresh_activity_list();
	refresh_day_list();
	hide_day_second_toolbar();
	reset_alert();
}

function hide_all_view() {
	document.getElementById("day_view").style.display = "none";
	document.getElementById("activity_view").style.display = "none";
	document.getElementById("edit_name_view").style.display = "none";
	document.getElementById("save_view").style.display = "none";
	document.getElementById("load_view").style.display = "none";
	document.getElementById("share_view").style.display = 'none';
	document.getElementById("button_edit_name").className = document.getElementById("button_edit_name").className.replace( /(?:^|\s)disabled(?!\S)/g , '' );
	document.getElementById("button_save").className = document.getElementById("button_save").className.replace( /(?:^|\s)disabled(?!\S)/g , '' );
	document.getElementById("button_load").className = document.getElementById("button_load").className.replace( /(?:^|\s)disabled(?!\S)/g , '' );
	document.getElementById("button_share").className = document.getElementById("button_share").className.replace( /(?:^|\s)disabled(?!\S)/g , '' );
}

function show(view) {
	document.getElementById(view).style.display = "block";
}

function hide(view) {
	document.getElementById(view).style.display = "none";
}

function back_view() {
	hide_all_view();
	select_view(document.getElementById("input_view").value);
	reset_alert();
}

function show_edit_name_view() {
	hide_all_view();
	document.getElementById("edit_name_view").style.display = "block";
	document.getElementById("button_edit_name").className += " disabled";
	reset_alert();
}

function show_save_view() {
	hide_all_view();
	document.getElementById("save_view").style.display = "block";
	document.getElementById("button_save").className += " disabled";
	reset_alert();
}

function show_load_view() {
	hide_all_view();
	document.getElementById("load_view").style.display = "block";
	document.getElementById("button_load").className += " disabled";
	reset_alert();
}

function show_share_view() {
	hide_all_view();
	document.getElementById("share_view").style.display = "block";
	document.getElementById("button_share").className += " disabled";
	reset_alert();
}

function open_date_status() {
	document.getElementById("date_status").style.display = "block";
	document.getElementById("button_open_date_status").style.display = "none";
	document.getElementById("button_close_date_status").style.display = "block";
	document.getElementById("day_status").style.display = "none";
	document.getElementById("day_list").style.display = "none";
	document.getElementById("button_add_day").style.display = "none";
	document.getElementById("text_subtitle").innerHTML = "Edit Travel Date";
	reset_alert();
}

function close_date_status() {
	document.getElementById("date_status").style.display = "none";
	document.getElementById("button_open_date_status").style.display = "block";
	document.getElementById("button_close_date_status").style.display = "none";
	document.getElementById("day_status").style.display = "block";
	document.getElementById("day_list").style.display = "block";
	document.getElementById("button_add_day").style.display = "block";
	document.getElementById("text_subtitle").innerHTML = "Itinerary";
}

function open_day_second_toolbar() {
	if(document.getElementById("day_second_toolbar").style.display == "none") {
		document.getElementById("day_second_toolbar").style.display = "block";
	}
	else if(document.getElementById("day_second_toolbar").style.display == "block") {
		document.getElementById("day_second_toolbar").style.display = "none";
	}
}

function hide_day_second_toolbar() {
	document.getElementById("day_second_toolbar").style.display = "none";
}

function open_activity_toolbar(trip_activity_id) {
	var activity = document.getElementsByName("activity_toolbar").length;
	if(document.getElementById("activity_toolbar"+trip_activity_id).style.display == "none") {
		var status = "on";
	}
	else if(document.getElementById("activity_toolbar"+trip_activity_id).style.display == "block") {
		var status = "off";
	}
	for(i = 0; i < activity; i++) {
		document.getElementsByName("activity_toolbar")[i].style.display = "none";
		document.getElementsByName("activity_toolbar_button")[i].innerHTML = "<i class='fa fa-caret-down'></i>"; 
	}
	if(status == "on") {
		document.getElementById("activity_toolbar"+trip_activity_id).style.display = "block";
		document.getElementById("activity_toolbar_button"+trip_activity_id).innerHTML = "<i class='fa fa-caret-up'></i>";
	}
	else if(status == "off") {
		document.getElementById("activity_toolbar"+trip_activity_id).style.display = "none";
		document.getElementById("activity_toolbar_button"+trip_activity_id).innerHTML = "<i class='fa fa-caret-down'></i>";
	}
}

function save_trip_name() {
	if(document.getElementById("input_trip_name").value != '') {
		var xmlhttp = new XMLHttpRequest();
		var url = document.getElementById("input_ajax_url").value;
		var data = "&action=" + "save_trip_name";
		data += setup_data();
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				hide_all_view();
				select_view(document.getElementById("input_view").value);
				document.getElementById("text_title").innerHTML = document.getElementById("input_trip_name").value;
				document.getElementById("input_conn").value = 'Done';
				if(document.getElementById("input_trip_name").value != '') {
					var msg ="Trip name is changed to <b>" + document.getElementById("input_trip_name").value + "</b>";
				}
				post_alert("success",msg);
			}
		};
		xmlhttp.open("GET", query, true);
		xmlhttp.send();
		document.getElementById("input_conn").value = 'Connecting';
		document.getElementById("input_action").value = 'save_trip_name';
	}
	else {
		document.getElementById("input_trip_name").value = document.getElementById("text_title").innerHTML;
		var msg = "Trip name cannot be empty";
		post_alert("error",msg);
	}
}

function save_travel_date() {
	var xmlhttp = new XMLHttpRequest();
	var url = document.getElementById("input_ajax_url").value;
	var data = "&action=" + "save_travel_date";
	data += setup_data();
	var query = url + data;
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
			close_date_status();
			refresh_day_list();
			document.getElementById("input_conn").value = 'Done';
			if(document.getElementById("input_travel_date").value != '') {
				var msg ="Travel date is changed to <b>" + document.getElementById("input_travel_date").value + "</b>";
			}
			else {
				var msg = "Travel date is removed";
			}
			post_alert("success",msg);
		}
	};
	xmlhttp.open("GET", query, true);
	xmlhttp.send();
	document.getElementById("input_conn").value = 'Connecting';
	document.getElementById("input_action").value = 'save_travel_date';
}

function enable_sort_day() {
	$(function() {
		$( "#sortable_day" ).sortable({
			items: 'li',
			cursor: 'move',
			helper: 'clone',
			opacity: 0.8,
			axis: 'y',
			update: function (event, ui) {
				var xmlhttp = new XMLHttpRequest();
				var url = document.getElementById("input_ajax_url").value;
				var data = "&action=" + "sort_day";
				data += setup_data();
				data += "&" + $(this).sortable('serialize');
				var query = url + data;
				xmlhttp.onreadystatechange = function() {
					if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						refresh_day_list();
						document.getElementById("input_conn").value = 'Done';
					}
				};
				xmlhttp.open("GET", query, true);
				xmlhttp.send();
				document.getElementById("input_conn").value = 'Connecting';
				document.getElementById("input_action").value = 'enable_sort_day';
			}
		});
		$( "#sortable_day" ).disableSelection();
	});
}

function enable_sort_activity() {
	$(function() {
		$( "#sortable_activity" ).sortable({
			items: 'li',
			cursor: 'move',
			helper: 'clone',
			opacity: 0.8,
			axis: 'y',
			update: function (event, ui) {
				var xmlhttp = new XMLHttpRequest();
				var url = document.getElementById("input_ajax_url").value;
				var data = "&action=" + "sort_activity";
				data += setup_data();
				data += "&" + $(this).sortable('serialize');
				var query = url + data;
				xmlhttp.onreadystatechange = function() {
					if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						refresh_activity_list();
						document.getElementById("input_conn").value = 'Done';
					}
				};
				xmlhttp.open("GET", query, true);
				xmlhttp.send();
				document.getElementById("input_conn").value = 'Connecting';
				document.getElementById("input_action").value = 'enable_sort_activity';
			}
		});
		$( "#sortable_activity" ).disableSelection();
	});
}

//initialization code
$(function() {
	
	if(document.getElementById("input_draft_id").value != '') {
		if(document.getElementById("input_view").value == "day") {
			enable_sort_day();
			select_view('day');
		}
		else if(document.getElementById("input_view").value == "activity") {
			enable_sort_activity();
			//select_view('activity'); not going to refresh activity view when initial a new page, will do it if able to refresh perfectly without lag
		}
	}
});