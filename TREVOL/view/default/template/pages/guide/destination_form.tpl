<style>
	form section { padding-left:10px; margin-bottom:20px; font-weight:bold; }
</style>

<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">

	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['guide/destination_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
    	<div class="col-xs-8 text-center"><h5><?php echo $title;?></h5></div>
        <div class="col-xs-2 text-right"><a class="btn btn-danger" role="button" onclick="submitForm('main-form');">Save</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<form id="main-form" role="form" style="max-width:600px; margin:auto;" action="<?php echo $link['guide/destination_post'];?>" method="post">
        
        	<!-- Demo -->
        	<div style="width:100%; text-align:center;">
            	<div id="demo" style="background-color:#CCC; width:300px; height:300px; margin:auto;">
        		<?php if($form['image'] != '') { echo $form['main_image'];  } else {?>
                    <div style="border:thin dashed #999; width:100%; height:100%;">
                       <div style="margin-top:120px;">No image</div>
                    </div>
                <?php } ?>
                </div>
            </div>
            
            <!-- Form Action -->
            <div class="form-group">
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="hidden" 
                        name="action"
                        value="<?php echo $form['action']; ?>"
                    >
                </div>
            </div>
            
            <!-- Form Content -->
        	<section>General</section>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-destination-id">ID</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="hidden" 
                        id="input-destination-id" 
                        name="destination_id"
                        value="<?php echo $form['destination_id']; ?>"
                    >
                    <?php echo $form['destination_id']; ?>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-destination-type-id">Tag</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<select 
                    	class="form-control" 
                        id="input-tag-id" 
                        name="tag_id"
                    >
                    	<option value="">-- Select tag --</option>
                    	<?php 
                            foreach($tag_option as $tag_id => $tag) {
                                echo "<option value='".$tag_id."'";
                                if($tag_id == $form['tag_id']) { echo " selected"; } 
                                echo ">".$tag['name']."</option>";
                            }
                        ?>
                    </select>
                </div>
            </div>
            
            <hr />
            <section>Description</section>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-language-id">Language</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<select 
                    	class="form-control" 
                        id="input-language-id" 
                        name="language_id"
                    >
                    	<?php 
                            foreach($language as $id => $name) {
                                echo "<option value='".$id."'>".$name."</option>";
                            }
                        ?>
                    </select>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-name">Name</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                        type="text" 
                        class="form-control" 
                        id="input-name" 
                        name="name"
                        placeholder="Name" 
                        value="<?php echo $form['name']; ?>" 
                    >
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-description">Blurb</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="text" 
                        class="form-control" 
                        id="input-blurb" 
                        name="blurb"
                        placeholder="Blurb" 
                        value="<?php echo $form['blurb']; ?>"
                    >
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-description">Description</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<textarea 
                   		class="form-control" 
                        rows="5"
                        id="input-description" 
                        name="description"
                        placeholder="Description" 
                    ><?php echo $form['description']; ?></textarea>
                </div>
            </div>
            
            <hr />
            <section>Image</section>
            <div class="row">
                <?php foreach($form['image'] as $e) { ?>
                    <div class="col-xs-4 col-sm-4 col-md-3">
                        <?php echo $e['image'] ?>
                    </div>
                <?php } ?>
            </div>
            <hr />
            <section>Relation</section>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-parent">Parent</label>
                <div class="input-group col-sm-9 col-xs-12">
                    <span class="input-group-btn" style="z-index:20;">
                    	<button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-destination-relation" ><i class="fa fa-plus"></i></button>
                    </span>
                    <input 
                    	type="hidden" 
                        class="form-control" 
                        id="input-parent" 
                        name="parent"
                        placeholder="" 
                    >
                    <div id="container-parent-destination" style="position:absolute; top:5px; left:40px; z-index:10; width:100%;"></div>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-child">Child</label>
                <div class="input-group col-sm-9 col-xs-12">
                    <span class="input-group-btn" style="z-index:20;">
                    	<button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-destination-relation" ><i class="fa fa-plus"></i></button>
                    </span>
                    <input 
                    	type="hidden" 
                        class="form-control" 
                        id="input-child" 
                        name="child"
                        placeholder="" 
                    >
                    <div id="container-child-destination" style="position:absolute; top:5px; left:40px; z-index:10; width:100%;"></div>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-similar">Similar</label>
                <div class="input-group col-sm-9 col-xs-12">
                    <span class="input-group-btn" style="z-index:20;">
                    	<button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-destination-relation" ><i class="fa fa-plus"></i></button>
                    </span>
                    <input 
                    	type="hidden" 
                        class="form-control" 
                        id="input-similar" 
                        name="similar"
                        placeholder="" 
                    >
                    <div id="container-similar-destination" style="position:absolute; top:5px; left:40px; z-index:10; width:100%;"></div>
                </div>
            </div>
        </form>
	</div>
    
    <div class="panel-footer col-xs-12">
    	<div class="col-xs-6 text-right"><a href="<?php echo $link['guide/destination_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
        <div class="col-xs-6 text-left"><a class="btn btn-danger" role="button" onclick="submitForm('main-form');">Save</a></div>
	</div>
</div>



<!-- START: Modal -->
<div class="modal fade" id="modal-destination-relation" role="dialog">
    <div class="modal-dialog">
    
        <!-- "Add Type" Modal content-->
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title text-center">Relation</h4>
            </div>
            <div class="modal-body">
                <table id="grid-destination-relation" class="table table-condensed table-hover table-striped">
                    <thead>
                        <tr>
                            <th data-column-id="id" data-formatter="destination_id">Id</th>
                            <th data-column-id="name" data-formatter="name">Name</th>
                            <th data-column-id="relation" data-width="300px" data-formatter="relation" data-sortable="false">Relation</th>
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
    
    </div>
</div>
<!-- END: Modal -->

<script>
	var tag = <?php echo $json_tag_option; ?>;
	var tag_option = [];
	for(i=0;i<tag.length;i++) {
		tag_option[tag[i].tag_id] = tag[i];
	}
	
	function submitForm(form) {
		document.getElementById(form).submit();
	}
	
	function clearSearch() {
		$("#grid-destination-relation").bootgrid("search");
	}
	
	var parent = <?php echo $json_parent; ?>;
	var child = <?php echo $json_child; ?>;
	var similar = <?php echo $json_similar; ?>;
	
	<!-- bootgrid for modal-add-parent -->
	var my_grid_destination_relation = $("#grid-destination-relation").bootgrid({
		caseSensitive: false,
		navigation: 1,
		columnSelection: false,
		formatters: {
			"name": function(column, row)
			{
				var name = JSON.parse(row.name);
				return "<span class=\"label label-pill search-child\" data-row-name=\"" + name.name + "\" style=\"background-color:"+name.color+"\">" + name.name + "</span>";
			},
			"relation": function(column, row)
			{
				var name = JSON.parse(row.name);
				var output = '';
				
				output += "<button id=\"button-set-none-" + row.id + "\" type=\"button\" ";
				if(row.relation == '') { 
					output += "class=\"btn btn-danger command-set-none\"";
				}
				else {
					output += "class=\"btn btn-default command-set-none\"";
				}
				output += " data-row-id=\"" + row.id + "\" data-row-name=\"" + name.name + "\" data-row-color=\"" + name.color + "\">None</button> "
				
				output += "<button id=\"button-set-parent-" + row.id + "\" type=\"button\" ";
				if(row.relation == 'parent') { 
					output += "class=\"btn btn-danger command-set-parent\"";
				}
				else {
					output += "class=\"btn btn-default command-set-parent\"";
				}
				output += " data-row-id=\"" + row.id + "\" data-row-name=\"" + name.name + "\" data-row-color=\"" + name.color + "\">Parent</button> "
				
				output += "<button id=\"button-set-child-" + row.id + "\" type=\"button\" ";
				if(row.relation == 'child') { 
					output += "class=\"btn btn-danger command-set-child\"";
				}
				else {
					output += "class=\"btn btn-default command-set-child\"";
				}
				output += " data-row-id=\"" + row.id + "\" data-row-name=\"" + name.name + "\" data-row-color=\"" + name.color + "\">Child</button> "
				
				output += "<button id=\"button-set-similar-" + row.id + "\" type=\"button\" ";
				if(row.relation == 'similar') { 
					output += "class=\"btn btn-danger command-set-similar\"";
				}
				else {
					output += "class=\"btn btn-default command-set-similar\"";
				}
				output += " data-row-id=\"" + row.id + "\" data-row-name=\"" + name.name + "\" data-row-color=\"" + name.color + "\">Similar</button> "
				
				return output;
			}
		}
	}).on("loaded.rs.jquery.bootgrid", function()
	{
		/* Executes after data is loaded and rendered */
		my_grid_destination_relation.find(".command-add").on("click", function(e)
		{
			document.getElementById("container-parent-destination").innerHTML += "<span class='label label-pill' style='background-color:" + $(this).data("row-color") + "; margin-right:5px;'>" + $(this).data("row-name") + "</span>";
			if(document.getElementById("input-parent").value != '') { document.getElementById("input-parent").value += ","; }
			document.getElementById("input-parent").value += $(this).data("row-id");
			document.getElementById("button-add-parent-"+$(this).data("row-id")).innerHTML = "<i class=\"fa fa-fw fa-minus\"></i>";
			document.getElementById("button-add-parent-"+$(this).data("row-id")).className = "btn btn-danger command-delete";
			
		})
		.end().find(".command-set-none").on("click", function(e)
		{
			var destination_id = $(this).data("row-id");
			removeParentDestination(destination_id);
			removeChildDestination(destination_id);
			removeSimilarDestination(destination_id);
			
		})
		.end().find(".command-set-parent").on("click", function(e)
		{
			var destination_id = $(this).data("row-id");
			var destination = {"destination_id":$(this).data("row-id"),"name":$(this).data("row-name"),"color":$(this).data("row-color")};
			removeChildDestination(destination_id);
			removeSimilarDestination(destination_id);
			addParentDestination(destination);
		})
		.end().find(".command-set-child").on("click", function(e)
		{
			var destination_id = $(this).data("row-id");
			var destination = {"destination_id":$(this).data("row-id"),"name":$(this).data("row-name"),"color":$(this).data("row-color")};
			removeParentDestination(destination_id);
			removeSimilarDestination(destination_id);
			addChildDestination(destination);
		})
		.end().find(".command-set-similar").on("click", function(e)
		{
			var destination_id = $(this).data("row-id");
			var destination = {"destination_id":$(this).data("row-id"),"name":$(this).data("row-name"),"color":$(this).data("row-color")};
			removeParentDestination(destination_id);
			removeChildDestination(destination_id);
			addSimilarDestination(destination);
		})
		;
	});
	
	function showParentDestination() {
		document.getElementById("container-parent-destination").innerHTML = '';
		for(i=0;i<parent.length;i++) {
			document.getElementById("container-parent-destination").innerHTML += "<span class='label label-pill' style='background-color:" + parent[i].color + "; margin-right:5px;'>" + parent[i].name  + "<a class='btn-xs' style='cursor:pointer;' onclick='removeParentDestination(" + parent[i].destination_id  + ");'><span class='fa fa-times-circle fa-inverse small'></span></a></span>";
		}
		document.getElementById("input-parent").value = JSON.stringify(parent);
	}
	
	function showChildDestination() {
		document.getElementById("container-child-destination").innerHTML = '';
		for(i=0;i<child.length;i++) {
			document.getElementById("container-child-destination").innerHTML += "<span class='label label-pill' style='background-color:" + child[i].color + "; margin-right:5px;'>" + child[i].name  + "<a class='btn-xs' style='cursor:pointer;' onclick='removeChildDestination(" + child[i].destination_id  + ");'><span class='fa fa-times-circle fa-inverse small'></span></a></span>";
		}
		document.getElementById("input-child").value = JSON.stringify(child);
	}
	
	function showSimilarDestination() {
		document.getElementById("container-similar-destination").innerHTML = '';
		for(i=0;i<similar.length;i++) {
			document.getElementById("container-similar-destination").innerHTML += "<span class='label label-pill' style='background-color:" + similar[i].color + "; margin-right:5px;'>" + similar[i].name  + "<a class='btn-xs' style='cursor:pointer;' onclick='removeSimilarDestination(" + similar[i].destination_id  + ");'><span class='fa fa-times-circle fa-inverse small'></span></a></span>";
		}
		document.getElementById("input-similar").value = JSON.stringify(similar);
	}
	
	showParentDestination();
	showChildDestination();
	showSimilarDestination();
	
	function selectNone(destination_id) {
		document.getElementById("button-set-none-"+destination_id).className = "btn btn-danger command-set-none";
		document.getElementById("button-set-parent-"+destination_id).className = "btn btn-default command-set-parent";
		document.getElementById("button-set-child-"+destination_id).className = "btn btn-default command-set-child";
		document.getElementById("button-set-similar-"+destination_id).className = "btn btn-default command-set-similar";
	}
	
	function selectParentDestination(destination_id) {
		document.getElementById("button-set-none-"+destination_id).className = "btn btn-default command-set-none";
		document.getElementById("button-set-parent-"+destination_id).className = "btn btn-danger command-set-parent";
		document.getElementById("button-set-child-"+destination_id).className = "btn btn-default command-set-child";
		document.getElementById("button-set-similar-"+destination_id).className = "btn btn-default command-set-similar";
	}
	
	function selectChildDestination(destination_id) {
		document.getElementById("button-set-none-"+destination_id).className = "btn btn-default command-set-none";
		document.getElementById("button-set-parent-"+destination_id).className = "btn btn-default command-set-parent";
		document.getElementById("button-set-child-"+destination_id).className = "btn btn-danger command-set-child";
		document.getElementById("button-set-similar-"+destination_id).className = "btn btn-default command-set-similar";
	}
	
	function selectSimilarDestination(destination_id) {
		document.getElementById("button-set-none-"+destination_id).className = "btn btn-default command-set-none";
		document.getElementById("button-set-parent-"+destination_id).className = "btn btn-default command-set-parent";
		document.getElementById("button-set-child-"+destination_id).className = "btn btn-default command-set-child";
		document.getElementById("button-set-similar-"+destination_id).className = "btn btn-danger command-set-similar";
	}
	
	function addParentDestination(destination) {
		parent.pushIfNotExist(destination, function(e) { 
			return e.destination_id === destination.destination_id && e.name === destination.name && e.color === destination.color; 
		});
		selectParentDestination(destination.destination_id);
		showParentDestination();
	}
	
	function addChildDestination(destination) {
		child.pushIfNotExist(destination, function(e) { 
			return e.destination_id === destination.destination_id && e.name === destination.name && e.color === destination.color; 
		});
		selectChildDestination(destination.destination_id);
		showChildDestination();
	}
	
	function addSimilarDestination(destination) {
		similar.pushIfNotExist(destination, function(e) { 
			return e.destination_id === destination.destination_id && e.name === destination.name && e.color === destination.color; 
		});
		selectSimilarDestination(destination.destination_id);
		showSimilarDestination();
	}
	
	function removeParentDestination(destination_id) {
		for(i=0;i<parent.length;i++) {
			if(parent[i].destination_id == destination_id) {
				parent.splice(i, 1);
				break;
			}
		}
		selectNone(destination_id);
		showParentDestination();
	}
	
	function removeChildDestination(destination_id) {
		for(i=0;i<child.length;i++) {
			if(child[i].destination_id == destination_id) {
				child.splice(i, 1);
				break;
			}
		}
		selectNone(destination_id);
		showChildDestination();
	}
	
	function removeSimilarDestination(destination_id) {
		for(i=0;i<similar.length;i++) {
			if(similar[i].destination_id == destination_id) {
				similar.splice(i, 1);
				break;
			}
		}
		selectNone(destination_id);
		showSimilarDestination();
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
	Array.prototype.pushIfNotExist = function(element, comparer) { 
		if (!this.inArray(comparer)) {
			this.push(element);
		}
	}; 
</script>