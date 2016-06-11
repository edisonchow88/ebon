<!-- Added Code, to be replaced in future-->
<?php 
$heading_title = 'Itinerary'; 
?>

<!-- -->
<h1 class="heading1">
	<span class="maintext"><?php echo $heading_title; ?></span>
</h1>

<?php if ($success) { ?>
<div class="alert alert-success">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<?php echo $success; ?>
</div>
<?php } ?>

<?php if ($error) { ?>
<div class="alert alert-error alert-danger">
<button type="button" class="close" data-dismiss="alert">&times;</button>
<?php echo $error; ?>
</div>
<?php } ?>


		<table class="table table-striped table-bordered">
			<?php foreach ($products as $product) { ?>
				<tr class="wishlist_<?php echo $product['product_id'] ?>">
					<td class="align_center">
						<a href="<?php echo $product['href']; ?>"><?php echo $product['thumb']['thumb_html']; ?></a>
					</td>
					<td class="align_left">
						<a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a>
					</td>
					
					<?php if ($display_price) { ?>
					<td class="align_right">
						<?php if ($product['special']) { ?>
						    <div class="pricenew"><?php echo $product['special'] ?></div>
						    <div class="priceold"><?php echo $product['price'] ?></div>
						<?php } else { ?>
						    <div class="oneprice"><?php echo $product['price'] ?></div>
						<?php } ?>					
					</td>
					<?php } ?>
					
					<td class="align_center">

					
						
						<a href="#" onclick="wishlist_remove('<?php echo $product['product_id'] ?>'); return false;" class="btn btn-sm btn-default btn-remove"><i class="fa fa-trash-o fa-fw"></i></a>
					</td>
				</tr>
			<?php } ?>
			<?php echo $this->getHookVar('more_wishlist_products'); ?>
		</table>

		<div class="pull-right mb20">
			<?php echo $this->getHookVar('top_wishlist_buttons'); ?>
			
			<a href="<?php echo $cart; ?>" class="btn btn-orange">
				<i class="fa fa-shopping-cart"></i>
				<?php echo $button_cart; ?>
			</a>
			<?php echo $this->getHookVar('bottom_wishlist_buttons'); ?>
		</div>
	

<script type="text/javascript"><!--

	function wishlist_remove(product_id) {
		var wclass = '.wishlist_'+product_id;
		var dismiss = '<button type="button" class="close" data-dismiss="alert">&times;</button>';
		$.ajax({
			type: 'POST',
			url: '<?php echo $this->html->getURL('product/wishlist/remove');?>&product_id='+product_id,
			dataType: 'json',
			beforeSend: function () {
				$('.success, .warning, .alert').remove();
				$(wclass+' .btn-remove i').hide();
				$(wclass+' .btn-remove').append('<i class="wait fa fa-spinner fa-spin"></i>');
			},
			complete: function () {
				$('.wait').remove();
			},
            error: function (jqXHR, exception) {
            	var text = jqXHR.statusText + ": " + jqXHR.responseText;
				$('.alert').remove();
				$('.wishlist').before('<div class="alert alert-error alert-danger">' + dismiss + text + '</div>');
				$(wclass+' .btn-remove i').show();
			},
			success: function (data) {
				if (data.error) {
					$('.alert').remove();
					$('.wishlist').before('<div class="alert alert-error alert-danger">' + dismiss + data.error + '</div>');
					$(wclass+' .btn-remove i').show();
				} else {
					$('.wishlist .alert').remove();
					$(wclass).remove();
				}
			}
		});
	}

//--></script>