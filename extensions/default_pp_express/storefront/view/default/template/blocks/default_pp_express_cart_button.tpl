<div class="clearfix mt10"></div>
<?php if ( has_value($billmelater) ){ ?>
<div style="width: 150px; vertical-align: top;" class="pull-right ml10">
<a class="<?php echo $billmelater['style']; ?> ml10" href="<?php echo $billmelater['href']; ?>">
	<img id="pp_exp_btn_bml_<?php echo $block_details['instance_id'];?>"  src="<?php echo $billmelater['image_src']; ?>" align="left">
</a>
<a href="https://www.securecheckout.billmelater.com/paycapture-content/fetch?hash=AU826TU8&content=/bmlweb/ppwpsiw.html">
	<img id="pp_exp_btn_bml_txt_<?php echo $block_details['instance_id'];?>" src="<?php echo $billmelater_txt['image_src']; ?>" /></a>
</div>
<?php } ?>

<a class="<?php echo $style; ?>" href="<?php echo $href; ?>">
	<img id="pp_exp_btn_<?php echo $block_details['instance_id'];?>" src="<?php echo $image_src; ?>" align="left">
</a>

