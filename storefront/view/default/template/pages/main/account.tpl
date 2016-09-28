<style>
	#wrapper-account-avatar {
		color:#999;
		text-align:center;
		margin-top:30px;
	}
	
	#wrapper-account-avatar-image {
		margin:auto;
	}
	
	#wrapper-account-button {
		padding-top:30px;
		text-align:center;
	}
	
	#wrapper-account-button a {
		margin:auto;
		margin-bottom:15px;
		height:48px;
		width:250px;
		line-height:48px;
		padding:0;
		border-radius:5px;
	}
</style>

<div class="fixed-bar wrapper-header-main row">
	<div class="col-xs-3 text-left">
    </div>
    <div class="col-xs-6">
    	<h1>Account</h1>
    </div>
    <div class="col-xs-3 text-right">
    </div>
</div>
<div id="wrapper-account-avatar">
	<div id="wrapper-account-avatar-image">
        <span class="fa-stack fa-5x">
            <i class="fa fa-circle fa-stack-2x"></i>
            <i class="fa fa-user fa-stack-1x fa-inverse"></i>
        </span>
    </div>
</div>
<div id="wrapper-account-button">
	<a class="btn btn-block btn-primary box-shadow" data-toggle="modal" data-target="#modal-account-login">Log In</a>
    <a class="btn btn-block btn-default box-shadow" data-toggle="modal" data-target="#modal-account-signup">Sign Up</a>
</div>

<!-- START: [modal] -->
    <?php echo $modal_account_signup; ?>
    <?php echo $modal_account_login; ?>
    <?php echo $modal_account_logout; ?>
    <?php echo $modal_account_detail; ?>
    <?php echo $modal_account_upgrade; ?>
<!-- END -->