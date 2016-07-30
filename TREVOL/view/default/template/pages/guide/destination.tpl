<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"></div>
    	<div class="col-xs-8 text-center"><h5>Destination</h5></div>
        <div class="col-xs-2 text-right"><a data-toggle="modal" data-target="#modal-add-destination" class="btn btn-danger" role="button">Add Destination</a></div>
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
	<?php echo $modal_add_destination; ?>
    <?php echo $modal_edit_destination; ?>
	<?php echo $modal_delete_destination; ?>
    <?php echo $modal_toggle_destination_status; ?>
    <?php echo $modal_view_destination_summary; ?>
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
				str = "<span id='destination-status-"+row.id+"' class='btn command-toggle-destination-status' data-row-id='"+row.id+"'>";
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
				return ""
				+ "<nav style='display:inline !important;'>"
					+ "<ul class='pagination' style='margin: 0px !important;'>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Summary'>"
							+ "<a class='btn btn-sm btn-default command-view-destination-summary' data-toggle='modal' data-target='#modal-view-destination-summary' data-row-id='"+row.id+"'>"
								+ "<span>View All"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Alias'>"
							+ "<a class='btn btn-sm btn-info command-view-destination-alias'data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-at'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Description'>"
							+ "<a class='btn btn-sm btn-info command-view-destination-description' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-ellipsis-h'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Image'>"
							+ "<a class='btn btn-sm btn-success command-view-destination-image' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-picture-o'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Tag'>"
							+ "<a class='btn btn-sm btn-success command-view-destination-tag' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-tag'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Relation'>"
							+ "<a class='btn btn-sm btn-warning command-view-destination-relation' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-sitemap'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Google'>"
							+ "<a class='btn btn-sm btn-primary command-view-destination-google' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-google'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Wikipedia'>"
							+ "<a class='btn btn-sm btn-primary command-view-destination-wikipedia' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-wikipedia-w'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
					+ "</ul>"
				+ "</nav>"
				+ "<nav style='display:inline !important; margin-left:10px !important;'>"
					+ "<ul class='pagination' style='margin: 0px !important;'>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Edit'>"
							+ "<a class='btn btn-sm command-edit' data-toggle='modal' data-target='#modal-edit-destination' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-pencil'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Delete'>"
							+ "<a class='btn btn-sm command-delete' data-toggle='modal' data-target='#modal-delete-destination' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-trash-o'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
					+ "</ul>"
				+ "</nav>"
				;
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		$('[data-toggle="tooltip"]').tooltip();
		grid.find(".command-edit").on("click", function(e)
		{
			document.getElementById("modal-get-destination-form-input-destination-id").value = $(this).data("row-id");
			getDestination(); <!-- the code is written in modal tpl -->
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("modal-delete-destination-form-input-destination-id").value = $(this).data("row-id");
			document.getElementById("modal-delete-destination-form-text-destination-id").innerHTML = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-toggle-destination-status").on("click", function(e)
		{
			document.getElementById("modal-toggle-destination-status-form-input-destination-id").value = $(this).data("row-id");
			toggleDestinationStatus(); <!-- the code is written in modal tpl -->
		})
		.end().find(".command-view-destination-summary").on("click", function(e)
		{
			document.getElementById("modal-get-destination-summary-form-input-destination-id").value = $(this).data("row-id");
			getDestinationSummary(); <!-- the code is written in modal tpl -->
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-view-destination-alias").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/destination_subset/alias']; ?>\&destination_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-destination-description").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/destination_subset/description']; ?>\&destination_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-destination-image").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/destination_subset/image']; ?>\&destination_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-destination-tag").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/destination_subset/tag']; ?>\&destination_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-destination-relation").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/destination_subset/relation']; ?>\&destination_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-destination-google").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/destination_subset/google']; ?>\&destination_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-destination-wikipedia").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/destination_subset/wikipedia']; ?>\&destination_id=" + $(this).data("row-id");
		})
		.end().find(".search-tag").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-name"));
		})
		.end().find(".search-parent").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-name"));
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
</script>