<div class="container-fluid">
    <ul class="thumbnails grid row">
        <?php
        foreach ($products as $product) {
            $item = array();
            $item['image'] = $product['thumb']['thumb_html'];
            $item['title'] = $product['name'];
            $item['description'] = $product['model'];
            $item['rating'] = ($product['rating']) ? "<img src='" . $this->templateResource('/image/stars_' . $product['rating'] . '.png') . "' alt='" . $product['stars'] . "' />" : '';
    
            $item['info_url'] = $product['href'];
            $item['buy_url'] = $product['add'];
    
            if (!$display_price) {
                $item['price'] = '';
            }
    
            $review = $button_write;
            if ($item['rating']) {
                $review = $item['rating'];
            }
        ?>
            <li class="col-lg-4 col-md-6 col-sm-6 col-xs-12">
                <div class="thumbnail">
                	<a class="btn btn-orange" style="width:<?php echo $image_product_width; ?>;" href="<?php echo $item['info_url'] ?>" title="<?php echo $item['title'] ?>">
                	<i class="fa fa-camera pull-left" style="width:20px; font-size:20px;"></i> 
                    <?php echo $item['title']?>
                </a>
                    <?php if ($product['special']) { ?>
                        <span class="sale tooltip-test"><?php echo $text_sale_label; ?></span>
                    <?php } ?>
                    <?php if ($product['new_product']) { ?>
                        <span class="new tooltip-test"><?php echo $text_new_label; ?></span>
                    <?php } ?>
                    <a href="<?php echo $item['info_url'] ?>"><?php echo $item['image'] ?></a>
                    <!-- <div class="blurb"><?php echo $product['blurb'] ?></div> TEMPORARY DISABLED-->
                    <?php echo $this->getHookvar('product_listing_details0_'.$product['product_id']);?>
                    	<a onclick="add_activity(<?php echo $product['product_id']; ?>)" class="btn btn-primary" style="display:inline-block; width:<?php echo $image_product_width; ?>;"><span class="glyphicon glyphicon-plus"></span> Add</a>
                </div>
            </li>
        <?php
        }
        ?>
    </ul>
</div>
    
<div class="container-fluid">
    <ul class="thumbnails list row">
        <?php
        foreach ($products as $product) {
            $item = array();
            $item['image'] = $product['thumb']['thumb_html'];
            $item['title'] = $product['name'];
            $item['rating'] = ($product['rating']) ? "<img src='" . $this->templateResource('/image/stars_' . $product['rating'] . '.png') . "' alt='" . $product['stars'] . "' />" : '';
    
            $item['info_url'] = $product['href'];
            $item['buy_url'] = $product['add'];
            if (!$display_price) {
                $item['price'] = '';
            }
    
            $review = $button_write;
            if ($item['rating']) {
                $review = $item['rating'];
            }
    
            ?>
            <li>
                <div class="thumbnail">
                    <div class="row">
                        <div class="col-md-4">
                            <?php if ($product['special']) { ?>
                                <span class="sale tooltip-test"><?php echo $text_sale_label; ?></span>
                            <?php } ?>
                            <?php if ($product['new_product']) { ?>
                                <span class="new tooltip-test"><?php echo $text_new_label; ?></span>
                            <?php } ?>
                            <?php echo $this->getHookvar('product_listing_label_'.$product['product_id']);?>
                            <a href="<?php echo $item['info_url'] ?>"><?php echo $item['image'] ?></a>
                        </div>
                        <div class="col-md-8">
                            <a class="prdocutname" href="<?php echo $item['info_url'] ?>"><?php echo $item['title'] ?>
                                <?php echo $product['model'] ? "(".$product['model'].")" :''; ?></a>
                            <div class="productdiscrption"><?php echo $product['description'] ?></div>
                            <div class="shortlinks">
                                <a class="details" href="<?php echo $item['info_url'] ?>"><?php echo $button_view ?></a>
                                <!-- DISABLED by TREVOL, 2016/01/25
                                <?php if ($review_status) { ?>
                                    <a class="compare"
                                       href="<?php echo $item['info_url'] ?>#review"><?php echo $review ?></a>
                                <?php } ?>
                                <?php echo $product['buttons'];?>
                                -->
                            </div>
                            <div class="blurb"><?php echo $product['blurb'] ?></div>
                            <?php echo $this->getHookvar('product_listing_details00_'.$product['product_id']);?>
                            <?php if ($display_price) { ?>
                            <div class="pricetag pull-right">
                                <span class="spiral"></span>
                                
                                <!-- DISABLED by TREVOL, 2016/01/25
                                <?php if($product['call_to_order']){ ?>
                                    <a data-id="<?php echo $product['product_id'] ?>" href="#"
                                           class="btn call_to_order"><?php echo $text_call_to_order?>&nbsp;&nbsp;<i class="fa fa-phone"></i></a>
                                <?php } else if ($product['track_stock'] && !$product['in_stock']) { ?>
                                    <span class="nostock"><?php echo $product['no_stock_text']; ?></span>
                                <?php } else { ?>
                                    <a data-id="<?php echo $product['product_id'] ?>"
                                                               href="<?php echo $item['buy_url'] ?>"
                                                               class="productcart"><?php echo $button_add_to_cart ?></a>
                                    
                                <?php } ?>
                                -->
                                <div class="price">
                                    <?php if ($product['special']) { ?>
                                        <div class="pricenew"><?php echo $product['special'] ?></div>
                                        <div class="priceold"><?php echo $product['price'] ?></div>
                                    <?php } else { ?>
                                        <div class="oneprice"><?php echo $product['price'] ?></div>
                                    <?php } ?>
                                </div>
                                <a href="<?php echo $add.$product['product_id'].'&product_id='.$product['product_id']; ?>" class="btn btn-primary" style="display:inline-block; width:<?php echo $image_product_width; ?>;"><span class="glyphicon glyphicon-plus"></span> Add</a>
                            </div>
                            <?php } ?>
                            <?php echo $this->getHookvar('product_listing_details11_'.$product['product_id']);?>
                        </div>
    
                    </div>
                </div>
            </li>
        <?php
        }
        ?>
    </ul>
</div>