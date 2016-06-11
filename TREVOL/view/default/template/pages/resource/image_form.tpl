<style>
	form section { padding-left:10px; margin-bottom:20px; font-weight:bold; }
</style>

<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">

	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['resource/image_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
    	<div class="col-xs-8 text-center"><h5><?php echo $title;?></h5></div>
        <div class="col-xs-2 text-right"><a class="btn btn-danger" role="button" onclick="submitForm('main-form');">Save</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<form id="main-form" role="form" style="max-width:600px; margin:auto;" action="<?php echo $link['resource/image_post'];?>" method="post">
        
        	<!-- Demo -->
        	<div style="width:100%; text-align:center;">
            	<div id="demo" style="background-color:#CCC; width:300px; height:300px; margin:auto;">
                    <?php if($form['image'] != '') { echo $form['image'];  } else {?>
                        <div style="border:thin dashed #999; width:100%; height:100%;">
                           <div style="margin-top:120px;">No image</div>
                        </div>
                    <?php } ?>
                </div>
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
            	<label class="control-label col-sm-3 col-xs-12" for="input-image-id">ID</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="hidden" 
                        id="input-image-id" 
                        name="image_id"
                        value="<?php echo $form['image_id']; ?>"
                    >
                    <?php echo $form['image_id']; ?>
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
                        placeholder="Name" 
                        value="<?php echo $form['name']; ?>" 
                    >
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-file">File</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="file" 
                        class="form-control" 
                        id="input-file" 
                        name="file"
                        onchange="refreshImage(this.value);"
                    >
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-filename">Filename</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="text" 
                        class="form-control" 
                        id="input-filename" 
                        name="filename"
                        placeholder="Filename" 
                        value="<?php echo $form['filename']; ?>" 
                    >
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-size">Size</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="hidden" 
                        id="input-size" 
                        name="size"
                        value="<?php echo $form['size']; ?>"
                    >
                    <?php echo $form['size']; ?>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-photographer">Photographer</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="text" 
                        class="form-control" 
                        id="input-photographer" 
                        name="photographer"
                        placeholder="Photographer" 
                        value="<?php echo $form['photographer']; ?>" 
                    >
                </div>
            </div>
             <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-source">Source</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="url" 
                        class="form-control" 
                        id="input-source" 
                        name="source"
                        placeholder="Link of the source" 
                        value="<?php echo $form['source']; ?>" 
                    >
                </div>
            </div>
            
            <hr />
            <section>Relation</section>
        </form>
	</div>
    
    <div class="panel-footer col-xs-12">
    	<div class="col-xs-6 text-right"><a href="<?php echo $link['resource/image_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
        <div class="col-xs-6 text-left"><a class="btn btn-danger" role="button" onclick="submitForm('main-form');">Save</a></div>
	</div>
</div>

<img src="" title="" width=""  />
<script>
	function submitForm(form) {
		document.getElementById(form).submit();
	}
	
	function refreshImage(file) {
		document.getElementById("demo").innerHTML = file;
	}
</script>