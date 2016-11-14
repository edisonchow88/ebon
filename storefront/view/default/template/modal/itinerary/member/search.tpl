<style>
	#modal-member-search-input-keyword-wrapper {
		height:40px;
		padding:3px;
	}
	
	#modal-member-search-keyword-form input {
		text-align:left;
		font-size:12px;
		border-radius:5px;
	}
	
	#modal-member-search-input-keyword-wrapper .btn-header {
		margin-top:-3px;
		color:#e93578;
	}
	
	#modal-member-search .button-clear {
		position:absolute;
		top:0;
		right:1px;
		padding:0;
	}
	
	#modal-member-search .button-clear div {
		border-radius:5px;
		background-color:#FFF;
		margin:7px 0;
		padding:0 15px;
		member-height:30px;
		text-align:center;
	}
	
	#modal-member-search-no-result {
		background-color:#FFF;
		color:#777;
		padding:15px;
		font-weight:bold;
	}
	
	#modal-member-search .modal-search-result {
		background-color:#FFF;
		height:calc(100vh - 40px);
	}
	
	#modal-member-search .result-user-row {
		border-bottom:solid thin #DDD;
		padding:15px 0;
		background-color:#FFF;
		color:#000;
		cursor:pointer;
	}
	
	#modal-member-search .result-user-image img {
		width:40px;
		height:40px;
		border-radius:20px;
		border:solid thin #DDD;
	}
	
	#modal-member-search .result-user-image .fa-stack {
		font-size:20px;
	}
	
	#modal-member-search .result-user-title {
		font-weight:normal;
		overflow:hidden;
		line-height:40px;
	}
	
	#modal-member-search .result-user-blurb {
		color:#777;
		overflow:hidden;
		font-size:12px;
	}
	
	#modal-member-search .result-user-button {
		text-align:right;
		line-height:40px;
		padding-right:16px;
	}
	
	#modal-member-search .result-user-row.selected > .result-user-button {
		color:#e93578;
	}
</style>
<!-- START: Modal -->
    <div class="modal" id="modal-member-search" role="dialog" data-backdrop="false">
        <div class="modal-dialog fixed-bar fixed-width">
            <div class="modal-content">
                <div class="modal-header">
                	<div class="modal-modal fixed-width" data-toggle="modal" data-target="#modal-member-search"></div>
                	<div id="modal-member-search-input-keyword-wrapper" class="header row">
                    	<div class="col-xs-10">
                        	<form id="modal-member-search-keyword-form">
                                <input name="keyword" class="form-control" placeholder="Search"/>
                                <a class="button-clear" class="btn btn-header"><div><i class="fa fa-fw fa-times-circle"></i><span class="sr-only">x</span></div></a>
                            </form>
                        </div>
                        <div class="col-xs-2 text-right">
                        	<a class="btn btn-header" data-toggle="modal" data-target="#modal-member-search">Cancel</a>
                        </div>
                    </div>
                </div>
                <div class="modal-body nopadding">
                    <?php echo $modal_component['form']; ?>
                    <div id="modal-member-search-no-result">No result.</div>
                    <div class="modal-search-result"></div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$('#modal-member-search .button-clear').on('click', function() {
		$('#modal-member-search-keyword-form input[name=keyword]').val('');
		$('#modal-member-search-keyword-form input[name=keyword]').trigger('change');
		setTimeout(function() { $('#modal-member-search-keyword-form input[name=keyword]').focus(); }, 1);
	});
	
	$('#modal-member-search-keyword-form input[name=keyword]').on('keyup change', function() {
		if($('#modal-member-search-keyword-form input[name=keyword]').val() != '') {
			$('#modal-member-search .button-clear').show();
			$('#modal-member-search .modal-body').show();
			$('#modal-member-search .modal-modal').hide();
			refreshMemberSearchResult();
		}
		else {
			$('#modal-member-search .button-clear').hide();
			$('#modal-member-search .modal-body').hide();
			$('#modal-member-search .modal-modal').show();
		}
	});
	
	$("#modal-member-search").on( "show.bs.modal", function() {
		$('.search-bar').hide();
		$('.search-bar-shadow').hide();
		$('#modal-member-search .modal-body').hide();
		$('#modal-member-search .button-clear').hide();
		$('#modal-member-search-no-result').hide();
		
	});
	
	$("#modal-member-search").on( "shown.bs.modal", function() {
		$('#modal-member-search-keyword-form input[name=keyword]').focus();
	});
	
	$("#modal-member-search").on( "hidden.bs.modal", function() { 
		$('#modal-member-search-form-alert').html('');
		$('#modal-member-search-keyword-form input[name=keyword]').val('');
		$('#modal-member-search-keyword-form input[name=keyword]').trigger('change');
		setTimeout(function() { $('.search-bar input').blur(); }, 1);
		$('.search-bar').show();
		$('.search-bar-shadow').show();
	});
	
	//IMPORATNT: Disable form submit by enter key 
	$('#modal-member-search-keyword-form').on('keyup keypress', function(e) {
		var keyCode = e.keyCode || e.which;
		if (keyCode === 13) { 
			e.preventDefault();
			return false;
		}
	});
</script>
<script>
	function printMemberSearchResult(data) {
		var content = '';
		
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
				+ '<span class="fa-stack">'
					+ '<i class="fa fa-circle fa-stack-2x"></i>'
					+ '<i class="fa fa-stack-1x fa-inverse">'+letter+'</i>'
				+ '</span>'
			;
		}
		
		var name = '';
		if(isset(data.fullname)) {
			name = data.fullname;
		}
		else {
			name = data.email.substring(0,data.email.indexOf('@'));
		}
		
		content += ''
			+ '<div class="row result-user-row" data-order="'+data.fullname.toLowerCase()+'" data-toggle="modal" data-target="#modal-member-invite" onclick="showUser('+data.user_id+');">'
				+ '<div class="col-xs-2 text-center result-user-image">'
					+ photo
				+ '</div>'
				+ '<div class="col-xs-8 text-left">'
					+ '<div class="result-user-title line-clamp-1">'
						+ name
					+ '</div>'
				+ '</div>'
				+ '<div class="col-xs-2 text-right result-user-button">'
					+ '<i class="fa fa-fw fa-lg fa-chevron-right"></i>'
				+ '</div>'
				+ '<form id="result-user-'+data.user_id+'-form" class="result-user-form hidden">'
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
		$('#modal-member-search .modal-search-result').append(content);
	}
	
	function refreshMemberSearchResult() {
		<!-- START: get data -->
			var keyword = $('#modal-member-search-keyword-form input[name=keyword]').val();
		<!-- END -->
		<!-- START: set data -->
			var data = {
				"action":"search_user",
				"keyword":keyword
			};
		<!-- END -->
		<!-- START: send POST -->
			$.post("<?php echo $ajax['trip/ajax_itinerary']; ?>", data, function(json) {
				$('#modal-member-search .modal-search-result').html('');
				if(json.length > 0) {
					$('#modal-member-search-no-result').hide();
					$.each(json, function(i) {
						printMemberSearchResult(json[i]);
					});
				}
				else {
					$('#modal-member-search-no-result').show();
				}
			}, "json");
		<!-- END -->
	}
	
	function showUser(user_id) {
		<!-- START -->
			var data = {
				'user_id'	: $('#result-user-'+user_id+'-form input[name=user_id]').val(),
				'fullname'	: $('#result-user-'+user_id+'-form input[name=fullname]').val(),
				'email'		: $('#result-user-'+user_id+'-form input[name=email]').val()
			};
		<!-- END -->
		<!-- START: process data -->
			if(isset(data.fullname) != false || data.fullname == '') {
				data.fullname = data.email.substring(0,data.email.indexOf('@'));
			}
		<!-- END -->
		<!-- START -->	
			$('#modal-member-invite-form input[name=user_id]').val(data.user_id);
			$('#modal-member-invite-form input[name=fullname]').val(data.fullname);
		<!-- END -->
	}
</script>

