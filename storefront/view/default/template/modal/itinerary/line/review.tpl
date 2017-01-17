<style>
	#modal-line-review .modal-body {
		padding:15px 15px 70px 0;
	}
	
	.review {
		padding:7px 0;
		color:#000;
	}
	
	.review-author-name {
	}
	
	.review-time {
		color:#999;
		font-size:12px;
	}
	
	.review-text {
		margin-top:7px;
		margin-bottom:7px;
		padding-bottom:15px;
		font-size:12px;
		border-bottom:solid thin #EEE;
	}
	
	.review-text .fa {
		color:#F90;
	}
	
	.review-profile {
	}
	
	.review-profile-photo {
		border-radius:25px;
		width:50px;
		min-height:50px;
	}
	
	.noimage {
		background-color:#000;
		border-radius:25px;
		width:50px;
		height:50px;
	}
</style>
<!-- START: Modal -->
    <div class="modal" id="modal-line-review" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
            <div class="modal-header fixed-width">
                <div class="navbar navbar-primary navbar-modal fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn" data-dismiss="modal" >Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span>Reviews</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-body fixed-width scrollable-y">
            	<div class="navbar navbar-shadow"></div>
                <div id="wrapper-explore-current-review"></div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-line-review").on( "shown.bs.modal", function() {
		$('#modal-line-review .modal-body').scrollTop(0);
	});
</script>