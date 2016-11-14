<style>
	#modal-member-add input:disabled {
		color:#000;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top noselect" id="modal-member-add" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-member-add-header-main" class="header fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-dismiss="modal" data-toggle="modal" data-target="#modal-member-list">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">New Member</div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header button-save-new-member disabled" onclick="saveNewMember();">Done</a>
                    </div>
                </div>
                <div class="header header-secondary fixed-bar fixed-width search-bar">
                    <input class="form-control" placeholder="Search existing user" data-toggle="modal" data-target="#modal-member-search">
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-header-shadow search-bar-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    	<div class="modal-section-title small modal-background-grey">You may invite existing user by using the search or add a new member manually by filing up the following form.</div>
                    	<div class="modal-member-add-alert">
                        </div>
                        <form class="mobile-form" id="modal-member-add-form">
                        	<div class="row">
                                <div class="col-xs-4"><label for="fullname" selected>Full Name</label></div>
                                <div class="col-xs-8">
                                	<input type="text" name="fullname"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4"><label for="passport" selected>Passport</label></div>
                                <div class="col-xs-8">
                                	<input type="text" name="passport"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4"><label for="dob" selected>Date of Birth</label></div>
                                <div class="col-xs-8">
                                	<input type="date" name="dob"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4"><label for="gender" selected>Gender</label></div>
                                <div class="col-xs-8">
                                	<select name="gender"/>
                                    	<option value="1">Male</option>
                                    	<option value="2">Female</option>
                                    </select>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4"><label for="mobile" selected>Mobile</label></div>
                                <div class="col-xs-8">
                                	<input type="text" name="mobile"/>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-4"><label for="email" selected>Email</label></div>
                                <div class="col-xs-8">
                                	<input type="text" name="email"/>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function saveNewMember() {
		<!-- START: get data -->
			var trip_id = <?php echo $this->trip->getTripId(); ?>;
		<!-- END -->
		<!-- START: set data -->
			var data = {
				"action"			: "add_member",
				"trip_id"			: trip_id,
				'trip_member_id'	: $('#modal-member-add-form input[name=trip_member_id]').val(),
				"status_id"			: 1,
				'fullname'			: $('#modal-member-add-form input[name=fullname]').val(),
				'passport'			: $('#modal-member-add-form input[name=passport]').val(),
				'dob'				: $('#modal-member-add-form input[name=dob]').val(),
				'gender'			: $('#modal-member-add-form select[name=gender]').val(),
				'mobile'			: $('#modal-member-add-form input[name=mobile]').val(),
				'email'				: $('#modal-member-add-form input[name=email]').val()
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
				$('#modal-member-add .modal-member-add-alert').html(content);
				return;
			}
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				if(isset(json.warning)) {
					showAlert(json.warning);
				}
				else if(isset(json.success)) {
					showHint('Member Added');
					$("#modal-member-add").modal('hide');
					$("#modal-member-list").modal('show');
					sortMember();
				}
			}, "json");
		<!-- END -->
	}
	
	$('#modal-member-add-form').on('change keydown',function() {
		$('#modal-member-add .button-save-new-member').removeClass('disabled');
	});
</script>
<script>
	$("#modal-member-add").on( "show.bs.modal", function() {
		<!-- START -->
			$('#modal-member-add-form').trigger('reset');
			$('#modal-member-add .button-save-new-member').addClass('disabled');
			$('#modal-member-add .modal-member-add-alert').html('');
		<!-- END -->
	});
</script>