<style>
	#modal-member-invite-form input:disabled {
		color:#000;
	}
	
	#modal-member-invite .btn-block {
		height:50px;
		margin-top:30px;
		border-radius:5px;
		line-height:36px;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top noselect" id="modal-member-invite" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div class="header fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-member-invite">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">User Info</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body">
                        <form class="mobile-form" id="modal-member-invite-form">
                        	<input type="text" name="user_id" class="hidden"/>
                            <input type="text" name="fullname" class="hidden"/>
                            <input type="text" name="email" class="hidden"/>
                        </form>
                        <div class="photo text-center"></div>
                        <div class="name text-center"></div>
                        <div>
                        	<a class="btn btn-block btn-primary box-shadow">Send Invitation</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->


<script>
	$("#modal-member-invite").on( "show.bs.modal", function() {
		<!-- START: set data -->
			var data = {
				'user_id'	: $('#modal-member-invite-form input[name=user_id]').val(),
				'fullname'	: $('#modal-member-invite-form input[name=fullname]').val(),
				'email'		: $('#modal-member-invite-form input[name=email]').val()
			};
		<!-- END -->
		<!-- START: set photo -->
			var photo = '';
			if(isset(data.photo)) {
				photo = '<img src="' + data.photo + '" onerror="this.onerror = \'\';this.src = \'resources/image/error/noimage.png\';" />';
			}
			else {
				var letter = '';
				if(isset(data.fullname)) {
					letter = data.fullname.substring(0,1);
				}
				else {
					letter = data.email.substring(0,1);
				}
				photo = ''
					+ '<span class="fa-stack fa-5x">'
						+ '<i class="fa fa-circle fa-stack-2x"></i>'
						+ '<i class="fa fa-stack-1x fa-inverse">'+letter+'</i>'
					+ '</span>'
				;
			}
		<!-- END -->
		<!-- START: set name -->
			var name = '';
			if(isset(data.fullname)) {
				name = data.fullname;
			}
			else {
				name = data.email.substring(0,data.email.indexOf('@'));
			}
		<!-- END -->
		
		$('#modal-member-invite .photo').html(photo);
		$('#modal-member-invite .name').html(name);
	});
</script>