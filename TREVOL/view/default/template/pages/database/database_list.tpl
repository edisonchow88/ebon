<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"></div>
    	<div class="col-xs-8 text-center"><h5>Database</h5></div>
        <div class="col-xs-2 text-right"><a data-toggle="modal" data-target="#modal-add-database" class="btn btn-danger" role="button">Add Database</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<table id="grid" class="table table-condensed table-hover table-striped">
            <thead>
                <tr>
                    <th data-column-id="id" data-type="numeric">ID</th>
                    <th data-column-id="name" data-formatter="name" data-width="300px" data-order="asc">Name</th>
                    <th data-column-id="folder" data-formatter="folder">Folder</th>
                    <th data-column-id="filename" data-formatter="filename">Filename</th>
                    <th data-column-id="sort_order" data-formatter="sort_order" data-order="asc">Sort</th>
                    <th data-column-id="link" data-formatter="link" data-visible="false">Link</th>
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
	<?php echo $modal_add_database; ?>
    <?php echo $modal_edit_database; ?>
	<?php echo $modal_delete_database; ?>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		rowCount: -1,
		columnSelection: false,
		multiSort: true,
		formatters: {
			"name": function(column, row)
			{
				return row.name;
			},
			"commands": function(column, row)
			{
				if(row.folder != '' || row.filename != '') {
					return "<button type=\"button\" class=\"btn btn-danger command-view\" data-row-link=\"" + row.link + "\"><span class=\"fa fa-fw fa-eye\"></span></button> " + 
					"<button type=\"button\" class=\"btn btn-default command-edit\" data-toggle=\"modal\" data-target=\"#modal-edit-database\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-pencil\"></span></button> " + 
						"<button type=\"button\" class=\"btn btn-default command-delete\" data-toggle=\"modal\" data-target=\"#modal-delete-database\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-trash-o\"></span></button>";
				}
				else {
					return "<button type=\"button\" class=\"btn btn-default command-view disabled\"><span class=\"fa fa-fw fa-ban\"></span></button> " + 
				"<button type=\"button\" class=\"btn btn-default command-edit\" data-toggle=\"modal\" data-target=\"#modal-edit-database\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-pencil\"></span></button> " + 
					"<button type=\"button\" class=\"btn btn-default command-delete\" data-toggle=\"modal\" data-target=\"#modal-delete-database\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-fw fa-trash-o\"></span></button>";
				}
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		grid.find(".command-edit").on("click", function(e)
		{
			document.getElementById("modal-form-get-database-input-database-id").value = $(this).data("row-id");
			getDatabase(); <!-- the code is written in modal tpl -->
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("modal-form-delete-database-input-database-id").value = $(this).data("row-id");
			document.getElementById("modal-form-delete-database-text-database-id").innerHTML = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		})
		.end().find(".command-view").on("click", function(e)
		{
			window.location.href = $(this).data("row-link");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
</script>