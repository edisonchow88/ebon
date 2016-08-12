<?php
	class componentDatabaseTable extends component{
		public function writeTable($object,$table,$action,$related,$grid) {
			$object_id= str_replace("_","-",$object);
			$object_name = ucwords(str_replace("_"," ",$object));
			
			//START: [header left]
				$n = count($related);
				if($n == 0) {
					$header_left = '';
				}
				else if($n == 1) {
					$header_left = '
						<a href="'.$related[0]['url'].'" class="btn btn-default" role="button">
							<i class="fa fa-fw fa-desktop"></i>&nbsp;&nbsp;'.ucwords($related[0]['title']).'
						</a>
					';
				}
				else {
					$header_left = '';
				}
			//END
			
			//START: [header center]
				$header_center = '<h5>'.$object_name.'</h5>';
			//END
			
			//START: [header right]
				if($action['add'] == true) {
					$header_right = '<a class="btn btn-danger" data-toggle="modal" data-target="#modal-add-'.$object_id.'">Add '.$object_name.'</a>';
				}
			//END
			
			//START: [table head]
				$table_head = '';
				$table_head .= '<tr>';
				foreach($table['column'] as $c) {
					$table_head .= "<th ";
					$table_head .= "data-column-id='".$c['name']."' ";
					$table_head .= "data-formatter='".$c['name']."' ";
					if(isset($c['type']) && $c['type'] != '') { $table_head .= "data-type='".$c['type']."' "; }
					if(isset($c['width']) && $c['width'] != '') { $table_head .= "data-width='".$c['width']."' "; }
					if(isset($c['order']) && $c['order'] != '') { $table_head .= "data-order='".$c['order']."' "; }
					if(isset($c['align']) && $c['align'] != '') { $table_head .= "data-align='".$c['align']."' "; }
					if(isset($c['headerAlign']) && $c['headerAlign'] != '') { $table_head .= "data-headerAlign='".$c['headerAlign']."' "; }
					if(isset($c['visible']) && $c['visible'] != '') { $table_head .= "data-visible='".$c['visible']."' "; }
					if(isset($c['sortable']) && $c['sortable'] != '') { $table_head .= "data-sortable='".$c['sortable']."' "; }
					if(isset($c['searchable']) && $c['searchable'] != '') { $table_head .= "data-searchable='".$c['searchable']."' "; }
					$table_head .= ">";
					$table_head .= $c['title'];
					$table_head .= "</th>";

				}
				$table_head .= '</tr>';
			//END
			
			//START: [table body]
				$table_body = '';
				if(isset($table['row'])) {
					foreach($table['row'] as $row) {
						$table_body .= '<tr>';
						foreach($row as $column) {
							$table_body .= '<td>'.$column.'</td>';
						}
						$table_body .= '</tr>';
					}
				}
			//END
			
			//START: write content
				$content = '';
				$content .= '
					<div id="content" class="panel panel-default">
						<div class="panel-heading col-xs-12">
							<div class="col-xs-3 text-left">
								'.$header_left.'
							</div>
							<div class="col-xs-6 text-center">
								'.$header_center.'
							</div>
							<div class="col-xs-3 text-right">
								'.$header_right.'
							</div>
						</div>
						
						<div class="panel-body panel-body-nopadding tab-content col-xs-12">
							<table id="grid" class="table table-condensed table-hover table-striped">
								<thead>
									'.$table_head.'
								</thead>
								<tbody>
									'.$table_body.'
								</tbody>
							</table>
						</div>
					</div>			
				';
				$content .= $this->writeScriptForTable($object,$grid['setting'],$grid['formatter'],$grid['function']);
				$content .= $this->writeScriptForClearSearch();
				return $content;
			//END
		}
		
		private function writeScriptForTable($object,$setting,$formatter,$function) {
			$object_id= str_replace("_","-",$object);
			$object_name = ucwords(str_replace("_"," ",$object));
			$object_name_no_space = str_replace(" ","",$object_name);
			
			//START: [setting]
				$grid_setting = '';
				foreach($setting as $k => $v) {
					$grid_setting .= $k.':'.$v.',';
				}
			//END
			
			//START: [default formatter]
				$format['color'] = '
					return "<i class=\'fa fa-fw fa-circle\' style=\'color:" + row.color + ";\' data-toggle=\'tooltip\' data-placement=\'bottom\' title=\'" + row.color + "\'></i>";
				';
				$format['icon'] = '
					return "<i class=\'fa fa-fw " + row.icon + "\' data-toggle=\'tooltip\' title=\'" + row.icon + "\'></i>";
				';
				$format['tag'] = '
					var tag = JSON.parse(row.tag);
					if(tag !== \'\' && tag !== \'undefined\' && tag !== null) {
						return "<a class=\"label label-pill\" style=\"background-color:"+tag.type_color+";\">" + tag.name + "</a>";
					}
				';
				$format['image'] = '
					var image = JSON.parse(row.image);
					if(image !== \'\' && image !== \'undefined\' && image !== null) {
						return "<img src=\"" + image.path + "\" title=\"" + image.name + "\" width=\"" + image.width + "\" />";
					}
				';
				$format['duration'] = '
					var hours = Math.floor(row.duration/ 60);          
					var minutes = row.duration % 60;
					var string = \'\';
					if(hours > 0) { string += hours + \'h \'; }
					if(minutes > 0) { string += minutes + \'m\'; }
					return string;
				';
				$format['time'] = '
					return row.time.substring(0, row.time.length - 3);
				';
				$format['last_login'] = '
					return "<span data-toggle=\'tooltip\' data-placement=\'bottom\' title=\'" + row.last_login + "\'>" + row.last_login.substring(0, 10) + "</span>";
				';
				$format['date_added'] = '
					return "<span data-toggle=\'tooltip\' data-placement=\'bottom\' title=\'" + row.date_added + "\'>" + row.date_added.substring(0, 10) + "</span>";
				';
				$format['date_modified'] = '
					return "<span data-toggle=\'tooltip\' data-placement=\'bottom\' title=\'" + row.date_modified + "\'>" + row.date_modified.substring(0, 10) + "</span>";
				';
				$format['commands'] = '
					return "<button type=\"button\" class=\"btn btn-default command-edit\" data-toggle=\"modal\" data-target=\"#modal-edit-'.$object_id.'\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-pencil\"></span></button> " + 
					"<button type=\"button\" class=\"btn btn-default command-delete\" data-toggle=\"modal\" data-target=\"#modal-delete-'.$object_id.'\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-trash-o\"></span></button>";
				';
			//END
			
			//START: [new or overwrite formatter]
				foreach($formatter as $k => $v) {
					$format[$k] = $v;
				}
			//END
			
			//START: set formatter
				$n = count($format);
				$i = 0;
				$grid_formatter = '';
				foreach($format as $k => $v) {
					$i += 1;
					$grid_formatter .= '"'.$k.'": function(column, row) { ';
					$grid_formatter .= $v;
					$grid_formatter .= '}';
					if($i < $n) { $grid_formatter .= ','; }
				}
			//END
			
			$content .= '
				<script>
					var grid = $("#grid").bootgrid({
						'.$grid_setting.'
						formatters: {
							'.$grid_formatter.'
						}
					}).on("loaded.rs.jquery.bootgrid", function()
					{
						$(\'[data-toggle="tooltip"]\').tooltip();
						grid.find(".command-edit").on("click", function(e)
						{
							document.getElementById("modal-get-'.$object_id.'-form-input-'.$object_id.'-id").value = $(this).data("row-id");
							get'.$object_name_no_space.'();
							$($(this).attr("data-target")).modal("show");
						})
						.end().find(".command-delete").on("click", function(e)
						{
							document.getElementById("modal-delete-'.$object_id.'-form-input-'.$object_id.'-id").value = $(this).data("row-id");
							document.getElementById("modal-delete-'.$object_id.'-form-text-'.$object_id.'-id").innerHTML = $(this).data("row-id");
							$($(this).attr("data-target")).modal("show");
						})
						'.$grid_function.'
						;
					});
				</script>
			';
			return $content;
		}
		
		/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute following function */
		private function writeScriptForClearSearch() {
			$content = '';
			$content .= '<script>';
			$content .= '
				function clearSearch() {
					$("#grid").bootgrid("search");
				}
			';
			$content .= '</script>';
			return $content;
		}	}
?>