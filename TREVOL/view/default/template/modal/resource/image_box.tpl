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
                            <form action="upload.php" id="form-upload-image" method="post" enctype="multipart/form-data">
                                <input 
                                    type="file" 
                                    class="form-file" 
                                    id="input-file" 
                                    name="file"
                                    onchange="$('#form-upload-image').trigger('submit');"
                                >
                            </form>
                </div>
            </div>
        </div>
    
    </div>
</div>
<!-- END: Modal -->