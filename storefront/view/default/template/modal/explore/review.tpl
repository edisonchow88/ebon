<style>
	#modal-explore-review .modal-body {
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
    <div class="modal modal-fixed-top" id="modal-explore-review" role="dialog">
        <div class="modal-wrapper">
        	<div class="modal-header">
            	<div class="fixed-bar">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-explore-review">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span class="btn-header modal-title">Reviews</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-bar">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body">
                        <div id="wrapper-explore-current-review"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-explore-review").on( "shown.bs.modal", function() {
		$('#modal-explore-review .modal-content').scrollTop(0);
	});
</script>