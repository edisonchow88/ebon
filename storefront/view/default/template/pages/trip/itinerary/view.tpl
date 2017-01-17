<div class="content-header fixed-width noselect">
    <div class="row navbar navbar-primary navbar-file">
        <div class="col-xs-3 text-left">
            <a class="btn" href="<?php echo $link['trip/summary']; ?>">Back</a>
        </div>
        <div class="col-xs-6 text-center">
            <h1>Itinerary</h1>
        </div>
        <div class="col-xs-3 text-right">
            <a class="btn" href="<?php echo $link['trip/itinerary/edit']; ?>">Edit</a>
        </div>
    </div>
</div>
<div class="content-body-loading fixed-width">
    <div class="col-xs-12">
        <i class="fa fa-circle-o-notch fa-spin fa-5x fa-fw"></i>
    </div>
</div>
<div class="content-body-empty fixed-width">
    <div class="col-xs-12">
    	<div><b>Itinerary cannot be found</b></div>
        <div>It may have been deleted.</div>
    </div>
</div>
<div class="content-body fixed-width">
	<div class="navbar navbar-shadow"></div>
    <div class="row navbar navbar-white">
        <div class="col-xs-3 text-left">
        	<span class="text-sub">View</span>
        </div>
        <div class="col-xs-9 text-right">
            <a class="btn button-toggle-info" onclick="toggleInfo();"><div class="label label-default">Info</div></a>
            <a class="btn button-toggle-transport" onclick="toggleTransport();"><div class="label label-default">Transport</div></a>
        </div>
    </div>
	<div class="content-body-alert"></div>
    <div class="content-body-result"></div>
</div>

<?php echo $script_trip_plan; ?>

<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/swiper.jquery.min.js'); ?>"></script>
<script>
	function refreshPlan() {
		<!-- START: reset loading screen -->
			$('.content-body-loading').show();
			$('.content-body-empty').show();
		<!-- END -->
		<!-- START: clear old result -->
			$('.content-body-result').html('');
		<!-- END -->
		<!-- START: get new result -->
			<!-- START: -->
				var plan_id = "<?php echo $this->trip->getPlanId(); ?>";
			<!-- END -->
			<!-- START: set data -->
				var data = {
					"action":"get_plan",
					"trip_id":"<?php echo $trip_id; ?>",
					"plan_id":"<?php echo $plan_id; ?>"
				};
			<!-- END -->
			<!-- START: send POST -->
				$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
					$('.content-body-result').html('<div id="plan-'+data.plan_id+'"></div>');
					runRefreshPlan(json);
				}, "json");
			<!-- END -->
		<!-- END -->
	}
	
	function runRefreshPlan(json) {
		<!-- START -->
			printPlan('view',json);
		<!-- END -->
		<!-- START: end loading -->
			$('.content-body-empty').hide();
			$('.content-body-loading').fadeOut();
		<!-- END -->
	}
	
	refreshPlan();
</script>
<script>
	function toggleInfo() {
		if($('.button-toggle-info .label').hasClass('label-default')) {
			$('.plan-line-detail').removeClass('hidden');
			$('.plan-line-menu').removeClass('hidden');
			$.each($('.plan-line'),function() {
				$(this).find('.fa-caret-down').first().addClass('fa-flip-vertical');
			});
			$('.button-toggle-info .label').toggleClass('label-default');
			$('.button-toggle-info .label').toggleClass('label-success');
		}
		else {
			$('.plan-line-detail').addClass('hidden');
			$('.plan-line-menu').addClass('hidden');
			$.each($('.plan-line'),function() {
				$(this).find('.fa-caret-down').first().removeClass('fa-flip-vertical');
			});
			$('.button-toggle-info .label').toggleClass('label-default');
			$('.button-toggle-info .label').toggleClass('label-success');
		}
	}
	
	function toggleTransport() {
		$('.plan-line-twins').toggleClass('hidden');
		$('.transport-row').toggleClass('hidden');
		$('.button-toggle-transport .label').toggleClass('label-default');
		$('.button-toggle-transport .label').toggleClass('label-success');
	}
</script>