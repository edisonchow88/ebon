<?php echo ${$children_blocks[0]}; ?>

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
<script type="text/javascript" src="<?php echo $this->templateResource('/javascript/bootstrap-confirmation.min.js'); ?>"></script>

<?php foreach ($scripts_bottom as $script) { ?>
	<script type="text/javascript" src="<?php echo $script; ?>"></script>
<?php } ?>