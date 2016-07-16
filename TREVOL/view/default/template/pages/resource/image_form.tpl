<style>
	#demo-replace-image-button {
		position:absolute; 
		top:0; 
		left:0; 
		opacity:0; 
		width:100%; 
		height:100%; 
		background-color:#000;
		cursor:pointer;
	}
	
	#demo-replace-image-button:hover {
		opacity:.9;
	}
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
            	<div id="demo" style="background-color:#CCC; width:300px; height:300px; margin:auto; position:relative;">
                    <?php if($form['image'] != '') { echo $form['image'];  } else {?>
                        <div style="border:thin dashed #999; width:100%; height:100%;">
                           <div style="margin-top:120px;">No image</div>
                        </div>
                    <?php } ?>
                    <div id="demo-replace-image-button">
                    	<div style="margin:auto; padding-top:100px; text-align:center;" data-toggle="modal" data-target="#modal-replace-image">
                            <i class="fa fa-upload fa-5x"></i>
                            <br /><br />Replace Image
                        </div>
                    </div>
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
        	<section>Description</section>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-name">
                    Name
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <input
                        type="text"
                        class="form-control"
                        id="input-name"
                        name="name"
                        value="<?php echo $form['name']; ?>" 
                    />
                </div>
            </div>
            <section>Source</section>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-photographer">
                    Photographer
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <input
                        type="text"
                        class="form-control"
                        id="input-photographer"
                        name="photographer"
                        value="<?php echo $form['photographer']; ?>"
                    />
                </div>
            </div>
             <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-link">
                    Link
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <input
                        type="text"
                        class="form-control"
                        id="input-link"
                        name="link"
                        value="<?php echo $form['link']; ?>" 
                    />
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-source-id">
                    Source
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <select 
                        class="form-control" 
                        id="input-source-id" 
                        name="image_source_id"
                    >
                        <option value="">-- Select source --</option>
                        <?php 
                            foreach($option['source'] as $image_source_id => $source) {
                                echo "<option value='".$image_source_id."'";
                                if($image_source_id == $form['image_source_id']) { echo " selected"; } 
                                echo ">".$source['name']."</option>";
                            }
                        ?>
                    </select>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-license-id">
                    License
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <select 
                        class="form-control" 
                        id="input-license-id" 
                        name="image_license_id"
                    >
                        <option value="">-- Select license --</option>
                        <?php 
                            foreach($option['license'] as $image_license_id => $license) {
                                echo "<option value='".$image_license_id."' ";
                                echo "data-toggle='tooltip' data-placement='right' ";
                                echo "title='".$image_license['description']."'";
                                if($image_license_id == $form['image_license_id']) { echo " selected"; } 
                                echo ">".$license['name']."</option>";
                            }
                        ?>
                    </select>
                    <span class="input-group-btn"><a class="btn btn-default" href="<?php echo $reference['license'];?>" target="_blank"><i class="fa fa-fw fa-question-circle"></i></a></span>
                </div>
            </div>
            <section>Tag</section>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-tag-time-id">
                    Time
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <span class="input-group-btn" style="z-index:20;">
                        <button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-tag-time"><i class="fa fa-plus"></i></button>
                    </span>
                    <input
                        type="hidden"
                        class="form-control"
                        id="input-tag-time-id"
                        name="tag_time_id"
                    />
                	<div id="container-tag-time" style="position:absolute; top:5px; left:40px; z-index:10; width:100%;"></div>
                </div>
            </div>
            <section>Linked</section>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-destination-id">
                    Destination
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <span class="input-group-btn" style="z-index:20;">
                        <button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-image-destination"><i class="fa fa-plus"></i></button>
                    </span>
                    <input
                        <input
                        type="hidden"
                        class="form-control"
                        id="input-destination-id"
                        name="destination_id" 
                    />
                	<div id="container-image-destination" style="position:absolute; top:5px; left:40px; z-index:10; width:100%;"></div>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-interest-id">
                    Interest
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <input
                        type="hidden"
                        class="form-control"
                        id="input-interest-id"
                        name="interest_id" 
                    />
                </div>
            </div>
            
            <section>General</section>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-image-id">
                    Id
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <input
                        type="hidden"
                        class="form-control"
                        id="input-image-id"
                        name="image_id" 
                        value="<?php echo $form['image_id']; ?>"
                    />
                    <?php echo $form['image_id']; ?>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-size">
                    Size
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <input
                        type="hidden"
                        class="form-control"
                        id="input-size"
                        name="size" 
                        value="<?php echo $form['size']; ?>"
                    />
                    <span id="text-size"><?php echo $form['size']; ?></span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-filename">
                   Filename
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <input
                        type="hidden"
                        class="form-control"
                        id="input-filename"
                        name="filename" 
                        value="<?php echo $form['filename']; ?>"
                    />
                    <span id="text-filename"><?php echo $form['filename']; ?></span>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-date-added">
                   Date Added
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <input
                        type="hidden"
                        class="form-control"
                        id="input-date-added"
                        name="date_added" 
                        value="<?php echo $form['date_added']; ?>"
                    />
                    <?php echo $form['date_added']; ?>
                </div>
            </div>
            <div class="form-group">
                <label class="control-label col-sm-3 col-xs-12" for="input-date-modified">
                   Date Modified
                </label>
                <div class="input-group col-sm-9 col-xs-12">
                    <input
                        type="hidden"
                        class="form-control"
                        id="input-date-modified"
                        name="date_modified" 
                        value="<?php echo $form['date_modified']; ?>"
                    />
                    <?php echo $form['date_modified']; ?>
                </div>
            </div>
        </form>
	</div>
    
    <div class="panel-footer col-xs-12">
    	<div class="col-xs-6 text-right"><a href="<?php echo $link['resource/image_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
        <div class="col-xs-6 text-left"><a class="btn btn-danger" role="button" onclick="submitForm('main-form');">Save</a></div>
	</div>
</div>

<!-- START: Modal -->
<?php echo $modal_tag_time; ?>
<?php echo $modal_image_destination; ?>
<?php echo $modal_replace_image; ?>
<script>
	setTagTime(<?php echo $form['tag_time']; ?>)
	setImageDestination(<?php echo $form['image_destination']; ?>)
</script>
<!-- END: Modal -->

<script>
	function submitForm(form) {
		document.getElementById(form).submit();
	}
	
	function refreshImage(file) {
		document.getElementById("demo").innerHTML = file;
	}
</script>