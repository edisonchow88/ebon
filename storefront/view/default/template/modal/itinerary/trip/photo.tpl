<style>	
	.swiper-page {
		position:absolute;
		background-color:#EEE;
		border:solid thin #CCC;
		border-radius:15px;
		left:0;
		right:0;
		bottom:10px;
		width:110px;
		margin:auto;
		padding:3px 6px;
		z-index:100;
	}
	
	.swiper-button-left {
		display:inline-block;
		color:#000;
	}
	
	.swiper-button-right {
		display:inline-block;
		color:#000;
	}
	
	.swiper-button-disabled {
		color:#CCC !important;
	}
	
	.swiper-pagination {
		display:inline-block;
		position:relative;
		bottom:0;
		width:auto;
	}
</style>
<style>		
	.photo-slide {
		height:100vh;
		position:fixed;
		top:0;
		left:0;
		right:0;
		margin:auto;
		z-index:-1;
		opacity:0;
		background-color:#000;
	}
</style>

<!-- START: Modal -->
<!-- IMPORTANT: idangero swiper cannot be work inside hidden element hence following codes are used to counter it -->
    <div id="modal-trip-photo" class="photo-slide fixed-width">
        <div class="navbar navbar-primary navbar-file">
            <div class="col-xs-3 text-left">
                <a class="btn" data-dismiss="modal" onclick="hidePhotoSlide();"><i class="fa fa-fw fa-lg fa-times"></i></a>
            </div>
            <div class="col-xs-6 text-center">
                <span></span>
            </div>
            <div class="col-xs-3 text-right">
                <a class="btn" data-toggle="modal" data-target="#modal-photo-confirm-delete"><i class="fa fa-fw fa-lg fa-trash"></i></a>
            </div>
        </div>
        <div class="swiper-container">
            <div class="swiper-wrapper">
            </div>
            <div class="swiper-page">
                <div class="col-xs-3 text-left">
                    <a>
                        <div class="swiper-button-left"><i class="fa fa-fw fa-lg fa-angle-left"></i></div>
                    </a>
                </div>
                <div class="col-xs-6 text-center">
                    <div class="swiper-pagination"></div>
                </div>
                <div class="col-xs-3 text-right">
                    <a>
                        <div class="swiper-button-right"><i class="fa fa-fw fa-lg fa-angle-right"></i></div>
                    </a>
                </div>
            </div>
        </div>
    </div>
<!-- END -->
<!-- START: Modal -->
<!--
    <div class="modal fade" id="modal-photo-action" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-dialog fixed-width">
            	<form id="modal-photo-action-form" class="hidden">
                	<input type="text" name="trip_photo_id"/>
                    <input type="text" name="name"/>
                </form>
            </div>
            <div class="modal-body modal-body-bottom fixed-width">
            	<div class="la la-50 la-border la-hover noselect">
                    <div class="la-row modal-photo-action-delete" data-dismiss="modal" data-toggle="modal" data-target="#modal-photo-confirm-delete">
                        <div class="la-icon">
                            <i class="fa fa-fw fa-lg fa-trash text-danger"></i>
                        </div>
                        <div class="la-desc">
                            <div class="la-text text-danger">Delete Forever</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
-->
<!-- END -->
<!-- START: Modal -->
    <div class="modal" id="modal-photo-confirm-delete" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-body modal-body-center">
                <form id="modal-photo-confirm-delete-form" class="hidden">
                    <input name="trip_photo_id" />
                </form>
                <div class="modal-body-header row">
                    <div class="col-xs-12">Delete Forever</div>
                </div>
                <div class="modal-body-body row">
                    <div class="col-xs-12">Are you sure that you want to permanently delete this photo? You can't undo this action.</div>
                </div>
                <div class="modal-body-footer row">
                    <div class="col-xs-6" data-dismiss="modal"><a>CANCEL</a></div>
                    <div class="col-xs-6" data-dismiss="modal" onclick="deleteTripPhoto();"><a>DELETE FOREVER</a></div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	var myPhotoSlide;
	
	function initPhotoSlide() {
		myPhotoSlide = new Swiper ('.swiper-container', {
			direction:'horizontal',
			loop:false,
			pagination: '.swiper-pagination',
			paginationType: 'fraction',
			nextButton: '.swiper-button-right',
			prevButton: '.swiper-button-left',
			onSlideChangeEnd:function() {
				resetModalPhotoConfirmDeleteForm();
			}
		})
	}
	
	function goToPhotoSlide(index) {
		initPhotoSlide();
		if(index != 0) {
			myPhotoSlide.slideTo(index,0,false);
		}
		else {
			//DIRTY SOLUTION for issue: idangero swiper failed to slide to index 0 correctly
			myPhotoSlide.slideTo(1,0,false);
			myPhotoSlide.slidePrev(false,0);
		}
		resetModalPhotoConfirmDeleteForm();
		showPhotoSlide();
	}
	
	function showPhotoSlide() {
		//DIRTY SOLUTION for issue: idangero swiper cannot work well with hidden element 
		$('.photo-slide').css('z-index',1050);
		$('.photo-slide').css('opacity',1);
	}
	
	function hidePhotoSlide() {
		$('.photo-slide').css('z-index',-1);
		$('.photo-slide').css('opacity',0);
	}
</script>
<script>
	function resetModalPhotoConfirmDeleteForm() {
		var trip_photo_id = $('#modal-trip-photo .swiper-slide-active input[name=trip_photo_id]').val();
		$('#modal-photo-confirm-delete-form input[name=trip_photo_id]').val(trip_photo_id);
	}
</script>
<script>
	function deleteTripPhoto() {
		<!-- START: set POST data -->
			var data = {
				"action":"delete_trip_photo",
				"trip_photo_id":$('#modal-photo-confirm-delete-form input[name=trip_photo_id]').val()
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				var index = myPhotoSlide.activeIndex;
				myPhotoSlide.removeSlide(index);
				if($('#modal-trip-photo .swiper-slide').length == 0) {
					hidePhotoSlide();
					showHint('Photo Deleted');
				}
				refreshTripPhoto();
				//showHint('Photo Deleted');
			}, "json");
		<!-- END -->
	}
</script>