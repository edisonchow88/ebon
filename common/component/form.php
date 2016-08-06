<?php
	class componentForm extends component{
		public function getForm($id,$action='',$input) {
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
				$content .= '<form id="'.$id.'">';
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
								$content .= '<div class="form-group">';
								if($i['label'] != '') {
									$content .= '<label class="control-label col-sm-4 col-xs-10">';
									$content .= $i['label'];
									$content .= '</label>';
									$content .= '<div class="control-label col-sm-1 col-xs-2 text-right">';
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
									$content .= '<input ';
									$content .= 'type="'.$i['type'].'" ';
									$content .= 'class="form-control" ';
									$content .= 'id="'.$id.'-input-'.$i['id'].'" ';
									$content .= 'name="'.$i['name'].'" ';
									$content .= 'value="'.$i['value'].'" ';
									$content .= 'placeholder="'.$i['placeholder'].'" ';
									$content .= '/>';
									if(isset($i['help'])) {
										$content .= '<span class="input-group-btn">';
										$content .= '<a class="btn btn-default" target="_blank" href="'.$i['link'].'" data-toggle="tooltip" data-replacement="top" title="'.$i['help'].'">';
										$content .= '<i class="fa fa-fw fa-question-circle">';
										$content .= '</i>';
										$content .= '</a>';
										$content .= '</span>';
									}
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
	}
?>