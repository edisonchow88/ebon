<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
            	<li><div style="padding:15px;"><b>Source :</b></div></li>
            	<?php 
                    foreach($source as $e) {
                        echo "<li>";
                        echo "<a href=".$e['link']." target='_blank'>".$e['name']."</a>";
                        echo "</li>";
                     } 
                 ?>
            </ul>
        </div>
    </div>
</nav>

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['resource/image_source_list']; ?>" class="btn btn-default" role="button"><i class="fa fa-fw fa-desktop"></i> View Image Source</a></div>
    	<div class="col-xs-8 text-center"><h5>Image</h5></div>
        <div class="col-xs-2 text-right"><a data-toggle="modal" data-target="#modal-upload-image" class="btn btn-danger" role="button">Upload Image</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<table id="grid" class="table table-condensed table-hover table-striped">
            <thead>
                <tr>
                	<th data-column-id="image" data-formatter="image" data-sortable="false">Image</th>
                    <th data-column-id="id" data-type="numeric" data-order="asc">ID</th>
                    <th data-column-id="name" data-formatter="name">Name</th>
                    <th data-column-id="source" data-formatter="source">Source</th>
                    <th data-column-id="linked" data-formatter="linked" data-sortable="false">Linked</th>
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
            <h4 class="modal-title">Delete Image</h4>
            </div>
        <div class="modal-body">
            <div class="alert alert-danger" role="alert">
                Are you sure you want to delete <b>Image #<span id="image-id-delete-text"></span></b> ?
            </div>
            <form id="form-delete" action="<?php echo $link['resource/image_post'];?>" method="post">
                <input 
                    type="hidden" 
                    id="image-id-delete-input" 
                    name="image_id" 
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
                <button type="button" class="btn btn-danger" onclick="deleteImage();">Delete</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<?php echo $modal_upload_image; ?>

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		formatters: {
			"image": function(column, row)
			{
				var image = JSON.parse(row.image);
				return "<img src=\"" + image.path + "\" title=\"" + image.name + "\" width=\"" + image.width + "\" />";
			},
			"name": function(column, row)
			{
				return row.name;
			},
			"source": function(column, row)
			{
				return "<a href=\"" + row.source + "\" target=\"_blank\">Link</a>";
			},
			"linked": function(column, row)
			{
				if(row.linked > 0) {
					return "<div class=\"text-center\"><a class=\"btn btn-default search-linked\" data-row-id=\"" + row.id + "\">" + row.linked + "</a></div>";
				}
				else {
					return "<div class=\"text-center\">0</div>";
				}
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
		grid.find(".search-linked").on("click", function(e)
		{
			window.location.href = "<?php echo $link['resource/image_form']; ?>\&image_id=" + $(this).data("row-id");
		})
		.end().find(".command-edit").on("click", function(e)
		{
			window.location.href = "<?php echo $link['resource/image_form']; ?>\&image_id=" + $(this).data("row-id");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("image-id-delete-text").innerHTML = $(this).data("row-id");
			document.getElementById("image-id-delete-input").value = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
	function deleteImage() {
		document.getElementById("form-delete").submit();
	}	
	
</script>