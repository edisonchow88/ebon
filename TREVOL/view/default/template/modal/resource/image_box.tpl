<style>
	.form-file {
		background-color: #CCC;
		outline: thin dashed #999;
		outline-offset: -10px;
		width:300px;
		height:300px;
		margin:auto;
		padding-top:130px;
		padding-left:60px;
	}
</style>

<!-- START: Modal -->
<div class="modal fade" id="modal-upload-image" role="dialog">
    <div class="modal-dialog">
    
        <!-- "Add Type" Modal content-->
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title text-center">Upload Image</h4>
            </div>
            <div class="modal-body">
            	<div style="width:100%; text-align:center;">
                    <form action="<?php echo $ajax['resource/image_upload']; ?>" id="form-upload-image" method="post" enctype="multipart/form-data">
                        <input 
                            type="file" 
                            class="form-file" 
                            id="input-file" 
                            name="file"
                            onchange="upload_image();"
                        >
                    </form>
                </div>
                <div class="modal-form">
                	<form id="form-edit-image" role="form" method="post">
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
                                    name="source_id"
                                >
                                    <option value="">-- Select source --</option>
                                    <?php 
                                        foreach($option['source'] as $source_id => $source) {
                                            echo "<option value='".$source_id."'";
                                            if($source_id == $form['image_source_id']) { echo " selected"; } 
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
                                    name="license_id"
                                >
                                    <option value="">-- Select license --</option>
                                    <?php 
                                        foreach($option['license'] as $license_id => $license) {
                                            echo "<option value='".$license_id."' ";
                                            echo "data-toggle='tooltip' data-placement='right' ";
                                            echo "title='".$license['description']."'";
                                            if($license_id == $form['image_license_id']) { echo " selected"; } 
                                            echo ">".$license['name']."</option>";
                                        }
                                    ?>
                                </select>
                                <span class="input-group-btn"><a class="btn btn-default" href="<?php echo $reference['license'];?>" target="_blank"><i class="fa fa-fw fa-question-circle"></i></a></span>
                            </div>
                        </div>
                        <section>Tag</section>
                    	<div class="form-group">
                            <label class="control-label col-sm-3 col-xs-12" for="input-tag-id">
                                Tag
                            </label>
                            <div class="input-group col-sm-9 col-xs-12">
                                <input
                                    type="hidden"
                                    class="form-control"
                                    id="input-tag-id"
                                    name="tag_id" 
                                />
                            </div>
                        </div>
                        
                        <section>Linked</section>
                    	<div class="form-group">
                            <label class="control-label col-sm-3 col-xs-12" for="input-destination-id">
                                Destination
                            </label>
                            <div class="input-group col-sm-9 col-xs-12">
                                <input
                                    type="hidden"
                                    class="form-control"
                                    id="input-destination-id"
                                    name="destination_id" 
                                />
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
                                />
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
                                />
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
                                />
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
                                />
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
                                />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
            	<div class="alert alert-warning text-left">
                	<h5><b>Pending Upgrade</b></h5>
                    <ul>
                        <li>Function to verify uploaded file</li>
                        <li>Function to crop image</li>
                        <li>Function to resize image</li>
                        <li>Enchanced user interface</li>
                    </ul>
                </div>
            </div>
        </div>
    
    </div>
</div>
<!-- END: Modal -->

<script>
	function upload_image() {
		var form_element = document.querySelector("#form-upload-image");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $ajax['resource/image_upload']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById('modal-body').innerHTML = xmlhttp.responseText;
			} else {
				document.getElementById('modal-body').innerHTML = "Error" + xmlhttp.status;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	}
</script>