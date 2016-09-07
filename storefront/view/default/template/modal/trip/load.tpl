<style>
	#modal-trip-load-left-panel {
		padding-right:15px;
	}
	#modal-trip-load-right-panel {
		min-height:350px;
		border-left:thin solid rgb(229, 229, 229);
		padding-left:15px;
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
		
		#modal-trip-load .tab-content {
			padding:0px 15px 10px 15px;
		}
		
		#modal-trip-load .tab-content .tab-title {
			padding:10px 0px;
			color:#333;
		}
	/* END */
	
	/* START: [list] */
		#modal-trip-load .trip-list .trip {
			margin:10px 0;
			padding:10px 0;
			border-bottom:solid thin #EEE;
		}
		
		#modal-trip-load .trip-list .trip:last-child {
			border-bottom:none;
		}
		
		#modal-trip-load .trip-list .trip .btn {
			margin:0 5px;
			padding:0 10px;
		}
	/* END */
</style>

<!-- START: Modal -->
    <div class="modal fade" id="modal-trip-load" role="dialog">
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
                            <li><a data-toggle="pill" href="#trip_my">Created by me</a></li>
                            <li><a data-toggle="pill" href="#trip_other">Shared with me</a></li>
                            <li><a data-toggle="pill" href="#trip_trash">Trash</a></li>
                            <li><hr /></li>
                            <li><span class="text"><b>Usage</b></span></li>
                            <li>
                                <div class="progress">
                                    <div class="progress-bar" role="progressbar" aria-valuenow="<?php echo $usage; ?>" aria-valuemin="0" aria-valuemax="100" style="width: <?php echo $usage; ?>%;"></div>
                                </div>
                            </li>
                            <li>
                            	<span class="text small">
                                	<span><?php echo $num_of_active_trip; ?></span>
                                    &nbsp;/&nbsp;
                                    <span><?php echo $max_active_trip; ?></span>
                                    &nbsp;Trips
                                </span>
                            </li>
                            <li><div class="btn-nav small"><a class="btn btn-sm btn-block btn-success" data-dismiss="modal" data-toggle="modal" data-target="#modal-account-upgrade">Upgrade Account</a></div></li>
                        </ul>
                    </div>
                    <div class="col-xs-6 col-md-8" id="modal-trip-load-right-panel">
                    	<div class="tab-content">
                        	<div id="trip_all" class="tab-pane active trip-list">
                            	<div class="row">
                                	<div class="col-xs-6 tab-title"><b>All Trips</b></div>
                                    <div class="col-xs-6 text-right"><a class="btn btn-primary" data-dismiss="modal" data-toggle="modal" onclick="verify_new_trip_condition();">Create New Trip</a></div>
                                </div>
                                <?php 
                                	foreach($result as $t) { 
                                    	echo '
                                        	<div class="trip row">
                                                <div class="col-xs-9">
                                                	<div class="row">
                                                    	<div class="col-xs-12">
                                                        	<a href="'.$t['url'].'"><b>'.$t['name'].'</b></a>
                                                        </div>
                                                        <div class="col-xs-12">
                                                        	<span class="small">Created by <b>'.$t['username'].'</b></span>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-xs-1">
                                                    <i data-toggle="tooltip" data-placement="top" title="'.$t['status']['name'].'" class="fa fa-fw fa-circle" style="color:'.$t['status']['color'].';"></i>
                                                </div>
                                                <div class="col-xs-2 text-right">
                                                    <a class="btn" href="'.$t['url'].'">Edit</a>
                                                </div>
                                            </div>
                                       	'; 
                                    }
                                    if(count($result) == 0) {
                                    	echo '<div class="trip row">No existing trip</div>';
                                    } 
                                ?>
                            </div>
                            <div id="trip_my" class="tab-pane">
                            	<div><b>Created by me</b></div>
                            </div>
                            <div id="trip_other" class="tab-pane">
                            	<div><b>Shared with me</b></div>
                            </div>
                            <div id="trip_trash" class="tab-pane">
                            	<div><b>Trash</b></div>
                            </div>
                        </div>
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
			var alert_text = "";
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
					alert_text = content;
				}
				else if(typeof json.success != 'undefined') {
					<!-- if success -->
					window.location.reload(true);
				}
				document.getElementById('modal-trip-load-form-alert').innerHTML = alert_text;
			} else {
				<!-- if connection failed -->
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
	
	function verify_load_trip_condition() {
		<?php if($this->user->isLogged() == false) { ?>
			$('#modal-account-login').modal('show');
			$('#modal-account-login-form-alert').html('<div class="alert alert-info">You need to log in to perform this action.</div>');
		<?php } else { ?>
			$('#modal-trip-load').modal('show');
		<?php } ?>
	}
</script>
<!-- END -->