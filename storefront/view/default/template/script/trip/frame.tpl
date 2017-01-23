<style>
	.photo-frame {
		position:relative;
		cursor:pointer;
	}
	
	.photo-frame-photo {
		min-height:100%;
		min-width:100%;
	}
	
	.photo-frame-photo-wrapper {
		position:relative;
		text-align:center;
		overflow:hidden;
		border:solid thin rgba(0,0,0,0.1);
	}
	
	.photo-frame-background {
		background-color:#EEE;
	}
	
	.photo-frame-background img {	
		opacity:0;
	}
	
	.photo-frame-empty {
		width:100px;
		height:100px;
	}
</style>
<script>
	function printPhotoFrame(photoFrame) {
		var content = '';
		var photo = photoFrame.photo;
		
		if(isset(photoFrame.photo)) {
			if(photo.length == 0 && photoFrame.edtiable == true ) {
				content = ''
					+ '<div class="photo-frame-background border-bottom">'
						+ '<img src="resources/image/black.png"/>'
					+ '</div>'
					+ '<div class="photo-frame-empty absolute-center">'
						+ '<img class="ca-img" src="resources/icon/gallery.gif"/>'
					+ '</div>'
				;
			}
			else if(photo.length == 0 && photoFrame.edtiable == false ) {
				content = '';
			}
			else if(photo.length == 1) {
				content = ''
					+ '<div class="row padding-1">'
						+ '<div class="col-xs-12 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[0].path+'"/>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
				;
			}
			else if(photo.length == 2) {
				content = ''
					+ '<div class="row padding-1">'
						+ '<div class="col-xs-6 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[0].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-6 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[1].path+'"/>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
				;
			}
			else if(photo.length == 3) {
				content = ''
					+ '<div class="row padding-1">'
						+ '<div class="col-xs-8 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[0].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-4 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[1].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-4 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[2].path+'"/>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
				;
			}
			else if(photo.length == 4) {
				content = ''
					+ '<div class="row padding-1">'
						+ '<div class="col-xs-6 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[0].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-6 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[1].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-6 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[2].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-6 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[3].path+'"/>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
				;
			}
			else {
				content = ''
					+ '<div class="row padding-1">'
						+ '<div class="col-xs-6 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[0].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-6 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[1].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-4 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[2].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-4 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[3].path+'"/>'
							+ '</div>'
						+ '</div>'
						+ '<div class="col-xs-4 padding-1">'
							+ '<div class="photo-frame-photo-wrapper">'
								+ '<img class="photo-frame-photo-background" src="resources/image/black.png"/>'
								+ '<img class="photo-frame-photo absolute-center" src="'+photo[4].path+'"/>'
							+ '</div>'
						+ '</div>'
					+ '</div>'
				;
			}
		}
		else {
			if(photoFrame.editable == true ) {
				content = ''
					+ '<div class="photo-frame-background border-bottom">'
						+ '<img src="resources/image/black.png"/>'
					+ '</div>'
					+ '<div class="photo-frame-empty absolute-center">'
						+ '<img class="ca-img" src="resources/icon/gallery.gif"/>'
					+ '</div>'
				;
			}
			else {
				content = '';
			}
		}
		
		$(photoFrame.frame).html(content);
	}
</script>