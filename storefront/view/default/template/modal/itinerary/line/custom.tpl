<style>
	#modal-line-custom .header-secondary {
	}
	
	#modal-line-custom .header-secondary .btn {
		color:#999;
	}
	
	#modal-line-custom .header-secondary .btn:hover {
		color:#000;
	}
	
	#modal-line-custom .header-secondary .btn.active {
		color:#e93578;
		cursor:default;
		pointer-events:none;
	}
	#modal-line-custom  .modal-body {
		background-color:#EEE;
	}
	#modal-line-custom  #line-map {
		height:calc(100vh - 180px);
		background-color:#666;
	}
	#modal-line-custom .form-spacer {
		height:10px;
		border-bottom:solid thin #DDD;
	}
	#modal-line-custom .image {
		background-color:#EEE;
		height:calc(100vh - 130px);
		width:100%;
		text-align:center;
		padding-top:30px;
	}
	#modal-line-custom .image img {
		background-color:#999;
		height:200px;
		width:200px;
		border:solid thin #DDD;
		border-radius:150px;
	}
	#modal-line-custom label {
		background-color:#FFF;
		color:#999;
		height:50px;
		width:100%;
		margin:0;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
		font-weight:normal;
	}
	#modal-line-custom input, #modal-line-custom select {
		background-color:#FFF;
		color:#000;
		height:50px;
		width:100%;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
	}
	#modal-line-custom input:disabled {
		color:#999;
	}
	#modal-line-custom select {
		-webkit-appearance: none;
		-webkit-border-radius: 0px;
	}
	#modal-line-custom textarea {
		height:calc(100vh - 130px);
		width:100%;
		padding:15px;
		border:none;
		border-bottom:solid thin #EEE;
		outline:none;
	}
	#modal-line-custom .icon-disabled {
		position:absolute;
		background-color:#FFF;
		color:#999;
		height:50px;
		padding:15px;
		top:0;
		right:0;
		border-bottom:solid thin #DDD;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-line-custom" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-line-map-header-add" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Add Activity</div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom"onclick="saveModalLineCustomForm('add');">Save</a>
                    </div>
                </div>
                <div id="modal-line-map-header-edit" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Edit Activity</div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-custom" onclick="saveModalLineCustomForm('edit');">Save</a>
                    </div>
                </div>
                <div class="header header-secondary header-white fixed-bar fixed-width row">
                	<div class="col-xs-3">
                    	<a class="btn btn-block btn-general" onclick="selectModalLineCustomTab('general');"><i class="fa fa-fw fa-lg fa-pencil"></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-time" onclick="selectModalLineCustomTab('time');"><i class="fa fa-fw fa-lg fa-clock-o"></i></a>
                    </div>
                    <div class="col-xs-3 hidden">
                    	<a class="btn btn-block btn-location" onclick="selectModalLineCustomTab('location');"><i class="fa fa-fw fa-lg fa-map-marker"></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-photo" onclick="selectModalLineCustomTab('photo');"><i class="fa fa-fw fa-lg fa-picture-o"></i></a>
                    </div>
                    <div class="col-xs-3 hidden">
                    	<a class="btn btn-block btn-fee" onclick="selectModalLineCustomTab('fee');"><i class="fa fa-fw fa-lg"><b>&#36;</b></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-more" onclick="selectModalLineCustomTab('more');"><i class="fa fa-fw fa-ellipsis-v"></i></a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    	<form id="modal-line-custom-form">
                        	<input type="hidden" name="line_id"/>
                            <input type="hidden" name="day_id"/>
                            <input type="hidden" name="sort_order"/>
                        	<div class="tab tab-general">
                                <div class="row">
                                	<div class="col-xs-12"><input type="text" name="title" placeholder="Title" /></div>
                                </div>
                                <textarea name="description" placeholder="Description"></textarea>
                            </div>
                            <div class="tab tab-time">
                                <div class="row hidden">
                                	<div class="col-xs-4"><label for="duration">Duration</label></div>
                                	<div class="col-xs-4"><input type="number" name="duration"/></div>
                                    <div class="col-xs-4"><label class="unit-duration" for="duration">mins</label></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="hrs">Duration</label></div>
                                	<div class="col-xs-2">
                                    	<select name=hrs>
                                        	<?php
                                            	for($i=0;$i<=23;$i++) {
                                                	echo '<option value="'.$i.'">'.$i.'</option>';
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div class="col-xs-2"><label class="unit-duration" for="hrs">hrs</label></div>
                                	<div class="col-xs-2">
                                    	<select name=mins>
                                        	<?php
                                            	for($i=0;$i<=59;$i++) {
                                                	echo '<option value="'.$i.'">'.$i.'</option>';
                                                }
                                            ?>
                                        </select>
                                    </div>
                                    <div class="col-xs-2"><label class="unit-duration" for="mins">mins</label></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="time">Time (From)</label></div>
                                	<div class="col-xs-8"><input type="time" name="time"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="time_to">Time (To)</label></div>
                                	<div class="col-xs-4"><input type="time" name="time_to"/></div>
                                    <div class="col-xs-4"><label class="unit-time-to" for="time_to">+ 1 day</label></div>
                                </div>
                            </div>
                            <div class="tab tab-fee">
                            	<div class="row">
                                </div>
                            </div>
                            <div class="tab tab-location">
                            	<div class="row">
                                	<div class="col-xs-4"><label for="lat">Latitude</label></div>
                                	<div class="col-xs-8"><input type="number" name="lat"/></div>
                                </div>
                                <div class="row">
                                	<div class="col-xs-4"><label for="lng">Longitude</label></div>
                                	<div class="col-xs-8"><input type="number" name="lng"/></div>
                                </div>
                                <div id="line-map">
                                </div>
                            </div>
                            <div class="tab tab-photo">
                            	<div class="row">
                                	<div class="col-xs-12 hidden"><input type="text" name="image_id"/></div>
                                	<div class="col-xs-12">
                                    	<input type="text" name="photo" placeholder="Place your photo url here" disabled/>
                                        <div class="icon-disabled"><i class="fa fa-fw fa-lock"></i></div>
                                    </div>
                                </div>
                                <div class="image">
                                	<img src="" onerror="this.onerror = '';this.src = 'resources/image/error/noimage.png';" />
                                </div>
                            </div>
                            <div class="tab tab-more">
                            	<ul class="menu menu-white">
                                	<li onclick="selectModalLineCustomTab('location');">
                                    	<i class="fa fa-fw fa-lg fa-map-marker"></i>
                                        <i class="fa fa-fw"></i>
                                        Location
                                    </li>
                                    <li class="hidden" onclick="selectModalLineCustomTab('photo');">
                                    	<i class="fa fa-fw fa-lg fa-picture-o"></i>
                                        <i class="fa fa-fw"></i>
                                        Photo
                                    </li>
                                    <li class="button-delete-activity text-danger" data-toggle="modal" data-target="#modal-line-delete">
                                    	<i class="fa fa-fw fa-lg fa-trash"></i>
                                        <i class="fa fa-fw"></i>
                                        Delete Activity
                                    </li>
                                </ul>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function setModalLineCustomForm(line_id) {
		$('#modal-line-custom-form').trigger("reset");
		$('#modal-line-custom-form input[type=hidden]').val('');
		
		var line = {
			day_id		: $('#plan-line-'+line_id+'-form-hidden input[name=day_id]').val(),
			sort_order	: $('#plan-line-'+line_id+'-form-hidden input[name=sort_order]').val(),
			title		: $('#plan-line-'+line_id+'-form-hidden input[name=title]').val(),
			description	: $('#plan-line-'+line_id+'-form-hidden input[name=description]').val(),
			duration	: $('#plan-line-'+line_id+'-form-hidden input[name=duration]').val(),
			time		: $('#plan-line-'+line_id+'-form-hidden input[name=time]').val(),
			lat			: $('#plan-line-'+line_id+'-form-hidden input[name=lat]').val(),
			lng			: $('#plan-line-'+line_id+'-form-hidden input[name=lng]').val(),
			photo		: $('#plan-line-'+line_id+' .image img').attr('src'),
			image_id	: $('#plan-line-'+line_id+'-form-hidden input[name=image_id]').val()
		};
		
		$('#modal-line-custom input[name=line_id]').val(line_id);
		$('#modal-line-custom input[name=day_id]').val(line.day_id);
		$('#modal-line-custom input[name=sort_order]').val(line.sort_order);
		$('#modal-line-custom input[name=title]').val(line.title);
		$('#modal-line-custom textarea[name=description]').val(line.description);
		$('#modal-line-custom input[name=duration]').val(line.duration);
		$('#modal-line-custom input[name=time]').val(line.time);
		$('#modal-line-custom input[name=lat]').val(line.lat);
		$('#modal-line-custom input[name=lng]').val(line.lng);
		$('#modal-line-custom input[name=photo]').val(line.photo);
		$('#modal-line-custom input[name=image_id]').val(line.image_id);
		
		$('#modal-line-custom input[name=duration]').trigger('change');
		$('#modal-line-custom input[name=duration]').trigger('blur');
		$('#modal-line-custom input[name=photo]').trigger('change');
	}
	
	function saveModalLineCustomForm(mode) {
		var line_id = $('#modal-line-custom input[name=line_id]').val();
		var day_id = $('.swiper-slide-active .plan-day-form-hidden input[name=day_id]').val();
		var sort_order = $('.swiper-slide-active .plan-line').length + 1; 
		
		if(mode=='edit') {
			day_id = $('#modal-line-custom input[name=day_id]').val();
			sort_order = $('#modal-line-custom input[name=sort_order]').val();
		}
		
		<!-- START: set line_id for Cookie -->
		if(mode=='add') {
		  <?php if($this->session->data['memory'] == 'cookie') { ?>
			  var line_id = 0;
			  var i = 1;
			  while(line_id < 1) {
				  var check_id = $("#plan-line-" + i + "-form-hidden").length;
				  if (check_id < 1) { line_id = i; }
				  i ++;
				  if(i > 100) { break; }
			  };
		  <?php } ?>
		}
		<!-- END -->
	  
		var line_raw = {
			line_id		: line_id,
			day_id		: day_id,
			sort_order	: sort_order,
			title 		: $('#modal-line-custom input[name=title]').val()||null,
			description	: $('#modal-line-custom textarea[name=description]').val()||null,
			duration	: $('#modal-line-custom input[name=duration]').val()||null,
			time		: $('#modal-line-custom input[name=time]').val()||null,
			lat			: $('#modal-line-custom input[name=lat]').val()||null,
			lng			: $('#modal-line-custom input[name=lng]').val()||null,
			photo		: $('#modal-line-custom input[name=photo]').val()||null,
			image_id	: $('#modal-line-custom input[name=image_id]').val()||null
		};
		
		var line = {
			line_id		: line_raw.line_id,
			day_id		: line_raw.day_id,
			sort_order	: line_raw.sort_order,
			title		: line_raw.title,
			description : line_raw.description,
			duration	: convertLineDurationFormat(line_raw.duration),
			time		: convertLineTimeFormat(line_raw.time),
			lat			: line_raw.lat,
			lng			: line_raw.lng,
			photo		: line_raw.photo,
			image_id	: line_raw.image_id
		}
		
		if(mode=='edit') {
			<!-- START: edit existing line -->
				<?php if($this->session->data['memory'] == 'cookie') { ?>
					runEditPlanLine(line,line_raw);
				<?php } else { ?>
					<!-- START: set data -->
						var data = {
							"action":"edit_line",
							"line":line
						};
					<!-- END -->
				
					<!-- START: send POST -->
						$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
							if(typeof json.warning != 'undefined') {
								showHint(json.warning);
							}
							else if(typeof json.success != 'undefined') {
								runEditPlanLine(line,line_raw);
							}
						}, "json");
					<!-- END -->
				<?php } ?>
			<!-- END -->
		}
		else {
			<!-- START: add new line -->
				<?php if($this->session->data['memory'] == 'cookie') { ?>
					runAddPlanLine(line,line_raw);
				<?php } else { ?>
					<!-- START: set data -->
						var data = {
							"action":"add_line",
							"line":line_raw
						};
					<!-- END -->
				
					<!-- START: send POST -->
						$.post("<?php echo $ajax_itinerary; ?>", data, function(json) {
							if(typeof json.warning != 'undefined') {
								showHint(json.warning);
							}
							else if(typeof json.success != 'undefined') {
								line.line_id = json.line_id;
								line_raw.line_id = json.line_id;
								runAddPlanLine(line,line_raw);
							}
						}, "json");
					<!-- END -->
				<?php } ?>
			<!-- END -->
		}
	}
</script>
<script>
	function selectModalLineCustomTab(tab) {
		$('#modal-line-custom .header-secondary .btn').removeClass('active');
		$('#modal-line-custom .tab').hide();
		$('#modal-line-custom .btn-'+tab).addClass('active');
		$('#modal-line-custom .tab-'+tab).show();
		$('#modal-line-custom .modal-body').css('background-color','#EEE');
		if(tab == 'more') { 
			$('#modal-line-custom .modal-body').css('background-color','#FFF');
		}
	}
	
	$('#modal-line-custom label').click(function() {
       name = $(this).attr('for');
	   if($('#modal-line-custom input[name='+name+']').length > 0) {
		   $('#modal-line-custom input[name='+name+']').focus();
	   }
	});
	
	function checkPhotoUrl(url) {
		return(url.match(/\.(jpeg|jpg|gif|png)$/) != null);
	}
	
	$('#modal-line-custom input[name=photo]').on('change',function() {
		var url = $('#modal-line-custom input[name=photo]').val();
		if(checkPhotoUrl(url)) {
			$('#modal-line-custom .image img').attr('src',url);
		}
		else {
			$('#modal-line-custom .image img').attr('src','resources/image/error/noimage.png');
		}
	});
	
	<!-- START: [tab-time] -->
		<!-- START: common function -->
			function convertTimeToMinute(time) {
				var hrs = parseInt(time.substring(0, time.indexOf(':')));
				var mins =  parseInt(time.substring(time.indexOf(':')+1));
				return (hrs * 60 + mins);
			}
			
			function convertMinuteToTime(minute) {
				var hrs = Math.floor(minute / 60);          
				var mins = minute % 60;
				hrs = ("0" + hrs).slice(-2);
				mins = ("0" + mins).slice(-2);
				var string = hrs + ':' + mins;
				return (string);
			}
		<!-- END -->
		<!-- START: [time] -->
			$('#modal-line-custom-form input[name=time]').on('blur',function() {
				var time_from = $('#modal-line-custom-form input[name=time]').val();
				var time_to = $('#modal-line-custom-form input[name=time_to]').val();
				var duration = $('#modal-line-custom-form input[name=duration]').val();
				var value;
				
				time_from = convertTimeToMinute(time_from);
				time_to = convertTimeToMinute(time_to);
				
				if((isset(time_from) && isNaN(time_from) != true) || time_from == 0) {
					if(isset(duration)) {
						value = convertMinuteToTime(time_from + parseInt(duration));
						$('#modal-line-custom-form input[name=time_to]').val(value);
					}
					else if((isset(time_to) && isNaN(time_to) != true) || time_to == 0) {
						if(time_to >= time_from) {
							value = time_to - time_from;
							$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
						}
						else {
							value = time_to + 1440 - time_from;
							$('#modal-line-custom-form .unit-time-to').css('color','#000');
						}
						$('#modal-line-custom-form input[name=duration]').val(value);
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
					}
				}
			});
			
			$('#modal-line-custom-form input[name=time_to]').on('blur',function() {
				var time_from = $('#modal-line-custom-form input[name=time]').val();
				var time_to = $('#modal-line-custom-form input[name=time_to]').val();
				var duration = $('#modal-line-custom-form input[name=duration]').val();
				var value;
				
				time_from = convertTimeToMinute(time_from);
				time_to = convertTimeToMinute(time_to);
				
				$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
				
				if((isset(time_to) && isNaN(time_to) != true) || time_to == 0) {
					if((isset(time_from) && isNaN(time_from) != true) || time_from == 0) {
						if(time_to >= time_from) {
							value = time_to - time_from;
						}
						else {
							value = time_to + 1440 - time_from;
							$('#modal-line-custom-form .unit-time-to').css('color','#000');
						}
						$('#modal-line-custom-form input[name=duration]').val(value);
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
					}
					else if(isset(duration)) {
						value = convertMinuteToTime(time_to - parseInt(duration));
						$('#modal-line-custom-form input[name=time]').val(value);
					}
				}
			});
		<!-- END -->
		<!-- START: [duration] -->
			$('#modal-line-custom-form input[name=duration]').on('blur',function() {
				if(isset($(this).val())) {
					$('#modal-line-custom-form select[name=hrs]').val(Math.floor(parseInt($(this).val())/ 60));
					$('#modal-line-custom-form select[name=mins]').val(parseInt($(this).val())%60);
				}
				else {
					$('#modal-line-custom-form select[name=hrs]').val(0);
					$('#modal-line-custom-form select[name=mins]').val(0);
				}
			});
			
			$('#modal-line-custom-form input[name=duration]').on('change',function() {
				var time_from = $('#modal-line-custom-form input[name=time]').val();
				var time_to = $('#modal-line-custom-form input[name=time_to]').val();
				var duration = $('#modal-line-custom-form input[name=duration]').val();
				var value;
				
				time_from = convertTimeToMinute(time_from);
				time_to = convertTimeToMinute(time_to);
				
				if(isset(time_from) && isNaN(time_from) != true) {
					time_to = time_from + parseInt(duration);
					if(time_to >= 1440) {
						time_to = time_to - 1440;
						$('#modal-line-custom-form .unit-time-to').css('color','#000');
					}
					else {
						$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
					}
					value = convertMinuteToTime(time_to);
					$('#modal-line-custom-form input[name=time_to]').val(value);
					
				}
				else if(isset(time_to) && isNaN(time_to) != true) {
					time_from = time_to - parseInt(duration);
					if(time_from < 0) {
						time_from = time_from + 1440;
						$('#modal-line-custom-form .unit-time-to').css('color','#000');
					}
					else {
						$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
					}
					value = convertMinuteToTime(time_from);
					value = convertMinuteToTime(time_from);
					$('#modal-line-custom-form input[name=time]').val(value);
				}
			});
			
			$('#modal-line-custom-form select[name=hrs]').on('change',function() {
				var hrs = $('#modal-line-custom-form select[name=hrs]').val();
				var mins = $('#modal-line-custom-form select[name=mins]').val();
				var duration;
				if(isset(hrs)) {
					if(isset(mins) == false) { 
						mins = 0;
						$('#modal-line-custom-form select[name=mins]').val(mins); 
					}
					duration = parseInt(hrs) * 60 + parseInt(mins);
					$('#modal-line-custom-form input[name=duration]').val(duration);
					$('#modal-line-custom-form input[name=duration]').trigger('blur');
					$('#modal-line-custom-form input[name=duration]').trigger('change');
				}
				else {
					if(isset(mins)) {
						hrs = 0;
						duration = parseInt(hrs) * 60 + parseInt(mins);
						$('#modal-line-custom-form select[name=hrs]').val(0);
						$('#modal-line-custom-form input[name=duration]').val(duration);
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
						$('#modal-line-custom-form input[name=duration]').trigger('change');
					}
					else {
						$('#modal-line-custom-form input[name=duration]').val('');
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
						$('#modal-line-custom-form input[name=duration]').trigger('change');
					}
				}
			});
			
			$('#modal-line-custom-form select[name=mins]').on('change',function() {
				var hrs = $('#modal-line-custom-form select[name=hrs]').val();
				var mins = $('#modal-line-custom-form select[name=mins]').val();
				var duration;
				if(isset(mins)) {
					if(isset(hrs) == false) { 
						hrs = 0;
						$('#modal-line-custom-form select[name=hrs]').val(hrs); 
					}
					duration = parseInt(hrs) * 60 + parseInt(mins);
					$('#modal-line-custom-form input[name=duration]').val(duration);
					$('#modal-line-custom-form input[name=duration]').trigger('blur');
					$('#modal-line-custom-form input[name=duration]').trigger('change');
				}
				else {
					if(isset(hrs)) {
						mins = 0;
						duration = parseInt(hrs) * 60 + parseInt(mins);
						$('#modal-line-custom-form select[name=mins]').val(0);
						$('#modal-line-custom-form input[name=duration]').val(duration);
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
						$('#modal-line-custom-form input[name=duration]').trigger('change');
					}
					else {
						$('#modal-line-custom-form input[name=duration]').val('');
						$('#modal-line-custom-form input[name=duration]').trigger('blur');
						$('#modal-line-custom-form input[name=duration]').trigger('change');
					}
				}
			});
		<!-- END -->
	<!-- END -->
</script>
<script>
	$("#modal-line-custom").on("show.bs.modal", function () {
		if($('#modal-line-custom-form input[name=line_id]').val() == '') {
			$('#modal-line-map-header-add').show();
			$('#modal-line-map-header-edit').hide();
			$('.button-delete-activity').hide();
		}
		else {
			$('#modal-line-map-header-add').hide();
			$('#modal-line-map-header-edit').show();
			$('.button-delete-activity').show();
		}
		selectModalLineCustomTab('general'); 
		$('#modal-line-custom-form .unit-time-to').css('color','#FFF');
		$('#modal-line-custom-form .unit-duration').css('color','#000');
	});
</script>