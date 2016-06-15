<!-- START: Modal -->
<div class="modal fade" id="modal-tag-time" role="dialog">
    <div class="modal-dialog">
    
        <!-- "Add Type" Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title text-center">Add Tag</h4>
            </div>
            <div class="modal-body">
            	<table id="grid-modal-tag-time" class="table table-condensed table-hover table-striped">
                    <thead>
                        <tr>
                            <th data-column-id="id" data-formatter="id">Id</th>
                            <th data-column-id="name" data-formatter="name">Name</th>
                            <th data-column-id="command" data-formatter="command" data-sortable="false" data-align="right"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                            foreach($result_modal_tag_time as $row) {
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
    
    </div>
</div>
<!-- END: Modal -->

<script>
	var myTagTime = new Array();
	
	var my_grid_modal_tag_add = $("#grid-modal-tag-time").bootgrid({
		caseSensitive: false,
		columnSelection: false,
		formatters: {
			"id": function(column, row)
			{
				return row.id;
			},
			"name": function(column, row)
			{
				var name = JSON.parse(row.name);
				return "<span class=\"label label-pill search-child\" data-row-name=\"" + name.name + "\" style=\"background-color:"+name.color+"\">" + name.name + "</span>";
			},
			"command": function(column, row)
			{
				var name = JSON.parse(row.name);
				return "<button id=\"button-modal-tag-time-" + row.id + "\" type=\"button\" class=\"btn btn-default command-add\" data-id=\"" + row.id + "\" data-name=\"" + name.name + "\" data-color=\"" + name.color + "\"><span class=\"fa fa-fw fa-plus\"></span></button>";
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		my_grid_modal_tag_add.find(".command-add").on("click", function(e)
		{
			var tag_id = $(this).data("id");
			var name = $(this).data("name");
			var color = $(this).data("color");
			var tag = {"tag_id":tag_id,"name":name,"color":color};
			toggleTagTime(tag);
		})
		;
	});
	
	function toggleTagTime(tag) {
		if(myTagTime.trueIfNotExist(tag, function(e) { 
			return e.tag_id === tag.tag_id && e.name === tag.name && e.color === tag.color; 
		})) {
			addTagTime(tag);
		}
		else {
			removeTagTime(tag.tag_id);
		}
	}
	
	function addTagTime(tag) {
		myTagTime.push(tag);
		document.getElementById("button-modal-tag-time-"+tag.tag_id).innerHTML = "<i class=\"fa fa-fw fa-minus\"></i>";
		document.getElementById("button-modal-tag-time-"+tag.tag_id).className = "btn btn-danger command-add";
		showTagTime();
	}
	
	function removeTagTime(tag_id) {
		for(i=0;i<myTagTime.length;i++) {
			if(myTagTime[i].tag_id == tag_id) {
				myTagTime.splice(i, 1);
				break;
			}
		}
		document.getElementById("button-modal-tag-time-"+tag_id).innerHTML = "<i class=\"fa fa-fw fa-plus\"></i>";
		document.getElementById("button-modal-tag-time-"+tag_id).className = "btn btn-default command-add";
		showTagTime();
	}
	
	function showTagTime() {
		document.getElementById("container-tag-time-id").innerHTML = '';
		for(i=0;i<myTagTime.length;i++) {
			document.getElementById("container-tag-time-id").innerHTML += "<span class='label label-pill' style='background-color:" + myTagTime[i].color + "; margin-right:5px;'>" + myTagTime[i].name  + "<a class='btn-xs' style='cursor:pointer;' onclick='removeTagTime(" + myTagTime[i].tag_id  + ");'><span class='fa fa-times-circle fa-inverse small'></span></a></span>";
		}
		document.getElementById("input-tag-time-id").value = JSON.stringify(myTagTime);
	}
	
	showTagTime();
	
	// check if an element exists in array using a comparer function
	// comparer : function(currentElement)
	Array.prototype.inArray = function(comparer) { 
		for(var i=0; i < this.length; i++) { 
			if(comparer(this[i])) return true; 
		}
		return false; 
	}; 

	// adds an element to the array if it does not already exist using a comparer 
	// function
	Array.prototype.trueIfNotExist = function(element, comparer) { 
		if (!this.inArray(comparer)) {
			return true;
		}
		return false;
	}; 
</script>