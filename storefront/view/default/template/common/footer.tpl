<!-- DISABLE by TREOVL
<footer class="footersocial">
	<section class="footersocial">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-3">
					<?php echo ${$children_blocks[0]}; ?>
				</div>
				<div class="col-md-3">
					<?php echo ${$children_blocks[1]}; ?>
				</div>
				<div class="col-md-3">
					<?php echo ${$children_blocks[2]}; ?>
				</div>
				<div class="col-md-3">
					<?php echo ${$children_blocks[3]}; ?>
				</div>
			</div>
		</div>
	</section>

	<section class="footerlinks">
		<div class="container-fluid">
			<div class="pull-left">
				<?php echo ${$children_blocks[4]}; ?>
			</div>
			<div class="pull-right">
				<?php echo ${$children_blocks[5]}; ?>
			</div>
		</div>
	</section>
	<section class="copyrightbottom align_center">
		<div class="container-fluid">
			<div class="pull-left mt5">
				<?php echo ${$children_blocks[6]}; ?>
			</div>
			<div class="pull-right align_center">
				<br />
	    		<?php echo $text_copy; ?>		
			</div>
			<div class="pull-right mr20 mt5">
				<?php echo ${$children_blocks[7]}; ?>
			</div>
		</div>
	</section>
	<a id="gotop" href="#">Back to top</a>
</footer>
</div>

<div id="msgModal" class="modal fade">
<div class="modal-dialog">
<div class="modal-content">
  <div class="modal-header">
    <button type="button" class="close callback-btn" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h3></h3>
  </div>
  <div class="modal-body">
  </div>
</div>
</div>  
</div>

-->

<!-- Placed at the end of the document so the pages load faster -->
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/bootstrap.min.js'); ?>"></script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/respond.min.js'); ?>"></script>
<script type="text/javascript" defer src="<?php echo $this->templateResource('/javascript/jquery.flexslider.js'); ?>"></script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/easyzoom.js'); ?>"></script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/jquery.validate.js'); ?>"></script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/jquery.carouFredSel-6.1.0-packed.js'); ?>"></script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/jquery.mousewheel.min.js'); ?>"></script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/jquery.touchSwipe.min.js'); ?>"></script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/jquery.ba-throttle-debounce.min.js'); ?>"></script>
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/jquery.onebyone.min.js'); ?>"></script>
<!--<script type="text/javascript" defer src="<?php echo $this->templateResource('/javascript/custom.js'); ?>"></script>
<script src="https://maps.googleapis.com/maps/api/js?callback=initMap" async defer></script>-->

<!-- DISABLED by TREVOL, 2016/02/27
<?php if ($google_analytics) {
	$ga_data = $this->registry->get('google_analytics_data');
	?>
	<script type="text/javascript">

		var _gaq = _gaq || [];
		_gaq.push(['_setAccount', '<?php echo $google_analytics;?>']);
		_gaq.push(['_trackPageview']);

		<?php if($ga_data){?>
		_gaq.push(['_set', 'currencyCode', '<?php echo $ga_data['currency_code'];?>']);
		_gaq.push(['_addTrans',
			'<?php echo $ga_data['transaction_id'];?>',
			'<?php echo $ga_data['store_name'];?>',
			'<?php echo $ga_data['total'];?>',
			'<?php echo $ga_data['tax'];?>',
			'<?php echo $ga_data['shipping'];?>',
			'<?php echo $ga_data['city'];?>',
			'<?php echo $ga_data['state'];?>',
			'<?php echo $ga_data['country'];?>'
		]);
		_gaq.push(['_trackTrans']);
		<?php }?>

		(function () {
			var ga = document.createElement('script');
			ga.type = 'text/javascript';
			ga.async = true;
			ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
			var s = document.getElementsByTagName('script')[0];
			s.parentNode.insertBefore(ga, s);
		})();

	</script>

<?php } ?>

-->
<?php foreach ($scripts_bottom as $script) { ?>
	<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>