<h1 class="heading1">
  <span><?php echo $heading_title; ?></span>
  <span class="subtext"></span>
</h1>

<div class="contentpanel">

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
                $item['image'] = !is_array($category['thumb']) ? '<img alt="'.$category['name'].'" class="thumbnail_small" src="' . $category['thumb'] . '" style="width:160px;"/>' : $category['thumb']['thumb_html'];
                $item['info_url'] = $category['href'];
            ?>
            <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12 text-center" style="padding:5px; height:200px;">
                    <a href="<?php echo $item['info_url'] ?>"><?php echo $item['image']?></a>
                    <br/>
                    <a class="productname" href="<?php echo $item['info_url'] ?>"><?php echo $item['name']?></a>
            </div>
            <?php } ?>
        </div>
    </div>
    <br/>
    

	<?php if ($products) { ?>
	<!-- Sorting + pagination-->
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
	<!-- end sorting-->

	<?php include( $this->templateResource('/template/pages/product/product_listing.tpl') ) ?>
		
	<!-- Sorting + pagination-->
	<div class="sorting well">
		<?php echo $pagination_bootstrap; ?>
		<div class="btn-group pull-right">
		</div>
	</div>
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