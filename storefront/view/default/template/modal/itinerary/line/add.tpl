<style>
	.search-bar {
		padding:3px;
	}
	
	.search-bar input {
		text-align:center;
		font-size:12px;
		border-radius:5px;
	}
</style>

<!-- START: Modal -->
	<div class="modal" id="modal-line-add" role="dialog" data-backdrop="false">
    	<div class="modal-wrapper fixed-width">
        	<div class="modal-header fixed-width">
            	<div class="navbar navbar-primary navbar-modal">
                	<div class="col-xs-3 text-left">
                    	<a class="btn" data-dismiss="modal">Cancel</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <span>New Activity</span>
                    </div>
                    <div class="col-xs-3 text-right">
                    	<a class="btn"  data-toggle="modal" data-target="#modal-line-search"><i class="fa fa-fw fa-lg fa-search"></i></a>
                    </div>
                </div>
        	</div>
            <div class="modal-body fixed-width">
                <div class="navbar navbar-shadow"></div>
                <div class="modal-body-body">
                	<div class="la la-50 la-border la-hover la-pointer noselect">
                    	<div class="la-row" data-dismiss="modal" data-toggle="modal" data-target="#modal-line-explore">
                        	<div class="la-icon">
                            	<i class="fa fa-fw fa-lg fa-location-arrow"></i>
                            </div>
                            <div class="la-desc">
                            	<div class="la-text">
                                	<span>Explore Around</span>
                            	</div>
                            </div>
                        </div>
                        <div class="la-row" data-dismiss="modal" data-toggle="modal" data-target="#modal-line-favourite">
                        	<div class="la-icon">
                            	<i class="fa fa-fw fa-lg fa-heart"></i>
                            </div>
                            <div class="la-desc">
                            	<div class="la-text">
                                	<span>From My Favourites</span>
                            	</div>
                            </div>
                        </div>
                        <div class="la-row" data-dismiss="modal" onclick="openModalLineCustom();">
                        	<div class="la-icon">
                            	<i class="fa fa-fw fa-lg fa-plus-circle"></i>
                            </div>
                            <div class="la-desc">
                            	<div class="la-text">
                                	<span>Add Custom Activity</span>
                            	</div>
                            </div>
                        </div>
                    </div>
                </div>
        	</div>
        </div>
    </div>
<!--
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
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-filter">Filter</a>
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
-->
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
<!--
<script>
	$("#modal-line-add").on("show.bs.modal", function () {
		initExploreMap();
	});
</script>
-->