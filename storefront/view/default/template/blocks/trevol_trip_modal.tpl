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
	
	#modal-edit-line .modal-body {
		font-size:11px;
	}
	
	#modal-edit-line-form label {
		margin:0;
		width:100%;
		height:40px;
		line-height:39px;
		padding-left:15px;
		padding-right:15px;
		border:none;
		border-bottom:solid thin #EEE;
		color:#000;
		font-weight:normal;
	}
	
	#modal-edit-line-form input {
		width:100%;
		height:40px;
		padding-left:15px;
		padding-right:15px;
		border:none;
		border-bottom:solid thin #EEE;
		color:#000;
	}
	
	#modal-edit-line-form select {
		width:100%;
		height:40px;
		padding-left:15px;
		padding-right:15px;
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
		display:block;
		width:100%;
		padding:10px 15px;
		text-align:left;
		border:none;
		border-bottom:solid thin #EEE;
		resize:none;
		color:#000;
	}
	
	#modal-edit-line-form input.border-right {
		border-right:solid thin #EEE;
	}
	
	#modal-edit-line-form select.border-right {
		border-right:solid thin #EEE;
	}
	
	#modal-edit-line .modal-footer {
		border-top:solid thin rgb(204, 204, 204);
	}
	
	#modal-edit-line .modal-body-top {
		background-color:#EEE;
		border-bottom:solid thin rgb(204, 204, 204);
	}
	
	#modal-edit-line .nav {
		border-bottom:none;
		padding:0 7px;
	}
	
	#modal-edit-line .nav > li {
		margin-bottom:-1px;
	}
	
	#modal-edit-line .nav > li.active > a {
		border:solid thin rgb(204, 204, 204);
		border-bottom:solid thin #FFF;
	}
	
	#modal-edit-line .nav > li:not(.active) > a:hover {
		border:solid thin rgb(204, 204, 204);
		background-color:#FFF;
		color:#000;
	}
	
	#modal-edit-line .nav > li > a {
		margin:0;
	}
	
	#modal-edit-line .tab-content {
		padding:0;
	}
	
	.noborderbottom {
		border-bottom:none !important;
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
        	<div class="modal-body-top">
            	<div style="padding:7px; position:relative;">
                    <form id="modal-edit-line-form-search">
                        <div class="input-group">
                            <input class="form-control" type="text" name="keyword" placeholder="Search ..."/>
                            <span class="input-group-btn">
                                <button class="btn btn-default" type="button">
                                	<i class="fa fa-fw fa-search"></i>
                                </button>
                            </span>
                        </div>
                    </form>
                    <div id="modal-edit-line-form-search-input-keyword-suggestion" style="position:absolute; z-index:15000; width:calc(100% - 14px); display:none;"></div>
                </div>
                <div>
                    <ul role="tablist" class="nav nav-tabs noselect">
                        <li role="presentation" class="active">
                        	<a href="#modal-edit-line-form-general" role="tab" data-toggle="tab">General</a>
                        </li>
                        <li role="presentation">
                        	<a href="#modal-edit-line-form-details" role="tab" data-toggle="tab">Details</a>
                        </li>
                    </ul>
                </div>
            </div>
            <form id="modal-edit-line-form">
            	<input type="hidden" name="day_id" />
                <input type="hidden" name="line_id" />
                <input type="hidden" name="action" />
                <div class="tab-content">
                	<div id="modal-edit-line-form-general" role="tabpanel" class="tab-pane active">
                        <div class="row">
                            <div class="col-xs-12">
                                <input placeholder='Title' name="title"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <textarea placeholder='Description' rows="10" name="description"></textarea>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <textarea class="noborderbottom" placeholder='Note (only viewable by planner)' rows="5" name="note"></textarea>
                            </div>
                        </div>
                    </div>
                    <div id="modal-edit-line-form-details" role="tabpanel" class="tab-pane">
                    	<div class="row">
                        	<div class="col-xs-2">
                            	<label>Activity</label>
                            </div>
                            <div class="col-xs-10">
                                <select class="border-right" name='activity' placeholader='Activity'>
                                    <option value="visit">Visit</option>
                                    <option value="eat">Eat</option>
                                    <option value="join">Join</option>
                                    <option value="stay">Stay</option>
                                    <option value="shopping">Shopping</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                        	<div class="col-xs-2">
                            	<label>Place</label>
                            </div>
                            <div class="col-xs-6">
                                <input class="border-right" placeholder='Place Name' name="place" id="modal-edit-line-form-input-name" />
                                <input type="hidden" name="keyword"/>
                                <input type="hidden" id="modal-edit-line-form-input-name-hidden" />
                                <input type="hidden" name="type" id="modal-edit-line-form-input-type-hidden" />
                                <input type="hidden" name="type_id" id="modal-edit-line-form-input-type-id-hidden" />
                                
                            </div>
                            <div class="col-xs-2">
                                <input class="border-right" placeholder='Latitude' name="lat" />
                            </div>
                            <div class="col-xs-2">
                                <input placeholder='Longitude' name="lng" />
                            </div>
                        </div>
                        <div class="row">
                        	<div class="col-xs-2">
                            	<label>Time</label>
                            </div>
                            <div class="col-xs-6">
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
                        </div>
                        <div class="row">
                        	<div class="col-xs-2">
                            	<label class="noborderbottom">Fee</label>
                            </div>
                            <div class="col-xs-6">
                                <input class="border-right noborderbottom" placeholder='Total Fee' name='fee'/>
                            </div>
                            <div class="col-xs-4">
                                <select class="noborderbottom" name='currency'>
                                    <option value="">Currency</option>
                                    <option value="MYR">MYR</option>
                                    <option value="JPY">JPY</option>
                                    <option value="USD">USD</option>
                                </select>
                            </div>
                        </div>
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
	<!-- START: [tab] -->
		$("#modal-edit-line").on( "hidden.bs.modal", function() { 
			$('#modal-edit-line .nav-tabs a[href="#modal-edit-line-form-general"]').tab('show');
		});
	<!-- END -->
</script>
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
	
	<!-- START: [currency] -->
		function update_modal_edit_line_form_input_currency_color() {
			if($('#modal-edit-line-form select[name=currency]').val() == '') {
				$('#modal-edit-line-form select[name=currency]').css('color','#96979d');
			}
			else {
				$('#modal-edit-line-form select[name=currency]').css('color','#000');
			}
		}
		
		$('#modal-edit-line-form select[name=currency]').on('change', function() {
			update_modal_edit_line_form_input_currency_color();
		});
		
		$("#modal-edit-line").on( "show.bs.modal", function() { 
			update_modal_edit_line_form_input_currency_color();
		});
	<!-- END -->
</script>

<!-- START: search -->
	<script>
        function update_search_input_event() {
			var form = 'modal-edit-line-form';
			var input = {
				input		: form + '-search input[name=keyword]',
				suggestion	: form + '-search-input-keyword-suggestion',
				hidden		: form + '-input-name-hidden',
				type		: form + '-input-type-hidden',
				type_id		: form + '-input-type-id-hidden'
			};
            
            $('#'+input.input).off();
            $('#'+input.input).on('keyup',function() {
                auto_suggest(form, input, event);
            });
            $('#'+input.input).on('focus',function() {
                show_suggestion(input.suggestion);
            });
            $('#'+input.input).on('click',function() {
                auto_suggest(form, input, event);
            });
            $('#'+input.input).on('blur',function() {
                setTimeout(function() { hide_suggestion(input.suggestion); }, 100);
            });
        }
        
        function auto_suggest(form, input, e) {
			
            var keyword = $('#'+input.input).val();
			$('#'+form+' input[name=keyword]').val(keyword);
            
            show_suggestion(input.suggestion);
			
            var key_code;
        
            if(window.event) { // IE                    
                key_code = e.keyCode;
            } else if(e.which){ // Netscape/Firefox/Opera                   
                key_code = e.which;
            }
            
            if(key_code == 40) { //if press down arrow
                if(document.getElementById(input.suggestion).innerHTML == '') { 
                    search_all(input, keyword);
                    show_suggestion(input.suggestion); 
                }
                select_next_suggestion();
                return;
            }
            else if(key_code == 38) { //if press up arrow
                if(document.getElementById(input.suggestion).innerHTML == '') { 
                    search_all(input, keyword);
                    show_suggestion(input.suggestion); 
                }
                select_previous_suggestion();
                return;
            }
            else if(key_code == 13) { //if press enter
                hide_suggestion(input.suggestion);
				$('#'+input.hidden).val(this.suggestion[this.selected_suggestion].name);
                return;
            }
            else if(key_code == 37 || key_code == 39) { //if press left or right arrow
            }
            else if(key_code != '' && key_code != 'undefined' && key_code != null) {
				$('#'+input.type).val('');
				$('#'+input.type_id).val('');
				$('#'+form+' input[name=place]').val('');
				$('#'+form+' input[name=lat]').val('');
				$('#'+form+' input[name=lng]').val('');
            }
			
			$('#'+input.hidden).val($('#'+input.input).val());
            search_all(input, keyword);
        }
        
        
        function search_all(input, keyword) {
			var suggestion_id = input.suggestion;
            <!-- START: set data -->
                var data = { action:'search_all',keyword:keyword }
            <!-- END -->
            <!-- START: send POST -->
                $.post("<?php echo $ajax_itinerary; ?>", data, function(result) {
                    auto_list(suggestion_id, keyword, result);
                }, "json");
            <!-- END -->
        }
        
        function auto_list(suggestion_id, keyword, result) {
			if(typeof result != 'undefined' && result != null) {
				var output = '';
				output += "<ul class='list-group' style='margin-top:-1px;'>";
				for(i = 0; i < result.length; i++) {
					output += "<a id='suggestion-"+i+"' class='suggestion btn list-group-item' style='border-top-right-radius:0; border-top-left-radius:0;' onclick='select_suggestion(\""+result[i].type_id+"\", \""+result[i].type+"\", \""+result[i].name+"\", \""+result[i].lat+"\", \""+result[i].lng+"\")')'>";
						output += "<div class='text-left' style='width:100%;'>";
							output += "<div class='text-left text-success' style='display:inline-block; width:50px;'>";
							if(result[i].type == 'destination') {
								output += "<i class='fa fa-map-marker fa-fw fa-2x'></i>";
							}
							else if(result[i].type == 'poi') {
								output += "<i class='fa fa-camera-retro fa-fw fa-2x'></i>";
							}
							output += "</div>";
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
				$('#'+suggestion_id).html(output);
			}
			else {
				$('#'+suggestion_id).html('');
			}
        }
        
        function reset_suggestion() {
            for(i=0;i<this.suggestion.length;i++) {
				$('#suggestion-'+i).css('background-color','');
            }
        }
        
        function select_next_suggestion() {
            reset_suggestion();
            
            if(this.selected_suggestion < this.suggestion.length) {
                this.selected_suggestion += 1;
            }
            else {
                this.selected_suggestion = 0;
            }
            
            highlight_suggestion();
        }
        
        function select_previous_suggestion() {
            reset_suggestion();
            
            if(this.selected_suggestion > 0) {
                this.selected_suggestion -= 1;
            }
            else {
                this.selected_suggestion = this.suggestion.length;
            }
            
            highlight_suggestion();
        }
        
        function highlight_suggestion() {
			var form = 'modal-edit-line-form';
			var input = {
				input		: form + '-search input[name=keyword]',
				suggestion	: form + '-search-input-keyword-suggestion',
				hidden		: form + '-input-name-hidden',
				type		: form + '-input-type-hidden',
				type_id		: form + '-input-type-id-hidden'
			};
            
            if(this.selected_suggestion != this.suggestion.length) {
                var suggestion_id = 'suggestion-'+this.selected_suggestion;
				$('#'+suggestion_id).css('background-color','#EEEEEE');
				$('#'+input.input).val(this.suggestion[this.selected_suggestion].name);
				$('#'+input.type).val(this.suggestion[this.selected_suggestion].type);
				$('#'+input.type_id).val(this.suggestion[this.selected_suggestion].type_id);
				$('#'+form+' input[name=title]').val(toTitleCase($('#'+form+' select[name=activity]').val()) + ' ' + this.suggestion[this.selected_suggestion].name);
				$('#'+form+' input[name=place]').val(this.suggestion[this.selected_suggestion].name);
				$('#'+form+' input[name=lat]').val(this.suggestion[this.selected_suggestion].lat);
				$('#'+form+' input[name=lng]').val(this.suggestion[this.selected_suggestion].lng);
            }
            else {
				$('#'+input.input).val($('#'+input.hidden).val());
				$('#'+input.type).val('');
				$('#'+input.type_id).val('');
				$('#'+form+' input[name=lat]').val('');
				$('#'+form+' input[name=lng]').val('');
            }
        }
        
        function select_suggestion(type_id, type, name, lat, lng) {
			var form = 'modal-edit-line-form';
			var input = {
				input		: form + '-search input[name=keyword]',
				suggestion	: form + '-search-input-keyword-suggestion',
				hidden		: form + '-input-name-hidden',
				type		: form + '-input-type-hidden',
				type_id		: form + '-input-type-id-hidden'
			};
			$('#'+input.input).val(name);
			$('#'+input.hidden).val(name);
			$('#'+input.type).val(type);
			$('#'+input.type_id).val(type_id);
			$('#'+form+' input[name=title]').val(toTitleCase($('#'+form+' select[name=activity]').val()) + ' ' + name);
			$('#'+form+' input[name=place]').val(name);
			$('#'+form+' input[name=lat]').val(lat);
			$('#'+form+' input[name=lng]').val(lng);
        }
        
        function show_suggestion(suggestion_id) {
			$('#'+suggestion_id).show();
        }
        
        function hide_suggestion(suggestion_id) {
            $('#'+suggestion_id).hide();
			$('#'+suggestion_id).html('');
        }
        
        RegExp.escape = function(str) 
        {
          var specials = /[.*+?|()\[\]{}\\$^]/g; // .*+?|()[]{}\$^
          return str.replace(specials, "\\$&");
        }
        
		function toTitleCase(str)
		{
			return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
		}
		
        function highlight_keyword_with_any_cases(text, keyword)
        {
          var regex = new RegExp("(" + RegExp.escape(keyword) + ")", "gi");
          return text.replace(regex, "<span style='background-color:yellow;'>$1</span>");
        }
		
		$('#modal-edit-line-form-search').on('keyup keypress', function(e) {
			var keyCode = e.keyCode || e.which;
			if (keyCode === 13) { 
				e.preventDefault();
				return false;
			}
		});
		
		update_search_input_event();
    </script>
<!-- END -->