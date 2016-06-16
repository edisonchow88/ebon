<!-- START: Modal -->
<div class="modal fade" id="modal-image-destination" role="dialog">
    <div class="modal-dialog">
    
        <!-- "Add Type" Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">&times;</button>
                <h4 class="modal-title text-center">Add Destination</h4>
            </div>
            <div class="modal-body">
            	<table id="grid-modal-image-destination" class="table table-condensed table-hover table-striped">
                    <thead>
                        <tr>
                            <th data-column-id="id" data-formatter="id">Id</th>
                            <th data-column-id="name" data-formatter="name">Name</th>
                            <th data-column-id="command" data-formatter="command" data-sortable="false" data-align="right"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php
                            foreach($result_modal_image_destination as $row) {
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
	var my_image_destination = new Array();
	var my_temp_image_destination = new Array();
	
	var my_grid_modal_image_destination = $("#grid-modal-image-destination").bootgrid({
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
				return "<span class=\"label label-pill\" data-row-name=\"" + name.name + "\" style=\"background-color:"+name.type_color+"\">" + name.name + "</span>";
			},
			"command": function(column, row)
			{
				var name = JSON.parse(row.name);
				return "<button id=\"button-modal-image-destination-" + row.id + "\" type=\"button\" class=\"btn btn-default command-add\" data-destination-id=\"" + row.id + "\" data-name=\"" + name.name + "\" data-type-color=\"" + name.type_color + "\"><i class=\"fa fa-fw fa-plus\"></i></button>";
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		my_grid_modal_image_destination.find(".command-add").on("click", function(e)
		{
			var destination_id = $(this).data("destination-id").toString(); //have to make sure id is a string to avoid failure when compare with function trueIfNotExist();
			var name = $(this).data("name");
			var type_color = $(this).data("type-color");
			var destination = {"destination_id":destination_id,"name":name,"type_color":type_color};
			toggleImageDestination(destination);
		})
		updateImageDestination();
		;
	});
	
	function toggleImageDestination(destination) {
		if(my_image_destination.trueIfNotExist(destination, function(e) { 
			return e.destination_id === destination.destination_id; 
		})) {
			addImageDestination(destination);
		}
		else {
			removeImageDestination(destination.destination_id);
		}
	}
	
	function addImageDestination(destination) {
		my_image_destination.push(destination);
		document.getElementById("button-modal-image-destination-"+destination.destination_id).innerHTML = "<i class=\"fa fa-fw fa-minus\"></i>";
		document.getElementById("button-modal-image-destination-"+destination.destination_id).className = "btn btn-danger command-add";
		showImageDestination();
	}
	
	function removeImageDestination(destination_id) {
		for(i=0;i<my_image_destination.length;i++) {
			if(my_image_destination[i].destination_id == destination_id) {
				my_image_destination.splice(i, 1);
				break;
			}
		}
		document.getElementById("button-modal-image-destination-"+destination_id).innerHTML = "<i class=\"fa fa-fw fa-plus\"></i>";
		document.getElementById("button-modal-image-destination-"+destination_id).className = "btn btn-default command-add";
		showImageDestination();
	}
	
	function showImageDestination() {
		document.getElementById("container-image-destination").innerHTML = '';
		for(i=0;i<my_image_destination.length;i++) {
			document.getElementById("container-image-destination").innerHTML += "<span class='label label-pill' style='background-color:" + my_image_destination[i].type_color + "; margin-right:5px;'>" + my_image_destination[i].name  + "<a class='btn-xs' style='cursor:pointer;' onclick='removeImageDestination(" + my_image_destination[i].destination_id  + ");'><span class='fa fa-times-circle fa-inverse small'></span></a></span>";
		}
		document.getElementById("input-destination-id").value = JSON.stringify(my_image_destination);
	}
	
	function setImageDestination(json) {;
		if(json != null && json != '') { my_temp_image_destination = json; }
	}
	
	function updateImageDestination() {
		for(i=0;i<my_temp_image_destination.length;i++) {
			toggleImageDestination(my_temp_image_destination[i]);
		}
		
		if(my_temp_image_destination.length > 1) { //for unknown reason, the function toggleImageDestination() in combined with for function will skip the number one element, hence need a workaround system to add the missing element
			toggleImageDestination(my_temp_image_destination[1]);
		}
	}
	
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