<style>
	#modal-trip-load-left-panel {
		padding-right:15px;
	}
	#modal-trip-load-right-panel {
		min-height:350px;
		border-left:thin solid rgb(229, 229, 229);
		padding-left:5px;
	}
	
	/* START: [nav] */
		#modal-trip-load .nav .text {
			padding:5px 15px;
			display:block;
		}
		
		#modal-trip-load .nav li > a {
			margin:0;
			color:#777;
			background-color:#FFF;
			padding:10px 15px 10px 10px;
			border-left:solid thick #FFF;
		}
		
		#modal-trip-load .nav li > a:hover {
			color:#333;
			background-color:#FFF;
			border-left:solid thick #EEE;
		}
		
		#modal-trip-load .nav li > a:focus {
			color:#333;
			background-color:#FFF;
		}
		
		#modal-trip-load .nav li.active > a {
			background-color:#FFF;
			padding:10px 15px 10px 10px;
			font-weight:bold;
			color:#333;
			cursor:default;
			border-left:solid thick #e93578;
		}
		
		#modal-trip-load .nav li.active > a:hover {
			background-color:#FFF;
		}
		
		#modal-trip-load .nav .progress {
			width:80%;
			margin:0px 15px;
		}
		
		#modal-trip-load .nav .progress-bar {
			background-color:#e93578;
		}
		
		#modal-trip-load .nav .btn-nav {
			padding:0 15px;
		}
		
		#modal-trip-load .tab-header {
			padding:0px 15px;
		}
		
		#modal-trip-load .tab-header .tab-title {
			padding:10px 0px 10px 10px;
			color:#333;
			font-weight:bold;
		}
		
		#modal-trip-load .tab-content {
			padding:0px 15px 10px 15px;
		}
	/* END */
	
	/* START: [list] */
		#modal-trip-load .trip-list .trip {
			margin:10px 0;
			padding:10px 0px 10px 10px;
			border-bottom:solid thin #EEE;
		}
		
		#modal-trip-load .trip-list .trip.selected a {
			cursor:default;
			pointer-events:none;
			color:#777;
		}
		
		#modal-trip-load .trip-list .trip:last-child {
			border-bottom:none;
		}
		
		#modal-trip-load .trip-list .trip .btn {
			margin:0 5px;
			padding:0 5px;
		}
	/* END */
</style>

<!-- START: Modal -->
    <div class="modal fade" id="modal-trip-load" role="dialog" data-backdrop="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title">Trips</h4>
                </div>
            <div class="modal-body">
            	<div class="row">
                    <div class="col-xs-6 col-md-4" id="modal-trip-load-left-panel">
                    	<ul class="nav nav-pills nav-stacked">
                        	<li class="active"><a data-toggle="pill" href="#trip_all">All Trips</a></li>
                            <li class="hidden"><a data-toggle="pill" href="#trip_my">Created by me</a></li>
                            <li class="hidden"><a data-toggle="pill" href="#trip_other">Shared with me</a></li>
                            <li><a data-toggle="pill" href="#trip_archive">Archive</a></li>
                            <li><hr /></li>
                            <li><span class="text"><b>Usage</b></span></li>
                            <li class="progress-for-trip">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </li>
                            <li class="progress-for-trip">
                            	<span class="text small">
                                	<span class="num_of_active_trip"></span>
                                    &nbsp;/&nbsp;
                                    <span class="max_active_trip"></span>
                                    &nbsp;Active Trips
                                </span>
                            </li>
                            <li class="progress-for-archive">
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="" aria-valuemin="0" aria-valuemax="100"></div>
                                </div>
                            </li>
                            <li class="progress-for-archive">
                            	<span class="text small">
                                	<span class="num_of_removed_trip"></span>
                                    &nbsp;/&nbsp;
                                    <span class="max_removed_trip"></span>
                                    &nbsp;Inactive Trips
                                </span>
                            </li>
                            <li><div class="btn-nav small"><a class="btn btn-sm btn-block btn-success" data-dismiss="modal" data-toggle="modal" data-target="#modal-account-upgrade">Upgrade Account</a></div></li>
                        </ul>
                    </div>
                    <div class="col-xs-6 col-md-8" id="modal-trip-load-right-panel">
                        <div id="modal-trip-load-form-alert"></div>
                        <div class="tab-header">
                        	<div class="row">
                                <div class="col-xs-6 tab-title">All Trips</div>
                                <div class="col-xs-6 text-right btn-for-trip"><a class="btn btn-primary" data-dismiss="modal" data-toggle="modal" onclick="verify_new_trip_condition();">Create New Trip</a></div>
                                <div class="col-xs-6 text-right btn-for-archive"><a class="btn btn-danger" onclick="cleanArchive();">Clean Archive</a></div>
                            </div>
                        </div>
                    	<div class="tab-content">
                        	<div id="trip_all" class="tab-pane active trip-list"></div>
                            <div id="trip_my" class="tab-pane trip-list"></div>
                            <div id="trip_other" class="tab-pane trip-list"></div>
                            <div id="trip_archive" class="tab-pane trip-list"></div>
                        </div>
                		<?php echo $modal_component['form']; ?>
                    </div>
                </div>
            </div>
                <div class="modal-footer">
                	<div class="row">
                        <div class="col-xs-12 col-sm-3 col-md-2 pull-right">
                            <button type="button" class="btn btn-block btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<!-- START: Script -->
<script>
	function loadTrip() {
		var form_element = document.querySelector("#modal-trip-load-form");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $modal_ajax; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				<!-- if connection success -->
				var json = JSON.parse(xmlhttp.responseText);
				
				if(typeof json.warning != 'undefined') {
					<!-- if error -->
					var content;
					content = "<div class='alert alert-danger'><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					var alert_text = content;
					document.getElementById('modal-trip-load-form-alert').innerHTML = alert_text;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					$('.progress-for-trip .progress-bar').css('width',json.usage_of_trip+'%');
					$('.progress-for-trip .progress-bar').attr('aria-valuenow',json.usage_of_trip);
					$('.progress-for-trip .num_of_active_trip').html(json.num_of_active_trip);
					$('.progress-for-trip .max_active_trip').html(json.max_active_trip);
					$('.progress-for-archive .progress-bar').css('width',json.usage_of_archive+'%');
					$('.progress-for-archive .progress-bar').attr('aria-valuenow',json.usage_of_archive);
					$('.progress-for-archive .num_of_removed_trip').html(json.num_of_removed_trip);
					$('.progress-for-archive .max_removed_trip').html(json.max_removed_trip);
					
					<!-- START: [all trips] -->
						var current_code = "<?php echo $this->trip->getCode(); ?>";
						var content = '';
						if(json.num_of_active_trip > 0) {
							for(i=0;i<json.num_of_active_trip;i++) {
								if(current_code == json.active_trip[i].code) { var selected = 'selected'; } else { var selected = ''; }
								content += ''
									+ '<div class="trip row '+selected+'">'
										+ '<div class="col-xs-7">'
											+ '<div class="row">'
												+ '<div class="col-xs-12">'
													+ '<a href="'+json.active_trip[i].url+'"><b>'+json.active_trip[i].name+'</b></a>&nbsp;'
													+ '<i data-toggle="tooltip" data-placement="top" title="'+json.active_trip[i].status.name+'" class="fa fa-fw fa-circle" style="color:'+json.active_trip[i].status.color+';"></i>'
												+ '</div>'
												+ '<div class="col-xs-12">'
													+ '<span class="small">Created by <b>'+json.active_trip[i].username+'</b></span>'
												+ '</div>'
											+ '</div>'
										+ '</div>'
										+ '<div class="col-xs-5">'
								;
								if(selected == 'selected') {
									content += ''
										+ '<a class="btn" href="'+json.active_trip[i].url+'">Editing</a>'
									;
								}
								else {
									content += ''
											+ '<a class="btn" onclick="removeTripByTripId(\''+json.active_trip[i].trip_id+'\');">Remove</a>'
											+ '<a class="btn" href="'+json.active_trip[i].url+'">Edit</a>'
									;
								}
								content += ''
										+ '</div>'
									+ '</div>'
								;
							}
						}
						else {
							content = '<div class="trip row">No existing trip</div>';
						}
						$('#trip_all').html(content);
						$('#trip_my').html(content);
					<!-- END -->
					
					<!-- START: [removed trips] -->
						var content = '';
						if(json.num_of_removed_trip > 0) {
							for(i=0;i<json.num_of_removed_trip;i++) {
								content += ''
									+ '<div class="trip row">'
										+ '<div class="col-xs-7">'
											+ '<div class="row">'
												+ '<div class="col-xs-12">'
													+ '<span><b>'+json.removed_trip[i].name+'</b></span>&nbsp;'
												+ '</div>'
												+ '<div class="col-xs-12">'
													+ '<span class="small">Created by <b>'+json.removed_trip[i].username+'</b></span>'
												+ '</div>'
											+ '</div>'
										+ '</div>'
										+ '<div class="col-xs-5">'
											+ '<a class="btn" onclick="deleteTripByTripId(\''+json.removed_trip[i].trip_id+'\');">Delete</a>'
											+ '<a class="btn" onclick="restoreTripByTripId(\''+json.removed_trip[i].trip_id+'\');">Restore</a>'
										+ '</div>'
									+ '</div>'
								;
							}
						}
						else {
							content = '<div class="trip row">No existing trip</div>';
						}
						$('#trip_archive').html(content);
					<!-- END -->
					
					<!-- START: init tooltip -->
						$('#modal-trip-load .fa-circle').tooltip();
					<!-- END -->
				}
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function restoreTripByTripId(trip_id) {
		<!-- START: set data -->
			var data = {
				"action":"restore_trip",
				"trip_id":trip_id,
				"user_id":"<?php echo $this->user->getUserId(); ?>",
				"role_id":"<?php echo $this->user->getRoleId(); ?>"
			};
		<!-- END -->
	
		<!-- START: send POST -->
			$.post("<?php echo $modal_ajax; ?>", data, function(json) {
				if(typeof json.warning != 'undefined') {
					var content;
					content = "<div class='alert alert-danger'><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					var alert_text = content;
					$('#modal-trip-load-form-alert').html(alert_text);
				}
				else {
					$('#modal-trip-load-form-alert').html('<div class="alert alert-success"><b>Trip has been restored</b></div>');
					loadTrip();
				}
			}, "json");
		<!-- END -->
	}
	
	function removeTripByTripId(trip_id) {
		<!-- START: set data -->
			var data = {
				"action":"remove_trip",
				"trip_id":trip_id,
				"user_id":"<?php echo $this->user->getUserId(); ?>",
				"role_id":"<?php echo $this->user->getRoleId(); ?>"
			};
		<!-- END -->
	
		<!-- START: send POST -->
			$.post("<?php echo $modal_ajax; ?>", data, function(json) {
				if(typeof json.warning != 'undefined') {
					var content;
					content = "<div class='alert alert-danger'><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					var alert_text = content;
					$('#modal-trip-load-form-alert').html(alert_text);
				}
				else {
					$('#modal-trip-load-form-alert').html('<div class="alert alert-success"><b>Trip has been removed</b></div>');
					loadTrip();
				}
			}, "json");
		<!-- END -->
	}
	
	function deleteTripByTripId(trip_id) {
		<!-- START: set data -->
			var data = {
				"action":"delete_trip",
				"trip_id":trip_id,
				"user_id":"<?php echo $this->user->getUserId(); ?>"
			};
		<!-- END -->
	
		<!-- START: send POST -->
			$.post("<?php echo $modal_ajax; ?>", data, function(json) {
				if(typeof json.warning != 'undefined') {
					var content;
					content = "<div class='alert alert-danger'><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					var alert_text = content;
					$('#modal-trip-load-form-alert').html(alert_text);
				}
				else {
					$('#modal-trip-load-form-alert').html('<div class="alert alert-success"><b>Trip has been deleted</b></div>');
					loadTrip();
				}
			}, "json");
		<!-- END -->
	}
	
	function cleanArchive() {
		<!-- START: set data -->
			var data = {
				"action":"clean_archive",
				"user_id":"<?php echo $this->user->getUserId(); ?>"
			};
		<!-- END -->
	
		<!-- START: send POST -->
			$.post("<?php echo $modal_ajax; ?>", data, function(json) {
				if(typeof json.warning != 'undefined') {
					var content;
					content = "<div class='alert alert-danger'><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					var alert_text = content;
					$('#modal-trip-load-form-alert').html(alert_text);
				}
				else {
					$('#modal-trip-load-form-alert').html('<div class="alert alert-success"><b>Archive has been cleaned</b></div>');
					loadTrip();
				}
			}, "json");
		<!-- END -->
	}
	
	function verify_load_trip_condition() {
		<?php if($this->user->isLogged() == false) { ?>
			$('#modal-account-login').modal('show');
			$('#modal-account-login-form-alert').html('<div class="alert alert-info">You need to log in to perform this action.</div>');
		<?php } else { ?>
			$('#modal-trip-load').modal('show');
			loadTrip();
		<?php } ?>
	}
	
	$("#modal-trip-load").on( "hidden.bs.modal", function() { 
		$('#modal-trip-load-form-alert').html('');
	});
	
	$('#modal-trip-load-left-panel ul li a').on('click',function() {
		<!-- START: [alert] -->
			$('#modal-trip-load-form-alert').html('');
		<!-- END -->
		<!-- START: [tab title] -->
			$('#modal-trip-load .tab-title').html($(this).html());
		<!-- END -->
		<!-- START: [progress] -->
			var tab = $(this).attr('href');
			if(tab == '#trip_archive') {
				$('.progress-for-trip').hide();
				$('.progress-for-archive').show();
				$('.btn-for-trip').hide();
				$('.btn-for-archive').show();
			}
			else {
				$('.progress-for-trip').show();
				$('.progress-for-archive').hide();
				$('.btn-for-trip').show();
				$('.btn-for-archive').hide();
			}
		<!-- END -->
	});
	
	$('.progress-for-archive').hide();
	$('.btn-for-archive').hide();
</script>
<!-- END -->