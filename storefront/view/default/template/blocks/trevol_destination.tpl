<a id="destination" name="destination"></a>
<span class="text-uppercase section-title">Destination</span>
<div class="sidewidt>
    <div class="row">
        <?php
        foreach ($categories as $category) {
            $item = $category;
            $item['image'] = !is_array($category['thumb']) ? '<img alt="'.$category['name'].'" src="' . $category['thumb'] . '"/>' : $category['thumb']['thumb_html'];
            $item['info_url'] = $category['href'];
        ?>
        <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12" style="padding:0;">
        	<div style="margin:0 auto; width:<?php echo $image_width; ?>;">
                <a class="btn btn-orange" style="text-align:left; width:100%;" href="<?php echo $item['info_url'] ?>">
                    <i class="fa fa-map-marker pull-left" style="width:20px; font-size:20px;"></i>
                    <?php echo $item['name']?>
                </a>
                <a href="<?php echo $item['info_url'] ?>"><?php echo $item['image']?></a>
                <!--
                <a href="<?php echo $add.$product['product_id'].'&product_id='.$product['product_id']; ?>" class="btn btn-primary" style="text-align:left; width:100%;">
                    <i class="fa fa-plus pull-left" style="padding-top:3px; width:30px;"></i> 
                    Add to Itinerary
                </a>
                -->
                <div><br /></div>
            </div>
        </div>
        <?php } ?>
    </div>
</div>