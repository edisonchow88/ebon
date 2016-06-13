<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"></div>
    	<div class="col-xs-8 text-center"><h5>Interest</h5></div>
        <div class="col-xs-2 text-right"><a href="<?php echo $link['guide/interest_form'];?>" class="btn btn-danger" role="button">Add Interest</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<table id="grid" class="table table-condensed table-hover table-striped">
            <thead>
                <tr>
                	<th data-column-id="image" data-formatter="image" data-sortable="false">Image</th>
                    <th data-column-id="id" data-type="numeric" data-order="asc">ID</th>
                    <th data-column-id="name" data-formatter="name">Name</th>
                    <th data-column-id="tag" data-formatter="tag">Tag</th>
                    <th data-column-id="parent" data-formatter="parent" data-sortable="false">Parent</th>
                    <th data-column-id="child" data-formatter="child" data-sortable="false">Child</th>
                    <th data-column-id="similar" data-formatter="similar" data-sortable="false">Similar</th>
                    <th data-column-id="status" data-formatter="status" data-sortable="false">Status</th>
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
    
    <div class="panel-footer col-xs-12" style="padding:10px;">
    	<div class="alert alert-warning">
            <h5><b>Pending Upgrade</b></h5>
            <ul>
            	<li>Function to show Similar Interest</li>
                <li>Function to calculate Descendant</li>
                <li>Function to edit the row directly in this page</li>
                <li>Function to change status</li>
            </ul>
        </div>
    </div>

</div>

<!-- START: Modal -->
<div class="modal fade" id="modal-delete" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">Delete Interest</h4>
            </div>
        <div class="modal-body">
            <div class="alert alert-danger" role="alert">
                Are you sure you want to delete <b>Interest Type #<span id="interest-id-delete-text"></span></b> ?
            </div>
            <form id="request-delete" action="<?php echo $link['guide/interest_post'];?>" method="post">
                <input 
                    type="hidden" 
                    id="interest-id-delete-input" 
                    name="interest_id" 
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
                <button type="button" class="btn btn-danger" onclick="deleteInterest();">Delete</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		formatters: {
			"image": function(column, row)
			{
				if(row.image.length > 1) {
					var image = JSON.parse(row.image);
					return "<img src=\"" + image[0].path + "\" title=\"" + image[0].name + "\" width=\"" + image[0].width + "\" />";
				}
			},
			"tag": function(column, row)
			{
				if(row.tag.length > 1) {
					var result = '';
					var tag = JSON.parse(row.tag);
					
					for(i=0;i<tag.length;i++) {
						result += "<a class=\"label label-pill search-tag\" data-row-tag=\"" + tag[i].name + "\" style=\"background-color:"+tag[i].type_color+";margin-right:5px;\">" + tag[i].name + "</a>"; 
					}
					return result;
				}
			},
			"name": function(column, row)
			{
				return row.name;
			},
			"parent": function(column, row)
			{
				if(row.parent.length > 1) {
					var result = '';
					var parent = JSON.parse(row.parent);
					
					for(i=0;i<parent.length;i++) {
						result += "<a class=\"label label-pill search-parent\" data-row-parent=\"" + parent[i].name + "\" style=\"background-color:"+parent[i].type_color+";margin-right:5px;\">" + parent[i].name + "</a>"; 
					}
					return result;
				}
			},
			"child": function(column, row)
			{
				if(row.child > 0) {
					return "<div class=\"text-center\"><a class=\"btn btn-default search-child\" data-row-name=\"" + row.name + "\">" + row.child + "</a></div>";
				}
				else {
					return "<div class=\"text-center\">0</div>";
				}
			},
			"status": function(column, row)
			{
				if(row.status == 1) {
				return "<div class=\"btn-group btn-group-xs\" role=\"group\"><button type=\"button\" class=\"btn btn-primary\">ON</button><button type=\"button\" class=\"btn btn-default\">OFF</button></div>";
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
		grid.find(".search-parent").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-parent"));
		})
		.end().find(".search-child").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-name"));
		})
		.end().find(".search-similar").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-similar"));
		})
		.end().find(".search-tag").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-tag"));
		})
		.end().find(".command-edit").on("click", function(e)
		{
			window.location.href = "<?php echo $link['guide/interest_form']; ?>\&interest_id=" + $(this).data("row-id");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("interest-id-delete-text").innerHTML = $(this).data("row-id");
			document.getElementById("interest-id-delete-input").value = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
	function deleteInterest() {
		document.getElementById("request-delete").submit();
	}	
	
</script>