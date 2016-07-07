<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"></div>
    	<div class="col-xs-8 text-center"><h5>Transport</h5></div>
        <div class="col-xs-2 text-right"><a data-toggle="modal" data-target="#modal-add-transport" class="btn btn-danger" role="button">Add Transport</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<table id="grid" class="table table-condensed table-hover table-stransported">
            <thead>
                <tr>
                    <th data-column-id="id" data-type="numeric">ID</th>
                    <th data-column-id="icon" data-formatter="icon">Icon</th>
                    <th data-column-id="name" data-formatter="name" data-order="asc">Name</th>
                    <th data-column-id="commands" data-formatter="commands" data-sortable="false">Commands</th>
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
	<?php echo $modal_add_transport; ?>
    <?php echo $modal_edit_transport; ?>
	<?php echo $modal_delete_transport; ?>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		rowCount: -1,
		columnSelection: false,
		formatters: {
			"icon": function(column, row)
			{
				return "<i class='fa fa-fw " + row.icon + "' data-toggle='tooltip' title='" + row.icon + "'></i>";
			},
			"commands": function(column, row)
			{
				return "<button type=\"button\" class=\"btn btn-default command-edit\" data-toggle=\"modal\" data-target=\"#modal-edit-transport\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-pencil\"></span></button> " + 
					"<button type=\"button\" class=\"btn btn-default command-delete\" data-toggle=\"modal\" data-target=\"#modal-delete-transport\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-trash-o\"></span></button>";
				
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		$('[data-toggle="tooltip"]').tooltip();
		grid.find(".command-edit").on("click", function(e)
		{
			document.getElementById("modal-form-get-transport-input-transport-id").value = $(this).data("row-id");
			getTransport(); <!-- the code is written in modal tpl -->
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("modal-form-delete-transport-input-transport-id").value = $(this).data("row-id");
			document.getElementById("modal-form-delete-transport-text-transport-id").innerHTML = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
</script>