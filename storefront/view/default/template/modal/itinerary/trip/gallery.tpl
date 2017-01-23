<style>
	.gallery {
		padding:1px;
	}
	
	.gallery-col {
		padding:1px;
	}
	
	.gallery img {
		min-width:100%;
		min-height:100%;
	}
	
	.gallery-photo-wrapper {
		position:relative;
		text-align:center;
		overflow:hidden;
		cursor:pointer;
	}
	
	.gallery-photo {
		position:absolute;
		top:0;
		bottom:0;
		left:0;
		right:0;
		margin:auto;
	}
</style>

<!-- START: Modal -->
    <div class="modal" id="modal-trip-gallery" role="dialog" data-backdrop="false">
    	<div class="modal-wrapper fixed-width">
        	<div class="modal-header fixed-width">
            	<div id="modal-trip-day-header-main" class="navbar navbar-primary navbar-modal">
                	<div class="col-xs-3 text-left">
                    	<a class="btn" data-dismiss="modal">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span>Photo</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    	<a class="btn" onclick="$('#modal-trip-gallery-form input[name=file]').trigger('click');"><i class="fa fa-fw fa-lg fa-plus"></i></a>
                    </div>
                </div>
        	</div>
            <div class="modal-body fixed-width scrollable-y">
            	<div class="navbar navbar-shadow"></div>
                <div class="modal-body-body">
                    <form id="modal-trip-gallery-form" class="hidden" enctype="multipart/form-data">
                        <input type="text" name="action" value="upload_trip_photo"/>
                        <input type="text" name="trip_id" value="<?php echo $this->trip->getTripId();?>"/>
                        <input type="text" name="user_id" value="<?php echo $this->user->getUserId();?>"/>
                        <input type="text" name="type" value="trip"/>
                        <input type="file" class="form-file" name="file"/>
                    </form>
                	<div class="row gallery">
                    </div>
                </div>
        	</div>
        </div>
    </div>
<!-- END -->

<script>
	$('#modal-trip-gallery-form input[name=file]').change(function(){
		var file = this.files[0];
		var name = file.name;
		var size = file.size;
		var type = file.type;
		
		<!-- START: validation -->
			if(!(type.match('image.*'))) {
				showAlert('It is not an image file.');
			}
			else if(size > 2000000) {
				showAlert('Photo too big');
			}
			else {
				uploadTripPhoto();
			}
		<!-- END -->
	});
	
	function uploadTripPhoto() {
		var formData = new FormData($('#modal-trip-gallery-form')[0]);
		
		<!-- START: send POST -->
			$.ajax({
				url:"<?php echo $ajax['trip/ajax_itinerary']; ?>",
				data:formData,
				type:'POST',
				cache:false,
				contentType:false,
				processData:false,
				dataType:'json',
				success:function(response) {
					refreshTripPhoto();
					showHint('Photo Uploaded');
				}
			});
		<!-- END -->
	}
	
	function refreshTripPhoto() {
		<!-- START: set POST data -->
			var data = {
				"action":"refresh_trip_photo",
				"trip_id":$('#modal-trip-gallery-form input[name=trip_id]').val()
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				$('#modal-trip-gallery .gallery-photo-col').remove();
				$('#modal-trip-photo .swiper-slide').remove();
				if(isset(json)) {
					var photoFrame = {
						frame:'.photo-frame',
						photo:json.photo,
						editable:true
					}
					printPhotoFrame(photoFrame);
					if(isset(json.photo)) {
						$.each(json.photo, function(i) {
							printTripPhoto(this,i);
							printPhotoSlide(this);
						});
					}
				}
			}, "json");
		<!-- END -->
	}
	
	function printTripPhoto(photo,i) {
		var content = '';
		content = ''
			+ '<div class="gallery-col gallery-photo-col col-xs-4">'
				+ '<div class="gallery-photo-wrapper border" onclick="goToPhotoSlide('+i+');">'
					+ '<img class="gallery-photo-background" src="resources/image/black.png"/>'
					+ '<img class="gallery-photo" src="'+photo.path+'"/>'
				+ '</div>'
			+ '</div>'
		;
		
		$('#modal-trip-gallery .gallery').append(content);
	}
	
	function printPhotoSlide(photo) {
		var content = '';
		content = ''
			+ '<div class="swiper-slide" style="height:calc(100vh - 80px);">'
					+ '<img class="absolute-center" src="'+photo.path+'"/>'
					+ '<form class="hidden">'
						+ '<input name="trip_photo_id" value="'+photo.trip_photo_id+'"/>'
					+ '</form>'
			+ '</div>'
		;
		$('#modal-trip-photo .swiper-wrapper').append(content);
	}
</script>