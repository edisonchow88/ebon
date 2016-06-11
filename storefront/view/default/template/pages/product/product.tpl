<!-- 2016/03/22 DISABLED by TREVOL
<?php if ($success) { ?>
	<div class="alert alert-success">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<?php echo $success; ?>
	</div>
<?php } ?>

<?php if ($error) { ?>
	<div class="alert alert-error alert-danger">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<strong><?php echo is_array($error) ? implode('<br>', $error) : $error; ?></strong>
	</div>
<?php } ?>
-->

<div id="product_details">
		<!-- Product Details-->
		<div class="row">
        	<div class="col-xs-12"><h1 class="heading1"><span><?php echo $heading_title; ?></span></h1></div>
			<!-- Left Image-->
			<div class="col-xs-12 text-center">

			
			<?php if (sizeof($images) > 1) { ?>
            <ul class="thumbnails mainimage smallimage">
			    <?php foreach ($images as $image) { ?>
			    <li class="producthtumb">
			        <?php
			        if ($image['origin'] != 'external') {
			        ?>
				    	<a href="<?php echo $image['main_url']; ?>" data-standard="<?php echo $image['thumb2_url']; ?>">
			        	<img src="<?php echo $image['thumb_url']; ?>" alt="<?php echo $image['title']; ?>" title="<?php echo $image['title']; ?>" />
				    	</a>
			        <?php } ?>
			    </li>
			    <?php
			    } ?>
            </ul>
			<?php } ?>
			

			<div class="mainimage bigimage easyzoom easyzoom--overlay easyzoom--with-thumbnails">
			<?php if (sizeof($images) > 0) {
				//NOTE: ZOOM is not supported for embeded image tags
				if ($image_main['origin'] == 'external') {
				?>
				    <a class="html_with_image">
				    <?php echo $image_main['main_html'];	?>								
				    </a>
				<?php
				} else {
				    $image_url = $image_main['main_url'];
				    $thumb_url = $image_main['thumb_url'];
				?>
				    <a class="local_image" href="<?php echo $image_url; ?>" target="_image" title="<?php echo $image_main['title']; ?>">
				    	<img src="<?php echo $thumb_url; ?>" alt="<?php echo $image['title']; ?>" title="<?php echo $image['title']; ?>" />
				    	<!-- <i class="fa fa-arrows"></i> --> <!-- DISABLED by TREVOL-->
				    </a>
				<?php } ?>
				<?php
				} 
				?>
			</div>

			</div>
			<!-- Right Details-->
			<div class="col-xs-12">
				<div class="row">
                	<div class="col-xs-12 hidden-lg"><br/></div>
                    <div class="col-xs-12">
                    	<?php if ($tags) { ?>
                            <div class="tab-pane" id="producttag">
                                <ul class="tags" style="margin-top:0px;">
                                    <?php foreach ($tags as $tag) { ?>
                                    <li><a href="<?php echo $tag['href']; ?>"><i class="fa fa-tag"></i><?php echo $tag['tag']; ?></a></li>
                                        <?php } ?>
                                </ul>
                            </div>
                            <div><br /></div>
                        <?php } ?>
                	</div>
                    <div class="col-xs-12"><?php echo $description; ?></div>
                    <div class="col-xs-12" style="margin-top:18px;">HOURS:</div>
                    <div class="col-xs-12">
                        <?php 
                        foreach($hours as $hour) {
                        	
                            
                        	echo "<div class='row'>";
                            echo "<div class='col-xs-4'><i class='fa fa-clock-o'></i> ".$hour['date']."</div>";
                            echo "<div class='col-xs-3'>".$hour['day']."</div>";
                            echo "<div class='col-xs-3'>".$hour['description']."</div>";
                            echo "<div class='col-xs-2 text-right'>".$hour['time']."</div>";
                            echo "</div>";
                        }
                        ?>
                    </div>
                    <?php if(!empty($prices)) { ?>
                        <div class="col-xs-12" style="margin-top:18px;">FEES:</div>
                        <div class="col-xs-12">
                            <?php 
                            foreach($prices as $price) {
                                echo "<div class='row'>";
                                echo "<div class='col-xs-4'><i class='fa fa-ticket'></i> ".$price['name']."</div>";
                                echo "<div class='col-xs-4'>".$price['condition']."</div>";
                                echo "<div class='col-xs-4 text-right'>".$price['amount']."</div>";
                                echo "</div>";
                                echo "<br/>";
                            }
                            ?>
                        </div>
					<?php } ?>
                    <div class="col-xs-12"><a class="btn btn-primary" style="width:100%; margin-top:18px;" onclick="add_activity(<?php echo $activity_id; ?>);"><i class="fa fa-plus fa-fw"></i> Add to Trip</a></div> <!-- function add_activity() is stored in BLOCK trip.tpl-->
				</div>
			</div>
		</div>
</div>

<script type="text/javascript"><!--

	var orig_imgs = $('div.bigimage').html();
	var orig_thumbs = $('ul.smallimage').html();

	jQuery(function ($) {

		start_easyzoom();

		//if have product options, load select option images 
		var $select = $('input[name^=\'option\'], select[name^=\'option\']'); 
		if ($select.length) {
			//if no images for options are present, main product images will be used. 
			//if atleast one image is present in the option, main images will be replaced.
			//????load_option_images($select.val());
		}

		display_total_price();

		$('#current_reviews .pagination a').on('click', function () {
			$('#current_reviews').slideUp('slow');
			$('#current_reviews').load(this.href);
			$('#current_reviews').slideDown('slow');
			return false;
		});

		reload_review('<?php echo $product_review_url; ?>');
	});

	$('#product_add_to_cart').click(function () {
		$('#product').submit();
	});
	$('#review_submit').click(function () {
		review();
	})
	
	//process clicks in review pagination
	$('#current_reviews').on('click', '.pagination a', function () {
		reload_review($(this).attr('href'));
		return false;
	})

	/* Process images for product options */
	$('input[name^=\'option\'], select[name^=\'option\']').change(function () {
		load_option_images($(this).val());
		display_total_price();
	});

	$('input[name=quantity]').keyup(function () {
		display_total_price();
	});


	function start_easyzoom() {
		// Instantiate EasyZoom instances
		var $easyzoom = $('.easyzoom').easyZoom();
		
		// Get an instance API
		var api1 = $easyzoom.filter('.easyzoom--with-thumbnails').data('easyZoom');
		//clean and reload esisting events 
		api1.teardown();
		api1._init();
		
		// Setup thumbnails
		$('.thumbnails .producthtumb').on('click', 'a', function(e) {
		   var $this = $(this);
		   e.preventDefault();
		   // Use EasyZoom's `swap` method
		   api1.swap($this.data('standard'), $this.attr('href'));
		});
	}

	function load_option_images( attribute_value_id ) {
		$.ajax({
			type: 'POST',
			url: '<?php echo $option_resources_url; ?>&attribute_value_id=' + attribute_value_id,
			dataType: 'json',
			success: function (data) {
				var html1 = '';
				var html2 = '';
				
				if (data.main) {
					if (data.main.origin == 'external') {
						html1 = '<a class="html_with_image">';
						html1 += data.main.main_html + '</a>';						
					} else {
				    	html1 = '<a href="' + data.main.main_url + '">';
				    	html1 += '<img src="' + data.main.thumb_url + '" />';
				    	html1 += '<i class="fa fa-arrows"></i></a>';
				    }			
				}				
				if (data.images) {
					for (img in data.images) {
						html2 += '<li class="producthtumb">';
						var img_url = data.images[img].main_url;
						var tmb_url = data.images[img].thumb_url;
						var tmb2_url = data.images[img].thumb2_url;
						if (data.images[img].origin != 'external') {
							html2 += '<a href="'+img_url+'" data-standard="'+tmb2_url+'"><img src="' + tmb_url + '" alt="' + data.images[img].title + '" title="' + data.images[img].title + '" /></a>';
						}
						html2 += '</li>';
					}
				} else {
					html1 = orig_imgs;
					html2 = orig_thumbs;
				}
				$('div.bigimage').html(html1);
				$('ul.smallimage').html(html2);
				start_easyzoom();
			}
		});
	}

	function display_total_price() {

		$.ajax({
			type: 'POST',
			url: '<?php echo $calc_total_url;?>',
			dataType: 'json',
			data: $("#product").serialize(),

			success: function (data) {
				if (data.total) {
					$('.total-price-holder').show();
					$('.total-price-holder').css('visibility', 'visible');
					$('.total-price').html(data.total);
				}
			}
		});

	}

	function reload_review( url) {
		$('#current_reviews').load(url);
	}

	function review() {
		var dismiss = '<button type="button" class="close" data-dismiss="alert">&times;</button>';

		<?php if ($review_recaptcha) { ?>
		var captcha = '&g-recaptcha-response=' + encodeURIComponent($('textarea[name=\'g-recaptcha-response\']').val());
		<?php } else { ?>
		var captcha = '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val());
		<?php } ?>

		$.ajax({
			type: 'POST',
			url: '<?php echo $product_review_write_url;?>',
			dataType: 'json',
			data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + captcha,
			beforeSend: function () {
				$('.success, .warning').remove();
				$('#review_button').attr('disabled', 'disabled');
				$('#review_title').after('<div class="wait"><i class="fa fa-spinner fa-spin"></i> <?php echo $text_wait; ?></div>');
			},
			complete: function () {
				$('#review_button').attr('disabled', '');
				$('.wait').remove();
				<?php if ($review_recaptcha) { ?>
    				grecaptcha.reset();
    			<?php } ?>
			},
            error: function (jqXHR, exception) {
            	var text = jqXHR.statusText + ": " + jqXHR.responseText;
				$('#review .alert').remove();
				$('#review_title').after('<div class="alert alert-error alert-danger">' + dismiss + text + '</div>');
			},
			success: function (data) {
				if (data.error) {
					$('#review .alert').remove();
					$('#review_title').after('<div class="alert alert-error alert-danger">' + dismiss + data.error + '</div>');
				} else {
					$('#review .alert').remove();
					$('#review_title').after('<div class="alert alert-success">' + dismiss + data.success + '</div>');

					$('input[name=\'name\']').val('');
					$('textarea[name=\'text\']').val('');
					$('input[name=\'rating\']:checked').attr('checked', '');
					$('input[name=\'captcha\']').val('');
				}
				$('img#captcha_img').attr('src', $('img#captcha_img').attr('src') + '&' + Math.random());
			}
		});
	}

	function wishlist_add() {
		var dismiss = '<button type="button" class="close" data-dismiss="alert">&times;</button>';
		$.ajax({
			type: 'POST',
			url: '<?php echo $product_wishlist_add_url; ?>',
			dataType: 'json',
			beforeSend: function () {
				$('.success, .warning').remove();
				$('.wishlist_add').hide();
				$('.wishlist').after('<div class="wait"><i class="fa fa-spinner fa-spin"></i> <?php echo $text_wait; ?></div>');
			},
			complete: function () {
				$('.wait').remove();
			},
            error: function (jqXHR, exception) {
            	var text = jqXHR.statusText + ": " + jqXHR.responseText;
				$('.wishlist .alert').remove();
				$('.wishlist').after('<div class="alert alert-error alert-danger">' + dismiss + text + '</div>');
				$('.wishlist_add').show();
			},
			success: function (data) {
				if (data.error) {
					$('.wishlist .alert').remove();
					$('.wishlist').after('<div class="alert alert-error alert-danger">' + dismiss + data.error + '</div>');
					$('.wishlist_add').show();
				} else {
					$('.wishlist .alert').remove();
					//$('.wishlist').after('<div class="alert alert-success">' + dismiss + data.success + '</div>');
					$('.wishlist_remove').show();
				}
			}
		});
	}

	function wishlist_remove() {
		var dismiss = '<button type="button" class="close" data-dismiss="alert">&times;</button>';
		$.ajax({
			type: 'POST',
			url: '<?php echo $product_wishlist_remove_url; ?>',
			dataType: 'json',
			beforeSend: function () {
				$('.success, .warning').remove();
				$('.wishlist_remove').hide();
				$('.wishlist').after('<div class="wait"><i class="fa fa-spinner fa-spin"></i> <?php echo $text_wait; ?></div>');
			},
			complete: function () {
				$('.wait').remove();
			},
            error: function (jqXHR, exception) {
            	var text = jqXHR.statusText + ": " + jqXHR.responseText;
				$('.wishlist .alert').remove();
				$('.wishlist').after('<div class="alert alert-error alert-danger">' + dismiss + text + '</div>');
				$('.wishlist_remove').show();
			},
			success: function (data) {
				if (data.error) {
					$('.wishlist .alert').remove();
					$('.wishlist').after('<div class="alert alert-error alert-danger">' + dismiss + data.error + '</div>');
					$('.wishlist_remove').show();
				} else {
					$('.wishlist .alert').remove();
					//$('.wishlist').after('<div class="alert alert-success">' + dismiss + data.success + '</div>');
					$('.wishlist_add').show();
				}
			}
		});
	}
	
	function itinerarylist_add() {
		var dismiss = '<button type="button" class="close" data-dismiss="alert">&times;</button>';
		$.ajax({
			type: 'POST',
			url: '<?php echo $product_itinerarylist_add_url; ?>',
			dataType: 'json',
			beforeSend: function () {
				$('.success, .warning').remove();
				$('.itinerarylist_add').hide();
				$('.itinerarylist').after('<div class="wait"><i class="fa fa-spinner fa-spin"></i> <?php echo $text_wait; ?></div>');
			},
			complete: function () {
				$('.wait').remove();
			},
            error: function (jqXHR, exception) {
            	var text = jqXHR.statusText + ": " + jqXHR.responseText;
				$('.itinerarylist .alert').remove();
				$('.itinerarylist').after('<div class="alert alert-error alert-danger">' + dismiss + text + '</div>');
				$('.itinerarylist_add').show();
			},
			success: function (data) {
				if (data.error) {
					$('.itinerarylist .alert').remove();
					$('.itinerarylist').after('<div class="alert alert-error alert-danger">' + dismiss + data.error + '</div>');
					$('.itinerarylist_add').show();
				} else {
					$('.itinerarylist .alert').remove();
					//$('.itinerarylist').after('<div class="alert alert-success">' + dismiss + data.success + '</div>');
					$('.itinerarylist_remove').show();
				}
			}
		});
	}

	function itinerarylist_remove() {
		var dismiss = '<button type="button" class="close" data-dismiss="alert">&times;</button>';
		$.ajax({
			type: 'POST',
			url: '<?php echo $product_itinerarylist_remove_url; ?>',
			dataType: 'json',
			beforeSend: function () {
				$('.success, .warning').remove();
				$('.itinerarylist_remove').hide();
				$('.itinerarylist').after('<div class="wait"><i class="fa fa-spinner fa-spin"></i> <?php echo $text_wait; ?></div>');
			},
			complete: function () {
				$('.wait').remove();
			},
            error: function (jqXHR, exception) {
            	var text = jqXHR.statusText + ": " + jqXHR.responseText;
				$('.itinerarylist .alert').remove();
				$('.itinerarylist').after('<div class="alert alert-error alert-danger">' + dismiss + text + '</div>');
				$('.itinerarylist_remove').show();
			},
			success: function (data) {
				if (data.error) {
					$('.itinerarylist .alert').remove();
					$('.itinerarylist').after('<div class="alert alert-error alert-danger">' + dismiss + data.error + '</div>');
					$('.itinerarylist_remove').show();
				} else {
					$('.itinerarylist .alert').remove();
					//$('.itinerarylist').after('<div class="alert alert-success">' + dismiss + data.success + '</div>');
					$('.itinerarylist_add').show();
				}
			}
		});
	}

	//--></script>