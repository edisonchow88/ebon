<style>
	body {
		overflow-y:scroll;
		overflow-x:hidden;
		text-align:center;
		padding-top:1px;
		margin-top:-1px;
		-webkit-overflow-scrolling:touch;
	}
	
	#section-body {
		min-height:100vh;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
		
		margin:auto;
		text-align:left;
		background-color:white;
	}
	
	.fixed-width {
		max-width:400px;
	}
	
	.fixed-bar {
		width:100%;
		max-width:400px;
		z-index:5;
	}
	
	.box-shadow {
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}
	
	/* START: empty-list */
		.empty-list {
			color:#777;
			margin-top:20vh;
			padding:15px;
			text-align:center;
		}
		
		.empty-list .title {
			background-color:transparent;
			color:#777;
			font-weight:bold;
		}
	/* END */
	
	/* START: section-tab */
		#section-tab {
			position:fixed;
			bottom:0;
			height:40px;
		}
		
		#section-tab li {
			float:left;
			width:33.33%;
			text-align:center;
			box-sizing: border-box; /* set inner border instead of edge border*/
			-moz-box-sizing: border-box;
			-webkit-box-sizing: border-box;
			border-left:solid thin #BBB;
		}
		
		#section-tab li:first-child {
			border:none;
		}
		
		#section-tab li.active a {
			box-shadow:0 5px 0 -1px #e93578 inset;
		}
		
		#section-tab a {
			display:block;
			width:100%;
			padding:10px 10px;
			background-color:#CCC;
			color:#333;
			-webkit-touch-callout: none; /* iOS Safari */
			-webkit-user-select: none;   /* Chrome/Safari/Opera */
			-khtml-user-select: none;    /* Konqueror */
			-moz-user-select: none;      /* Firefox */
			-ms-user-select: none;       /* Internet Explorer/Edge */
			user-select: none;           /* Non-prefixed version, currently not supported by any browser */
		}
		
		#section-tab a:hover {
			background-color:#BBB;
			color:#222;
		}
		
		#section-tab li.active a {
			background-color:#AAA;
			color:#111;
			cursor:default;
		}
		
		#section-tab-button {
			position:absolute;
			top:10px;
			right:-1px;
		}
		
		#section-tab-button > .btn {
			font-size:9px;
			padding:10px;
			border:solid thin #EEE;
			border-radius:5px 0 0 5px;
		}
	/* END */
	
	/* START: section-content */
		#section-content {
			width:100%;
			background-color:#FFF;
		}
		
		#content-explore {
			width:100%;
			min-height:100vh;
			float:left;
			background-color:#EEE;
			padding-top:calc(40px);
			padding-bottom:calc(40px);
		}
		
		#content-trip {
			width:100%;
			min-height:100vh;
			float:left;
			background-color:#EEE;
			padding-top:calc(40px);
			padding-bottom:calc(40px);
		}
		
		#content-account {
			width:100%;
			min-height:100vh;
			float:left;
			background-color:#EEE;
			padding-top:calc(40px);
			padding-bottom:calc(40px);
		}
		
		#wrapper-header-explore {
			height:40px;
		}
		
		.wrapper-header-main {
			position:fixed;
			top:0;
			height:40px;
			background-color:#e93578;
			color:#FFF;
			text-align:center;
		}
		
		.wrapper-header-main h1 {
			margin:0;
			font-size:14px;
			line-height:40px;
			font-weight:bold;
		}
		
		.btn-header {
			margin:0;
			padding:0 15px;
			font-size:14px;
			line-height:40px;
			border:none;
		}
		
		.btn-header:active {
			box-shadow:none;
		}
		
		.wrapper-header-main .btn-header {
			color:#FFF;
		}
		
		.wrapper-header-main .btn-header:hover {
			color:#000;
		}
	/* END */
	
	/* START: modal */
		.modal {
			text-align:center;
		}
		
		.modal-dialog {
			margin:0 auto;
			text-align:left;
		}
		
		.modal-content {
			position:relative;
			border-radius:0;
			border:none;
		}
		
		.modal-header {
			border-radius:0;
			background-color:#DDD;
			height:40px;
			padding:0;
			border-bottom:solid thin #CCC;
		}
		
		.modal-title {
			color:#000;
			font-weight:bold;
		}
	/* END */
	/* START: [modal form] */
		.modal-body-footnote {
			width:100%;
			text-align:center;
		}
		
		.modal-button {
			border-radius:3px;
			line-height:40px;
			padding:0;
		}
		
		.modal-form .form-group {
			position:relative;
		}
		
		.modal-form .form-control {
			border:none;
			border-bottom:solid thin #DDD;
			height:40px;
			margin-top:15px;
			margin-bottom:15px;
			box-shadow: 0 2px 0 0 #FFF;
			padding:0;
			color:#000;
		}
		
		.modal-form .form-control:focus {
			border-bottom:solid thin #e93578;
			box-shadow: 0 2px 0 0 #e93578;
		}
		
		.modal-form .form-control:focus ~label {
			color:#e93578;
		}
		
		.modal-form .form-group:first-child {
			margin-top:15px;
		}
		
		.modal-form .form-group:last-child {
			margin-bottom:30px;
		}
		
		.modal-form label {
			position:absolute;
			top:0;
			left:0;
			padding:0;
			margin:0;
			font-size:12px;
			z-index:3;
			color:#999;
		}
		.modal-form input:-webkit-autofill {
			-webkit-box-shadow: 0 0 0 1000px white inset !important;
		}
		.modal-form input.form-control::-webkit-input-placeholder { /* Chrome/Opera/Safari */
		  color: #999;
			}
		.modal-form input.form-control::-moz-placeholder { /* Firefox 19+ */
		  color: #999;
		}
		.modal-form input.form-control:-ms-input-placeholder { /* IE 10+ */
		  color: #999;
		}
		.modal-form input.form-control:-moz-placeholder { /* Firefox 18- */
		  color: #999;
		}
		
		.modal-form input[type='date'] {
			-webkit-appearance: none;
		}
	/* END */
	/* START: [modal fixed-top] */
		body.modal-open {
			overflow: hidden;
			position:fixed;
			top:0;
			bottom:0;
			left:0;
			right:0;
		}
		.modal.modal-fixed-top {
			top: 0; 
			right: 0; 
			bottom: 0; 
			left: 0;
			-webkit-overflow-scrolling:auto;
			overflow-x:hidden;
			overflow-y:hidden;
		}
		.modal-fixed-top .modal-wrapper {
			position:relative;
		}
		.modal-fixed-top .modal-header {
			position:absolute;
			top:0;
			width:100%;
			text-align:center;
			border-radius:0;
			padding:0;
			z-index:10500;
			background-color:transparent;
			border-bottom:none;
		}
		.modal-fixed-top .modal-header > .fixed-bar {
			height:40px;
			margin:0 auto;
			background-color:#DDD;
			border-bottom:solid thin #CCC;
		}
		.modal-fixed-top .modal-header-shadow {
			display:block;
			height:40px;
		}
		.modal-fixed-top .modal-dialog {
			background-color:#FFF;
		}
		.modal-fixed-top .modal-content {
			overflow-y:scroll;
			overflow-x:hidden;
			-webkit-overflow-scrolling:touch;
			height:calc(100vh - 40px);
			padding-top:1px;
			margin-top:-1px;
		}
		.modal-fixed-top .modal-body {
			padding-bottom:70px;
		}
		.modal-fixed-top .modal-footer {
			position:absolute;
			bottom:0;
			width:100%;
			text-align:center;
			border-radius:0;
			padding:0;
			z-index:10500;
			background-color:transparent;
			border-top:none;
		}
	/* END */
	/* START: [popover alert] */	
		#section-popover-alert {
			position:fixed;
			bottom:10px;
			right:0;
			left:0;
			width:100%;
			z-index:15000;
		}
		
		#popover-alert{
			margin:auto;
			width:390px;
			line-height:50px;
			max-width:calc(100% - 10px);
			height:auto;
			background-color: rgba(139,0,0,0.9);
			color:#FFF;
			padding: 5px;
			display: none;
		}
	/* END */
	/* START: [popover hint] */	
		#section-popover-hint {
			position:fixed;
			bottom:10px;
			right:0;
			left:0;
			width:100%;
			z-index:15000;
		}
		
		#popover-hint{
			margin:auto;
			width:390px;
			line-height:50px;
			max-width:calc(100% - 10px);
			height:auto;
			background-color: rgba(0,0,0,0.9);
			color:#FFF;
			padding: 5px;
			display: none;
		}
	/* END */	
</style>

<script>
	function isset(x) {
		if(typeof x != 'undefined' && x != null && x != '') {
			return true;
		}
		else {
			return false;
		}
	}
</script>

<!-- START: [splash] -->
	<?php echo $modal_home_splash; ?>
<!-- END -->

<div id="section-body" class="fixed-bar">
	<div class="row" id="section-content">
        <div class="content" id="content-explore">
        	<?php echo $section_content_explore; ?>
        </div>
        <div class="content" id="content-trip">
        	<?php echo $section_content_trip; ?>
        </div>
        <div class="content" id="content-account">
        	<?php echo $section_content_account; ?>
        </div>
    </div>
    <div id="section-tab" class="fixed-bar">
    	<ul>
        	<li id="section-tab-explore" class="section-tab-button"><a onclick="showTab('explore');">Explore</a></li>
            <li id="section-tab-trip" class="section-tab-button"><a onclick="showTab('trip');">Trips</a></li>
            <li id="section-tab-account" class="section-tab-button"><a onclick="showTab('account');">Account</a></li>
        </ul>
    </div>
</div>

<!-- START: [modal] -->
	<?php echo $modal_trip_new; ?>
<!-- END -->

<script>
	<!-- START: [splash] -->
		setTimeout(function() {
			$('#wrapper-splash').fadeOut(500);
		},1000);
	<!-- END -->
	<!-- START: [tab] -->
		function getHash() {
			var hash = location.hash;
			if(hash.indexOf('gid') > 0) {
				hash = hash.replace('gid=','@');
				hash = hash.substr(hash.indexOf("@") + 1);
			}
			else {
				hash = '';
			}
			return hash;
		}
		
		function getHashTab() {
			var hash = location.hash;
			if(hash.indexOf('tab') > 0) {
				hash = hash.replace('#tab=','');
				if(hash.indexOf('&') > 0) {
					hash = hash.substring(0, hash.indexOf('&'));
				}
			}
			else {
				hash ='';
			}
			return hash;
		}
		
		function setHashTab(id) {
			if(getHash() != '') {
				window.location.hash = '#tab=' + id + '&gid=' + getHash();
			}
			else {
				window.location.hash = '#tab=' + id;
			}
		}
		
		function showTab(id) {
			$('.section-tab-button').removeClass('active');
			$('#section-tab-'+id).addClass('active');
			$('.content').hide();
			$('#content-'+id).show();
			setHashTab(id);
			//Google Analytics Event
			ga('send', 'event','main-tab','change', id);
		}
		
		function initTab() {
			<?php if($this->request->get_or_post('tab')) { ?>
				showTab("<?php echo $this->request->get_or_post('tab'); ?>");
			<?php } else { ?>
				var hashTab = getHashTab();
				var hash = getHash();
				if(hashTab != '') {
					showTab(hashTab);
				}
				else {
					showTab('explore'); //default browser tab
				}
			<?php } ?>
		}
		
		initTab();
	<!-- END -->
	
	<?php if($last_action != '') { ?>
		showHint("<?php echo $last_action; ?>");
	<?php } ?>
</script>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCWNokmtFWOCjz3VDLePmZYaqMcfY4p5i0&libraries=places&callback=initMap" async defer></script>