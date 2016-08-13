<?php
	class componentDatabaseModal extends component{
		public function add($object,$ajax,$form) {
			//START: set modal
				$modal['action'] = 'add';
				$modal['next'] = 'Save';
				$modal['object'] = $object;
				$modal['object_id'] = str_replace("_","-",$object);
				$modal['object_name'] = ucwords(str_replace("_"," ",$object));
				$modal['id'] = 'modal-'.$modal['action'].'-'.$modal['object_id'];
				$modal['title'] = ucwords($modal['action'].' '.$modal['object_name']);
				$modal['function'] = $modal['action'].str_replace(" ","",$modal['object_name']).'()';
				$modal['ajax'] = $ajax;
			//END
			
			//START: set form
				foreach($form as $action => $f) {
					$id = 'modal-'.$action.'-'.$modal['object_id'].'-form';
					$modal['body'] .= $this->writeForm($id,$action,$f['input']);
				}
			//END
			
			//START: set output
				$output ='';
				$output .= $this->writeModal($modal['id'],$modal['title'],$modal['body'],$modal['next'],$modal['function']);
				$output .= $this->writeScript($modal['id'],$modal['action'],$modal['function'],$modal['ajax']);
			//END
			
			return $output;
		}
		
		public function edit($object,$ajax,$form) {
			//START: set modal
				$modal['action'] = 'edit';
				$modal['next'] = 'Save';
				$modal['object'] = $object;
				$modal['object_id'] = str_replace("_","-",$object);
				$modal['object_name'] = ucwords(str_replace("_"," ",$object));
				$modal['id'] = 'modal-'.$modal['action'].'-'.$modal['object_id'];
				$modal['title'] = ucwords($modal['action'].' '.$modal['object_name']);
				$modal['function'] = $modal['action'].str_replace(" ","",$modal['object_name']).'()';
				$modal['ajax'] = $ajax;
			//END
			
			//START: set for get script
				$get['action'] = 'get';
				$get['id'] = 'modal-'.$get['action'].'-'.$modal['object_id'];
				$get['function'] = $get['action'].str_replace(" ","",$modal['object_name']).'()';
				$get['ajax'] = $ajax;
			//END
			
			//START: set form
				foreach($form as $action => $f) {
					$id = 'modal-'.$action.'-'.$modal['object_id'].'-form';
					$modal['body'] .= $this->writeForm($id,$action,$f['input']);
				}
			//END
			
			//START: set output
				$output ='';
				$output .= $this->writeModal($modal['id'],$modal['title'],$modal['body'],$modal['next'],$modal['function']);
				$output .= $this->writeScript($modal['id'],$modal['action'],$modal['function'],$modal['ajax']);
				$output .= $this->writeScriptForGet($get['id'],$get['action'],$get['function'],$get['ajax'],$form['edit']['input']);
			//END
			
			return $output;
		}
		
		public function delete($object,$ajax,$form) {
			//START: set modal
				$modal['action'] = 'delete';
				$modal['next'] = 'Delete';
				$modal['object'] = $object;
				$modal['object_id'] = str_replace("_","-",$object);
				$modal['object_name'] = ucwords(str_replace("_"," ",$object));
				$modal['id'] = 'modal-'.$modal['action'].'-'.$modal['object_id'];
				$modal['title'] = ucwords($modal['action'].' '.$modal['object_name']);
				$modal['function'] = $modal['action'].str_replace(" ","",$modal['object_name']).'()';
				$modal['ajax'] = $ajax;
			//END
			
			//START: set body
				$modal['body'] = ''; 
				$modal['body'] .= '<div class="alert alert-danger" role="alert">';
				$modal['body'] .= 'Are you sure you want to delete <b>'.$modal['object_name'].' #<span id="'.$modal['id'].'-form-text-'.$modal['object_id'].'-id"></span></b> ?';
				$modal['body'] .= '</div>';
			//END
			
			//START: set form
				foreach($form as $action => $f) {
					$id = 'modal-'.$action.'-'.$modal['object_id'].'-form';
					$modal['body'] .= $this->writeForm($id,$action,$f['input']);
				}
			//END
			
			//START: set output
				$output ='';
				$output .= $this->writeModal($modal['id'],$modal['title'],$modal['body'],$modal['next'],$modal['function']);
				$output .= $this->writeScript($modal['id'],$modal['action'],$modal['function'],$modal['ajax']);
			//END
			
			return $output;
		}
		
		public function writeModal($id,$title,$body,$next,$function) {
			$content = '';
			
			//START: [modal]
				$content .= '
					<div class="modal fade" id="'.$id.'" role="dialog">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<h4 class="modal-title">'.$title.'</h4>
								</div>
							
								<div class="modal-body">
									<div id="'.$id.'-form-alert"></div>
									'.$body.'
								</div>
						
								<div class="modal-footer">
									<button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
									<button type="button" class="btn btn-danger" onclick="'.$function.';">'.$next.'</button>
								</div>
							</div>
						</div>
					</div>
				';
			//END
			
			return $content;
		}
		
		public function writeForm($id,$action='',$input, $setting=array()) {
			$content = '';
			
			//START: [tab]
				$tab = 0;
				foreach($input as $i) {
					if(isset($i['tab'])) {
						if($tab == 0) { 
							$content .= '<ul class="nav nav-pills" role="tablist">';
							$tab = 1;
						}
						$content .= '<li role="presentation"';
						if($i['tab']['active'] == true) { $content .= ' class="active"'; }
						$content .= '>';
						$content .= '<a href="#'.$i['tab']['id'].'"';
						$content .= ' aria-controls="'.$i['tab']['id'].'"';
						$content .= ' role="tab" data-toggle="pill">';
						$content .= $i['tab']['name'];
						$content .= '</a>';
						$content .= '</li>';
					}
				}
				if($tab == 1) { $content .= '</ul>'; }
			//END
			
			//START: [form]
				$content .= '<form id="'.$id.'" ';
				if($setting['autocomplete'] == true) { $content .= 'autocomplete="true" '; }
				$content .= '>';
					$content .= '<input type="hidden" name="action" value="'.$action.'"/>';
					$content .= '<div class="tab-content">';
						$tab = 0;
						foreach($input as $i) {
							if(isset($i['tab'])) {
								if($tab == 1) {
									$content .= '</div>';
									$tab = 0;
								}
								if($tab == 0) {
									$content .= '<div role="tabpanel" class="tab-pane';
									if($i['tab']['active'] == true) { $content .= ' active'; }
									$content .= '"'; 
									$content .= 'id="'.$i['tab']['id'].'"';
									$content .= '>';
									$tab = 1;
								}
							}
							else if(isset($i['section'])) {
								$content .= '<section>';
								$content .= $i['section'];
								$content .= '</section>';
							}
							else {
								$content .= '<div class="form-group row">';
								if($i['label'] != '') {
									$content .= '<label class="control-label col-sm-4 col-xs-10">';
									$content .= $i['label'];
									$content .= '</label>';
									$content .= '<div class="control-label col-sm-1 col-xs-2 text-center">';
									if($i['required'] == true) {
										$content .= '<i class="fa fa-asterisk fa-fw text-warning" data-toggle="tooltip" data-placement="bottom" title="Required"></i>';
									}
									$content .= '</div>';
								}
								$content .= '<div class="input-group col-sm-7 col-xs-12">';
								if($i['type'] == 'textarea') {
									$content .= '<textarea ';
									$content .= 'class="form-control" ';
									if(isset($i['row'])) { $r = $i['row']; } else { $r = 5; }
									$content .= 'rows="'.$r.'" ';
									$content .= 'id="'.$id.'-input-'.$i['id'].'" ';
									$content .= 'name="'.$i['name'].'" ';
									$content .= 'placeholder="'.$i['placeholder'].'" ';
									$content .= '>';
									$content .= $i['value'];
									$content .= '</textarea>';
								}
								else if($i['type'] == 'select') {
									$content .= '<select ';
									$content .= 'class="form-control" ';
									$content .= 'id="'.$id.'-input-'.$i['id'].'" ';
									$content .= 'name="'.$i['name'].'" ';
									$content .= '>';
									$content .= '<option value="">';
									$content .= '-- Select '.$i['label'].' --';
									$content .= '</option>';
									foreach($i['option'] as $o) {
										$content .= '<option ';
										$content .= 'value="'.$o[$i['name']].'"';
										if($i['value'] == $o[$i['name']]) { $content .= 'selected=seletected '; }
										$content .= '>';
										if(isset($o['name'])) { $content .= $o['name']; } else { $content .= $o[$i['name']]; }
										$content .= '</option>';
									}
									$content .= '</select>';
								}
								else {
									//START: [input]
										$disabled = ''; //reset for new input
										if($i['type'] == 'disabled') { $disabled = 'disabled'; } 
										$content .= '
											<input 
												type="'.$i['type'].'" 
												class="form-control"
												id="'.$id.'-input-'.$i['id'].'" 
												name="'.$i['name'].'"
												value="'.$i['value'].'"
												placeholder="'.$i['placeholder'].'"
												'.$disabled.'
											/>
										';
									//END
									//START: [help]
										if(isset($i['help'])) {
											$content .= '
												<span class="input-group-btn">
													<a 
														class="btn btn-default" 
														target="_blank" href="'.$i['link'].'" 
														data-toggle="tooltip" 
														data-replacement="top" 
														title="'.$i['help'].'"
													>
														<i class="fa fa-fw fa-question-circle">
														</i>
													</a>
												</span>
											';
									}
									//END
									//START: [text]
										$content .= '<span id="'.$id.'-text-'.$i['id'].'">';
										if($i['type'] == 'hidden') {
											if (strpos($i['text'], 'http') !== false) {
												$content .= '<a href="'.$i['text'].'" target="_blank">Link</a>';
											}
											else {
												$content .= $i['text'];
											}
										}
										$content .= '</span>';
									//END
								}
								$content .= '</div>';
								$content .= '</div>';
							}
						}
						if($tab == 1) { $content .= '</div>'; }
					$content .= '</div>';
				$content .= '</form>';
			//END
			
			return $content;
		}
		
		private function writeScript($id,$action,$function,$ajax) {
			$content = '';
			
			$content .= '<script>';
				$content .= 'function '.$function.' {';
					$content .= 'var form_element = document.querySelector("#'.$id.'-form");';
					$content .= 'var form_data = new FormData(form_element);';
					$content .= 'var xmlhttp = new XMLHttpRequest();';
					$content .= 'var url = "'.$ajax.'";';
					$content .= 'var data = "";';
					$content .= 'var query = url + data;';
					$content .= 'xmlhttp.onreadystatechange = function() {';
						$content .= 'document.getElementById("'.$id.'-form-alert").innerHTML = "";';
						//START: [if connection success]
							$content .= 'if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {';
								$content .='var json = JSON.parse(xmlhttp.responseText);';
								//START: [if warning]
									$content .='
										if(typeof json.warning != "undefined") {
											var content;
											content = "<div class=\'alert alert-danger\'>Error:<br/><ul>";
											for(i=0;i<json.warning.length;i++) {
												content += "<li>"+json.warning[i]+"</li>";
											}
											content += "</ul></div>";
											document.getElementById("'.$id.'-form-alert").innerHTML = content;
										}
									';
								//END
								//START: [if success]
									$content .='
										if(typeof json.success != "undefined") {
											window.location.reload(true);
										}
									';
								//END
							$content .='}';
						//END
						
						//START: [if connection failed]
							$content .='
								else {}
							';
						//END
					$content .='};';
					$content .='xmlhttp.open("POST", query, true);';
					$content .='xmlhttp.send(form_data);';
				$content .= '}';
				
				//START: fix browser warning of "Synchronous XMLHttpRequest on the main thread is deprecated..."
				//[Note:  this fix may lead to unexpected behavior since the script is loaded after the HTML]
					$content .= '
						$.ajaxPrefilter(function( options, originalOptions, jqXHR ) {
							options.async = true;
						});
					';
				//END
			$content .= '</script>';
			
			return $content;
		}
		
		private function writeScriptForGet($id,$action,$function,$ajax,$input='') {
			$content = '';
			
			$content .= '<script>';
				$content .= 'function '.$function.' {';
					$content .= 'var form_element = document.querySelector("#'.$id.'-form");';
					$content .= 'var form_data = new FormData(form_element);';
					$content .= 'var xmlhttp = new XMLHttpRequest();';
					$content .= 'var url = "'.$ajax.'";';
					$content .= 'var data = "";';
					$content .= 'var query = url + data;';
					$content .= 'xmlhttp.onreadystatechange = function() {';
						$content .= 'document.getElementById("'.str_replace('get','edit',$id).'-form-alert").innerHTML = "";';
						//START: [if connection success]
							$content .= 'if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {';
								$content .= 'var json = JSON.parse(xmlhttp.responseText);';
								foreach($input as $i) {
									if(!isset($i['section'])) {
										$content .= 'document.getElementById("'.str_replace('get','edit',$id).'-form-input-'.$i['id'].'").value = json.'.$i['name'].';';
										if(isset($i['json'])) {
											$content .= 'document.getElementById("'.str_replace('get','edit',$id).'-form-text-'.$i['id'].'").innerHTML = json.'.$i['json'].';';
										}
									}
								}
							$content .='}';
						//END
						
						//START: [if connection failed]
							$content .='
								else {}
							';
						//END
					$content .='};';
					$content .='xmlhttp.open("POST", query, true);';
					$content .='xmlhttp.send(form_data);';
				$content .= '}';
				
				//START: fix browser warning of "Synchronous XMLHttpRequest on the main thread is deprecated..."
				//[Note:  this fix may lead to unexpected behavior since the script is loaded after the HTML]
					$content .= '
						$.ajaxPrefilter(function( options, originalOptions, jqXHR ) {
							options.async = true;
						});
					';
				//END
			$content .= '</script>';
			
			return $content;
		}
	}
?>