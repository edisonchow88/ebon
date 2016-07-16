<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">

	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['resource/image_license_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
    	<div class="col-xs-8 text-center"><h5><?php echo $title;?></h5></div>
        <div class="col-xs-2 text-right"><a class="btn btn-danger" role="button" onclick="submitForm('form-main');">Save</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<form id="form-main" role="form" style="max-width:600px; margin:auto;" action="<?php echo $link['resource/image_license_post'];?>" method="post">
        	<!-- Demo -->
        	<div style="width:100%; text-align:center;">
        		<img width="25%" src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Cc.logo.circle.svg/2000px-Cc.logo.circle.svg.png" />
            </div>
            
            <!-- Form Action -->
            <div class="form-group">
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="hidden" 
                        name="action"
                        value="<?php echo $form['action']; ?>"
                    >
                </div>
            </div>
            
            <!-- Form Content -->
        	<section>General</section>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-image-license-id">Id</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="hidden" 
                        id="input-image-license-id" 
                        name="image_license_id"
                        value="<?php echo $form['image_license_id']; ?>"
                    >
                    <?php echo $form['image_license_id']; ?>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-name">Name</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="text" 
                        class="form-control" 
                        id="input-name" 
                        name="name"
                        value="<?php echo $form['name']; ?>" 
                    >
                </div>
            </div>
             <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-description">Description</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<textarea
                        class="form-control" 
                        id="input-description" 
                        name="description"
                        rows="5"
                    ><?php echo $form['description']; ?></textarea>
                </div>
            </div>
             <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-link">Link</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="url" 
                        class="form-control" 
                        id="input-link" 
                        name="link"
                        value="<?php echo $form['link']; ?>" 
                    >
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-sort-order">Sort Order</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="text" 
                        class="form-control" 
                        id="input-sort-order" 
                        name="sort_order"
                        value="<?php echo $form['sort_order']; ?>" 
                    >
                </div>
            </div>
        </form>
	</div>
    
    <div class="panel-footer col-xs-12">
    	<div class="col-xs-6 text-right"><a href="<?php echo $link['resource/image_license_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
        <div class="col-xs-6 text-left"><a class="btn btn-danger" role="button" onclick="submitForm('form-main');">Save</a></div>
	</div>
</div>

<script>
	function submitForm(form) {
		document.getElementById(form).submit();
	}
</script>