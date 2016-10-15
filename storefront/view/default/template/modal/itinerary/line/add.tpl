<style>
	.search-bar {
		padding:3px;
		background-color:#DDD;
		border-bottom:solid thin #CCC;
	}
	
	.search-bar input {
		text-align:center;
		font-size:12px;
		border-radius:5px;
	}
	
	.menu li {
		height:50px;
		padding:15px;
		border-bottom:solid thin #DDD;
		cursor:pointer;
	}
	
	.menu li .fa {
		color:#666;
	}
	
	.menu li:hover {
		background-color:#EEE;
	}
	
	.menu li.text-danger {
		color:#F00;
	}
	
	.menu li.text-danger .fa {
		color:#C00;
	}
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-line-add" role="dialog" data-backdrop="false">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-line-add-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-add">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Add Activity</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
                <div class="header header-secondary fixed-bar fixed-width search-bar">
                    <input class="form-control" placeholder="Search" data-toggle="modal" data-target="#modal-line-search">
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-header-shadow search-bar-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    	<ul class="menu">
                        	<li data-toggle="modal" data-target="#modal-line-explore" onclick="closeModalLineAdd();">
                            	<i class="fa fa-fw fa-lg fa-location-arrow"></i><i class="fa fa-fw"></i>Explore Around
                            </li>
                        	<li data-toggle="modal" data-target="#modal-line-favourite" onclick="closeModalLineAdd();">
                            	<i class="fa fa-fw fa-lg fa-heart"></i><i class="fa fa-fw"></i>From My Favourites
                            </li>
                            <li onclick="openModalLineCustom() ;">
                            	<i class="fa fa-fw fa-lg fa-plus-circle"></i><i class="fa fa-fw"></i>Add Custom Activity
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	function closeModalLineAdd() {
		$('#modal-line-add').modal('hide');
	}
	
	function openModalLineCustom() {
		closeModalLineAdd();
		$('#modal-line-custom-form').trigger("reset");
		$('#modal-line-custom-form input[type=hidden]').val('');
		$('#modal-line-custom .image img').attr('src','resources/image/error/noimage.png');
		$('#modal-line-custom').modal('show');
	}
</script>
<script>
	$("#modal-line-add").on("show.bs.modal", function () {
		initExploreMap();
	});
</script>