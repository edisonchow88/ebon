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
	
	.fixed-bar {
		width:100%;
		max-width:400px;
		z-index:5;
	}
	
	.box-shadow {
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}
	
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
			line-height:38px;
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
		
		.modal-body {
			min-height:calc(100vh - 40px);
		}
		
		.modal-title {
			color:#000;
			font-weight:bold;
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
	/* END */
</style>

<div id="section-body" class="fixed-bar">
	<div class="row" id="section-content">
        <div class="content" id="content-explore">
        	<?php echo $section_content_explore; ?>
        </div>
        <div class="content" id="content-trip">
        	<?php echo $section_content_trip; ?>
            <?php 
            	for($i=0;$i<100;$i++) {
                	echo '<div>'.$i.'</div><br/>';
            	}
            ?>
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

<script>
	<!-- START: [tab] -->
		function showTab(id) {
			$('.section-tab-button').removeClass('active');
			$('#section-tab-'+id).addClass('active');
			$('.content').hide();
			$('#content-'+id).show();
		}
		
		function initTab() {
			<?php if($this->request->get_or_post('tab')) { ?>
				showTab("<?php echo $this->request->get_or_post('tab'); ?>");
			<?php } else { ?>
				showTab('explore'); //default browser tab
			<?php } ?>
		}
		
		initTab();
	<!-- END -->
</script>