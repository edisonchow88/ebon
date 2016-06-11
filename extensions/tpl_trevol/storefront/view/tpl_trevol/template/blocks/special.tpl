<div class="sidewidt">
<?php if ( $block_framed ) { ?>
	<div class="block_frame block_frame_<?php echo $block_details['block_txt_id']; ?>"
				 id="block_frame_<?php echo $block_details['block_txt_id'] . '_' . $block_details['instance_id'] ?>">
	<h2 class="heading2"><span><?php echo $heading_title; ?></span></h2>
<?php } ?>
		<ul class="side_prd_list">
<?php
if ($products) {
    foreach ($products as $product) {
        $item = array();
		if( $product['thumb']['origin']=='internal'){
			$item['image'] = '<img class="thumbnail_small" src="'. $product['thumb']['thumb_url'].'"/>';
		}else{
			$item['image'] = $product['thumb']['thumb_html'];
		}
        $item['title'] = $product['name'];
        $item['description'] = $product['model'];
        $item['rating'] = ($product['rating']) ? "<img src='". $this->templateResource('/image/stars_'.$product['rating'].'.png') ."' alt='".$product['stars']."' />" : '';
                
        $item['info_url'] = $product['href'];
        $item['buy_url'] = $product['add'];
	    if(!$display_price){
		    $item['price'] = '';
	    }
	    
	    $review = $button_write;
	    if ($item['rating']) {
	    	$review = $item['rating'];
	    }
	    
?>      
              <li class="col-xs-12">
              	<a href="<?php echo $item['info_url']?>"><?php echo $item['image']?></a>
              	<a class="productname" href="<?php echo $item['info_url']?>"><?php echo $item['title']?></a>
              	<?php if ($review_status) { ?>
                <span class="procategory"><?php echo $item['rating']?></span>
                <?php } ?>
                <span class="price">
		        <?php  if ($product['special']) { ?>
		            <span class="pricenew"><?php echo $product['special']?></span>
		        	<span class="priceold"><?php echo $product['price']?></span>
		        <?php } else { ?>
		            <span class="oneprice"><?php echo $product['price']?></span>
		  		<?php } ?>
                </span>
              </li>
<?php
	}
}
?>
		</ul>
<?php if ( $block_framed ) { ?>
</div>
<?php } ?>
</div>