<style>
	
	.mobile-form label {
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
	.mobile-form input, .mobile-form select {
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
		
	.mobile-form input:disabled {
		color:#999;
	}
	.mobile-form select {
		-webkit-appearance: none;
		-webkit-border-radius: 0px;
	}
</style>

<!-- START: Modal -->
	<div class="modal" id="modal-member-join" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
            <div class="modal-header fixed-width">
                <div class="navbar navbar-primary navbar-modal fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn" data-toggle="modal" data-target="#modal-member-join">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span>Request to Join Trip</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-body fixed-width padding">
            	<div class="navbar navbar-shadow"></div>
                <div class="modal-member-join-alert">
                </div>
                <form class="mobile-form" id="modal-member-join-form">
                    <div class="row">
                        <div class="col-xs-4"><label for="fullname" selected>Full Name*</label></div>
                        <div class="col-xs-8">
                            <input type="text" name="fullname"/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-4"><label for="passport" selected>Passport No.</label></div>
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
                <div class="padding">
                	<a class="btn btn-block btn-primary box-shadow rounded fixed-height-5" onclick="saveNewMember();">Send Request</a>
                </div>        
            </div>
        </div>
    </div>
<!-- END -->


<script>
	function saveNewMember() {
		<!-- START: get data -->
			var trip_id = <?php echo $this->trip->getTripId(); ?>;
			var user_id = <?php echo $this->user->getUserId(); ?>;
			//alert (user_id);
		<!-- END -->
		<!-- START: set data -->
			var data = {
				"action"			: "request_join_trip",
				"user_id"			: user_id,
				"trip_id"			: trip_id,
				'trip_member_id'	: $('#modal-member-join-form input[name=trip_member_id]').val(),
				"status_id"			: 5,
				'fullname'			: $('#modal-member-join-form input[name=fullname]').val(),
				'passport'			: $('#modal-member-join-form input[name=passport]').val(),
				'dob'				: $('#modal-member-join-form input[name=dob]').val(),
				'gender'			: $('#modal-member-join-form select[name=gender]').val(),
				'mobile'			: $('#modal-member-join-form input[name=mobile]').val(),
				'email'				: $('#modal-member-join-form input[name=email]').val()
			};
		<!-- END -->
		<!-- START: verify data -->
			if(isset(data.fullname) == false) {
				showWarning ("Full Name is Missing.");
				return;
			}else { showWarning (""); }
		<!-- END -->
	
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				//alert (JSON.stringify(json));
				if(isset(json.warning)) {
					showWarning(json.warning);
				}
				else if(isset(json.success)) {
					showWarning("");
					showHint(json.success);
					//redirect
					window.location = json.redirect;
				}
			}, "json");
		<!-- END -->
	}
	
	function showWarning (msg) {
		var content = '';
				content = ''
					+ '<div class="alert alert-danger">'
						+ '<ul>'
							+ '<li>'
								+ msg
							+ '</li>'
						+ '</ul>'
					+ '</div>'
				;
		
		if (msg == "" ) content= "";		
		$('#modal-member-join .modal-member-join-alert').html(content);		
	}
	
	$('#modal-member-join-form label').click(function() {
       name = $(this).attr('for');
	   if($('#modal-member-join-form input[name='+name+']').length > 0) {
		   $('#modal-member-join-form input[name='+name+']').focus();
	   }
	   else if($('#modal-member-join-form textarea[name='+name+']').length > 0) {
		   $('#modal-member-join-form textarea[name='+name+']').focus();
	   }
	   else if($('#modal-member-join-form select[name='+name+']').length > 0) {
		   $('#modal-member-join-form select[name='+name+']').focus();
	   }
	});
	
	$('#modal-member-join-form').on('change keydown',function() {
		$('#modal-member-join .button-save-new-member').removeClass('disabled');
	});
</script>
<script>
	$("#modal-member-join").on( "show.bs.modal", function() {
		<!-- START -->
			//$('#modal-member-join-form').trigger('reset');
			$('#modal-member-join .button-save-new-member').addClass('disabled');
			$('#modal-member-join .modal-member-join-alert').html('');
		<!-- END -->
	});
</script>