<style>
	#modal-line-delete .modal-modal {
		top:0;
		height:100vh;
	}
	
	.modal-modal-button {
		position:absolute;
		width:100%;
		padding:15px;
		top:calc(50vh);
		z-index:30;
	}
	
	.modal-modal-button .btn {
		background-color:#FFF;
		height:50px;
		padding:15px;
		border-bottom:solid thin #DDD;
	}
</style>

<!-- START: Modal -->
	<div class="modal" id="modal-line-delete" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-body modal-body-center fixed-width">
                <div class="modal-body-header row">
                    <div class="col-xs-12">Delete Activity</div>
                </div>
                <div class="modal-body-body row">
                    <div class="col-xs-12">Are you sure that you want to permanently delete <div class="modal-target"></div>? You can't undo this action.</div>
                </div>
                <div class="modal-body-footer row">
                    <div class="col-xs-6" data-dismiss="modal"><a>CANCEL</a></div>
                    <div class="col-xs-6" data-dismiss="modal" onclick="deletePlanLine();"><a>DELETE FOREVER</a></div>
                </div>
            </div>
        </div>
    </div>
<!--
    <div class="modal" id="modal-line-delete" role="dialog" data-backdrop="false">
        <div class="modal-dialog fixed-bar fixed-width">
            <div class="modal-content" style="position:relative;">
                <div class="modal-modal fixed-width" data-toggle="modal" data-target="#modal-line-delete"></div>
                <div class="modal-modal-button">
                	<div><a class="btn btn-block" style="color:#F00;" onclick="deletePlanLine();">Delete Activity</a></div>
                    <div><a class="btn btn-block" style="color:#000;" data-toggle="modal" data-target="#modal-line-delete"><b>Cancel</b></a></div>
                </div>
            </div>
        </div>
    </div>
-->
<!-- END -->

