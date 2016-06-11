<div class="side_block">
	<?php if ($block_framed) { ?>
		<h2><?php echo $heading_title; ?></h2>
	<?php }	?>

	<ul class="side_prd_list">
		<?php
		/**
		 * @var $this AView
		 */
		if ($content) {
			foreach ($content as $item) {


				$item['image'] = $item['thumb']['thumb_html'];

				$item['title'] = $item['name'] ? $item['name'] : $item['thumb']['title'];
				$item['description'] = $item['model'];
				$item['rating'] = ($item['rating']) ? "<img src='" . $this->templateResource('/image/stars_' . $item['rating'] . '.png') . "' alt='" . $item['stars'] . "' />" : '';

				$item['info_url'] = $item['href'] ? $item['href'] : $item['thumb']['main_url'];
				$item['buy_url'] = $item['add'];
				if (!$display_price) {
					$item['price'] = '';
				}

				$review = $button_write;
				if ($item['rating']) {
					$review = $item['rating'];
				}

				?>

				<li class="col-md-3">
				<?php if ($item[ 'resource_code' ]) {
						echo $item[ 'resource_code' ];
					} else {?>
					<a href="<?php echo $item['info_url'] ?>"><?php echo $item['image'] ?></a>
					<a class="productname" href="<?php echo $item['info_url'] ?>"><?php echo $item['title']?></a>
					<?php if ($review_status) { ?>
					<span class="procategory"><?php echo $item['rating']?></span>
					<?php } ?>
			<?php if($item['price']){?>
				   <span class="price">
					<?php  if ($item['special']) { ?>
						   <div class="pricenew"><?php echo $item['special']?></div>
						   <div class="priceold"><?php echo $item['price']?></div>
					<?php } else { ?>
						   <div class="oneprice"><?php echo $item['price']?></div>
					<?php } ?>
				   </span>
			<?php } }?>
				</li>

			<?php
			}
		}
		?>
	</ul>

	<?php if ($block_framed) { ?>
	<?php } ?>
</div>
