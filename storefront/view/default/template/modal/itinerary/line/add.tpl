<style>
	#wrapper-explore-search {
		position:fixed;
		top:40px;
		height:40px;
		padding:3px;
		background-color:#DDD;
		border-bottom:solid thin #CCC;
	}
	
	#wrapper-explore-search input {
		text-align:center;
		font-size:12px;
		border-radius:5px;
	}
	
	#wrapper-explore-search-shadow {
		height:40px;
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
</style>

<!-- START: Modal -->
    <div class="modal modal-fixed-top" id="modal-line-add" role="dialog">
        <div class="modal-wrapper">
            <div class="modal-header">
                <div id="modal-line-add-header-general" class="header fixed-bar fixed-width">
                    <div class="col-xs-3 text-left">
                        <a class="btn btn-header" data-toggle="modal" data-target="#modal-line-add">Back</a>
                    </div>
                    <div class="col-xs-6 text-center">
                        <div class="title">Add Activity</div>
                    </div>
                    <div class="col-xs-3 text-right">
                    </div>
                </div>
            </div>
            <div class="modal-dialog fixed-width">
                <div class="modal-header-shadow"></div>
                <div class="modal-header-shadow"></div>
                <div class="modal-content">
                    <div class="modal-body nopadding">
                    	<div class="fixed-bar fixed-width" id="wrapper-explore-search">
                            <input class="form-control" placeholder="Search" data-toggle="modal" data-target="#modal-explore-search">
                        </div>
                    	<ul class="menu">
                        	<li><i class="fa fa-fw fa-lg fa-location-arrow"></i><i class="fa fa-fw"></i>Explore Around</li>
                        	<li><i class="fa fa-fw fa-lg fa-heart"></i><i class="fa fa-fw"></i>From My Favourites</li>
                            <li><i class="fa fa-fw fa-lg fa-plus-circle"></i><i class="fa fa-fw"></i>Add Custom Activity</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- END -->

<script>
</script>