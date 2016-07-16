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
<div class="modal fade" id="modal-replace-image" role="dialog">
    <div class="modal-dialog">
    
        <!-- "Add Type" Modal content-->
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title text-center">Upload Image</h4>
            </div>
            <div class="modal-body">
            	<div style="width:100%; text-align:center;">
                    <form action="<?php echo $ajax['resource/image_replace']; ?>" id="form-replace-image" method="post" enctype="multipart/form-data">
                        <input 
                            type="file" 
                            class="form-file" 
                            id="input-file" 
                            name="file"
                        >
                    </form>
                </div>
            </div>
        </div>
    
    </div>
</div>
<!-- END: Modal -->

<script>
	$("#form-replace-image").change(function(e) {
		//replace the display image via selected image
		var file = e.originalEvent.srcElement.files[0];
		var image_id = document.getElementById('input-image-id').value;
		var img = document.getElementById('image-'+image_id);
		var reader = new FileReader();
        reader.onloadend = function() {
             img.src = reader.result;
        }
        reader.readAsDataURL(file);
		
		//close modal
		$('#modal-replace-image').modal('hide');
		
		var form_element = document.querySelector("#form-replace-image");
		var form_data = new FormData(form_element);
		var xmlhttp = new XMLHttpRequest();
		var url = "<?php echo $ajax['resource/replace_image']; ?>";
		var data = "";
		var query = url + data;
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var json = JSON.parse(xmlhttp.responseText);
				document.getElementById('input-size').value = json.size;
				document.getElementById('text-size').innerHTML = formatBytes(json.size,0);
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