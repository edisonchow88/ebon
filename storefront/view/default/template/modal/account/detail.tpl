<style>
	#modal-account-detail .modal-body {
		padding-bottom:70px !important;
	}
	
	#modal-account-detail .photo {
		margin-top:30px;
		image-orientation: from-image !important;
	}
	
	#modal-account-detail .photo img {
		margin:10px;
		height:120px;
		width:120px;
		border-radius:60px;
		background-color:#CCC;
		image-orientation: from-image !important;
	}
	
	#modal-account-detail .button-edit-photo-wrapper {
		padding-bottom:30px;
		border-bottom:solid thin #DDD;
	}
	
	#modal-account-detail-view-form input:disabled {
		color:#000;
		-webkit-text-fill-color:#000;
		-webkit-opacity: 1;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-account-detail" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
            	<div id="modal-account-detail-header-main" class="fixed-bar">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-account-detail"><i class="fa fa-fw fa-lg fa-chevron-left"></i><span class="sr-only">Cancel</span></a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span class="btn-header modal-title">Profile</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    	<a class="btn btn-header" onclick="openEditUserForm();">Edit</a>
                    </div>
                </div>
                <div id="modal-account-detail-header-edit" class="header fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" onclick="closeEditUserForm();">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span class="btn-header modal-title">Edit Profile</span>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header button-save-edit-user disabled" onclick="saveEditUserForm();">Done</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal-dialog fixed-bar">
            <div class="modal-header-shadow"></div>
            <div class="modal-content">
                <div class="modal-body nopadding">
                    <div id="modal-account-detail-alert"></div>
                    <div class="photo text-center"></div>
                    <div class="text-center button-edit-photo-wrapper"><a class="button-edit-photo">Edit</a></div>
                    <form class="mobile-form hidden" id="modal-account-detail-photo-form" enctype="multipart/form-data">
                        <input type="text" name="action" value="upload_user_photo"/>
                        <input type="text" name="user_id" value="<?php echo $this->user->getUserId();?>"/>
                        <input type="text" name="type" value="user"/>
                        <input type="file" class="form-file" id="input-file" name="file" capture="camera" accept="image/*" />
                    </form>
                    <form class="mobile-form" id="modal-account-detail-view-form">
                        <div class="row">
                            <div class="col-xs-5"><label for="plan" selected>Plan</label></div>
                            <div class="col-xs-7">
                                <input type="text" name="plan" disabled="disabled"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="email" selected>Email</label></div>
                            <div class="col-xs-7">
                                <input type="text" name="email" disabled="disabled"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="fullname" selected>Full Name</label></div>
                            <div class="col-xs-7">
                                <input type="text" name="fullname" disabled="disabled"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="passport" selected>Passport</label></div>
                            <div class="col-xs-7">
                                <input type="text" name="passport" disabled="disabled"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="dob" selected>Date of Birth</label></div>
                            <div class="col-xs-7">
                                <input type="date" name="dob" disabled="disabled"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="gender" selected>Gender</label></div>
                            <div class="col-xs-7">
                                <select name="gender" disabled="disabled"/>
                                    <option></option>
                                    <option value="1">Male</option>
                                    <option value="2">Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="mobile" selected>Mobile</label></div>
                            <div class="col-xs-7">
                                <input type="text" name="mobile" disabled="disabled"/>
                            </div>
                        </div>
                    </form>
                    <form class="mobile-form" id="modal-account-detail-edit-form">
                        <div class="row">
                            <div class="col-xs-5"><label for="email" selected>Email</label></div>
                            <div class="col-xs-7">
                                <input type="text" name="email"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="fullname" selected>Full Name</label></div>
                            <div class="col-xs-7">
                                <input type="text" name="fullname"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="passport" selected>Passport</label></div>
                            <div class="col-xs-7">
                                <input type="text" name="passport"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="dob" selected>Date of Birth</label></div>
                            <div class="col-xs-7">
                                <input type="date" name="dob"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="gender" selected>Gender</label></div>
                            <div class="col-xs-7">
                                <select name="gender"/>
                                    <option></option>
                                    <option value="1">Male</option>
                                    <option value="2">Female</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-5"><label for="mobile" selected>Mobile</label></div>
                            <div class="col-xs-7">
                                <input type="text" name="mobile"/>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function getUser() {
		<!-- START: get data -->
			var user_id = <?php echo $this->user->getUserId(); ?>;
		<!-- END -->
		<!-- START: set data -->
			var data = {
				'action'	: 'get_user',
				'user_id'	: user_id
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['account/ajax_user']; ?>", data, function(json) {
				<!-- START: set photo -->
					var photo = '';
					if(isset(json.photo)) {
						photo = '<img src="' + json.photo.path + '?' + new Date().getTime() + '" onerror="this.onerror = \'\';this.src = \'resources/image/error/noimage.png\';" />';
					}
					else {
						var letter = '';
						if(isset(json.fullname)) {
							letter = json.fullname.substring(0,1);
						}
						else {
							letter = json.email.substring(0,1);
						}
						photo = ''
							+ '<span class="fa-stack fa-5x">'
								+ '<i class="fa fa-circle fa-stack-2x"></i>'
								+ '<i class="fa fa-stack-1x fa-inverse">'+letter.toUpperCase()+'</i>'
							+ '</span>'
						;
					}
					$('#modal-account-detail .photo').html(photo);
				<!-- END -->
				$('#modal-account-detail-view-form input[name=plan]').val('<?php echo $this->user->getRole(); ?>');
				
				
				<!-- START: set data -->
					var form = '#modal-account-detail-view-form';
					var result = {
						'fullname'			: json.fullname,
						'passport'			: json.passport,
						'dob'				: json.dob,
						'gender'			: json.gender,
						'mobile'			: json.mobile,
						'email'				: json.email
					};
				<!-- END -->
				<!-- START -->
					$.each(result, function(key,value) {
						if($(form + ' input[name='+key+']').length > 0) {
							if(isset(value)) {
								$(form + ' input[name='+key+']').val(value);
							}
							else {
								$(form + ' input[name='+key+']').hide();
								$(form + ' label[for='+key+']').hide();
							}
						}
						else if($(form + ' select[name='+key+']').length > 0) {
							if(isset(value)) {
								$(form + ' select[name='+key+']').val(value);
							}
							else {
								$(form + ' select[name='+key+']').hide();
								$(form + ' label[for='+key+']').hide();
							}
						}
					});
				<!-- END -->
			}, "json");
		<!-- END -->
	}
	
	getUser();
</script>
<script>
	function openEditUserForm() {
		<!-- START -->
			$('#modal-account-detail-view-form').hide();
			$('#modal-account-detail-edit-form').show();
			$('#modal-account-detail-header-main').hide();
			$('#modal-account-detail-header-edit').show();
			onEditUserPhotoButton();
			$('#modal-account-detail .button-edit-photo').show();
			$('#modal-account-detail .button-save-edit-user').addClass('disabled');
		<!-- END -->
		<!-- START -->
			var data = {
				'fullname'			: $('#modal-account-detail-view-form input[name=fullname]').val(),
				'passport'			: $('#modal-account-detail-view-form input[name=passport]').val(),
				'dob'				: $('#modal-account-detail-view-form input[name=dob]').val(),
				'gender'			: $('#modal-account-detail-view-form select[name=gender]').val(),
				'mobile'			: $('#modal-account-detail-view-form input[name=mobile]').val(),
				'email'				: $('#modal-account-detail-view-form input[name=email]').val()
			};
		<!-- END -->
		<!-- START -->	
			$('#modal-account-detail-edit-form input[name=fullname]').val(data.fullname);
			$('#modal-account-detail-edit-form input[name=passport]').val(data.passport);
			$('#modal-account-detail-edit-form input[name=dob]').val(data.dob);
			$('#modal-account-detail-edit-form select[name=gender]').val(data.gender);
			$('#modal-account-detail-edit-form input[name=mobile]').val(data.mobile);
			$('#modal-account-detail-edit-form input[name=email]').val(data.email);	
		<!-- END -->
	}
	
	function closeEditUserForm() {
		<!-- START -->
			$('#modal-account-detail-view-form').show();
			$('#modal-account-detail-edit-form').hide();
			$('#modal-account-detail-header-main').show();
			$('#modal-account-detail-header-edit').hide();
			offEditUserPhotoButton();
			$('#modal-account-detail .button-edit-photo').hide();
			$('#modal-account-detail-view .modal-account-detail-alert').html('');
			$('#modal-account-detail .button-save-edit-user').addClass('disabled');
		<!-- END -->
	}
	
	function updateViewUserForm() {
		<!-- START -->
			closeEditUserForm();
		<!-- END -->
		<!-- START -->
			var form = '#modal-account-detail-view-form';
			var data = {
				'fullname'			: $('#modal-account-detail-edit-form input[name=fullname]').val(),
				'passport'			: $('#modal-account-detail-edit-form input[name=passport]').val(),
				'dob'				: $('#modal-account-detail-edit-form input[name=dob]').val(),
				'gender'			: $('#modal-account-detail-edit-form select[name=gender]').val(),
				'mobile'			: $('#modal-account-detail-edit-form input[name=mobile]').val(),
				'email'				: $('#modal-account-detail-edit-form input[name=email]').val()
			};
		<!-- END -->
		<!-- START -->	
			$.each(data, function(key,value) {
				if($(form + ' input[name='+key+']').length > 0) {
					if(isset(value)) {
						$(form + ' input[name='+key+']').val(value);
						$(form + ' input[name='+key+']').show();
						$(form + ' label[for='+key+']').show();
					}
					else {
						$(form + ' input[name='+key+']').val('');
						$(form + ' input[name='+key+']').hide();
						$(form + ' label[for='+key+']').hide();
					}
				}
				else if($(form + ' select[name='+key+']').length > 0) {
					if(isset(value)) {
						$(form + ' select[name='+key+']').val(value);
						$(form + ' select[name='+key+']').show();
						$(form + ' label[for='+key+']').show();
					}
					else {
						$(form + ' select[name='+key+']').val('');
						$(form + ' select[name='+key+']').hide();
						$(form + ' label[for='+key+']').hide();
					}
				}
			});
		<!-- END -->
	}
	
	function saveEditUserForm() {
		<!-- START: get data -->
			var user_id = <?php echo $this->user->getUserId(); ?>;
		<!-- END -->
		<!-- START: set data -->
			var data = {
				"action"			: "edit_user",
				"user_id"			: user_id,
				'fullname'			: $('#modal-account-detail-edit-form input[name=fullname]').val(),
				'passport'			: $('#modal-account-detail-edit-form input[name=passport]').val(),
				'dob'				: $('#modal-account-detail-edit-form input[name=dob]').val(),
				'gender'			: $('#modal-account-detail-edit-form select[name=gender]').val(),
				'mobile'			: $('#modal-account-detail-edit-form input[name=mobile]').val(),
				'email'				: $('#modal-account-detail-edit-form input[name=email]').val()
			};
		<!-- END -->
		<!-- START: verify data -->
			if(isset(data.email) == false) {
				var content = '';
				content = ''
					+ '<div class="alert alert-danger">'
						+ '<ul>'
							+ '<li>'
								+ 'Email is Missing.'
							+ '</li>'
						+ '</ul>'
					+ '</div>'
				;
				$('#modal-account-detail-view .modal-account-detail-alert').html(content);
				return;
			}
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['account/ajax_user']; ?>", data, function(json) {
				if(isset(json.warning)) {
					showAlert(json.warning);
				}
				else if(isset(json.success)) {
					showHint('Info Updated');
					updateViewUserForm();
				}
			}, "json");
		<!-- END -->
	}
	
	$('#modal-account-detail-edit-form label').click(function() {
       name = $(this).attr('for');
	   if($('#modal-account-detail-edit-form input[name='+name+']').length > 0) {
		   $('#modal-account-detail-edit-form input[name='+name+']').focus();
	   }
	   else if($('#modal-account-detail-edit-form textarea[name='+name+']').length > 0) {
		   $('#modal-account-detail-edit-form textarea[name='+name+']').focus();
	   }
	   else if($('#modal-account-detail-edit-form select[name='+name+']').length > 0) {
		   $('#modal-account-detail-edit-form select[name='+name+']').focus();
	   }
	});
	
	$('#modal-account-detail-edit-form').on('change keydown',function() {
		$('#modal-account-detail .button-save-edit-user').removeClass('disabled');
	});
</script>
<script>
	$('#modal-account-detail-photo-form input[name=file]').change(function(){
		var file = this.files[0];
		var name = file.name;
		var size = file.size;
		var type = file.type;
		
		<!-- START: validation -->
			if(!(type.match('image.*'))) {
				showAlert('It is not an image file.');
			}
			else {
				uploadUserPhoto();
			}
		<!-- END -->
	});
	
	function uploadUserPhoto() {
		var formData = new FormData($('#modal-account-detail-photo-form')[0]);
		
		<!-- START: send POST -->
			$.ajax({
				url:"<?php echo $ajax['account/ajax_user']; ?>",
				data:formData,
				type:'POST',
				cache:false,
				contentType:false,
				processData:false,
				dataType:'json',
				success:function(json) {
					if(isset(json.warning)) {
						showAlert(json.warning);
					}
					else if(isset(json.success)) {
						refreshUserPhoto(json);
						showHint(json.success);
					}
				}
			});
		<!-- END -->
	}
	
	function refreshUserPhoto(json) {
		var content = '';
		content = ''
			+ '<img src="' + json.photo.path + '?' + new Date().getTime() + '" onerror="this.onerror = \'\';this.src = \'resources/image/error/noimage.png\';" />'
		;
		$('#modal-account-detail .photo').html(content);
	}
</script>
<script>
	function onEditUserPhotoButton() {
		$('#modal-account-detail .photo img').css('cursor','pointer');
		$('#modal-account-detail .photo img').off().on('click',function() {
			$('#input-file').trigger('click');
		});
		$('#modal-account-detail .photo span').css('cursor','pointer');
		$('#modal-account-detail .photo span').off().on('click',function() {
			$('#input-file').trigger('click');
		});
		$('#modal-account-detail .button-edit-photo').off().on('click',function() {
			$('#input-file').trigger('click');
		});
	}
	
	function offEditUserPhotoButton() {
		$('#modal-account-detail .photo img').css('cursor','default');
		$('#modal-account-detail .photo img').off();
		$('#modal-account-detail .photo span').css('cursor','default');
		$('#modal-account-detail .photo span').off();
		$('#modal-account-detail .button-edit-photo').off();
	}
</script>
<script>
	$("#modal-account-detail").on( "show.bs.modal", function() {
		$('#modal-account-detail-edit-form').hide();
		$('#modal-account-detail-header-edit').hide();
		$('#modal-account-detail .button-edit-photo').hide();
		$('#modal-account-detail .modal-account-detail-alert').html('');
		offEditUserPhotoButton();
	});
</script>