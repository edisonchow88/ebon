<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['tag/tag_list'];?>" class="btn btn-default" role="button"><i class="fa fa-fw fa-desktop"></i> View Tag</a></div>
    	<div class="col-xs-8 text-center"><h5>Tag Type</h5></div>
        <div class="col-xs-2 text-right"><a href="<?php echo $link['tag/type_form'];?>" class="btn btn-danger" role="button">Add Tag Type</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<table id="grid" class="table table-condensed table-hover table-striped">
            <thead>
                <tr>
                    <th data-column-id="id" data-type="numeric" data-order="asc">ID</th>
                    <th data-column-id="name">Name</th>
                    <th data-column-id="color" data-formatter="color">Color</th>
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
<div class="modal fade" id="modal-delete" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Delete Tag Type</h4>
            </div>
        <div class="modal-body">
            <div class="alert alert-danger" role="alert">
                Are you sure you want to delete <b>Tag Type #<span id="tag-type-id-delete-text"></span></b> ?
            </div>
            <form id="request-delete" action="<?php echo $link['submit'];?>" method="post">
                <input 
                    type="hidden" 
                    id="tag-type-id-delete-input" 
                    name="tag_type_id" 
                />
                <input 
                    type="hidden" 
                    name="action"
                    value="delete" 
                />
            </form>
        </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" onclick="deleteTagType();">Delete</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		formatters: {
			"color": function(column, row)
			{
				return "<i class=\"fa fa-fw fa-square\" style=\"color:"+row.color+";\"></i>";
			},
			"commands": function(column, row)
			{
				return "<button type=\"button\" class=\"btn btn-default command-edit\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-pencil\"></span></button> " + 
					"<button type=\"button\" class=\"btn btn-default command-delete\" data-toggle=\"modal\" data-target=\"#modal-delete\" data-row-id=\"" + row.id + "\"><span class=\"fa fa-trash-o\"></span></button>";
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		grid.find(".command-edit").on("click", function(e)
		{
			window.location.href = "<?php echo $link['tag/type_form']; ?>\&tag_type_id=" + $(this).data("row-id");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("tag-type-id-delete-text").innerHTML = $(this).data("row-id");
			document.getElementById("tag-type-id-delete-input").value = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
	function deleteTagType() {
		document.getElementById("request-delete").submit();
	}
</script>