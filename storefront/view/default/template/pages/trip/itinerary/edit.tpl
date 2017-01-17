<div class="content-header fixed-width noselect">
    <div class="row navbar navbar-primary navbar-file">
        <div class="col-xs-3 text-left">
            <?php if($this->session->data['memory'] == 'cookie') { ?>
                <a class="btn" href="<?php echo $link['list/trip/upcoming']; ?>">Back</a>
            <?php } ?>
        </div>
        <div class="col-xs-6 text-center">
            <h1>Edit Itinerary</h1>
        </div>
        <div class="col-xs-3 text-right">
            <?php if($this->session->data['memory'] == 'cookie') { ?>
                <a class="btn button-save-trip" data-toggle="modal" data-target="#modal-trip-save">Save</a>
            <?php } else { ?>
                <a class="btn" href="<?php echo $link['trip/itinerary/view']; ?>">Done</a>
            <?php } ?>
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
	<div class="content-body-alert"></div>
    <div class="content-body-result"></div>
</div>

<?php echo $script_trip_plan; ?>

<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/swiper.jquery.min.js'); ?>"></script>
<script><!-- START: jquery function to serialize form -->
		$.fn.serializeObject = function() {
			var o = {};
			var a = this.serializeArray();
			$.each(a, function() {
				if (o[this.name] !== undefined) {
					if (!o[this.name].push) {
						o[this.name] = [o[this.name]];
					}
					o[this.name].push(this.value || '');
				} else {
					o[this.name] = this.value || '';
				}
			});
			return o;
		};
	<!-- END -->
	function refreshPlan() {
		<!-- START: reset loading screen -->
			$('.content-body-loading').show();
			$('.content-body-empty').show();
		<!-- END -->
		<!-- START: clear old result -->
			$('.content-body-result').html('');
		<!-- END -->
		<?php if(isset($trip_id)) { ?>
			<!-- START: [logged] -->
				<!-- START: -->
					var plan_id = "<?php echo $this->trip->getPlanId(); ?>";
				<!-- END -->
				<!-- START: set data -->
					var data = {
						"action":"refresh_plan",
						"trip_id":"<?php echo $trip_id; ?>",
						"plan_id":"<?php echo $plan_id; ?>"
					};
				<!-- END -->
				<!-- START: send POST -->
					$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(plan) {
						$('.content-body-result').html('<div id="plan-'+data.plan_id+'"></div>');
						runRefreshPlan(plan);
					}, "json");
				<!-- END -->
			<!-- END -->
		<?php } else { ?>
			<!-- START: [not logged] -->
				$('.content-body-result').html('<div id="plan"></div>');
				var plan = getCookie('plan');
				if(plan == '') {
					<!-- START: [first time] -->
						var plan = {"name":"Plan 1","travel_date":"","day":[{"day_id":"1","sort_order":"1"}]};
						plan = JSON.stringify(plan);
						setCookie('plan',plan,1);
						plan = JSON.parse(plan);
						runRefreshPlan(plan);
					<!-- END -->
				}
				else {
					<!-- START: [revisit] -->
						plan = JSON.parse(plan);
						runRefreshPlan(plan);
					<!-- END -->
				}
			<!-- END -->
		<?php } ?>
	}
	
	function runRefreshPlan(json) {
		<!-- START -->
			printPlan('edit',json);
		<!-- END -->
		<!-- START: end loading -->
			$('.content-body-empty').hide();
			$('.content-body-loading').fadeOut();
		<!-- END -->
	}
	
	refreshPlan();
</script>