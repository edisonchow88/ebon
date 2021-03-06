<div id="wrapper-account">
	<div id="wrapper-account-modal-background" onclick="hide_wrapper_account();">
    </div>
    <div id="wrapper-account-modal-body" class="col-xs-12 col-sm-6 col-md-3">
    	<div id="wrapper-account-modal-shadow" class="box-shadow">
        </div>
    	<div id="wrapper-account-modal-content">
        	<?php if($logged == true) { ?>
            	<!-- START: if logged -->
                    <ul>
                    	<li>
                            <a data-toggle='modal' data-target='#modal-account-detail' onclick="hide_wrapper_account();">
                                My Account
                            </a>
                        </li>
                        <li>
                            <a onclick="logout();">
                                Log Out
                            </a>
                        </li>
                    </ul>
                <!-- END -->
            <?php } else { ?>
            	<!-- START: if not logged -->
                    <ul>
                        <li>
                            <a data-toggle='modal' data-target='#modal-account-signup' onclick="hide_wrapper_account();">
                                Sign Up
                            </a>
                        </li>
                        <li>
                            <a data-toggle='modal' data-target='#modal-account-login' onclick="hide_wrapper_account();">
                                Log In
                            </a>
                        </li>
                    </ul>
                <!-- END -->
            <?php } ?>
        </div>
    </div>
</div>

<!-- START: [modal] -->
    <?php echo $modal_account_signup; ?>
    <?php echo $modal_account_login; ?>
    <?php echo $modal_account_logout; ?>
    <?php echo $modal_account_detail; ?>
    <?php echo $modal_account_upgrade; ?>
<!-- END -->

<!-- START: [script] -->
	<script>
        function toggle_wrapper_account() {
            if(document.getElementById('wrapper-account-modal-background').style.display == 'block') {
                hide_wrapper_account();
            }
            else {
                show_wrapper_account();
            }
        }
        
        function show_wrapper_account() {
            $('#wrapper-account').show();
            $('#wrapper-account-modal-background').fadeIn();
            $('#wrapper-account-modal-shadow').slideDown('fast');
            $('#wrapper-account-modal-content').slideDown('fast');
            
            <!-- START: Hide tooltip -->
                var id = $('#wrapper-account-icon').attr('aria-describedby');
                $('#'+id).hide();
                $('#wrapper-account-icon').attr('data-original-title', 'Close Account Menu');
            <!-- END -->
        }
        
        function hide_wrapper_account() {
            $('#wrapper-account-modal-background').fadeOut();
            $('#wrapper-account-modal-shadow').slideUp('fast');
            $('#wrapper-account-modal-content').slideUp('fast');
            
            <!-- START: Hide tooltip -->
                var id = $('#wrapper-account-icon').attr('aria-describedby');
                $('#'+id).hide();
                $('#wrapper-account-icon').attr('data-original-title', 'Open Account Menu');
            <!-- END -->
        }
    </script>
<!-- END -->