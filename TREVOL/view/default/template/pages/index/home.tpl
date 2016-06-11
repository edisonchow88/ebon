<div class="row">
<div class="col-sm-12 col-lg-12">
	<div class="panel panel-default">
		<div class="panel-body">

	    <div class="row">
	        <?php foreach( $shortcut as $item ) { ?>
	            <div class="col-xs-4 col-sm-3 col-md-2 shortcut temp text-center">
					<a href="<?php echo $item['href'] ?>">
						<?php echo $item['icon'] ?>
						<h5><?php echo $item['text'] ?></h5>
					</a>
	            </div>
	        <?php } ?>
	    </div>

  		</div>
  	</div>
</div>
</div>