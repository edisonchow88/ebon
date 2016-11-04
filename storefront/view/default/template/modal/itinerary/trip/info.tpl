<style>
	#modal-trip-info .header-secondary {
	}
	
	#modal-trip-info .header-secondary .btn {
		color:#999;
	}
	
	#modal-trip-info .header-secondary .btn:hover {
		color:#000;
	}
	
	#modal-trip-info .header-secondary .btn.active {
		color:#e93578;
		cursor:default;
		pointer-events:none;
	}
	
	#modal-trip-info .modal-body {
		background-color:#FFF;
	}
	#modal-trip-info .tab {
		position:relative;
	}
	
	/* START: map */
		#modal-trip-info .button-left {
			left:0;
		}
		#modal-trip-info .button-recenter {
			right:0;
		}
		#modal-trip-info .button-reset {
			border-radius:5px 0 0 5px;
			color:#000;
		}
		#modal-trip-info .button-remove {
			border-radius:0 5px 5px 0;
			color:#000;
		}
		#modal-trip-info .button-left .disabled {
			pointer-events:none;
			cursor:not-allowed;
			color:#999;
		}
		#modal-trip-info .tab-location .btn-group {
			padding:10px;
			position:absolute;
			z-index:20;
		}
		#modal-trip-info .tab-location .btn {
			height:40px;
			padding:10px;
			border-radius:5px;
		}
		#modal-trip-info  #line-map {
			width:100%;
			height:calc(100vh - 180px);
		}
	/* END */
	#modal-trip-info .form-spacer {
		height:10px;
		border-bottom:solid thin #DDD;
	}
	#modal-trip-info .image {
		background-color:#EEE;
		height:calc(100vh - 130px);
		width:100%;
		text-align:center;
		padding-top:30px;
	}
	#modal-trip-info .image img {
		background-color:#999;
		height:200px;
		width:200px;
		border:solid thin #DDD;
		border-radius:150px;
	}
	#modal-trip-info label {
		background-color:#FFF;
		color:#999;
		height:50px;
		width:100%;
		margin:0;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
		font-weight:normal;
	}
	#modal-trip-info input, #modal-trip-info select {
		background-color:#FFF;
		color:#000;
		height:50px;
		width:100%;
		padding:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #DDD;
		outline:none;
		-webkit-appearance: none;
	}
	#modal-trip-info input:disabled {
		color:#999;
	}
	#modal-trip-info select {
		-webkit-appearance: none;
		-webkit-border-radius: 0px;
	}
	#modal-trip-info textarea {
		height:calc(100vh - 130px);
		width:100%;
		padding:15px;
		border:none;
		border-bottom:solid thin #EEE;
		outline:none;
	}
	#modal-trip-info .icon-disabled {
		position:absolute;
		color:#000;
		height:50px;
		padding:15px;
		top:0;
		right:0;
	}
	
	#modal-trip-info .tab-photo, #modal-trip-info .tab-photo .col-xs-4 {
		padding:1px;
	}
	
	#modal-trip-info .tab-photo .col-xs-4 {
	}
	
	#modal-trip-info .tab-photo .trip-photo-wrapper {
		position:relative;
		vertical-align:middle;
		overflow:hidden;
	}
	
	#modal-trip-info .tab-photo .trip-photo-background {
		width:100%;
		border:solid thin #DDD;
	}
	
	#modal-trip-info .tab-photo .trip-photo {
		position:absolute;
		top:0;
		bottom:0;
		left:0;
		margin:auto;
		width:100%;
	}
	
	#modal-trip-info .button-add-trip-photo img {
		border:solid thin #DDD;
	}
	
	#modal-trip-info .trip-photo {
		min-height:133px;
	}
	
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-trip-info" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-trip-info-header" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-trip-info">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Edit Trip Info</div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-trip-info" onclick="saveTripInfo();">Save</a>
                    </div>
                </div>
                <div class="header header-secondary header-white fixed-bar fixed-width row">
                	<div class="col-xs-3">
                    	<a class="btn btn-block btn-general" onclick="selectModalTripInfoTab('general');"><i class="fa fa-fw fa-lg fa-pencil"></i></a>
                    </div>
                    <div class="col-xs-3">
                    	<a class="btn btn-block btn-photo" onclick="selectModalTripInfoTab('photo');"><i class="fa fa-fw fa-lg fa-picture-o"></i></a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    	<form id="modal-trip-info-form">
                        	<input type="text" name="trip_id" class="hidden"/>
                        	<div class="tab tab-general">
                                <div class="col-xs-12"><input type="text" name="name" placeholder="Title" /></div>
                                <textarea name="description" placeholder="Description"></textarea>
                            </div>
                            <div class="tab tab-photo row">
                                <div class="col-xs-4 button-add-trip-photo">
                                    <img class="btn" src="resources/icon/add_photo.png" style="padding:10px; width:100%;" onclick="$('#input-file').trigger('click');"/>
                                </div>
                            </div>
                        </form>
                        <form id="modal-trip-info-photo-form" class="hidden" enctype="multipart/form-data">
                        	<input type="text" name="action" value="upload_trip_photo"/>
                        	<input type="text" name="trip_id"/>
                            <input type="text" name="user_id" value="<?php echo $this->user->getUserId();?>"/>
                            <input type="text" name="type" value="trip"/>
                        	<input type="file" class="form-file" id="input-file" name="file"/>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$('#modal-trip-info-photo-form input[name=file]').change(function(){
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
		var formData = new FormData($('#modal-trip-info-photo-form')[0]);
		
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
				"trip_id":$('#modal-trip-info-photo-form input[name=trip_id]').val()
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				$('#modal-trip-info .trip-photo-col').remove();
				$.each(json.photo, function() {
					printTripPhoto(this);
				});
			}, "json");
		<!-- END -->
	}
	
	function printTripPhoto(photo) {
		var content = '';
		content = ''
			+ '<div class="trip-photo-col col-xs-4">'
				+ '<div class="trip-photo-wrapper">'
				+ '<img class="trip-photo-background" src="resources/image/black.png"/>'
				+ '<img class="trip-photo" src="'+photo.path+'"/>'
				+ '</div>'
			+ '</div>'
		;
		$('#modal-trip-info .tab-photo').append(content);
	}
</script>
<script>
	function selectModalTripInfoTab(tab) {
		$('#modal-trip-info .header-secondary .btn').removeClass('active');
		$('#modal-trip-info .tab').hide();
		$('#modal-trip-info .btn-'+tab).addClass('active');
		$('#modal-trip-info .tab-'+tab).show();
	}
</script>
<script>
	$("#modal-trip-info").on("show.bs.modal", function () {
		selectModalTripInfoTab('general');
		refreshTrip(); 
		refreshTripPhoto();
	});
</script>