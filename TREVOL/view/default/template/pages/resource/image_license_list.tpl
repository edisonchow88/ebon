<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['resource/image_list']; ?>" class="btn btn-default" role="button"><i class="fa fa-fw fa-desktop"></i> View Image</a></div>
    	<div class="col-xs-8 text-center"><h5>Image License</h5></div>
        <div class="col-xs-2 text-right"><a href="<?php echo $link['resource/image_license_form']; ?>" class="btn btn-danger" role="button">Add Image License</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<table id="grid" class="table table-condensed table-hover table-striped">
            <thead>
                <tr>
                    <th data-column-id="id" data-type="numeric">ID</th>
                    <th data-column-id="name" data-formatter="name">Name</th>
                    <th data-column-id="description">Description</th>
                    <th data-column-id="link" data-formatter="link">Link</th>
                    <th data-column-id="sort-order" data-formatter="order" data-order="asc">Sort Order</th>
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
            <h4 class="modal-title">Delete Image License</h4>
            </div>
        <div class="modal-body">
            <div class="alert alert-danger" role="alert">
                Are you sure you want to delete <b>Image License #<span id="modal-delete-text"></span></b> ?
            </div>
            <form id="form-delete" action="<?php echo $link['resource/image_license_post'];?>" method="post">
                <input 
                    type="hidden" 
                    id="modal-delete-input" 
                    name="image_license_id" 
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
                <button type="button" class="btn btn-danger" onclick="deleteImageLicense();">Delete</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		formatters: {
			"name": function(column, row)
			{
				return row.name;
			},
			"link": function(column, row)
			{
				if(row.link=='') { return; }
				return "<a href=\"" + row.link + "\" target=\"_blank\">Link</a>";
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
			window.location.href = "<?php echo $link['resource/image_license_form']; ?>\&image_license_id=" + $(this).data("row-id");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("modal-delete-text").innerHTML = $(this).data("row-id");
			document.getElementById("modal-delete-input").value = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
	function deleteImageLicense() {
		document.getElementById("form-delete").submit();
	}	
	
</script>