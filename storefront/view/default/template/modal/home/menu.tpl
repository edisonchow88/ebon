<style>
	/* START: modal */
		.modal {
			text-align:center;
		}
		
		.modal-wrapper {
			margin:0 auto;
			text-align:left;
			position:relative;
		}
		
		.modal-shadow {
			background-color:rgba(0, 0, 0, 0.3);
			height:100vh;
		}
		
		.modal-menu {
			width:calc(100% - 50px);
			height:100vh;
			background-color:#FFF;
			position:absolute;
			top:0;
			border-right:solid thin #ccc;
		}
		
		.modal-dialog {
			margin:0;
			width:100%;
		}
		
		.modal-content {
			position:relative;
			border-radius:0;
			border:none;
			box-shadow:none;
		}
		
		.modal-header {
			border-radius:0;
			border-bottom:none;
			padding:0;
			margin:0 auto;
		}
		
		.modal-body {
			min-height:calc(100vh - 40px);
		}
		
		.modal-title {
			color:#000;
			font-weight:bold;
		}
	/* END */
</style>

<!-- START: Modal -->
    <div class="modal" id="modal-home-menu" role="dialog" data-backdrop="false">
        <div class="modal-wrapper fixed-width">
        	<div class="modal-shadow fixed-width" data-dismiss="modal"></div>
            <div class="modal-menu">
                <ul class="menu">
                    <li>Edison Chow</li>
                    <hr />
                    <li><i class="fa fa-fw fa-lg fa-location-arrow"></i>Explore</li>
                    <li><i class="fa fa-fw fa-lg fa-heart"></i>My Favourites</li>
                    <li><i class="fa fa-fw fa-lg fa-file-text"></i>My Templates</li>
                    <li><i class="fa fa-fw fa-lg fa-suitcase"></i>My Trips</li>
                    <hr />
                </ul>
            </div>
        </div>
    </div>
<!-- END -->

<script>
	$("#modal-home-menu").on( "show.bs.modal", function() {
		$('#modal-home-menu .modal-menu').hide();
	});
	$("#modal-home-menu").on( "shown.bs.modal", function() {
		$('#modal-home-menu .modal-menu').toggle('slide');
	});
	$("#modal-home-menu").on( "hide.bs.modal", function() {
		$('#modal-home-menu .modal-menu').toggle('slide');
	});
</script>