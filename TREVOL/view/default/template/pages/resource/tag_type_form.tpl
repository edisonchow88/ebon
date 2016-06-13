<style>
	form section { padding-left:10px; margin-bottom:20px; font-weight:bold; }
</style>
<div id="content" class="panel panel-default">

	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['resource/tag_type_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
    	<div class="col-xs-8 text-center"><h5><?php echo $title;?></h5></div>
        <div class="col-xs-2 text-right"><a class="btn btn-danger" role="button" onclick="submitForm('main-form');">Save</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<form id="main-form" role="form" style="max-width:600px; margin:auto;" action="<?php echo $link['resource/tag_type_post'];?>" method="post">
        	<div style="width:100%; text-align:center;">
        		<h3>
                    <span class="label" style="font-size:24px; background-color:<?php echo $form['type_color']; ?>;"><?php echo $form['name']; ?></span>
                </h3>
            </div>
            <div class="form-group">
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="hidden" 
                        name="action" 
                        value="<?php echo $form['action']; ?>"
                    >
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="tag-type-id">ID</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="hidden" 
                        id="tag-type-id" 
                        name="tag_type_id" 
                        value="<?php echo $form['tag_type_id']; ?>"
                    >
                    <?php echo $form['tag_type_id']; ?>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="type-name">Name</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="text" 
                        class="form-control" 
                        id="type-name" 
                        name="type_name" 
                        value="<?php echo $form['type_name']; ?>"
                    >
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="type-color">Color</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="color" 
                        class="form-control" 
                        id="type-color" 
                        name="type_color" 
                        placeholder="HTML colors HEX code" 
                        value="<?php echo $form['type_color']; ?>"
                    >
                </div>
            </div>
        </form>
	</div>
    
    <div class="panel-footer col-xs-12">
    	<div class="col-xs-6 text-right"><a href="<?php echo $link['resource/tag_type_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
        <div class="col-xs-6 text-left"><a class="btn btn-danger" role="button" onclick="submitForm('main-form');">Save</a></div>
	</div>
</div>

<script>
	function submitForm(form) {
		document.getElementById(form).submit();
	}
</script>