<style>
	/* START: wrapper-menu */
		#wrapper-menu {
			position:relative;
			z-index:1000;
			border-top:solid thin #EEE;
			text-align:left;
		}
		
		#wrapper-menu-modal-background {
			position:absolute;
			top:0;
			left:0;
			height:calc(100vh - 48px);
			width:calc(100vw);
			background-color:#000;
			opacity:0.2;
			display:none;
		}
		
		#wrapper-menu-modal-body {
			position:absolute;
			top:0;
			left:0;
		}
		
		#wrapper-menu-modal-shadow {
			position:absolute;
			top:6px;
			left:0;
			width:100%;
			height:calc(100vh - 48px - 6px);
			display:none;
		}
		
		#wrapper-menu-modal-content {
			position:absolute;
			top:0;
			left:0;
			width:100%;
			height:calc(100vh - 48px);
			padding:15px 0;
			background-color:#FFF;
			display:none;
		}
		
		#wrapper-menu ul {
			width:100%;
		}
		
		#wrapper-menu li {
			height:40px;
			width:100%;
			line-height:30px;
		}
		
		#wrapper-menu li a {
			padding:5px 15px;
			display:block;
			width:100%;
			color:#777;
		}
		
		#wrapper-menu li.active a {
			color:#fff;
			background-color:#e93578;
		}
		
		#wrapper-menu li a:hover {
			color:#fff;
			background-color:#e93578;
		}
		
		.menu-subtitle {
			padding:5px 15px;
			display:block;
			width:100%;
			color:#777;
			font-weight:bold;
		}
	/* END */


	#wrapper-menu-modal-content a.disabled {
		pointer-events: none;
		cursor: default;
		color:#AAA;
	}
	
	#wrapper-menu-modal-content a.disabled:hover {
		background-color:transparent;
	}
</style>

<div id="wrapper-menu">
	<div id="wrapper-menu-modal-background" onclick="hide_wrapper_menu();" style="max-width:400px !important;">
    </div>
    <div id="wrapper-menu-modal-body" class="col-xs-12">
    	<div id="wrapper-menu-modal-shadow" class="box-shadow">
        </div>
    	<div id="wrapper-menu-modal-content">
            <ul>
            	<!-- START: [desktop view] -->
                	<li class="menu-subtitle">My Trip</li>
                    <li class="menu-itinerary-list">
                        <a onclick="hide_wrapper_menu(); verify_new_trip_condition();">
                            <i class="fa fa-fw fa-file"></i>
                            <i class="fa fa-fw"></i>
                            New Trip
                        </a>
                    </li>
                    <li class="menu-itinerary-list">
                        <a onclick="hide_wrapper_menu(); verify_load_trip_condition();">
                            <i class="fa fa-fw fa-folder-open"></i>
                            <i class="fa fa-fw"></i>
                            Open
                        </a>
                    </li>
                    <li class="menu-itinerary-list">
                        <a onclick="hide_wrapper_menu(); verify_save_trip_condition();">
                            <i class="fa fa-fw fa-floppy-o"></i>
                            <i class="fa fa-fw"></i>
                            Save
                        </a>
                    </li>
                    <li class="menu-itinerary-list hidden">
                        <?php
                            if($this->session->data['memory'] == 'cookie') {
                                $disabled = 'disabled';
                            }
                            echo '<a class="'.$disabled.'" data-toggle="modal" data-target="#modal-trip-share" onclick="hide_wrapper_menu();">';
                        ?>
                            <i class="fa fa-fw fa-share-alt"></i>
                            <i class="fa fa-fw"></i>
                            Share
                        </a>
                    </li>
                    <li class="menu-itinerary-list">
                        <?php
                            if($this->session->data['memory'] == 'cookie') {
                                $disabled = 'disabled';
                            }
                            echo '<a class="'.$disabled.'" onclick="hide_wrapper_menu(); verify_remove_trip_condition();">';
                        ?>
                            <i class="fa fa-fw fa-archive"></i>
                            <i class="fa fa-fw"></i>
                            Remove to Archive
                        </a>
                    </li>
                    <hr class="menu-itinerary-list hidden"/>
                    <li class="menu-itinerary-list hidden active">
                        <a>
                            <i class="fa fa-fw fa-file-text"></i>
                            <i class="fa fa-fw"></i>
                            Itinerary
                        </a>
                    </li>
                    <li class="menu-itinerary-list hidden">
                        <a>
                            <i class="fa fa-fw fa-user"></i>
                            <i class="fa fa-fw"></i>
                            Member
                        </a>
                    </li>
                <!-- END -->
                <!-- START: [mobile view] -->
                	<hr class="menu-itinerary-list"/>
                    <li class="menu-subtitle">My Account</li>
                    <?php if($this->user->isLogged() == false) { ?>
                        <!-- START: [not logged] -->
                            <li class="menu-account-list">
                                <a data-toggle='modal' data-target='#modal-account-signup' onclick="hide_wrapper_account();">
                                    <i class="fa fa-fw fa-pencil-square-o"></i>
                                    <i class="fa fa-fw"></i>
                                    Sign Up
                                </a>
                            </li>
                            <li class="menu-account-list">
                                <a data-toggle='modal' data-target='#modal-account-login' onclick="hide_wrapper_account();">
                                    <i class="fa fa-fw fa-sign-in"></i>
                                    <i class="fa fa-fw"></i>
                                    Log In
                                </a>
                            </li>
                        <!-- END -->
                    <?php } else { ?>
                        <!-- START: [logged] -->
                            <li class="menu-account-list">
                                <a data-toggle='modal' data-target='#modal-account-detail' onclick="hide_wrapper_account();">
                                    <i class="fa fa-fw fa-user"></i>
                                    <i class="fa fa-fw"></i>
                                    My Account
                                </a>
                            </li>
                            <li class="menu-account-list">
                                <a onclick="logout();">
                                    <i class="fa fa-fw fa-sign-out"></i>
                                    <i class="fa fa-fw"></i>
                                    Log Out
                                </a>
                            </li>
                        <!-- END -->
                    <?php } ?>
                <!-- END -->
            </ul>
        </div>
    </div>
</div>

<!-- START: [modal] -->
	<?php echo $modal_trip_new; ?>
    <?php echo $modal_trip_load; ?>
    <?php echo $modal_trip_save; ?>
    <?php echo $modal_trip_delete; ?>
    <?php echo $modal_trip_remove; ?>
    <?php echo $modal_trip_share; ?>
    <?php echo $modal_trip_quota; ?>
<!-- END -->

<script>
	function toggle_wrapper_menu() {
		if(document.getElementById('wrapper-menu-modal-background').style.display == 'block') {
			hide_wrapper_menu();
		}
		else {
			show_wrapper_menu();
		}
	}
	
	function show_wrapper_menu() {
		<!-- START: animation -->
			$('#wrapper-menu').show();
			$('#wrapper-menu-modal-background').fadeIn();
			$('#wrapper-menu-modal-shadow').slideDown('fast');
			$('#wrapper-menu-modal-content').slideDown('fast');
		<!-- END -->
		
		<!-- START: Hide tooltip -->
			var id = $('#wrapper-menu-icon').attr('aria-describedby');
			$('#'+id).hide();
			$('#wrapper-menu-icon').attr('data-original-title', 'Close Menu');
		<!-- END -->
	}
	
	function hide_wrapper_menu() {
		<!-- START: animation -->
			$('#wrapper-menu-modal-background').fadeOut();
			$('#wrapper-menu-modal-shadow').slideUp('fast');
			$('#wrapper-menu-modal-content').slideUp('fast');
		<!-- END -->
		
		<!-- START: Hide tooltip -->
			var id = $('#wrapper-menu-icon').attr('aria-describedby');
			$('#'+id).hide();
			$('#wrapper-menu-icon').attr('data-original-title', 'Open Menu');
		<!-- END -->
	}
</script>