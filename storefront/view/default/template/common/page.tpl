<?php if(strpos($_REQUEST["rt"],"ajax") === false) {?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" xml:lang="<?php echo $lang; ?>" <?php echo $this->getHookVar('hk_html_attribute'); ?>>
<head><?php	echo $head; ?></head>
<body>

<?php if($maintenance_warning){ ?>
    <div style="width:100%; margin-top:20vh; text-align:center;">
    	<div style="font-size:48px; color:#F90;">Trevol</div>
    	<br/>Thanks for showing interest.<br/> Next beta version is coming on:<br/> <br/> 
    	<div style="font-size:24px"><b>31 August 2016</b></div>
    </div>
<?php exit; } ?>

<a id="top" name="top"></a>
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

<?php if ( !empty( ${$footer_top} ) ) { ?>
	<div class="container-fluid">
		<div class="col-md-12">
	    <?php echo ${$footer_top}; ?>
	  	</div>
	</div>
<?php } ?>

<?php echo ${$footer}; ?>

</body>
</html>

<?php } ?>