<div id="wrapper-header" class="box-shadow">
	<div id="wrapper-menu-icon" data-toggle='tooltip' data-placement='bottom' title='Open Menu'>
    	<a class="btn btn-primary" onclick="toggle_wrapper_menu(); hide_wrapper_account();"><i class="fa fa-fw fa-bars fa-lg"></i></a>
    </div>
    <div id="wrapper-title" data-toggle='tooltip' data-placement='bottom' title='Rename Trip'>
        <input id="wrapper-title-input" class="form-control" type="text" value="Trip 1" onkeyup="resize_wrapper_title_input();"></input>
    </div>
    <!-- START: float right -->
        <div id="wrapper-account-icon" class="dropdown" data-toggle='tooltip' data-placement='bottom' title='Open Account Menu'>
        	<a onclick="toggle_wrapper_account(); hide_wrapper_menu();">
            	<span class="fa-stack fa-lg">
                <i class="fa fa-circle fa-stack-2x"></i>
                <i class="fa fa-user fa-stack-1x fa-inverse"></i>
                </span>
            </a>
        </div>
        <div id="wrapper-button" class="hidden-xs hidden-sm">
            <a class="btn btn-default">Share</a>
            <a class="btn btn-primary">Save</a>
        </div>
        <div id="wrapper-alert" class="hidden-xs hidden-sm hidden-md">
            <div class="alert alert-success alert-dismissible" role="alert">
                <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <span><strong>Irrashaimase!</strong> welcome (＾▽＾)</span>
            </div>
        </div>
    <!-- END -->
</div>

<script>
	function resize_wrapper_title_input() {
		var input = document.getElementById('wrapper-title-input');
		input.style.width = Math.min(Math.max(((input.value.length + 1) * 8), 120), 240) + 'px';
	}
	
	resize_wrapper_title_input();
</script>
