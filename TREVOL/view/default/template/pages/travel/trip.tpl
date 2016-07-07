<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"></div>
    	<div class="col-xs-8 text-center"><h5>Trip</h5></div>
        <div class="col-xs-2 text-right"><a data-toggle="modal" data-target="#modal-add-trip" class="btn btn-danger" role="button">Add Trip</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<table id="grid" class="table table-condensed table-hover table-striped">
            <thead>
                <tr>
                    <th data-column-id="id" data-type="numeric">ID</th>
                    <th data-column-id="status" data-formatter="status">Status</th>
                    <th data-column-id="name" data-formatter="name">Name</th>
                    <th data-column-id="description" data-formatter="description">Description</th>
                    <th data-column-id="transport" data-formatter="transport">Transport</th>
                    <th data-column-id="user" data-formatter="user">Admin</th>
                    <th data-column-id="travel_date" data-formatter="travel_date" data-order="desc">Travel Date</th>
                    <th data-column-id="date_added" data-formatter="date_added" data-visible="false">Date Added</th>
                    <th data-column-id="date_modified" data-formatter="date_modified" data-visible="false">Date Modified</th>
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
	<?php echo $modal_add_trip; ?>
    <?php echo $modal_edit_trip; ?>
	<?php echo $modal_delete_trip; ?>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		rowCount: -1,
		columnSelection: false,
		formatters: {
			"description": function(column, row)
			{
				if(row.description != '') {
					return "<i class='fa fa-fw fa-ellipsis-h' data-toggle='tooltip' data-placement='right' title='" + row.description + "'></i>";
				}
			},
			"status": function(column, row)
			{
				var status = JSON.parse(row.status);
				return "<i class='fa fa-fw fa-circle' style='color:" + status.color + ";' data-toggle='tooltip' data-placement='right' title='" + status.name + "'></i>";
			},
			"transport": function(column, row)
			{
				var transport = JSON.parse(row.transport);
				return "<i class='fa fa-fw " + transport.icon + "' data-toggle='tooltip' data-placement='right' title='" + transport.name + "'></i>";
			},
			"commands": function(column, row)
			{
				return "<button type=\"button\" class=\"btn btn-default command-edit\" data-toggle=\"modal\" data-target=\"#modal-edit-trip\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-pencil\"></span></button> " + 
					"<button type=\"button\" class=\"btn btn-default command-delete\" data-toggle=\"modal\" data-target=\"#modal-delete-trip\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-trash-o\"></span></button>";
				
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		$('[data-toggle="tooltip"]').tooltip();
		grid.find(".command-edit").on("click", function(e)
		{
			document.getElementById("modal-form-get-trip-input-trip-id").value = $(this).data("row-id");
			getTrip(); <!-- the code is written in modal tpl -->
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("modal-form-delete-trip-input-trip-id").value = $(this).data("row-id");
			document.getElementById("modal-form-delete-trip-text-trip-id").innerHTML = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
</script>