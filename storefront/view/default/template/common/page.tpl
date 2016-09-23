
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>" <?php echo $this->getHookVar('hk_html_attribute'); ?>>


<head>
<?php echo $head; ?>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
</head>

<body>

<?php if(strpos($_REQUEST["rt"],"trip") === false) { ?>
	<?php echo $content; ?>
<?php } else { ?>    
<div class="container-fluid">
	<div class="row">
    	<div class="col-xs-12">
            <?php echo ${$header}; ?>
        </div>
    </div>
    
    <div><?php echo ${$header_bottom}; ?></div>
    <div id="wrapper-main">
        <div id="wrapper-left">
            <?php echo ${$column_left}; ?>
        </div>
        <div id="wrapper-center">
        
            <?php if ( !empty( ${$content_top} ) ) { echo ${$content_top}; } ?>
            
            <div id="wrapper-center-content">
            	<?php echo $content; ?>
            </div>
            
            <?php if ( !empty( ${$content_bottom} ) ) { echo ${$content_bottom}; } ?>
            
        </div>
        <div id="wrapper-right">
            <?php echo ${$column_right}; ?>
        </div>
    </div>
</div>
<?php } ?>

<?php if ( !empty( ${$footer_top} ) ) { ?>
<!-- footer top blocks placeholder -->
	<div class="container-fluid">
		<div class="col-md-12">
	    <?php echo ${$footer_top}; ?>
	  	</div>
	</div>
<!-- footer top blocks placeholder -->
<?php } ?>

<!-- footer blocks placeholder -->
<div id="wrapper-footer">
	<?php echo ${$footer}; ?>
</div>

</body>
</html>