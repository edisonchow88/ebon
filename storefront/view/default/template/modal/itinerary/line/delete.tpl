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
<!-- END -->

