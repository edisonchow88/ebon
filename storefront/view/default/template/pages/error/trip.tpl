<style>
	body {
		background-color:#FFF;
	}
	
	.error_content {
		width:100%;
		max-width:600px;
		margin:auto;
		padding:15px;
		text-align:left;
	}
	.error_header {
		font-size:24px;
		color:#000;
		margin-bottom:30px;
	}
	.error_body {
		margin-bottom:30px;
	}
	.error_left {
		color:#000;
	}
	.error_title {
		font-size:18px;
		font-weight:bold;
		margin-bottom:15px;
	}
	.error_description {
		color:#333;
	}
	.error_footer div {
		padding:0 3px;
		margin-bottom:15px;
	}
</style>

<div class="error_content">
	<div class="error_header row">
		<div>
        	<a href="<?php echo $link['home']; ?>">
            	<?php echo $website_name; ?>
            </a>
        </div>
    </div>
    <div class="error_body row">
        <div class="error_left col-xs-12 col-sm-9">
            <div class="error_title">
            	<?php echo $error_title; ?>
            </div>
            <div class="error_description">
            	<?php echo $error_description; ?>
            </div>
        </div>
        <div class="error_right col-sm-3 hidden-xs">
            <div><i class="fa fa-fw fa-5x <?php echo $error_icon; ?>"></i></div>
        </div>
    </div>
    <div class="error_footer row">
    	<?php 
        	foreach($error_button as $e) {
            	echo '<div class="col-xs-12 col-sm-4">';
                echo '<a class="btn btn-block '.$e['class'].'" href="'.$e['url'].'">'.$e['title'].'</a>';
                echo '</div>';
        	}
        ?>
    </div>
</div>