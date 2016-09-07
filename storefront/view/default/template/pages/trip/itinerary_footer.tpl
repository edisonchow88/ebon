<style>
	#section-limiter {
		min-width:220px;
	}
	#section-limiter .progress {
		margin-top:12px;
		border:thin solid #999;
		min-width:150px;
		display:inline-block;
		float:left;
	}
	#section-limiter .progress .progress-bar {
		-webkit-transition: none;
		-moz-transition: none;
		-ms-transition: none;
		-o-transition: none;
		transition: none;
	}
	#section-limiter .text {
		display:inline-block;
		font-size:12px;
		float:left;
		margin-top:10px;
		margin-left:7px;
	}
</style>

<ul class="nav nav-tabs nav-tabs-bottom">
    <li>
        <i class="fa fa-fw"></i>
        <i class="fa fa-fw"></i>
    </li>
    <?php if($this->session->data['memory'] == 'cookie') { ?>
        <li id="section-limiter" data-toggle='tooltip' data-placement='top' title='Current memory is limited by web browser.'>
            <div class="progress">
                <div class="progress-bar" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="background-color:#e93578;">
                </div>
            </div>
            <div class="text">
            	<span id="section-limiter-memory"></span>&nbsp;
            	<i class="fa fa-fw fa-question-circle"></i>
            </div>
        </li>
        <li>
            <a class="nomargin btn btn-sm" style="color:#e93578;" onclick="getFreeUnlimitedMemory();">Get free unlimited memory</a>
        </li>
    <?php } else {?>
<!--
    <li>
        <a class="btn nomargin padding-xs" data-toggle="tooltip" data-placemenet="top" title="Add Plan"><i class="fa fa-fw fa-plus"></i></a>
    </li>
    <li>
        <a class="btn nomargin padding-xs" data-toggle="tooltip" data-placemenet="top" title="All Plans"><i class="fa fa-fw fa-bars"></i></a>
    </li>
    <li>
        <a class="nomargin padding-xs"><i class="fa fa-fw"></i></a>
    </li>
    <li class="dropup tab active">
        <a class="btn nomargin padding-xs dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Plan 1 <i class="fa fa-fw fa-caret-up"></i>
        </a>
        <ul class="dropdown-menu">
            <li><a>Delete</a></li>
            <li><a>Duplicate</a></li>
            <li><a>Rename</a></li>
            <li role="separator" class="divider"></li>
            <li><a>Mark as Latest Plan</a></li>
        </ul>
    </li>
    <li class="tab">
        <a class="btn nomargin padding-xs dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            Plan 2 <i class="fa fa-fw fa-caret-up"></i>
        </a>
    </li>
-->
	<?php } ?>
</ul>
<div id='section-powerby' class="noselect">
	<span>Power by </span><span id='section-powerby-brand'>TREVOL</span>
</div>

<script>
	function updateSectionLimiter() {
		var num_of_day = $('.plan-day-tr').length;
		var num_of_line = $('.plan-line-tr').length;
		var current_memory = (num_of_day * 50 + num_of_line * 300);
		var current_memory_text = ((current_memory)/1000).toFixed(1) + ' kB';
		var max_memory = 3000;
		var percentage = current_memory / max_memory * 100;
		$('#section-limiter-memory').html(current_memory_text);
		$('#section-limiter .progress-bar').attr('aria-valuenow',percentage);
		$('#section-limiter .progress-bar').css('width',percentage+'%');
	}
	
	function getFreeUnlimitedMemory() {
		var alert_text = '<div class="alert alert-info">Enjoy free unlimited memory per trip by saving it in our server.</div>';
		<?php if($this->user->isLogged() == false) { ?>
			$('#modal-account-login').modal('show');
			$('#modal-account-login-form-alert').html(alert_text);
		<?php } else { ?>
			verify_save_trip_condition();
			$('#modal-trip-save-form-alert').html(alert_text);
		<?php } ?>
	}
</script>