<div id="wrapper-menu">
	<div id="wrapper-menu-modal-background" onclick="hide_wrapper_menu();">
    </div>
    <div id="wrapper-menu-modal-body" class="col-xs-12 col-sm-6 col-md-3">
    	<div id="wrapper-menu-modal-shadow" class="box-shadow">
        </div>
    	<div id="wrapper-menu-modal-content">
            <ul>
            	<li>
                	<a>
                    	<i class="fa fa-fw fa-file"></i>
                        <i class="fa fa-fw"></i>
                        New Trip
                    </a>
                </li>
                <li>
                	<a>
                    	<i class="fa fa-fw fa-folder-open"></i>
                        <i class="fa fa-fw"></i>
                        Open
                    </a>
                </li>
                <li>
                	<a>
                    	<i class="fa fa-fw fa-floppy-o"></i>
                        <i class="fa fa-fw"></i>
                        Save
                    </a>
                </li>
                <li>
                	<a>
                    	<i class="fa fa-fw fa-share-alt"></i>
                        <i class="fa fa-fw"></i>
                        Share
                    </a>
                </li>
                <hr />
                <li class="active">
                	<a>
                    	<i class="fa fa-fw fa-file-text"></i>
                        <i class="fa fa-fw"></i>
                        Itinerary
                    </a>
                </li>
                <li>
                	<a>
                    	<i class="fa fa-fw fa-user"></i>
                        <i class="fa fa-fw"></i>
                        Member
                    </a>
                </li>
            </ul>
        </div>
    </div>
</div>

<script>
	function toggle_wrapper_menu() {
		if(document.getElementById('wrapper-menu-modal-background').style.display == 'block') {
			hide_wrapper_menu();
		}
		else {
			show_wrapper_menu();
		}
	}
	
	function show_wrapper_menu() {
		<!-- START: animation -->
			$('#wrapper-menu').show();
			$('#wrapper-menu-modal-background').fadeIn();
			$('#wrapper-menu-modal-shadow').slideDown('fast');
			$('#wrapper-menu-modal-content').slideDown('fast');
		<!-- END -->
		
		<!-- START: Hide tooltip -->
			var id = $('#wrapper-menu-icon').attr('aria-describedby');
			$('#'+id).hide();
			$('#wrapper-menu-icon').attr('data-original-title', 'Close Menu');
		<!-- END -->
	}
	
	function hide_wrapper_menu() {
		<!-- START: animation -->
			$('#wrapper-menu-modal-background').fadeOut();
			$('#wrapper-menu-modal-shadow').slideUp('fast');
			$('#wrapper-menu-modal-content').slideUp('fast');
		<!-- END -->
		
		<!-- START: Hide tooltip -->
			var id = $('#wrapper-menu-icon').attr('aria-describedby');
			$('#'+id).hide();
			$('#wrapper-menu-icon').attr('data-original-title', 'Open Menu');
		<!-- END -->
	}
</script>