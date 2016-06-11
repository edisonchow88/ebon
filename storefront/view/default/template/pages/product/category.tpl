<h1 class="heading1">
  <span><?php echo $heading_title; ?></span>
  <span class="subtext"></span>
</h1>

<div>

	<?php if ($description) { ?>
	<div style="margin-bottom: 15px;"><?php echo $description; ?></div>
	<?php } ?>
	<?php if (!$categories && !$products) { ?>
	<div class="content"><?php echo $text_error; ?></div>
	<?php } ?>
    
    <div class="container-fluid">
        <div class="row">
            <?php
            foreach ($categories as $category) {
                $item = $category;
                $item['image'] = !is_array($category['thumb']) ? '<img alt="'.$category['name'].'" src="' . $category['thumb'] . '"/>' : $category['thumb']['thumb_html'];
                $item['info_url'] = $category['href'];
            ?>
            <div class="col-lg-4 col-md-6 col-sm-6 col-xs-12" style="padding:0;">
                <div style="margin:0 auto; width:200px;">
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
    <br/>
    
	
	<?php if ($products) { ?>
	<!-- Sorting + pagination-->
    <!-- 2016/03/22 DISABLED by TREVOL
    <h1 class="heading1">Attraction</h1>
	<div class="sorting well">
	  <form class=" form-inline pull-left">
	    <?php echo $text_sort; ?>&nbsp;&nbsp;<?php echo $sorting; ?>
	  </form>
	  <div class="btn-group pull-right">
	    <button class="btn" id="list"><i class="fa fa-th-list"></i>
	    </button>
	    <button class="btn btn-orange" id="grid"><i class="fa fa-th"></i></button>
	  </div>
	</div>
    -->
	<!-- end sorting-->

	<?php include( $this->templateResource('/template/pages/product/product_listing.tpl') ) ?>
		
	<!-- Sorting + pagination-->
    <!-- 2016/03/22 DISABLED by TREVOL
	<div class="sorting well">
		<?php echo $pagination_bootstrap; ?>
		<div class="btn-group pull-right">
		</div>
	</div>
    -->
	<!-- end sorting-->
	
<?php } ?>		

		
</div>

<script type="text/javascript"><!--

$('#sort').change(function () {
	Resort();
});

function Resort() {
	url = '<?php echo $url; ?>';
	url += '&sort=' + $('#sort').val();
	url += '&limit=' + $('#limit').val();
	location = url;
}
//--></script>