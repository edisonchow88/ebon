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
	
	#modal-edit-line-form {
		font-size:11px;
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
            	<input type="hidden" name="day_id" />
                <input type="hidden" name="line_id" />
                <input type="hidden" name="action" />
            	<div class="row">
                    <div class="col-xs-2">
                        <input class="border-right" placeholder='Activity' name="activity" />
                    </div>
                	<div class="col-xs-6" style="position:relative;">
                    	<input class="border-right" placeholder='Place' name="place" id="modal-edit-line-form-input-type-id" />
                        <input type="hidden" id="modal-edit-line-form-input-type-hidden" />
                        <input type="hidden" id="modal-edit-line-form-input-type-id-hidden" />
                        <input type="hidden" name="type" id="modal-edit-line-form-input-type-value"/>
                        <input type="hidden" name="type_id" id="modal-edit-line-form-input-type-id-value" />
                        <input type="hidden" name="keyword"/>
                        <div id="modal-edit-line-form-input-type-id-suggestion" style="position:absolute; z-index:15000; width:100%; display:none;"></div>
                    </div>
                	<div class="col-xs-2">
                    	<input class="border-right" placeholder='Latitude' name="lat" />
                    </div>
                    <div class="col-xs-2">
                    	<input placeholder='Longitude' name="lng" />
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
                            <option value=""></option>
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
                <button type="button" class="btn btn-primary" data-dismiss="modal">Save</button>
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
	
	<!-- START: [fee] -->
		$('#modal-edit-line-form input[name=fee]').on('blur', function() {
			if($('#modal-edit-line-form input[name=fee]').val() == '' || $('#modal-edit-line-form input[name=fee]').val() == 0) {
				$('#modal-edit-line-form select[name=currency]').val('');
			}
		});
	<!-- END -->
</script>

<!-- START: search -->
	<script>
        function update_search_input_event() {
            var form_id = 'modal-edit-line-form';
            var input_id = form_id + '-input-' + 'type-id';
            var search_id = input_id + '-suggestion';
			var inputbox = '#modal-edit-line-form input[name=place]';
            
            $(inputbox).off();
            $(inputbox).on('keyup',function() {
                auto_suggest(form_id, this.id, event);
            });
            $(inputbox).on('focus',function() {
                show_suggestion(search_id);
            });
            $(inputbox).on('click',function() {
                auto_suggest(form_id, this.id, event);
            });
            $(inputbox).on('blur',function() {
                setTimeout(function() { hide_suggestion(search_id); }, 100);
            });
        }
        
        function auto_suggest(form_id, input_id, e) {
            var suggestion_id = input_id + "-suggestion";
            var hidden_id = input_id + "-hidden";
            var value_id = input_id + "-value";
            var keyword = $('#'+input_id).val();
            
			$('#'+form_id+' input[name=keyword]').val(keyword);
            
            show_suggestion(suggestion_id);
			
            var key_code;
        
            if(window.event) { // IE                    
                key_code = e.keyCode;
            } else if(e.which){ // Netscape/Firefox/Opera                   
                key_code = e.which;
            }
            
            if(key_code == 40) { //if press down arrow
                if(document.getElementById(suggestion_id).innerHTML == '') { 
                    search_destination(input_id, suggestion_id, keyword);
                    show_suggestion(suggestion_id); 
                }
                select_next_suggestion(input_id);
                return;
            }
            else if(key_code == 38) { //if press up arrow
                if(document.getElementById(suggestion_id).innerHTML == '') { 
                    search_destination(input_id, suggestion_id, keyword);
                    show_suggestion(suggestion_id); 
                }
                select_previous_suggestion(input_id);
                return;
            }
            else if(key_code == 13) { //if press enter
                hide_suggestion(suggestion_id);
                document.getElementById(hidden_id).value = this.suggestion[this.selected_suggestion].name;
                return;
            }
            else if(key_code == 37 || key_code == 39) { //if press left or right arrow
            }
            else if(key_code != '' && key_code != 'undefined' && key_code != null) {
                document.getElementById(value_id).value = '';
                document.getElementById(suggestion_id).innerHTML = '';
            }
			
			$('#'+hidden_id).val($('#'+input_id).val());
            search_destination(input_id, suggestion_id, keyword);
        }
        
        
        function search_destination(input_id, suggestion_id, keyword) {
            <!-- START: set data -->
                var form = 'modal-edit-line-form';
                var data = { action:'search_place',keyword:keyword }
            <!-- END -->
            <!-- START: send POST -->
                $.post("<?php echo $ajax_itinerary; ?>", data, function(result) {
                    auto_list(input_id, suggestion_id, keyword, result);
                }, "json");
            <!-- END -->
        }
        
        function auto_list(input_id, suggestion_id, keyword, response) {
            var result = response;
            var output = '';
            output += "<ul class='list-group' style='margin-top:-1px;'>";
            for(i = 0; i < result.length; i++) {
                output += "<a id='suggestion-"+i+"' class='suggestion btn list-group-item' style='border-top-right-radius:0; border-top-left-radius:0;' onclick='select_suggestion(\""+input_id+"\", \""+result[i].destination_id+"\", \""+result[i].name+"\")'>";
                    output += "<div class='text-left' style='width:100%;'>";
                        output += "<div class='text-left text-success' style='display:inline-block; width:50px;'><i class='fa fa-map-marker fa-fw fa-2x'></i></div>";
                        output += "<div style='display:inline-block;'>";
                            output += "<span class='text-left' style='display:block;'><b>";
                                output += highlight_keyword_with_any_cases(result[i].name, keyword);
                            output += "</b></span>";
                            if(typeof result[i].parent != 'undefined') {
                                output += "<span class='text-left small' style='display:block;'>";
                                    output += result[i].parent.name;
                                output += "</span>";
                            }
                        output += "</div>";
                    output += "</div>";
                output += "</a>";
            }
            output += "</ul>";
            this.suggestion = result;
            this.selected_suggestion = -1;
            document.getElementById(suggestion_id).innerHTML = output;
        }
        
        function reset_suggestion() {
            for(i=0;i<this.suggestion.length;i++) {
                document.getElementById('suggestion-'+i).style.backgroundColor = '';
            }
        }
        
        function select_next_suggestion(input_id) {
            reset_suggestion();
            
            if(this.selected_suggestion < this.suggestion.length) {
                this.selected_suggestion += 1;
            }
            else {
                this.selected_suggestion = 0;
            }
            
            highlight_suggestion(input_id);
        }
        
        function select_previous_suggestion(input_id) {
            reset_suggestion();
            
            if(this.selected_suggestion > 0) {
                this.selected_suggestion -= 1;
            }
            else {
                this.selected_suggestion = this.suggestion.length;
            }
            
            highlight_suggestion(input_id);
        }
        
        function highlight_suggestion(input_id) {
            var hidden_id = input_id + '-hidden';
            var value_id = input_id + '-value';
            
            if(this.selected_suggestion != this.suggestion.length) {
                var suggestion_id = 'suggestion-'+this.selected_suggestion;
                document.getElementById(suggestion_id).style.backgroundColor = '#EEEEEE';
                document.getElementById(input_id).value = this.suggestion[this.selected_suggestion].name;
                document.getElementById(value_id).value = this.suggestion[this.selected_suggestion].destination_id;
            }
            else {
                document.getElementById(input_id).value = document.getElementById(hidden_id).value;
                document.getElementById(value_id).value = '';
            }
        }
        
        function select_suggestion(input_id, destination_id, name) {
            var hidden_id = input_id + '-hidden';
            var value_id = input_id + '-value';
            
            document.getElementById(hidden_id).value = name;
            document.getElementById(input_id).value = name;
            document.getElementById(value_id).value = destination_id;
        }
        
        function show_suggestion(suggestion_id) {
            document.getElementById(suggestion_id).style.display = "block";
        }
        
        function hide_suggestion(suggestion_id) {
            document.getElementById(suggestion_id).style.display = "none";
            document.getElementById(suggestion_id).innerHTML = '';
        }
        
        RegExp.escape = function(str) 
        {
          var specials = /[.*+?|()\[\]{}\\$^]/g; // .*+?|()[]{}\$^
          return str.replace(specials, "\\$&");
        }
        
        function highlight_keyword_with_any_cases(text, keyword)
        {
          var regex = new RegExp("(" + RegExp.escape(keyword) + ")", "gi");
          return text.replace(regex, "<span style='background-color:yellow;'>$1</span>");
        }
		
		update_search_input_event();
    </script>
<!-- END -->