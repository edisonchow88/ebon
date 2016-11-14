<style>
	.result-member-row {
		border-bottom:solid thin #DDD;
		padding:15px 0;
		background-color:#FFF;
		color:#000;
		cursor:pointer;
	}
	
	.result-member-image img {
		width:40px;
		height:40px;
		border-radius:20px;
		border:solid thin #DDD;
	}
	
	.result-member-image .fa-stack {
		font-size:20px;
	}
	
	.result-member-title {
		font-weight:bold;
		overflow:hidden;
	}
	
	.result-member-blurb {
		color:#777;
		overflow:hidden;
		font-size:12px;
	}
	
	.result-member-button {
		text-align:right;
		line-height:40px;
		padding-right:16px;
	}
	
	.result-member-row.selected > .result-member-button {
		color:#e93578;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top noselect" id="modal-member-list" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-member-list-header-main" class="header fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-dismiss="modal">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">All Members</div>
                    </div>
                    <div class="col-xs-3 text-right">
                        <a class="btn btn-header"></a>
                    </div>
                </div>
                <div id="modal-member-list-header-general" class="header header-secondary header-white fixed-bar fixed-width row">
                    <div class="col-xs-6 text-left">
                        <a class="btn btn-header" onclick="openEditMember();">Edit</a>
                    </div>
                    <div class="col-xs-6 text-right">
                    	<a class="btn btn-header" data-dismiss="modal" data-toggle="modal" data-target="#modal-member-add">Add Member</a>
                    </div>
                </div>
                <div id="modal-member-list-header-edit" class="header header-secondary header-white fixed-bar fixed-width row">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" onclick="closeEditMember();">Done</a>
                    </div>
                    <div class="col-xs-6 text-center">
                    </div>
                    <div class="col-xs-3 text-right">
                    	<a class="btn btn-header button-delete" onclick="removeSelectedMember();">Remove</a>
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    	<div id="modal-member-list-list"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function printMember(data) {
		var content = '';
		
		var photo = '';
		if(isset(data.photo)) {
			photo = '<img src="' + data.photo + '" onerror="this.onerror = \'\';this.src = \'resources/image/error/noimage.png\';" />';
		}
		else {
			photo = ''
				+ '<span class="fa-stack">'
					+ '<i class="fa fa-circle fa-stack-2x"></i>'
					+ '<i class="fa fa-stack-1x fa-inverse">'+data.fullname.substring(0,1)+'</i>'
				+ '</span>'
			;
		}
		
		content += ''
			+ '<div class="row result-member-row" data-order="'+data.fullname.toLowerCase()+'">'
				+ '<div class="col-xs-2 text-center result-member-image">'
					+ photo
				+ '</div>'
				+ '<div class="col-xs-8 text-left">'
					+ '<div class="result-member-title line-clamp-1">'
						+ data.fullname
					+ '</div>'
					+ '<div class="result-member-blurb line-clamp-1">'
						+ data.description
					+ '</div>'
				+ '</div>'
				+ '<div class="col-xs-2 text-right result-member-button">'
					+ '<i class="fa fa-fw fa-lg fa-chevron-right"></i>'
				+ '</div>'
				+ '<form id="result-member-'+data.trip_member_id+'-form" class="result-member-form hidden">'
					+ '<input type="hidden" name="trip_member_id" value="' + data.trip_member_id + '"/>'
					+ '<input type="hidden" name="user_id" value="' + data.user_id + '"/>'
					+ '<input type="hidden" name="status_id" value="' + data.status_id + '"/>'
					+ '<input type="hidden" name="fullname" value="' + data.fullname + '"/>'
					+ '<input type="hidden" name="passport" value="' + data.passport + '"/>'
					+ '<input type="hidden" name="dob" value="' + data.dob + '"/>'
					+ '<input type="hidden" name="gender" value="' + data.gender + '"/>'
					+ '<input type="hidden" name="mobile" value="' + data.mobile + '"/>'
					+ '<input type="hidden" name="email" value="' + data.email + '"/>'
				+ '</form>'
			+ '</div>'
		;
		$('#modal-member-list-list').append(content);
	}
	
	function refreshMemberList() {
		<!-- START: get data -->
			var trip_id = <?php echo $this->trip->getTripId(); ?>;
		<!-- END -->
		<!-- START: set data -->
			var data = {
				"action":"refresh_member",
				"trip_id":trip_id
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				$('#modal-member-list-list').html('');
				$.each(json, function(i) {
					printMember(json[i]);
				});
				updateMemberListButton();
				sortMember();
			}, "json");
		<!-- END -->
	}
	
	function openEditMember() {
		$('#modal-member-list-header-general').addClass('hidden');
		$('#modal-member-list-header-edit').removeClass('hidden');
		$('.result-member-button').html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$('.result-member-button').css('color','#CCC');
		$('.result-member-row').removeClass('selected');
		$('.result-member-row').off().on('click',function() { 
			var button = $(this).find('.result-member-button');
			if($(this).hasClass('selected')) {
				$(this).removeClass('selected');
				deselectMember(button);
			}
			else {
				$(this).addClass('selected');
				selectMember(button);
			}
		});
	}
	
	function closeEditMember() {
		$('#modal-member-list-header-general').removeClass('hidden');
		$('#modal-member-list-header-edit').addClass('hidden');
		$('#modal-member-list .button-delete').addClass('disabled');
		$('.result-member-button').html('<i class="fa fa-fw fa-lg fa-chevron-right"></i>');
		$('.result-member-button').css('color','#000');
		updateMemberListButton();
	}
	
	function selectMember(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-check-square"></i>');
		$(button).css('color','#e93578');
		if($('.result-member-row.selected').length > 0) {
			$('#modal-member-list .button-delete').removeClass('disabled');
		}
	}
	
	function deselectMember(button) {
		$(button).html('<i class="fa fa-fw fa-lg fa-square-o"></i>');
		$(button).css('color','#CCC');
		if($('.result-member-row.selected').length < 1) {
			$('#modal-member-list .button-delete').addClass('disabled');
		}
	}
	
	function removeSelectedMember() {
		//Google Analytics Event
		ga('send', 'event','member', 'remove-member');
		<!-- START: get data -->
			var trip_id = <?php echo $this->trip->getTripId(); ?>;
			var member = new Array();
			var trip_member_id = '';
			var e;
			for(i=0;i<$('.result-member-row.selected').length;i++) {
				e = $('.result-member-row.selected .result-member-form input[name=trip_member_id]').get(i);
				trip_member_id = $(e).val();
				member.push(trip_member_id);
			}
		<!-- END -->
		<!-- START: set data -->
			var data = {
				"action"	: "delete_member",
				"trip_id"	: trip_id,
				"member"	: member
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				<!-- START -->
					var length = $('.result-member-row.selected').length;
				<!-- END -->
				<!-- START -->
					$('.result-member-row.selected').remove();
					$('#modal-member-list .button-delete').addClass('disabled');
				<!-- END -->
				<!-- START: show hint -->
					if(length > 1) {
						showHint('Members Removed');
					}
					else {
						showHint('Member Removed');
					}
				<!-- END -->
			}, "json");
		<!-- END -->
	}
	
	function sortMember() {
		$('#modal-member-list-list').find('.result-member-row').sort(function (a, b) {
			if(a.getAttribute('data-order') < b.getAttribute('data-order')) return -1;
			if(a.getAttribute('data-order') > b.getAttribute('data-order')) return 1;
			return 0;
		})
		.appendTo($('#modal-member-list-list'));
	}
	
	$('.button-add-member').on('click',function() { addMember(); });
	
	
	function updateMemberListButton() {
		$('.result-member-row').off().on('click',function() {
			var data = {
				"trip_member_id":$(this).find('.result-member-form input[name=trip_member_id]').val(),
				"user_id":$(this).find('.result-member-form input[name=user_id]').val(),
				"status_id":$(this).find('.result-member-form input[name=status_id]').val(),
				"fullname":$(this).find('.result-member-form input[name=fullname]').val(),
				"passport":$(this).find('.result-member-form input[name=passport]').val(),
				"dob":$(this).find('.result-member-form input[name=dob]').val(),
				"gender":$(this).find('.result-member-form input[name=gender]').val(),
				"mobile":$(this).find('.result-member-form input[name=mobile]').val(),
				"email":$(this).find('.result-member-form input[name=email]').val()
			};
			openViewMemberModal(data);
			$('#modal-member-view').modal('show');
			$('#modal-member-list').modal('hide');
		});
	}
</script>
<script>
	$("#modal-member-list").on( "show.bs.modal", function() {
		refreshMemberList();
		closeEditMember();
		$('#modal-member-list-alert').html('');
		<?php if($this->session->data['mode'] != 'edit') { ?>
			$('#modal-member-list #modal-member-list-header-general').addClass('hidden');
			$('#modal-member-list .modal-header-shadow:first').addClass('hidden');
		<?php } ?>
	});
	$("#modal-member-list").on( "shown.bs.modal", function() {
		$('#modal-member-list .modal-content').scrollTop(0);
	});
</script>