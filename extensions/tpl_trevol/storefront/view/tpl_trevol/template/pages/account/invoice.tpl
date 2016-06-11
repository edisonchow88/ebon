<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
  <script src="//code.jquery.com/jquery-1.10.2.js"></script>
  <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
  <link rel="stylesheet" href="/resources/demos/style.css">
  <style>
  	#sortable { list-style-type: none; margin: 0; padding: 0; width: 620px; }
  	#sortable li { margin: 0 3px 3px 3px; padding: 0.4em; padding-left: 1.5em; background-color:#f9f9f9;  border: 1px solid #ddd; overflow:hidden;}
  	#sortable li span { margin: 3px; display:inline-block; }
  	.sort_th { font-weight:bold; float:left; }
	.sort_tr { float:left; }
  	.sort_col1{ width:80px; }
	.sort_col2{ width:250px; }
	.sort_col4{ width:50px; }
	.sort_col5{ width:120px; float:right; }
}
  </style>

<input type="hidden" id="input_parent_id_key" value="order_id" />
<input type="hidden" id="input_parent_id_value" value="<?php echo $this->data['order_id'];?>" />
<input type="hidden" id="input_child_id_key" value="product_id" />
<input type="hidden" id="input_db" value="<?php echo $this->db->table('order_products');?>" />
<input type="hidden" id="input_url" value="<?php echo HTTPS_SERVER.'sortable.php';?>" />


<h1 class="heading1">
	<span class="maintext"><i class="fa fa-file"></i> <?php echo $heading_title; ?></span>
	<span class="subtext"></span>
</h1>
<?php if ($success) { ?>
<div class="alert alert-success">
	<button type="button" class="close" data-dismiss="alert">&times;</button>
	<?php echo $success; ?>
</div>
<?php } ?>

<div class="contentpanel">

	<div class="container-fluid invoice_products table-responsive">
		<ul id="sortable">
        	<li>
				<span class="sort_th sort_col1 align_left"><?php echo $text_image; ?></span>
				<span class="sort_th sort_col2 align_left"><?php echo $text_product; ?></span>
				<span class="sort_th sort_col4 align_right"><?php echo $text_total; ?></span>
                <span class="sort_th sort_col5 align_right"><?php echo "Action"; ?></span>
			</li>
			<?php 
                foreach ($products as $product) {
            	$id = $product['id']; ?>
				<li id="<?php echo 'pid-'.$id;?>" >
					<span class="sort_tr sort_col1" align="left" valign="top"><?php echo $product['thumbnail']['thumb_html']; ?></span>
					<span class="sort_tr sort_col2 align_left  valign_top"><a
								href="<?php echo str_replace('%ID%', $product['id'], $product_link) ?>"><?php echo $product['name']; ?></a>
						<?php foreach ($product['option'] as $option) { ?>
							<br/>
							&nbsp;
							<small title="<?php echo $option['title']?>"> - <?php echo $option['name']; ?> <?php echo $option['value']; ?></small>
						<?php } ?></span>
					<span class="sort_tr sort_col4 align_right valign_top"><?php echo $product['total']; ?></span>
                    <span class="sort_tr sort_col5 align_right valign_top">
                    	<a class="btn btn-sm btn-default"><i class="fa fa-trash fa-fw"></i></a>
                        <a class="btn btn-sm btn-default"><i class="fa fa-edit fa-fw"></i></a>
                    	<a class="btn btn-sm btn-default"><i class="fa fa-arrows fa-fw"></i></a></span>
				</li>
			<?php } ?>
			<?php echo $this->getHookVar('list_more_product_last'); ?>
		</ul>
	</div>

	<div class="form-group">
		<div class="mt20 mb40">
		    <a href="<?php echo $continue; ?>" class="btn btn-default mr10" title="<?php echo $button_continue->text ?>">
		    	<i class="<?php echo $button_continue->{'icon'}; ?>"></i>
		    	<?php echo $button_continue->text ?>
		    </a>
		    <?php echo $this->getHookVar('hk_additional_buttons'); ?>

			<?php if ($button_order_cancel) { ?>
		    <a href="" class="btn btn-default mr10 pull-right" data-toggle="modal" data-target="#cancelationModal"
		       title="<?php echo $button_order_cancel->text ?>">
		    	<i class="<?php echo $button_order_cancel->{'icon'}; ?>"></i>
		    	<?php echo $button_order_cancel->text ?>
		    </a>
				<div id="cancelationModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="cancelationModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
								<h3 id="returnPolicyModalLabel"><?php echo $text_order_cancelation; ?></h3>
							</div>
							<div class="modal-body"><?php echo $text_order_cancelation_confirm; ?></div>
							<div class="modal-footer">
								<button class="btn btn-default pull-left" data-dismiss="modal" aria-hidden="true"><i class="fa fa-close">&nbsp;</i><?php echo $text_close; ?></button>
								<button class="btn btn-orange pull-right" onclick="location='<?php echo $order_cancelation_url;?>';"><i class="fa fa-arrow-right"></i>&nbsp;<?php echo $button_continue->text; ?></button>
							</div>
						</div>
					</div>
				</div>

			<?php } ?>
		    <a href="javascript:window.print();" class="btn btn-orange mr10 pull-right"
		       title="<?php echo $button_print->text ?>">
		    	<i class="<?php echo $button_print->{'icon'}; ?>"></i>
		    	<?php echo $button_print->text ?>
		    </a>
		</div>
	</div>

	</form>
</div>

<script>
	$(function() {
    	$( "#sortable" ).sortable({
			items: 'li:not(:first)',
			cursor: 'move',
			helper: 'clone',
			opacity: 0.8,
			axis: 'y',
    		update: function (event, ui) {
				var data = $(this).sortable('serialize');
       		 	data += "&parent_id_key=";
				data += document.getElementById("input_parent_id_key").value;
				data += "&parent_id_value=";
				data += document.getElementById("input_parent_id_value").value;
				data += "&child_id_key=";
				data += document.getElementById("input_child_id_key").value;
				data += "&db=";
				data += document.getElementById("input_db").value;
				var url = document.getElementById("input_url").value;
		
        		$.ajax({
            		data: data,
            		type: 'POST',
            		url: url//Rename below php file
        		});
    		}
		});
		$( "#sortable" ).disableSelection();
	});
</script>