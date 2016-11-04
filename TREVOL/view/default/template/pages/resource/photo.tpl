<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"></div>
    	<div class="col-xs-8 text-center"><h5>Photo</h5></div>
        <div class="col-xs-2 text-right"><a data-toggle="modal" data-target="#modal-upload-photo" class="btn btn-danger" role="button">Upload Photo</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<table id="grid" class="table table-condensed table-hover table-striped">
            <thead>
                <tr>
                	<!-- START: Column -->
                    <?php
                    	foreach($column as $c) {
                        	echo "<th ";
                            echo "data-column-id='".$c['name']."' ";
                            echo "data-formatter='".$c['name']."' ";
                            if(isset($c['type']) && $c['type'] != '') { echo "data-type='".$c['type']."' "; }
                            if(isset($c['width']) && $c['width'] != '') { echo "data-width='".$c['width']."' "; }
                            if(isset($c['order']) && $c['order'] != '') { echo "data-order='".$c['order']."' "; }
                            if(isset($c['align']) && $c['align'] != '') { echo "data-align='".$c['align']."' "; }
                            if(isset($c['headerAlign']) && $c['headerAlign'] != '') { echo "data-headerAlign='".$c['headerAlign']."' "; }
                            if(isset($c['visible']) && $c['visible'] != '') { echo "data-visible='".$c['visible']."' "; }
                            if(isset($c['sortable']) && $c['sortable'] != '') { echo "data-sortable='".$c['sortable']."' "; }
                            if(isset($c['searchable']) && $c['searchable'] != '') { echo "data-searchable='".$c['searchable']."' "; }
                            echo ">";
                            echo $c['title'];
                            echo "</th>";
                        }
                    ?>
                    <!-- END -->
                </tr>
            </thead>
            <tbody>
            	<?php
                	foreach($result as $row) {
                    	echo "<tr>";
                        	foreach($row as $column) {
                                echo "<td>" . $column . "</td>";
                            }
                        echo "</tr>";
                    }
            	?>
            </tbody>
        </table>
	</div>
</div>

<!-- START: Modal -->
	<?php echo $modal_upload_photo; ?>
    <?php echo $modal_edit_photo; ?>
	<?php echo $modal_delete_photo; ?>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		rowCount: -1,
		columnSelection: false,
		formatters: {
			"blurb": function(column, row)
			{
				if(row.blurb != '') {
					return "<i class='fa fa-fw fa-ellipsis-h' data-toggle='tooltip' data-placement='right' title='" + row.blurb + "'></i>";
				}
			},
			"description": function(column, row)
			{
				if(row.description != '') {
					return "<i class='fa fa-fw fa-ellipsis-h' data-toggle='tooltip' data-placement='right' title='" + row.description + "'></i>";
				}
			},
			"lat": function(column, row)
			{
				if(row.lat != '') {
					return "<span data-toggle='tooltip' data-placement='right' title='" + row.lat + "'>"+row.lat.substring(0, row.lat.length - 7)+"</span>";
				}
			},
			"lng": function(column, row)
			{
				if(row.lng != '') {
					return "<span data-toggle='tooltip' data-placement='right' title='" + row.lng + "'>"+row.lng.substring(0, row.lng.length - 7)+"</span>";
				}
			},
			"row_status": function(column, row)
			{
				str = "<span id='photo-status-"+row.id+"' class='btn command-toggle-photo-status' data-row-id='"+row.id+"'>";
				if(row.row_status == 1) {
					str += "<i class='fa fa-fw fa-toggle-on'></i> <span class='small'>ON</span>";
				}
				else if(row.row_status == 0) {
					str += "<i class='fa fa-fw fa-toggle-off'></i> <span class='small'>OFF</span>";
				}
				str += "</span>";
				return str;
				
			},
			"date_added": function(column, row)
			{
				if(row.date_added != '') {
					return "<i class='fa fa-fw fa-calendar-o' data-toggle='tooltip' data-placement='right' title='" + row.date_added + "'></i>";
				}
			},
			"date_modified": function(column, row)
			{
				if(row.date_modified != '') {
					return "<i class='fa fa-fw fa-calendar-o' data-toggle='tooltip' data-placement='right' title='" + row.date_modified + "'></i>";
				}
			},
			"color": function(column, row)
			{
				return "<i class='fa fa-fw fa-circle' style='color:" + row.color + ";' data-toggle='tooltip' data-placement='right' title='" + row.color + "'></i>";
			},
			"icon": function(column, row)
			{
				return "<i class='fa fa-fw " + row.icon + "' data-toggle='tooltip' title='" + row.icon + "'></i>";
			},
			"tag": function(column, row)
			{
				var tag = JSON.parse(row.tag);
				if(tag !== '' && tag !== 'undefined' && tag !== null) {
					return "<a class=\"label label-pill search-tag\" data-row-name=\"" + tag.name + "\" style=\"background-color:"+tag.type_color+";\">" + tag.name + "</a>";
				}
			},
			"parent": function(column, row)
			{
				var parent = JSON.parse(row.parent);
				if(parent !== '' && parent !== 'undefined' && parent !== null) {
					return "<a class=\"label label-pill search-parent\" data-row-name=\"" + parent.name + "\" style=\"background-color:"+parent.type_color+";\">" + parent.name + "</a>";
				}
			},
			"image": function(column, row)
			{
				var image = JSON.parse(row.image);
				if(image !== '' && image !== 'undefined' && image !== null) {
					return "<img src=\"" + image.path + "\" title=\"" + image.name + "\" width=\"" + image.width + "\" height=\"" + image.width + "\" />";
				}
			},
			"photo": function(column, row)
			{
				var photo = JSON.parse(row.photo);
				if(photo !== '' && photo !== 'undefined' && photo !== null) {
					return "<img src=\"" + photo.path + "\" title=\"" + photo.name + "\" width=\"" + photo.width + "\" height=\"" + photo.width + "\" />";
				}
			},
			"duration": function(column, row)
			{
				var hours = Math.floor(row.duration/ 60);          
				var minutes = row.duration % 60;
				var string = '';
				if(hours > 0) { string += hours + 'h '; }
				if(minutes > 0) { string += minutes + 'm'; }
				return string;
			},
			"time": function(column, row)
			{
				return row.time.substring(0, row.time.length - 3);
			},
			"line": function(column, row)
			{
				var line = JSON.parse(row.line);
				return line.line_id;
			},
			"day": function(column, row)
			{
				var day = JSON.parse(row.day);
				return day.date;
			},
			"commands": function(column, row)
			{
				return "<button type=\"button\" class=\"btn btn-default command-delete\" data-toggle=\"modal\" data-target=\"#modal-delete-photo\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-trash-o\"></span></button>";
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		$('[data-toggle="tooltip"]').tooltip();
		grid.find(".command-delete").on("click", function(e)
		{
			document.getElementById("modal-delete-photo-form-input-photo-id").value = $(this).data("row-id");
			document.getElementById("modal-delete-photo-form-text-photo-id").innerHTML = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
</script>