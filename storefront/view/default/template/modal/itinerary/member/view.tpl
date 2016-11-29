<style>
	#modal-member-view input:disabled {
		color:#000;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top noselect" id="modal-member-view" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-member-view-header-main" class="header fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-dismiss="modal" data-toggle="modal" data-target="#modal-member-list">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Member Info</div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header button-edit-member" onclick="showEditMemberForm();">Edit</a>
                    </div>
                </div>
                <div id="modal-member-view-header-edit" class="header fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" onclick="closeEditMemberForm();">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title"></div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header button-save-edit-member disabled" onclick="saveEditMemberForm();">Done</a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding modal-background-grey">
                    	<div class="modal-member-view-alert">
                        </div>
                    	<form class="mobile-form" id="modal-member-view-form">
                        	<input type="text" name="trip_member_id" class="hidden"/>
                            <div class="row">
                                <div class="col-xs-5"><label for="fullname" selected>Full Name</label></div>
                                <div class="col-xs-7">
                                	<input type="text" name="fullname" disabled="disabled"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-5"><label for="status_id" selected>Status</label></div>
                                <div class="col-xs-7">
                                	<select name="status_id" disabled="disabled"/>
                                    	<option value="1">Going</option>
                                    	<option value="2">Not Going</option>
                                        <option value="3">Invited</option>
                                    </select>
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
                            <div class="row">
                                <div class="col-xs-5"><label for="email" selected>Email</label></div>
                                <div class="col-xs-7">
                                	<input type="text" name="email" disabled="disabled"/>
                                </div>
                            </div>
                        </form>
                        <form class="mobile-form" id="modal-member-edit-form">
                        	<input type="text" name="trip_member_id" class="hidden"/>
                        	<div class="row">
                                <div class="col-xs-5"><label for="fullname" selected>Full Name</label></div>
                                <div class="col-xs-7">
                                	<input type="text" name="fullname"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-5"><label for="status_id" selected>Status</label></div>
                                <div class="col-xs-7">
                                	<select name="status_id"/>
                                    	<option value="1">Going</option>
                                    	<option value="2">Not Going</option>
                                        <option value="3">Invited</option>
                                    </select>
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
                            <div class="row">
                                <div class="col-xs-5"><label for="email" selected>Email</label></div>
                                <div class="col-xs-7">
                                	<input type="text" name="email"/>
                                </div>
                            </div>
                        </form>
                    	<div class="modal-header-shadow"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function openViewMemberModal(data) {
		<!-- START -->
			$('#modal-member-view-form input[name=trip_member_id]').val(data.trip_member_id);
			$('#modal-member-view-form input[name=fullname]').val(data.fullname);
			$('#modal-member-view-form select[name=status_id]').val(data.status_id);
			$('#modal-member-view-form input[name=passport]').val(data.passport);
			$('#modal-member-view-form input[name=dob]').val(data.dob);
			$('#modal-member-view-form select[name=gender]').val(data.gender);
			$('#modal-member-view-form input[name=mobile]').val(data.mobile);
			$('#modal-member-view-form input[name=email]').val(data.email);
		<!-- END -->	
	}
	
	function showEditMemberForm() {
		<!-- START -->
			$('#modal-member-view-form').hide();
			$('#modal-member-edit-form').show();
			$('#modal-member-view-header-main').hide();
			$('#modal-member-view-header-edit').show();
			$('#modal-member-view .button-save-edit-member').addClass('disabled');
		<!-- END -->
		<!-- START -->
			var data = {
				'trip_member_id'	: $('#modal-member-view-form input[name=trip_member_id]').val(),
				'fullname'			: $('#modal-member-view-form input[name=fullname]').val(),
				'status_id'			: $('#modal-member-view-form select[name=status_id]').val(),
				'passport'			: $('#modal-member-view-form input[name=passport]').val(),
				'dob'				: $('#modal-member-view-form input[name=dob]').val(),
				'gender'			: $('#modal-member-view-form select[name=gender]').val(),
				'mobile'			: $('#modal-member-view-form input[name=mobile]').val(),
				'email'				: $('#modal-member-view-form input[name=email]').val()
			};
		<!-- END -->
		<!-- START -->	
			$('#modal-member-edit-form input[name=trip_member_id]').val(data.trip_member_id);
			$('#modal-member-edit-form input[name=fullname]').val(data.fullname);
			$('#modal-member-edit-form select[name=status_id]').val(data.status_id);
			$('#modal-member-edit-form input[name=passport]').val(data.passport);
			$('#modal-member-edit-form input[name=dob]').val(data.dob);
			$('#modal-member-edit-form select[name=gender]').val(data.gender);
			$('#modal-member-edit-form input[name=mobile]').val(data.mobile);
			$('#modal-member-edit-form input[name=email]').val(data.email);	
		<!-- END -->
	}
	
	function closeEditMemberForm() {
		<!-- START -->
			$('#modal-member-view-form').show();
			$('#modal-member-edit-form').hide();
			$('#modal-member-view-header-main').show();
			$('#modal-member-view-header-edit').hide();
			$('#modal-member-view .modal-member-view-alert').html('');
			$('#modal-member-view .button-save-edit-member').removeClass('disabled');
		<!-- END -->
	}
	
	function updateViewMemberForm() {
		<!-- START -->
			$('#modal-member-view-form').show();
			$('#modal-member-edit-form').hide();
			$('#modal-member-view-header-main').show();
			$('#modal-member-view-header-edit').hide();
		<!-- END -->
		<!-- START -->
			var data = {
				'trip_member_id'	: $('#modal-member-edit-form input[name=trip_member_id]').val(),
				'fullname'			: $('#modal-member-edit-form input[name=fullname]').val(),
				'status_id'			: $('#modal-member-edit-form select[name=status_id]').val(),
				'passport'			: $('#modal-member-edit-form input[name=passport]').val(),
				'dob'				: $('#modal-member-edit-form input[name=dob]').val(),
				'gender'			: $('#modal-member-edit-form select[name=gender]').val(),
				'mobile'			: $('#modal-member-edit-form input[name=mobile]').val(),
				'email'				: $('#modal-member-edit-form input[name=email]').val()
			};
		<!-- END -->
		<!-- START -->	
			$('#modal-member-view-form input[name=trip_member_id]').val(data.trip_member_id);
			$('#modal-member-view-form input[name=fullname]').val(data.fullname);
			$('#modal-member-view-form select[name=status_id]').val(data.status_id);
			$('#modal-member-view-form input[name=passport]').val(data.passport);
			$('#modal-member-view-form input[name=dob]').val(data.dob);
			$('#modal-member-view-form select[name=gender]').val(data.gender);
			$('#modal-member-view-form input[name=mobile]').val(data.mobile);
			$('#modal-member-view-form input[name=email]').val(data.email);	
		<!-- END -->
	}
	
	function saveEditMemberForm() {
		<!-- START: get data -->
			var trip_id = <?php echo $this->trip->getTripId(); ?>;
		<!-- END -->
		<!-- START: set data -->
			var data = {
				"action"			: "edit_member",
				"trip_id"			: trip_id,
				'trip_member_id'	: $('#modal-member-edit-form input[name=trip_member_id]').val(),
				'fullname'			: $('#modal-member-edit-form input[name=fullname]').val(),
				'status_id'			: $('#modal-member-edit-form select[name=status_id]').val(),
				'passport'			: $('#modal-member-edit-form input[name=passport]').val(),
				'dob'				: $('#modal-member-edit-form input[name=dob]').val(),
				'gender'			: $('#modal-member-edit-form select[name=gender]').val(),
				'mobile'			: $('#modal-member-edit-form input[name=mobile]').val(),
				'email'				: $('#modal-member-edit-form input[name=email]').val()
			};
		<!-- END -->
		<!-- START: verify data -->
			if(isset(data.fullname) == false) {
				var content = '';
				content = ''
					+ '<div class="alert alert-danger">'
						+ '<ul>'
							+ '<li>'
								+ 'Full Name is Missing.'
							+ '</li>'
						+ '</ul>'
					+ '</div>'
				;
				$('#modal-member-view .modal-member-view-alert').html(content);
				return;
			}
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				if(isset(json.warning)) {
					showAlert(json.warning);
				}
				else if(isset(json.success)) {
					showHint('Member Info Updated');
					updateViewMemberForm();
				}
			}, "json");
		<!-- END -->
	}
	
	$('#modal-member-edit-form label').click(function() {
       name = $(this).attr('for');
	   if($('#modal-member-edit-form input[name='+name+']').length > 0) {
		   $('#modal-member-edit-form input[name='+name+']').focus();
	   }
	   else if($('#modal-member-edit-form textarea[name='+name+']').length > 0) {
		   $('#modal-member-edit-form textarea[name='+name+']').focus();
	   }
	   else if($('#modal-member-edit-form select[name='+name+']').length > 0) {
		   $('#modal-member-edit-form select[name='+name+']').focus();
	   }
	});
	
	$('#modal-member-edit-form').on('change keydown',function() {
		$('#modal-member-view .button-save-edit-member').removeClass('disabled');
	});
</script>
<script>
	$("#modal-member-view").on( "show.bs.modal", function() {
		$('#modal-member-edit-form').hide();
		$('#modal-member-view-header-edit').hide();
		$('#modal-member-view .modal-member-view-alert').html('');
		<?php if($this->session->data['mode'] != 'edit') { ?>
			$('#modal-member-view .button-edit-member').hide();
		<?php } ?>
	});
</script>