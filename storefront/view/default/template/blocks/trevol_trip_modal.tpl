<style>
	#modal-edit-line .modal-header {
		background-color:#333;
		color:#FFF;
		border-radius:4px 4px 0 0;
	}
	
	#modal-edit-line .modal-header > button {
		color:#FFF;
		opacity:0.5;
	}
	
	#modal-edit-line .modal-header > button:hover {
		color:#FFF;
		opacity:0.9;
	}
	
	#modal-edit-line .modal-footer {
		background-color:#EEE;
		border-radius:0 0 4px 4px;
	}
	
	#modal-edit-line .modal-title {
		cursor:default;
	}
	
	#modal-edit-line-form input {
		width:100%;
		height:40px;
		padding-left:15px;
		border:none;
		border-bottom:solid thin #EEE;
		color:#000;
	}
	
	#modal-edit-line-form select {
		width:100%;
		height:40px;
		padding-left:15px;
		border:none;
		border-radius:0;
		border-bottom:solid thin #EEE;
		background-color:#FFF;
		color:#000;
  		-webkit-appearance: none;
		-webkit-border-radius: 0px;
		background: url("data:image/svg+xml;utf8,<svg version='1.1' xmlns='http://www.w3.org/2000/svg' xmlns:xlink='http://www.w3.org/1999/xlink' width='24' height='24' viewBox='0 0 24 24'><path fill='#CCC' d='M7.406 7.828l4.594 4.594 4.594-4.594 1.406 1.406-6 6-6-6z'></path></svg>");
		background-position: 100% 50%;
		background-repeat: no-repeat;
	}
	
	#modal-edit-line-form input:focus, #modal-edit-line-form textarea:focus, #modal-edit-line-form select:focus {
		outline: none;
	}
	
	#modal-edit-line-form textarea {
		width:100%;
		padding-left:15px;
		padding-top:10px;
		text-align:left;
		border:none;
		border-bottom:solid thin #EEE;
		resize:none;
		margin-bottom:-6px;
		color:#000;
	}
	
	#modal-edit-line-form input.border-right {
		border-right:solid thin #EEE;
	}
</style>

<div class="modal fade" id="modal-edit-line" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header noselect">
            <button type="button" class="close nos" data-dismiss="modal">&times;</button>
            <h4 class="modal-title noselect">Edit Activity</h4>
            </div>
        <div class="modal-body nopadding">
            <form id="modal-edit-line-form">
            	<input type="hidden" name="line_id" />
            	<div class="row">
                    <div class="col-xs-4">
                        <input class="border-right" placeholder='Activity' name="activity" />
                    </div>
                	<div class="col-xs-8">
                    	<input placeholder='Place' name="place" />
                    </div>
                </div>
                <div class="row">
                    <div class="col-xs-4">
                        <input class="border-right" placeholder='Start Time' name='time' type="time"/>
                    </div>
                    <div class="col-xs-4">
                        <input class="border-right" placeholder='Duration' name='duration'/>
                        <div id="modal-edit-line-form-input-hourminute" class="row">
                            <div class="col-xs-3">
                                <input class="text-right" name='hour' placeholder='0'/>
                            </div>
                            <div class="col-xs-3">
                            	<input placeholder='h' disabled/>
                            </div>
                            <div class="col-xs-3">
                                <input class="text-right" name='minute' placeholder='00'/>
                            </div>
                            <div class="col-xs-3">
                            	<input class="border-right" placeholder='m' disabled/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <input class="text-right" placeholder='Fee' name='fee'/>
                    </div>
                    <div class="col-xs-2">
                        <select name='currency'>
                            <option value="MYR">MYR</option>
                            <option value="JPY">JPY</option>
                        	<option value="USD">USD</option>
                        </select>
                    </div>
                </div>
                <div class="row">
                	<div class="col-xs-12">
                        <textarea placeholder='Note' rows="10" name="note"></textarea>
                    </div>
                </div>
            </form>
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveEditPlanLineForm();">Save</button>
            </div>
        </div>
    </div>
</div>

<script>
	<!-- START: [time] -->
		$('#modal-edit-line-form input[name=time]').on('focus', function() {
			$('#modal-edit-line-form input[name=time]').attr('type','time');
		});
		$('#modal-edit-line-form input[name=time]').on('blur', function() {
			if($('#modal-edit-line-form input[name=time]').val() == '') {
				$('#modal-edit-line-form input[name=time]').attr('type','text');
			}
		});
	<!-- END -->	
		
	<!-- START: [duration] -->
		$('#modal-edit-line-form input[name=duration]').on('focus', function() {
			$('#modal-edit-line-form input[name=duration]').hide();
			$('#modal-edit-line-form-input-hourminute').show();
			$('#modal-edit-line-form input[name=hour]').focus();
		});
		$('#modal-edit-line-form input[name=hour]').on('blur', function() {
			if($('#modal-edit-line-form input[name=hour]').val() == '') {
				$('#modal-edit-line-form input[name=hour]').val(0);
			}
			setTimeout(function() {
				if($(document.activeElement).attr('name') == 'minute') {
				}
				else {
					if($('#modal-edit-line-form input[name=hour]').val() == '' || $('#modal-edit-line-form input[name=hour]').val() == 0) {
						if($('#modal-edit-line-form input[name=minute]').val() == '' || $('#modal-edit-line-form input[name=minute]').val() == 0 || $('#modal-edit-line-form input[name=minute]').val() == '00') {
							$('#modal-edit-line-form input[name=duration]').show();
							$('#modal-edit-line-form-input-hourminute').hide();
							$('#modal-edit-line-form input[name=duration]').val('');
							$('#modal-edit-line-form input[name=hour]').val('');
							$('#modal-edit-line-form input[name=minute]').val('');
						}
					}
					else {
						if($('#modal-edit-line-form input[name=minute]').val() == '' || $('#modal-edit-line-form input[name=minute]').val() == 0) {
							$('#modal-edit-line-form input[name=minute]').val('00');
						}
					}
				}
			}, 100);
		});
		$('#modal-edit-line-form input[name=minute]').on('blur', function() {
			if($('#modal-edit-line-form input[name=minute]').val() == '' || $('#modal-edit-line-form input[name=minute]').val() == '0') {
				$('#modal-edit-line-form input[name=minute]').val('00');
			}
			setTimeout(function() {
				if($(document.activeElement).attr('name') == 'hour') {
				}
				else {
					if($('#modal-edit-line-form input[name=minute]').val() == '' || $('#modal-edit-line-form input[name=minute]').val() == 0 || $('#modal-edit-line-form input[name=minute]').val() == '00') {
						if($('#modal-edit-line-form input[name=hour]').val() == '' || $('#modal-edit-line-form input[name=hour]').val() == 0) {
							$('#modal-edit-line-form input[name=duration]').show();
							$('#modal-edit-line-form-input-hourminute').hide();
							$('#modal-edit-line-form input[name=duration]').val('');
							$('#modal-edit-line-form input[name=hour]').val('');
							$('#modal-edit-line-form input[name=minute]').val('');
						}
					}
					else {
						if($('#modal-edit-line-form input[name=hour]').val() == '' || $('#modal-edit-line-form input[name=hour]').val() == 0) {
							$('#modal-edit-line-form input[name=hour]').val(0);
						}
					}
				}
			}, 100);
		});
	<!-- END -->
</script>