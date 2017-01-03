<!-- START: Modal -->
    <div class="modal" id="menu-mobile-main" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-body modal-body-left" style="padding-top:10px;">
                <div class="la la-40">
                	<?php if($this->user->isLogged() != false) { ?>
                        <div class="la-row">
                            <div class="la-icon">
                                <i class="fa fa-fw fa-lg fa-user-circle-o"></i>
                            </div>
                            <div class="la-desc">
                                <div class="la-text">
                                    <?php echo $this->user->getEmail(); ?>
                                </div>
                            </div>
                        </div>
                        <hr />
                    <?php } ?>
                    <div class="la-row">
                    	<a href="<?php echo $link['landing/home'];?>">
                            <div class="la-icon">
                                <i class="fa fa-fw fa-lg fa-home"></i>
                            </div>
                            <div class="la-desc">
                                <div class="la-text">
                                    Home
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="la-row hidden">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-file-text"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text">
                                My Templates
                            </div>
                        </div>
                    </div>
                    <div class="la-row">
                    	<a href="<?php echo $link['list/trip/upcoming'];?>">
                            <div class="la-icon">
                                <i class="fa fa-fw fa-lg fa-briefcase"></i>
                            </div>
                            <div class="la-desc">
                                <div class="la-text">
                                    My Trips
                                </div>
                            </div>
                        </a>
                    </div>
                    <hr />
                    <?php if($this->user->isLogged() == false) { ?>
                        <!-- START: if not logged -->
                            <div class="la-row" data-dismiss="modal" data-toggle="modal" data-target="#modal-account-login">
                                <div class="la-icon">
                                    <i class="fa fa-fw fa-lg fa-lock"></i>
                                </div>
                                <div class="la-desc">
                                    <div class="la-text">
                                        Log In
                                    </div>
                                </div>
                            </div>
                            <div class="la-row" data-dismiss="modal" data-toggle="modal" data-target="#modal-account-signup">
                                <div class="la-icon">
                                    <i class="fa fa-fw fa-lg fa-sign-in"></i>
                                </div>
                                <div class="la-desc">
                                    <div class="la-text">
                                        Sign Up
                                    </div>
                                </div>
                            </div>
                        <!-- END -->
                    <?php } else { ?>
                        <!-- START: if logged -->
                            <div class="la-row" onclick="logout();">
                                <div class="la-icon">
                                    <i class="fa fa-fw fa-lg fa-unlock-alt"></i>
                                </div>
                                <div class="la-desc">
                                    <div class="la-text">
                                        Log Out
                                    </div>
                                </div>
                            </div>
                        <!-- END -->
                    <?php } ?>
                </div>
        	</div>
        </div>
    </div>
<!-- END -->

<!-- START: [modal] -->
    <?php echo $modal_account_signup; ?>
    <?php echo $modal_account_login; ?>
    <?php echo $modal_account_logout; ?>
    <?php 
    	if($this->user->isLogged()) {
        	echo $modal_account_detail;
        }
    ?>
<!-- END -->

<script>
	$("#menu-mobile-main").on( "show.bs.modal", function() {
		$('#menu-mobile-main .modal-body').hide();
	});
	$("#menu-mobile-main").on( "shown.bs.modal", function() {
		$('#menu-mobile-main .modal-body').toggle('slide');
	});
	$("#menu-mobile-main").on( "hide.bs.modal", function() {
		$('#menu-mobile-main .modal-body').toggle('slide');
	});
</script>
<script>
	<?php if($last_action != '') { ?>
		showHint("<?php echo $last_action; ?>");
	<?php } ?>
</script>