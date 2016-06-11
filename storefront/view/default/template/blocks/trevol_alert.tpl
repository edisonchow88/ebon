<div class="row">
    <div class="col-xs-12">
        <div id="alert_container">
            <?php if ($success) { ?>
                <div class="alert alert-success">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <div class='row'>
                    	<div class='col-xs-3 col-sm-2'>
                        	<span class='fa-stack fa-2x'>
                            	<i class='fa fa-stack-2x fa-circle'></i>
                                <i class='fa fa-stack-1x fa-inverse fa-check'></i>
                        	</span>
                    	</div>
                        <div class='col-xs-8 col-sm-9'>
                        	<b style='font-size:16px;'>SUCCESS!</b><br />
                            <?php echo $success; ?>
                        </div>
                    </div>
                </div>
            <?php } ?>
            
            <?php if ($error) { ?>
                <div class="alert alert-danger">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <div class='row'>
                    	<div class='col-xs-3 col-sm-2'>
                        	<span class='fa-stack fa-2x'>
                            	<i class='fa fa-stack-2x fa-circle'></i>
                                <i class='fa fa-stack-1x fa-inverse fa-exclamation-triangle'></i>
                        	</span>
                    	</div>
                        <div class='col-xs-8 col-sm-9'>
                        	<b style='font-size:16px;'>ERROR!</b><br />
                            <?php echo is_array($error) ? implode('<br>', $error) : $error; ?>
                        </div>
                    </div>
                </div>
            <?php } ?>
        </div>
    </div>
</div>