<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['account/user_group']; ?>" class="btn btn-default" role="button"><i class="fa fa-fw fa-desktop"></i> User Group</a></div>
    	<div class="col-xs-8 text-center"><h5>User</h5></div>
        <div class="col-xs-2 text-right"><a data-toggle="modal" data-target="#modal-add-user" class="btn btn-danger" role="button">Add User</a></div>
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
                	if(isset($result)) {
                        foreach($result as $row) {
                            echo "<tr>";
                                foreach($row as $column) {
                                    echo "<td>" . $column . "</td>";
                                }
                            echo "</tr>";
                        }
                    }
            	?>
            </tbody>
        </table>
	</div>
</div>

<!-- START: Modal -->
	<?php echo $modal_add_user; ?>
    <?php echo $modal_edit_user; ?>
	<?php echo $modal_delete_user; ?>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		rowCount: -1,
		columnSelection: false,
		multiSort: true,
		formatters: {
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
					return "<a class=\"label label-pill\" style=\"background-color:"+tag.type_color+";\">" + tag.name + "</a>";
				}
			},
			"image": function(column, row)
			{
				var image = JSON.parse(row.image);
				if(image !== '' && image !== 'undefined' && image !== null) {
					return "<img src=\"" + image.path + "\" title=\"" + image.name + "\" width=\"" + image.width + "\" />";
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
			"last_login": function(column, row)
			{
				return "<span data-toggle='tooltip' data-placement='bottom' title='" + row.last_login + "'>" + row.last_login.substring(0, 10) + "</span>";
			},
			"date_added": function(column, row)
			{
				return "<span data-toggle='tooltip' data-placement='bottom' title='" + row.date_added + "'>" + row.date_added.substring(0, 10) + "</span>";
			},
			"date_modified": function(column, row)
			{
				return "<span data-toggle='tooltip' data-placement='bottom' title='" + row.date_modified + "'>" + row.date_modified.substring(0, 10) + "</span>";
			},
			"commands": function(column, row)
			{
				return "<button type=\"button\" class=\"btn btn-default command-edit\" data-toggle=\"modal\" data-target=\"#modal-edit-user\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-pencil\"></span></button> " + 
					"<button type=\"button\" class=\"btn btn-default command-delete\" data-toggle=\"modal\" data-target=\"#modal-delete-user\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-trash-o\"></span></button>";
				
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		$('[data-toggle="tooltip"]').tooltip();
		grid.find(".command-edit").on("click", function(e)
		{
			document.getElementById("modal-get-user-form-input-user-id").value = $(this).data("row-id");
			getUser(); <!-- the code is written in modal tpl -->
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("modal-delete-user-form-input-user-id").value = $(this).data("row-id");
			document.getElementById("modal-delete-user-form-text-user-id").innerHTML = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
</script>