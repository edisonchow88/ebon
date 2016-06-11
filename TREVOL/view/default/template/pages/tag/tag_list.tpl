<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">
	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['tag/type_list'];?>" class="btn btn-default" role="button"><i class="fa fa-fw fa-desktop"></i> View Tag Type</a></div>
    	<div class="col-xs-8 text-center"><h5>Tag</h5></div>
        <div class="col-xs-2 text-right"><a href="<?php echo $link['tag/tag_form'];?>" class="btn btn-danger" role="button">Add Tag</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<table id="grid" class="table table-condensed table-hover table-striped">
            <thead>
                <tr>
                	<th data-column-id="icon" data-width="60px" data-formatter="icon" data-sortable="false">Icon</th>
                    <th data-column-id="id" data-type="numeric" data-order="asc">ID</th>
                    <th data-column-id="type">Type</th>
                    <th data-column-id="name" data-formatter="name">Name</th>
                    <th data-column-id="parent" data-formatter="parent" data-sortable="false">Parent</th>
                    <th data-column-id="child" data-formatter="child" data-sortable="false">Child</th>
                    <th data-column-id="similar" data-formatter="similar" data-sortable="false">Similar</th>
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
            <h4 class="modal-title">Delete Tag</h4>
            </div>
        <div class="modal-body">
            <div class="alert alert-danger" role="alert">
                Are you sure you want to delete <b>Tag #<span id="tag-id-delete-text"></span></b> ?
            </div>
            <form id="request-delete" action="<?php echo $link['tag/tag_post'];?>" method="post">
                <input 
                    type="hidden" 
                    id="tag-id-delete-input" 
                    name="tag_id" 
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
                <button type="button" class="btn btn-danger" onclick="deleteTag();">Delete</button>
            </div>
        </div>
    </div>
</div>
<!-- END: Modal -->

<script>
	var grid = $("#grid").bootgrid({
		caseSensitive: false,
		formatters: {
			"icon": function(column, row)
			{
				return "<i class=\"fa " + row.icon + "\" style=\"width:100%; text-align:center;\"></i>";
			},
			"name": function(column, row)
			{
				var name = JSON.parse(row.name);
				return "<a class=\"label label-pill search-child\" data-row-name=\"" + name.name + "\" style=\"background-color:"+name.color+"\">" + name.name + "</a>";
			},
			"parent": function(column, row)
			{
				if(row.parent.length > 1) {
					var result = '';
					var parent = JSON.parse(row.parent);
					
					for(i=0;i<parent.length;i++) {
						result += "<a class=\"label label-pill search-parent\" data-row-parent=\"" + parent[i].name + "\" style=\"background-color:"+parent[i].color+";margin-right:5px;\">" + parent[i].name + "</a>"; 
					}
					return result;
				}
			},
			"child": function(column, row)
			{
				if(row.child > 0) {
					var name = JSON.parse(row.name);
					return "<div class=\"text-center\"><a class=\"btn btn-default search-child\" data-row-name=\"" + name.name + "\">" + row.child + "</a></div>";
				}
				else {
					return "<div class=\"text-center\">0</div>";
				}
			},
			"similar": function(column, row)
			{
				if(row.similar.length > 1) {
					var result = '';
					var similar = JSON.parse(row.similar);
					
					for(i=0;i<similar.length;i++) {
						result += "<a class=\"label label-pill search-similar\" data-row-similar=\"" + similar[i].name + "\" style=\"background-color:"+similar[i].color+";margin-right:5px;\">" + similar[i].name + "</a>"; 
					}
					return result;
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
		grid.find(".search-child").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-name"));
		})
		.end().find(".search-parent").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-parent"));
		})
		.end().find(".search-similar").on("click", function(e)
		{
			$("#grid").bootgrid("search", $(this).data("row-similar"));
		})
		.end().find(".command-edit").on("click", function(e)
		{
			window.location.href = "<?php echo $link['tag/tag_form']; ?>\&tag_id=" + $(this).data("row-id");
		})
		.end().find(".command-delete").on("click", function(e)
		{
			document.getElementById("tag-id-delete-text").innerHTML = $(this).data("row-id");
			document.getElementById("tag-id-delete-input").value = $(this).data("row-id");
			$($(this).attr("data-target")).modal("show");
		});
	});
	
	/* @admin/view/default/javascript/jquery.bootgrid-1.3.1/jquery.bootgrid.min.js has been edited to execute this function */
	function clearSearch() {
		$("#grid").bootgrid("search");
	}
	
	function deleteTag() {
		document.getElementById("request-delete").submit();
	}	
	
</script>