<style>
	.form-file {
		position:absolute;
		top:0;
		left:0;
		opacity:0;
		width:300px;
		height:300px;
		padding-top:130px;
		padding-left:60px;
	}
	
	#demo {
		margin:auto;
		position:relative;
		width:300px;
		height:300px;
	}
	
	#demo-photo-background {
		position:absolute; 
		top:0; 
		left:0;
		background-color:#CCC; 
		outline: thin dashed #999;
		outline-offset: -10px;
		width:100%; 
		height:100%;
	}
	
	#demo-photo {
		position:absolute; 
		top:0; 
		left:0;
		width:100%;
		height:100%;
	}
	
	#demo-photo-button {
		position:absolute; 
		top:0; 
		left:0; 
		opacity:0; 
		width:100%; 
		height:100%; 
		background-color:#000;
		cursor:pointer;
	}
	
	#demo-photo-button:hover {
		opacity:.9;
	}
	
	#form-add-photo {
		display:none;
	}
	
	#modal-upload-photo-footer {
		display:none;
	}
</style>

<!-- START: Modal -->
<div class="modal fade" id="modal-add-photo" role="dialog">
    <div class="modal-dialog">
    
        <!-- "Add Type" Modal content-->
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title text-center">Upload Photo</h4>
            </div>
            <div class="modal-body">
            	<div id="form-upload-photo-warning"></div>
            	<div style="width:100%; text-align:center;">
                    <form id="form-upload-photo" method="post" enctype="multipart/form-data">
                    	<div id="demo">
                            <div id="demo-photo-background">
                                <div style="margin:auto; padding-top:100px; text-align:center;">
                                    <i class="fa fa-upload fa-5x"></i>
                                    <br /><br />Select photo to upload
                                </div>
                            </div>
                            <img id="demo-photo"/>
                            <input 
                                type="file" 
                                class="form-file" 
                                id="input-temp-file" 
                                name="file"
                            >
                            <div id="demo-photo-button" onclick="$('#input-temp-file').trigger('click'); ">
                                <div style="margin:auto; padding-top:100px; text-align:center;">
                                    <i class="fa fa-upload fa-5x"></i>
                                    <br /><br />Select photo to upload
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div>
                    <form id="form-add-photo" role="form" action="<?php echo $ajax['resource/ajax_photo'];?>" method="post" enctype="multipart/form-data">
                        <!-- Form Action -->
                        <div class="form-group">
                            <div class="input-group col-sm-9 col-xs-12">
                                <input 
                                    type="hidden" 
                                    name="action"
                                    value="add"
                                >
                            </div>
                        </div>
                        
                        
                        <div class="form-group" style="display:none;">
                            <div class="input-group col-sm-9 col-xs-12">
                                <input 
                                    type="file" 
                                    class="form-control" 
                                    id="input-file" 
                                    name="file"
                                >
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-xs-12 text-center">
                                <span id="text-filename"></span>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-xs-12 text-center">
                                <input
                                    type="hidden"
                                    class="form-control"
                                    id="input-size"
                                    name="size" 
                                />
                                <span id="text-size"></span>
                            </div>
                        </div>
                        
                        <!-- Form Content -->
                        <div class="form-group">
                            <label class="control-label col-sm-3 col-xs-12" for="input-caption">
                                Caption
                            </label>
                            <div class="input-group col-sm-9 col-xs-12">
                                <input
                                    type="text"
                                    class="form-control"
                                    id="input-caption"
                                    name="caption"
                                    value="<?php echo $form['caption']; ?>" 
                                />
                            </div>
                        </div>
                    </form>
                </div>
            </div>
            <div id="modal-upload-photo-footer" class="modal-footer">
            	<div class="col-xs-3"></div>
                <div class="col-xs-3"><a class="btn btn-block btn-default" role="button" onclick="$('#modal-upload-photo').modal('hide');">Cancel</a></div>
                <div class="col-xs-3"><a class="btn btn-block btn-danger" role="button" onclick="$('#form-add-photo').submit();">Save</a></div>
                <div class="col-xs-3"></div>
            </div>
        </div>
    
    </div>
</div>
<!-- END: Modal -->

<script>
	$("#form-upload-photo").change(function(e) {
		//replace the display photo via selected photo
		var file = e.originalEvent.srcElement.files[0];
		var img = document.getElementById('demo-photo');
		var reader = new FileReader();
        reader.onloadend = function() {
             img.src = reader.result;
        }
        reader.readAsDataURL(file);
		
		var form_element = document.querySelector("#form-upload-photo");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $ajax['travel/photo/ajax_photo']; ?>";
		var data = "&action=try_add";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var json = JSON.parse(xmlhttp.responseText);
				document.getElementById('form-upload-photo-warning').innerHTML = "";
				if(json.warning.length > 0) {
					var content;
					content = "<div class='alert alert-danger'>Error:<br/><ul>";
					for(i=0;i<json.warning.length;i++) {
						content += "<li>"+json.warning[i]+"</li>";
					}
					content += "</ul></div>";
					document.getElementById('form-upload-photo-warning').innerHTML = content;
				}
				else {
					document.getElementById('input-size').value = json.size;
					document.getElementById('input-file').files = document.getElementById('input-temp-file').files;
					document.getElementById('text-size').innerHTML = formatBytes(json.size,0);
					document.getElementById('text-filename').innerHTML = json.name;
					document.getElementById('form-add-photo').style.display = 'block';
					document.getElementById('modal-upload-photo-footer').style.display = 'block';
				}
			} else {
				document.getElementById('modal-body').innerHTML = json.alert;
			}
		};
		xmlhttp.open("POST", query, true);
		xmlhttp.send(form_data);
	});
	
	function formatBytes(bytes,decimals) {
	   if(bytes == 0) return '0 Byte';
	   var k = 1000; // or 1024 for binary
	   var dm = decimals + 1 || 3;
	   var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
	   var i = Math.floor(Math.log(bytes) / Math.log(k));
	   return parseFloat((bytes / Math.pow(k, i)).toFixed(dm)) + ' ' + sizes[i];
	}
</script>