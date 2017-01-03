<style>
	.css-tools-or-with-line {
		width: 100%; 
		text-align: center; 
		border-bottom: 1px solid #CCC; 
		line-height: 0.1em;
		margin: 30px 0 20px; 
	}
	
	.css-tools-or-with-line span {
    	padding:0 20px; 
		background:#eee; 
		color:#777;
	}
</style>

<div class="content-header fixed-width noselect">
    <div class="row navbar navbar-primary navbar-modal">
        <div class="col-xs-3 text-left">
            <a class="btn" onclick="window.history.back();">Back</a>
        </div>
        <div class="col-xs-6 text-center">
            <h1>Select Template</h1>
        </div>
        <div class="col-xs-3 text-right">
            <a class="btn">Skip</a>
        </div>
    </div>
</div>
<div class="content-body fixed-width background-empty">
	<div class="navbar navbar-shadow"></div>
    <form class="mobile-form mobile-form-simple" id="modal-trip-new-form" autocomplete="off">
        <input type="hidden" name="action" value="new_trip" />
        <input type="hidden" name="user_id" value="<?php echo $this->user->getUserId(); ?>" />
        <input type="hidden" name="role_id" value="<?php echo $this->user->getRoleId(); ?>" />
        <input type="hidden" name="language_id" value="<?php echo $this->language->getLanguageId(); ?>" />
        <input type="hidden" name="name" value="My Trip" />
        <div class="row">
            <div class="col-xs-4"><label for="country_id" selected>Destination</label></div>
            <div class="col-xs-8">
                <select name="country_id">
                	<option value="0" selected>Any</option>
                    <?php
                        $country_id = $this->request->get_or_post('country_id');
                        foreach($country as $key => $value) {
                            if($country_id) {
                                 if($value['country_id'] == $country_id) { $selected = 'selected'; } else { $selected = ''; }
                            }
                            echo '<option value="'.$value['country_id'].'" '.$selected.'>'.$value['name'].'</option>';
                            
                        }
                    ?>
                </select>
            </div>
        </div>
        <div class="filter">
            <div class="row">
                <div class="col-xs-4"><label for="month" selected>Month</label></div>
                <div class="col-xs-8">
                    <select name="month">
                        <?php
                            $requested_month = $this->request->get_or_post('month');
                            
                            if($requested_month) {
                            	$selected = '';
                            }
                            else {
                            	$selected = 'selected';
                            }
                            
                            echo '<option value="0" '.$selected.'>Any</option>';
                            
                            $selected = '';
                            
                            foreach($month as $key => $value) {
                                if($requested_month) {
                                     if($value['data_id'] == $requested_month) { $selected = 'selected'; } else { $selected = ''; }
                                }
                                echo '<option value="'.$value['data_id'].'" '.$selected.'>'.$value['name'].'</option>';
                                
                            }
                        ?>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4"><label for="mode_id" selected>Transport</label></div>
                <div class="col-xs-8">
                    <select name="mode_id">
                        <?php
                            $mode_id = $this->request->get_or_post('mode_id');
                            
                            if($mode_id) {
                            	$selected = '';
                            }
                            else {
                            	$selected = 'selected';
                            }
                            
                            echo '<option value="0" '.$selected.'>Any</option>';
                            
                            $selected = '';
                            
                            foreach($mode as $key => $value) {
                                if($mode_id) {
                                     if($value['mode_id'] == $mode_id) { $selected = 'selected'; } else { $selected = ''; }
                                }
                                echo '<option value="'.$value['mode_id'].'" '.$selected.'>'.$value['name'].'</option>';
                                
                            }
                        ?>
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-4"><label for="duration" selected>Duration</label></div>
                <div class="col-xs-8">
                    <select name="duration">
                    <option value="0" selected>Any</option>
                        <?php
                            for($i=1;$i<31;$i++) {
                                if($i == 1) { $unit = 'day'; } else { $unit = 'days'; }
                                echo '<option value="'.$i.'">'.$i.' '.$unit.'</option>';
                            }
                        ?>
                    </select>
                </div>
            </div>
        </div>
    </form>
    <div class="row navbar navbar-transparent">
        <div class="col-xs-6 text-left">
            <span class="text-sub text-num-of-result"></span>
        </div>
        <div class="col-xs-6 text-right">
            <a class="btn btn-set-filter hidden" data-toggle="modal" data-target="#modal-wizard-filter" style="display:none;">More Filters</a>
        </div>
    </div>
    <div class="content-body-alert"></div>
    <div class="content-body-result" style="margin-top:15px;">
    	<div class="content-body-result-loading">
        	<div class="col-xs-12">
                <i class="fa fa-circle-o-notch fa-spin fa-5x fa-fw"></i>
            </div>
        </div>
        <div class="content-body-result-empty">
        	<div class="col-xs-12">
                <div><b>No Available Template</b></div>
                <div>Click to <a href="<?php echo $link['wizard/new']; ?>">create from scratch</a></div>
            </div>
        </div>
        <div class="content-body-result-list ca ca-card ca-white noselect">
        </div>
    </div>
    <div class="content-body-optional hidden">
        <div class="css-tools-or-with-line"><span>OR</span></div>
        <div class="row text-center padding">
            <div class="text-sub padding">Can't find any template?</div>
            <a class="btn btn-block btn-primary box-shadow rounded fixed-height-5" onclick="verify_new_trip_condition();">Create From Scratch</a>
        </div>
    </div>
</div>

<script>
	function toggleFilter() {
		$('.filter').toggleClass('hidden');
		$('.btn-set-filter .fa').toggleClass('fa-flip-vertical');
	}
</script>
<script>
	function updateTripName() {
		var country_id = $('#modal-trip-new-form select[name=country_id]').val();
		var country = $('#modal-trip-new-form select[name=country_id] option[value="'+country_id+'"]').text();
		var name = '';
		
		if(country_id > 0) {
			name = 'My ' + country + ' Trip';
		}
		else {
			name = 'My Trip';
		}
		
		$('#modal-trip-new-form input[name=name]').val(name);
	}
	
	function newTrip() {
		var form_element = document.querySelector("#modal-trip-new-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $ajax['trip/ajax_itinerary']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			var alert_text = "";
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				
				if(typeof json.exceeded_quota != 'undefined') {
					$('#modal-trip-quota-alert-text').html('New trip cannot be created.');
					$('#modal-trip-quota').modal('show');
					$('#modal-trip-new').modal('hide');
				}
				else if(typeof json.warning != 'undefined') {
					<!-- if error -->
					var content;
					content = "<div class='alert alert-danger'><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					alert_text = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					setCookie('trip','',0);
					setCookie('plan','',0);
					window.location = json.redirect;
				}
				document.getElementById('modal-trip-new-form-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function newTripViaCookie() {
		var title = $('#modal-trip-new-form input[name=name]').val();
		var trip = '{"name":"'+title+'"}';
		var plan = '{"name":"Plan 1","travel_date":"","day":[{"day_id":1,"sort_order":1}]}';
		setCookie('trip',trip,1);
		setCookie('plan',plan,1);
		window.location = '<?php echo $link["trip/itinerary"]; ?>';
	}
	
	function verify_new_trip_condition() {
		updateTripName();
		//Google Analytics Event
		ga('send', 'event','trip','create-new-trip');
		<?php if($this->user->isLogged() == false) { ?>
			<!-- START: [not logged] -->
				newTripViaCookie();
			<!-- END -->
		<?php } else { ?>
			<!-- START: [logged] -->
				newTrip();
			<!-- END -->
		<?php } ?>
	}
</script>
<script>
	function refreshTemplate() {
		<!-- START: reset loading screen -->
			$('.content-body-result-list').hide();
			$('.content-body-result-loading').show();
			$('.content-body-result-empty').show();
		<!-- END -->
		<!-- START: clear old result -->
			$('.content-body-result-list').html('');
			$('.text-num-of-result').html('');
			$('.btn-set-filter').addClass('hidden');
			$('.content-body-optional').addClass('hidden');
		<!-- END -->
		<!-- START: get new result -->
			<!-- START: -->
				var country_id = $('#modal-trip-new-form select[name=country_id]').val();
				var month = $('#modal-trip-new-form select[name=month]').val();
				var mode_id = $('#modal-trip-new-form select[name=mode_id]').val();
				var duration = $('#modal-trip-new-form select[name=duration]').val();
			<!-- END -->
			<!-- START -->
				var url = window.location.href.split('&')[0];
				url = url +'&country_id='+country_id+'&month='+month+'&mode_id='+mode_id+'&duration='+duration;
				history.replaceState('','',url);
			<!-- END -->
			<!-- START: set data -->
				var data = {
					"action":"refresh_template",
					"country_id":country_id,
					"month":month,
					"mode_id":mode_id,
					"duration":duration
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['wizard/ajax_trip']; ?>", data, function(json) {
					runRefreshTemplate(json);
				}, "json");
			<!-- END -->
		<!-- END -->
	}
	
	function runRefreshTemplate(json) {
		if(isset(json)) {
			for(i=0;i<=json.template.length;i++) {
				if(i==json.template.length) {
					$('.content-body-result-loading').fadeOut();
					if(json.template.length > 0) {
						$('.content-body-result-empty').hide();
						$('.content-body-result-list').fadeIn();
						$('.btn-set-filter').removeClass('hidden');
						$('.content-body-optional').removeClass('hidden');
						if(json.template.length > 1) { var text_result = 'results'; } else { var text_result = 'result'; }
						$('.text-num-of-result').html(json.template.length+' '+text_result);
					}
				}
				else {
					printTemplate(json.template[i],i);
				}
			}
		}
	}
	
	function printTemplate(data,index) {
		<!-- START: [variable] -->
		<!-- END -->
		<!-- START: [text] -->
			if(data.mode_id == 1) {
				text_transport = 'By public transport';
			}
			else if(data.mode_id == 2) {
				text_transport = 'By car';
			}
			else if(data.mode_id == 3) {
				text_transport = 'By walking';
			}
			
			var text_month = '';
			var month = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
			var month2 = ["JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"];
			if(isset(data.month)) {
				for(m=0;m<data.month.length;m++) {
					text_month += month[data.month[m]-1];
					if(m<data.month.length-1) { text_month += ', '; }
				}
			}
			
			var text_unit_day = 'DAY';
			if(data.num_of_day > 1) { text_unit_day = 'DAYS'; }
			
			var text_date_update = '';
			text_date_update = fromNow(data.date_modified);
			
			<!-- START: -->
				var country_id = $('#modal-trip-new-form select[name=country_id]').val();
				var month = $('#modal-trip-new-form select[name=month]').val();
				var mode_id = $('#modal-trip-new-form select[name=mode_id]').val();
				var duration = $('#modal-trip-new-form select[name=duration]').val();
			<!-- END -->
			<!-- START: -->
				var url = "<?php echo $link['wizard/template']; ?>" + "&index=" + index + "&country_id=" + country_id + "&month=" + month + "&mode_id=" + mode_id + "&duration=" + duration;
			<!-- END -->
		<!-- END -->
		<!-- START: [content] -->
			content = ''
				+ '<div class="ca-row result-template">'
					+ '<a href="'+url+'">'
						+ '<div class="row padding">'
							+ '<div class="col-xs-12 text-left">'
								+ '<div class="ca-text ca-text-sub">' 
									+ '<div class="row">'
										+ '<div class="col-xs-6 text-left">'
											+ '<span class="label label-success">'+data.num_of_day+' '+text_unit_day+'</span>'
										+ '</div>'
										+ '<div class="col-xs-6 text-right">'
											+ 'Updated ' + text_date_update
										+ '</div>'
									+ '</div>'
								+ '</div>'
								+ '<div class="ca-text ca-text-main">' 
									+ data.name
								+ '</div>'
								+ '<div class="ca-text ca-text-sub">' 
									+ text_month
								+ '</div>'
								+ '<div class="ca-text ca-text-sub">' 
									+ text_transport
								+ '</div>'
							+ '</div>'
						+ '</div>'
						+ '<div class="row ca-gallery">'
							+ '<div class="col-xs-6 text-left padding-bottom padding-right">'
								+ '<img class="ca-img" src="resources/template/japan.png"/>'
							+ '</div>'
							+ '<div class="col-xs-6 text-left padding-bottom padding-left">'
								+ '<img class="ca-img" src="resources/template/japan.png"/>'
							+ '</div>'
							+ '<div class="col-xs-6 text-left padding-top padding-right">'
								+ '<img class="ca-img" src="resources/template/japan.png"/>'
							+ '</div>'
							+ '<div class="col-xs-6 text-left padding-top padding-left">'
								+ '<img class="ca-img" src="resources/template/japan.png"/>'
							+ '</div>'
						+ '</div>'
					+ '</a>'
					+ '<form class="result-template-form hidden">'
						+ '<input type="hidden" name="trip_id" value="'+data.trip_id+'"/>'
					+ '</form>'
				+ '</div>'
			;
			$('.content-body-result-list').append(content);
		<!-- END -->
	}
	
	$('#modal-trip-new-form').on('change',function() {
		refreshTemplate();
	});
	
	refreshTemplate();
</script>