<style>
	form section { padding-left:10px; margin-bottom:20px; font-weight:bold; }
</style>

<!-- START: Alert -->
<?php include($tpl_common_dir . 'action_confirm.tpl'); ?>
<!-- END: Alert -->

<div id="content" class="panel panel-default">

	<div class="panel-heading col-xs-12">
    	<div class="col-xs-2 text-left"><a href="<?php echo $link['tag/tag_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
    	<div class="col-xs-8 text-center"><h5><?php echo $title;?></h5></div>
        <div class="col-xs-2 text-right"><a class="btn btn-danger" role="button" onclick="submitForm('main-form');">Save</a></div>
	</div>

	<div class="panel-body panel-body-nopadding tab-content col-xs-12">
    	<form id="main-form" role="form" style="max-width:600px; margin:auto;" action="<?php echo $link['tag/tag_post'];?>" method="post">
        
        	<!-- Demo -->
        	<div style="width:100%; text-align:center;">
        		<h3>
                	<span id="demo-icon"><i class="fa fa-fw <?php echo $form['icon']; ?>"></i></span>
                    <span id="demo" class="label" style="font-size:24px; background-color:
                    	<?php if($form['type_color'] !='') { echo $form['type_color']; } else { echo 'black'; }?>
                    ">
                    	<?php if($form['name'] !='') { echo $form['name']; } else { echo 'Demo'; }?>
                    </span>
                </h3>
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
            	<label class="control-label col-sm-3 col-xs-12" for="input-tag-id">ID</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="hidden" 
                        id="input-tag-id" 
                        name="tag_id"
                        value="<?php echo $form['tag_id']; ?>"
                    >
                    <?php echo $form['tag_id']; ?>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-tag-type-id">Type</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<select 
                    	class="form-control" 
                        id="input-tag-type-id" 
                        name="tag_type_id"
                        onchange="updateDemoColor();"
                    >
                    	<option value="">-- Select type --</option>
                    	<?php 
                            foreach($type_option as $tag_type_id => $type) {
                                echo "<option value='".$tag_type_id."'";
                                if($tag_type_id == $form['tag_type_id']) { echo " selected"; } 
                                echo ">".$type['type_name']."</option>";
                            }
                        ?>
                    </select>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-icon">Icon</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="text" 
                        class="form-control" 
                        id="input-icon" 
                        name="icon"
                        onchange="updateDemoIcon(this.value);"
                        placeholder="fa-awesome" 
                        value="<?php echo $form['icon']; ?>"
                    >
                    <span class="input-group-btn"><a class="btn btn-default" href="<?php echo $link['fa_awesome'];?>" target="_blank"><i class="fa fa-fw fa-question-circle"></i></a></span>
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
                        onchange="updateDemoName(this.value);"
                    >
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-description">Description</label>
                <div class="input-group col-sm-9 col-xs-12">
                	<input 
                    	type="text" 
                        class="form-control" 
                        id="input-description" 
                        name="description"
                        placeholder="Description" 
                        value="<?php echo $form['description']; ?>"
                    >
                </div>
            </div>
            <hr />
            
            <section>Relation</section>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-parent">Parent</label>
                <div class="input-group col-sm-9 col-xs-12">
                    <span class="input-group-btn" style="z-index:20;">
                    	<button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-tag-relation" ><i class="fa fa-plus"></i></button>
                    </span>
                    <input 
                    	type="hidden" 
                        class="form-control" 
                        id="input-parent" 
                        name="parent"
                        placeholder="" 
                    >
                    <div id="container-parent-tag" style="position:absolute; top:5px; left:40px; z-index:10; width:100%;"></div>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-child">Child</label>
                <div class="input-group col-sm-9 col-xs-12">
                    <span class="input-group-btn" style="z-index:20;">
                    	<button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-tag-relation" ><i class="fa fa-plus"></i></button>
                    </span>
                    <input 
                    	type="hidden" 
                        class="form-control" 
                        id="input-child" 
                        name="child"
                        placeholder="" 
                    >
                    <div id="container-child-tag" style="position:absolute; top:5px; left:40px; z-index:10; width:100%;"></div>
                </div>
            </div>
            <div class="form-group">
            	<label class="control-label col-sm-3 col-xs-12" for="input-similar">Similar</label>
                <div class="input-group col-sm-9 col-xs-12">
                    <span class="input-group-btn" style="z-index:20;">
                    	<button class="btn btn-default" type="button" data-toggle="modal" data-target="#modal-tag-relation" ><i class="fa fa-plus"></i></button>
                    </span>
                    <input 
                    	type="hidden" 
                        class="form-control" 
                        id="input-similar" 
                        name="similar"
                        placeholder="" 
                    >
                    <div id="container-similar-tag" style="position:absolute; top:5px; left:40px; z-index:10; width:100%;"></div>
                </div>
            </div>
        </form>
	</div>
    
    <div class="panel-footer col-xs-12">
    	<div class="col-xs-6 text-right"><a href="<?php echo $link['tag/tag_list'];?>" class="btn btn-default" role="button">Cancel</a></div>
        <div class="col-xs-6 text-left"><a class="btn btn-danger" role="button" onclick="submitForm('main-form');">Save</a></div>
	</div>
</div>



<!-- START: Modal -->
<div class="modal fade" id="modal-tag-relation" role="dialog">
    <div class="modal-dialog">
    
        <!-- "Add Type" Modal content-->
        <div class="modal-content">
            <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title text-center">Tag Relation</h4>
            </div>
            <div class="modal-body">
                <table id="grid-tag-relation" class="table table-condensed table-hover table-striped">
                    <thead>
                        <tr>
                            <th data-column-id="id" data-formatter="tag_id">Id</th>
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
	var type = <?php echo $json_type; ?>;
	var type_option = [];
	for(i=0;i<type.length;i++) {
		type_option[type[i].tag_type_id] = type[i];
	}
	
	function updateDemoColor() {
		var id = document.getElementById("input-tag-type-id").value;
		document.getElementById("demo").style.backgroundColor = 'black';
		document.getElementById("demo").style.backgroundColor = type_option[id].type_color;	
	}
	
	function updateDemoIcon(value) {
		document.getElementById("demo-icon").innerHTML = "<i class='fa fa-fw "+value+"'></i>";	
	}
	
	function updateDemoName(value) {
		value = value.charAt(0).toUpperCase() + value.slice(1);
		document.getElementById("demo").innerHTML = value;	
	}
	
	function submitForm(form) {
		document.getElementById(form).submit();
	}
	
	function clearSearch() {
		$("#grid-tag-relation").bootgrid("search");
	}
	
	var parent = <?php echo $json_parent; ?>;
	var child = <?php echo $json_child; ?>;
	var similar = <?php echo $json_similar; ?>;
	
	<!-- bootgrid for modal-add-parent -->
	var my_grid_tag_relation = $("#grid-tag-relation").bootgrid({
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
		my_grid_tag_relation.find(".command-add").on("click", function(e)
		{
			document.getElementById("container-parent-tag").innerHTML += "<span class='label label-pill' style='background-color:" + $(this).data("row-color") + "; margin-right:5px;'>" + $(this).data("row-name") + "</span>";
			if(document.getElementById("input-parent").value != '') { document.getElementById("input-parent").value += ","; }
			document.getElementById("input-parent").value += $(this).data("row-id");
			document.getElementById("button-add-parent-"+$(this).data("row-id")).innerHTML = "<i class=\"fa fa-fw fa-minus\"></i>";
			document.getElementById("button-add-parent-"+$(this).data("row-id")).className = "btn btn-danger command-delete";
			
		})
		.end().find(".command-set-none").on("click", function(e)
		{
			var tag_id = $(this).data("row-id");
			removeParentTag(tag_id);
			removeChildTag(tag_id);
			removeSimilarTag(tag_id);
			
		})
		.end().find(".command-set-parent").on("click", function(e)
		{
			var tag_id = $(this).data("row-id");
			var tag = {"tag_id":$(this).data("row-id"),"name":$(this).data("row-name"),"color":$(this).data("row-color")};
			removeChildTag(tag_id);
			removeSimilarTag(tag_id);
			addParentTag(tag);
		})
		.end().find(".command-set-child").on("click", function(e)
		{
			var tag_id = $(this).data("row-id");
			var tag = {"tag_id":$(this).data("row-id"),"name":$(this).data("row-name"),"color":$(this).data("row-color")};
			removeParentTag(tag_id);
			removeSimilarTag(tag_id);
			addChildTag(tag);
		})
		.end().find(".command-set-similar").on("click", function(e)
		{
			var tag_id = $(this).data("row-id");
			var tag = {"tag_id":$(this).data("row-id"),"name":$(this).data("row-name"),"color":$(this).data("row-color")};
			removeParentTag(tag_id);
			removeChildTag(tag_id);
			addSimilarTag(tag);
		})
		;
	});
	
	function showParentTag() {
		document.getElementById("container-parent-tag").innerHTML = '';
		for(i=0;i<parent.length;i++) {
			document.getElementById("container-parent-tag").innerHTML += "<span class='label label-pill' style='background-color:" + parent[i].color + "; margin-right:5px;'>" + parent[i].name  + "<a class='btn-xs' style='cursor:pointer;' onclick='removeParentTag(" + parent[i].tag_id  + ");'><span class='fa fa-times-circle fa-inverse small'></span></a></span>";
		}
		document.getElementById("input-parent").value = JSON.stringify(parent);
	}
	
	function showChildTag() {
		document.getElementById("container-child-tag").innerHTML = '';
		for(i=0;i<child.length;i++) {
			document.getElementById("container-child-tag").innerHTML += "<span class='label label-pill' style='background-color:" + child[i].color + "; margin-right:5px;'>" + child[i].name  + "<a class='btn-xs' style='cursor:pointer;' onclick='removeChildTag(" + child[i].tag_id  + ");'><span class='fa fa-times-circle fa-inverse small'></span></a></span>";
		}
		document.getElementById("input-child").value = JSON.stringify(child);
	}
	
	function showSimilarTag() {
		document.getElementById("container-similar-tag").innerHTML = '';
		for(i=0;i<similar.length;i++) {
			document.getElementById("container-similar-tag").innerHTML += "<span class='label label-pill' style='background-color:" + similar[i].color + "; margin-right:5px;'>" + similar[i].name  + "<a class='btn-xs' style='cursor:pointer;' onclick='removeSimilarTag(" + similar[i].tag_id  + ");'><span class='fa fa-times-circle fa-inverse small'></span></a></span>";
		}
		document.getElementById("input-similar").value = JSON.stringify(similar);
	}
	
	showParentTag();
	showChildTag();
	showSimilarTag();
	
	function selectNone(tag_id) {
		document.getElementById("button-set-none-"+tag_id).className = "btn btn-danger command-set-none";
		document.getElementById("button-set-parent-"+tag_id).className = "btn btn-default command-set-parent";
		document.getElementById("button-set-child-"+tag_id).className = "btn btn-default command-set-child";
		document.getElementById("button-set-similar-"+tag_id).className = "btn btn-default command-set-similar";
	}
	
	function selectParentTag(tag_id) {
		document.getElementById("button-set-none-"+tag_id).className = "btn btn-default command-set-none";
		document.getElementById("button-set-parent-"+tag_id).className = "btn btn-danger command-set-parent";
		document.getElementById("button-set-child-"+tag_id).className = "btn btn-default command-set-child";
		document.getElementById("button-set-similar-"+tag_id).className = "btn btn-default command-set-similar";
	}
	
	function selectChildTag(tag_id) {
		document.getElementById("button-set-none-"+tag_id).className = "btn btn-default command-set-none";
		document.getElementById("button-set-parent-"+tag_id).className = "btn btn-default command-set-parent";
		document.getElementById("button-set-child-"+tag_id).className = "btn btn-danger command-set-child";
		document.getElementById("button-set-similar-"+tag_id).className = "btn btn-default command-set-similar";
	}
	
	function selectSimilarTag(tag_id) {
		document.getElementById("button-set-none-"+tag_id).className = "btn btn-default command-set-none";
		document.getElementById("button-set-parent-"+tag_id).className = "btn btn-default command-set-parent";
		document.getElementById("button-set-child-"+tag_id).className = "btn btn-default command-set-child";
		document.getElementById("button-set-similar-"+tag_id).className = "btn btn-danger command-set-similar";
	}
	
	function addParentTag(tag) {
		parent.pushIfNotExist(tag, function(e) { 
			return e.tag_id === tag.tag_id && e.name === tag.name && e.color === tag.color; 
		});
		selectParentTag(tag.tag_id);
		showParentTag();
	}
	
	function addChildTag(tag) {
		child.pushIfNotExist(tag, function(e) { 
			return e.tag_id === tag.tag_id && e.name === tag.name && e.color === tag.color; 
		});
		selectChildTag(tag.tag_id);
		showChildTag();
	}
	
	function addSimilarTag(tag) {
		similar.pushIfNotExist(tag, function(e) { 
			return e.tag_id === tag.tag_id && e.name === tag.name && e.color === tag.color; 
		});
		selectSimilarTag(tag.tag_id);
		showSimilarTag();
	}
	
	function removeParentTag(tag_id) {
		for(i=0;i<parent.length;i++) {
			if(parent[i].tag_id == tag_id) {
				parent.splice(i, 1);
				break;
			}
		}
		selectNone(tag_id);
		showParentTag();
	}
	
	function removeChildTag(tag_id) {
		for(i=0;i<child.length;i++) {
			if(child[i].tag_id == tag_id) {
				child.splice(i, 1);
				break;
			}
		}
		selectNone(tag_id);
		showChildTag();
	}
	
	function removeSimilarTag(tag_id) {
		for(i=0;i<similar.length;i++) {
			if(similar[i].tag_id == tag_id) {
				similar.splice(i, 1);
				break;
			}
		}
		selectNone(tag_id);
		showSimilarTag();
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