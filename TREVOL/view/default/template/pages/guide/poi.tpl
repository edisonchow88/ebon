<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"></div>
    	<div class="col-xs-8 text-center"><h5>Point of Interest (Poi)</h5></div>
        <div class="col-xs-2 text-right"><a data-toggle="modal" data-target="#modal-add-poi" class="btn btn-danger" role="button">Add Poi</a></div>
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
	<?php echo $modal_add_poi; ?>
    <?php echo $modal_edit_poi; ?>
	<?php echo $modal_delete_poi; ?>
    <?php echo $modal_toggle_poi_status; ?>
    <?php echo $modal_view_poi_summary; ?>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		rowCount: 10,
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
				str = "<span id='poi-status-"+row.id+"' class='btn command-toggle-poi-status' data-row-id='"+row.id+"'>";
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
			"image": function(column, row)
			{
				var image = JSON.parse(row.image);
				if(image !== '' && image !== 'undefined' && image !== null) {
					return "<img src=\"" + image.path + "\" title=\"" + image.name + "\" width=\"" + image.width + "\" height=\"" + image.width + "\" />";
				}
			},
			"destination": function(column, row)
			{
				var destination = JSON.parse(row.destination);
				return "<a class=\"label label-pill search-destination\" data-row-name=\"" + destination.name + "\" style=\"background-color:"+destination.type_color+";margin-right:5px;\">" + destination.name + "</a>";
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
							+ "<a class='btn btn-sm nopadding btn-default command-view-poi-summary' data-toggle='modal' data-target='#modal-view-poi-summary' data-row-id='"+row.id+"'>"
								+ "<span>View All"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Alias'>"
							+ "<a class='btn btn-sm nopadding btn-info command-view-poi-alias'data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-at'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Description'>"
							+ "<a class='btn btn-sm nopadding btn-info command-view-poi-description' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-ellipsis-h'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Recognition'>"
							+ "<a class='btn btn-sm nopadding btn-info command-view-poi-recognition' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-trophy'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Image'>"
							+ "<a class='btn btn-sm nopadding btn-success command-view-poi-image' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-picture-o'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Tag'>"
							+ "<a class='btn btn-sm nopadding btn-success command-view-poi-tag' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-tag'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Destination'>"
							+ "<a class='btn btn-sm nopadding btn-warning command-view-poi-destination' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-map-marker'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Interest'>"
							+ "<a class='btn btn-sm nopadding btn-warning command-view-poi-interest' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-gratipay'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Relation'>"
							+ "<a class='btn btn-sm nopadding btn-warning command-view-poi-relation' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-sitemap'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Hour'>"
							+ "<a class='btn btn-sm nopadding btn-danger command-view-poi-hour' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-clock-o'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Fee'>"
							+ "<a class='btn btn-sm nopadding btn-danger command-view-poi-fee' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-dollar'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Contact'>"
							+ "<a class='btn btn-sm nopadding btn-danger command-view-poi-contact' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-phone'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Review'>"
							+ "<a class='btn btn-sm nopadding btn-danger command-view-poi-review' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-commenting'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Google'>"
							+ "<a class='btn btn-sm nopadding btn-primary command-view-poi-google' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-google'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Wikipedia'>"
							+ "<a class='btn btn-sm nopadding btn-primary command-view-poi-wikipedia' data-row-id='"+row.id+"'>"
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
							+ "<a class='btn btn-sm command-edit' data-toggle='modal' data-target='#modal-edit-poi' data-row-id='"+row.id+"'>"
								+ "<span class='fa fa-fw fa-pencil'>"
								+ "</span>"
							+ "</a>"
							+ "</span>"
						+ "</li>"
						+ "<li>"
							+ "<span class='nopadding' data-toggle='tooltip' data-placement='top' title='Delete'>"
							+ "<a class='btn btn-sm command-delete' data-toggle='modal' data-target='#modal-delete-poi' data-row-id='"+row.id+"'>"
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
			document.getElementById("modal-get-poi-form-input-poi-id").value = $(this).data("row-id");
			getPoi(); <!-- the code is written in modal tpl -->
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("modal-delete-poi-form-input-poi-id").value = $(this).data("row-id");
			document.getElementById("modal-delete-poi-form-text-poi-id").innerHTML = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-toggle-poi-status").on("click", function(e)
		{
			document.getElementById("modal-toggle-poi-status-form-input-poi-id").value = $(this).data("row-id");
			togglePoiStatus(); <!-- the code is written in modal tpl -->
		})
		.end().find(".command-view-poi-summary").on("click", function(e)
		{
			document.getElementById("modal-get-poi-summary-form-input-poi-id").value = $(this).data("row-id");
			getPoiSummary(); <!-- the code is written in modal tpl -->
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-view-poi-alias").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/alias']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-description").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/description']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-recognition").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/recognition']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-image").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/image']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-tag").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/tag']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-destination").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/destination']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-interest").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/interest']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-relation").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/relation']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-hour").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/hour']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-fee").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/fee']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-contact").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/contact']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-review").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/review']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-google").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/google']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".command-view-poi-wikipedia").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/poi_subset/wikipedia']; ?>\&poi_id=" + $(this).data("row-id");
		})
		.end().find(".search-tag").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-name"));
		})
		.end().find(".search-destination").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-name"));
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
</script>